import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../api/api_client_provider.dart';
import '../sync_conflict.dart';
import '../sync_providers.dart';
import 'cloud_sync_config.dart';
import 'persistent_sync_queue.dart';
import 'sync_orchestrator.dart';
import 'sync_queue_storage.dart';
import 'sync_transport.dart';

part 'cloud_sync_providers.g.dart';

@Riverpod(keepAlive: true)
SyncQueueStorage syncQueueStorage(Ref ref) => MemorySyncQueueStorage();

@Riverpod(keepAlive: true)
CloudSyncConfig? cloudSyncConfig(Ref ref) => null;

@Riverpod(keepAlive: true)
SyncTransport syncTransport(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return RestSyncTransport(apiClient: apiClient);
}

@Riverpod(keepAlive: true)
SyncOrchestrator syncOrchestrator(Ref ref) {
  final storage = ref.watch(syncQueueStorageProvider);
  final config = ref.watch(cloudSyncConfigProvider);
  final transport = ref.watch(syncTransportProvider);
  final queue = PersistentSyncQueue(storage: storage);
  return SyncOrchestrator(
    queue: queue,
    transport: transport,
    config: config ?? const CloudSyncConfig(accountId: '', companyId: ''),
    conflictDetector: ref.watch(conflictDetectorProvider),
    defaultStrategy: ConflictStrategy.clientWins,
  );
}
