import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/sync/cloud/cloud_sync_config.dart';
import 'package:accounting_app/core/sync/cloud/sync_orchestrator.dart';
import 'package:accounting_app/core/sync/cloud/sync_transport.dart';
import 'package:accounting_app/core/sync/cloud/sync_queue_storage.dart';
import 'package:accounting_app/core/sync/cloud/persistent_sync_queue.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/sync_conflict.dart';

SyncOperation makeOp(String id,
        {OperationType type = OperationType.create,
        int localVersion = 1}) {
  return SyncOperation(
    id: 'op-$id',
    operationType: type,
    entityType: 'customer',
    entityId: 'CUST-$id',
    data: {'name': 'Test'},
  ).copyWith(localVersion: localVersion);
}

class _MockTransport implements SyncTransport {
  int pushCallCount = 0;
  int pullCallCount = 0;
  int batchCallCount = 0;
  int versionFetchCallCount = 0;
  bool throwOnNextPush = false;
  bool throwOnNextPull = false;
  int? serverVersion;
  List<RemoteChange> pullChanges = [];
  DateTime pullCursor = DateTime(2026, 7, 23);

  @override
  Future<void> push(SyncOperation operation) async {
    pushCallCount++;
    if (throwOnNextPush) {
      throwOnNextPush = false;
      throw Exception('Push failed');
    }
  }

  @override
  Future<PullResult> pull(String companyId, {DateTime? since}) async {
    pullCallCount++;
    if (throwOnNextPull) {
      throwOnNextPull = false;
      throw Exception('Pull failed');
    }
    return PullResult(changes: pullChanges, cursor: pullCursor);
  }

  @override
  Future<void> batch(List<SyncOperation> operations) async {
    batchCallCount++;
    for (final op in operations) {
      await push(op);
    }
  }

  @override
  Future<int?> fetchEntityVersion(
      String entityType, String entityId) async {
    versionFetchCallCount++;
    return serverVersion;
  }
}

void main() {
  late MemorySyncQueueStorage storage;
  late PersistentSyncQueue queue;
  late _MockTransport transport;
  late CloudSyncConfig config;
  late SyncOrchestrator orchestrator;

  setUp(() {
    storage = MemorySyncQueueStorage();
    queue = PersistentSyncQueue(storage: storage);
    transport = _MockTransport();
    config = CloudSyncConfig(accountId: 'acc-1', companyId: 'comp-1');
    orchestrator = SyncOrchestrator(
      queue: queue,
      transport: transport,
      config: config,
    );
  });

  group('lifecycle state transitions', () {
    test('initial state is idle', () {
      expect(orchestrator.lifecycle.state, equals(SyncState.idle));
    });

    test('push transitions from pushing to idle on success', () async {
      await queue.enqueue(makeOp('1', type: OperationType.create));
      await orchestrator.push();
      expect(orchestrator.lifecycle.state, equals(SyncState.idle));
      expect(orchestrator.lifecycle.pushSucceeded, equals(1));
      expect(transport.pushCallCount, equals(1));
    });

    test('push reports failures without setting error state', () async {
      transport.throwOnNextPush = true;
      await queue.enqueue(makeOp('1', type: OperationType.create));
      await orchestrator.push();
      expect(orchestrator.lifecycle.state, equals(SyncState.idle));
      expect(orchestrator.lifecycle.pushFailed, equals(1));
    });
  });

  group('push with conflict scenarios', () {
    test('clientWins resolves conflict by sending to server', () async {
      transport.serverVersion = 5;
      await queue.enqueue(
          makeOp('1', type: OperationType.update, localVersion: 1));
      await orchestrator.push();
      expect(orchestrator.lifecycle.pushConflicts, equals(1));
      expect(transport.pushCallCount, equals(1));
    });

    test('serverWins discards local operation', () async {
      final serverWinsOrch = SyncOrchestrator(
        queue: queue,
        transport: transport,
        config: config,
        defaultStrategy: ConflictStrategy.serverWins,
      );
      transport.serverVersion = 5;
      await queue.enqueue(
          makeOp('1', type: OperationType.update, localVersion: 1));
      await serverWinsOrch.push();
      expect(serverWinsOrch.lifecycle.state, equals(SyncState.idle));
      expect(transport.pushCallCount, equals(0));
    });

    test('abort keeps operation in failed queue', () async {
      final abortOrch = SyncOrchestrator(
        queue: queue,
        transport: transport,
        config: config,
        defaultStrategy: ConflictStrategy.abort,
      );
      transport.serverVersion = 5;
      await queue.enqueue(
          makeOp('1', type: OperationType.update, localVersion: 1));
      await abortOrch.push();
      expect(abortOrch.lifecycle.state, equals(SyncState.idle));
      expect(transport.pushCallCount, equals(0));
      final failed = await queue.getFailed();
      expect(failed, isNotEmpty);
    });
  });

  group('pull', () {
    test('pull transitions from pulling to idle', () async {
      transport.pullChanges = [
        RemoteChange(
          entityType: 'customer',
          entityId: 'CUST-1',
          operationType: OperationType.update,
          data: {'name': 'Updated'},
          version: 2,
          updatedAt: DateTime(2026, 7, 23, 10),
        ),
      ];
      final result = await orchestrator.pull();
      expect(orchestrator.lifecycle.state, equals(SyncState.idle));
      expect(orchestrator.lifecycle.pullChanges, equals(1));
      expect(result.changes, hasLength(1));
      expect(transport.pullCallCount, equals(1));
    });

    test('pull throws and sets error state on failure', () async {
      transport.throwOnNextPull = true;
      try {
        await orchestrator.pull();
        fail('Expected exception');
      } catch (_) {
        expect(orchestrator.lifecycle.state, equals(SyncState.error));
        expect(orchestrator.lifecycle.hasError, isTrue);
      }
    });
  });

  group('incrementalSync', () {
    test('push then pull on incremental sync', () async {
      await queue.enqueue(makeOp('1', type: OperationType.create));
      await orchestrator.incrementalSync();
      expect(transport.pushCallCount, equals(1));
      expect(transport.pullCallCount, equals(1));
    });

    test('does not pull if push fails', () async {
      transport.throwOnNextPush = true;
      await queue.enqueue(makeOp('1', type: OperationType.create));
      await orchestrator.incrementalSync();
      expect(transport.pushCallCount, equals(1));
      expect(transport.pullCallCount, equals(0));
    });
  });

  group('config management', () {
    test('updateConfig replaces config', () {
      final newConfig =
          CloudSyncConfig(accountId: 'acc-2', companyId: 'comp-2');
      orchestrator.updateConfig(newConfig);
      expect(orchestrator.config.accountId, equals('acc-2'));
      expect(orchestrator.config.companyId, equals('comp-2'));
    });

    test('push advances sync cursor on success', () async {
      final before = orchestrator.config.lastSyncCursor;
      await queue.enqueue(makeOp('1', type: OperationType.create));
      await orchestrator.push();
      final after = orchestrator.config.lastSyncCursor;
      expect(after, isNotNull);
      expect(after!.isAfter(before ?? DateTime(2000)), isTrue);
    });
  });
}
