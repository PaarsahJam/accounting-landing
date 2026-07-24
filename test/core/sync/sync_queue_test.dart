import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/sync_queue.dart';
import 'package:accounting_app/core/sync/sync_status.dart';

void main() {
  late InMemorySyncQueue queue;

  setUp(() {
    queue = InMemorySyncQueue();
  });

  SyncOperation makeOp(String id, {OperationType type = OperationType.create}) =>
      SyncOperation(
        id: id,
        operationType: type,
        entityType: 'customer',
        entityId: 'CUST-$id',
        data: {'id': 'CUST-$id', 'name': 'Test $id'},
        localVersion: 1,
        createdAt: DateTime.now(),
      );

  group('queuing', () {
    test('enqueue adds operation and updates pending count', () async {
      await queue.enqueue(makeOp('1'));
      expect(await queue.pendingCount(), equals(1));
    });

    test('multiple enqueues increase pending count', () async {
      await queue.enqueue(makeOp('1'));
      await queue.enqueue(makeOp('2'));
      await queue.enqueue(makeOp('3'));
      expect(await queue.pendingCount(), equals(3));
    });

    test('dequeue returns operations in FIFO order', () async {
      await queue.enqueue(makeOp('A'));
      await queue.enqueue(makeOp('B'));
      final op1 = await queue.dequeue();
      final op2 = await queue.dequeue();
      expect(op1?.entityId, equals('CUST-A'));
      expect(op2?.entityId, equals('CUST-B'));
    });

    test('dequeue returns null when queue is empty', () async {
      final op = await queue.dequeue();
      expect(op, isNull);
    });

    test('pending operation serialization round-trip', () async {
      final original = makeOp('roundtrip', type: OperationType.update);
      final json = original.toJson();
      final restored = SyncOperation.fromJson(json);
      expect(restored.id, equals(original.id));
      expect(restored.operationType, equals(original.operationType));
      expect(restored.entityType, equals(original.entityType));
      expect(restored.entityId, equals(original.entityId));
      expect(restored.localVersion, equals(original.localVersion));
      expect(restored.status, equals(original.status));
    });
  });

  group('lifecycle', () {
    test('markCompleted removes in-flight operation', () async {
      await queue.enqueue(makeOp('1'));
      final op = await queue.dequeue();
      expect(op, isNotNull);
      await queue.markCompleted(op!.id);
      expect(await queue.pendingCount(), equals(0));
    });

    test('markFailed moves operation to failed list', () async {
      await queue.enqueue(makeOp('1'));
      final op = await queue.dequeue();
      await queue.markFailed(op!.id, 'Server error');
      final failed = await queue.getFailed();
      expect(failed.length, equals(1));
      expect(failed.first.failureReason, equals('Server error'));
    });

    test('status tracks pending, inFlight, and failed counts', () async {
      await queue.enqueue(makeOp('1'));
      await queue.enqueue(makeOp('2'));
      final op1 = await queue.dequeue();

      final status1 = await queue.getStatus();
      expect(status1.pendingCount, equals(1));
      expect(status1.inFlightCount, equals(1));
      expect(status1.failedCount, equals(0));

      await queue.markFailed(op1!.id, 'error');
      final status2 = await queue.getStatus();
      expect(status2.pendingCount, equals(1));
      expect(status2.inFlightCount, equals(0));
      expect(status2.failedCount, equals(1));
    });

    test('status stream emits on each mutation', () async {
      final emitted = <SyncStatus>[];
      final sub = queue.statusStream.listen(emitted.add);

      await queue.enqueue(makeOp('1'));
      await queue.enqueue(makeOp('2'));
      await queue.dequeue();

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(emitted.length, greaterThanOrEqualTo(3));
      expect(emitted.last.pendingCount, equals(1));
    });
  });

  group('edge cases', () {
    test('clear prepares for fresh start', () async {
      await queue.enqueue(makeOp('1'));
      await queue.enqueue(makeOp('2'));
      expect(await queue.pendingCount(), equals(2));
      queue.clear();
      expect(await queue.pendingCount(), equals(0));
      expect(await queue.getFailed(), isEmpty);
    });

    test('getPending returns unprocessed operations', () async {
      await queue.enqueue(makeOp('1'));
      await queue.enqueue(makeOp('2'));
      final pending = await queue.getPending();
      expect(pending.length, equals(2));
    });

    test('getFailed returns only failed operations', () async {
      await queue.enqueue(makeOp('1'));
      final op = await queue.dequeue();
      await queue.markFailed(op!.id, 'fail');
      await queue.enqueue(makeOp('2'));
      final failed = await queue.getFailed();
      expect(failed.length, equals(1));
      expect(failed.first.entityId, equals('CUST-1'));
    });
  });
}
