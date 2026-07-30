import 'package:accounting_app/core/sync/cloud/cloud_sync_config.dart';
import 'package:accounting_app/core/sync/cloud/cloud_sync_providers.dart';
import 'package:accounting_app/core/sync/cloud/sync_orchestrator.dart';
import 'package:accounting_app/core/sync/cloud/sync_transport.dart';
import 'package:accounting_app/core/sync/sync_queue.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/sync_status.dart';
import 'package:accounting_app/features/sync/presentation/sync_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSyncQueue implements SyncQueue {
  @override
  Future<void> enqueue(SyncOperation operation) async {}

  @override
  Future<SyncOperation?> dequeue() async => null;

  @override
  Future<void> markCompleted(String operationId) async {}

  @override
  Future<void> markFailed(String operationId, String reason) async {}

  @override
  Future<int> pendingCount() async => 0;

  @override
  Future<List<SyncOperation>> getPending() async => [];

  @override
  Future<List<SyncOperation>> getFailed() async => [];

  @override
  Future<SyncStatus> getStatus() async =>
      SyncStatus(pendingCount: 0, inFlightCount: 0, failedCount: 0);

  @override
  Stream<SyncStatus> get statusStream => const Stream.empty();
}

class _FakeSyncTransport implements SyncTransport {
  @override
  Future<void> push(SyncOperation operation) async {}

  @override
  Future<PullResult> pull(String companyId, {DateTime? since}) async =>
      PullResult(changes: [], cursor: DateTime.now());

  @override
  Future<void> batch(List<SyncOperation> operations) async {}

  @override
  Future<int?> fetchEntityVersion(String entityType, String entityId) async =>
      null;
}

SyncOrchestrator _createFakeOrchestrator() => SyncOrchestrator(
      queue: _FakeSyncQueue(),
      transport: _FakeSyncTransport(),
      config: const CloudSyncConfig(accountId: '', companyId: ''),
    );

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      syncOrchestratorProvider.overrideWith((ref) => _createFakeOrchestrator()),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: SyncStatusPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('SyncStatusPage renders title and action button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Sync Status'), findsWidgets);
    expect(find.text('Sync Now'), findsOneWidget);
    expect(find.text('Actions'), findsOneWidget);
  });
}
