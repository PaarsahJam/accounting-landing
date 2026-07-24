import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../api/api_client_provider.dart';
import 'sync_conflict.dart';
import 'sync_engine.dart';
import 'sync_queue.dart';

part 'sync_providers.g.dart';

@Riverpod(keepAlive: true)
SyncQueue syncQueue(Ref ref) => InMemorySyncQueue();

@Riverpod(keepAlive: true)
ConflictDetector conflictDetector(Ref ref) => const ConflictDetector();

@Riverpod(keepAlive: true)
SyncEngine syncEngine(Ref ref) {
  final queue = ref.watch(syncQueueProvider);
  final apiClient = ref.watch(apiClientProvider);
  return SyncEngine(
    queue: queue,
    apiClient: apiClient,
    conflictDetector: ref.watch(conflictDetectorProvider),
    defaultStrategy: ConflictStrategy.clientWins,
  );
}
