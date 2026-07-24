import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../errors/app_failure.dart';
import '../errors/app_result.dart';
import '../logging/app_logger.dart';
import 'sync_conflict.dart';
import 'sync_operation.dart';
import 'sync_queue.dart';
import 'sync_status.dart';

class SyncResult {
  const SyncResult({
    required this.processed,
    required this.succeeded,
    required this.failed,
    required this.conflicts,
    this.status,
    this.error,
  });

  final int processed;
  final int succeeded;
  final int failed;
  final int conflicts;
  final SyncStatus? status;
  final AppFailure? error;

  bool get isSuccess => error == null && failed == 0;
}

class SyncEngine {
  SyncEngine({
    required SyncQueue queue,
    required ApiClient apiClient,
    ConflictDetector? conflictDetector,
    ConflictStrategy defaultStrategy = ConflictStrategy.clientWins,
  })  : _queue = queue,
        _apiClient = apiClient,
        _conflictDetector = conflictDetector ?? const ConflictDetector(),
        _defaultStrategy = defaultStrategy;

  final SyncQueue _queue;
  final ApiClient _apiClient;
  final ConflictDetector _conflictDetector;
  final ConflictStrategy _defaultStrategy;

  bool _processing = false;

  bool get isProcessing => _processing;

  /// Processes all pending operations in FIFO order.
  Future<SyncResult> processAll() async {
    if (_processing) {
      return const SyncResult(
          processed: 0, succeeded: 0, failed: 0, conflicts: 0);
    }
    _processing = true;

    int succeeded = 0;
    int failed = 0;
    int conflicts = 0;
    AppFailure? fatalError;

    try {
      while (true) {
        final operation = await _queue.dequeue();
        if (operation == null) break;

        final result = await _processSingle(operation);
        switch (result) {
          case _SingleResult(conflict: true):
            conflicts++;
            break;
          case _SingleResult(success: true):
            succeeded++;
            break;
          case _SingleResult(success: false):
            failed++;
            break;
        }
      }
    } on AppFailure catch (e) {
      fatalError = e;
      AppLogger.warning('Sync engine fatal error', error: e);
    } catch (e) {
      fatalError = UnknownFailure(message: e.toString());
      AppLogger.warning('Sync engine unexpected error', error: e);
    }

    _processing = false;

    final status = await _queue.getStatus();
    return SyncResult(
      processed: succeeded + failed + conflicts,
      succeeded: succeeded,
      failed: failed,
      conflicts: conflicts,
      status: status,
      error: fatalError,
    );
  }

  Future<_SingleResult> _processSingle(SyncOperation operation) async {
    try {
      final serverVersion = await _fetchServerVersion(operation);

      if (serverVersion != null) {
        final conflict = _conflictDetector.detect(
          operation,
          serverVersion,
          strategy: _defaultStrategy,
        );
        if (conflict != null) {
          if (!conflict.resolved) {
            await _queue.markFailed(
              operation.id,
              conflict.resolutionNote ?? 'Conflict; manual resolution needed',
            );
            return _SingleResult(conflict: true);
          }
          if (conflict.resolvedOperation == null) {
            await _queue.markCompleted(operation.id);
            return _SingleResult(conflict: true);
          }
          await _applyToServer(conflict.resolvedOperation!);
          await _queue.markCompleted(operation.id);
          return _SingleResult(conflict: true);
        }
      }

      await _applyToServer(operation);
      await _queue.markCompleted(operation.id);
      return _SingleResult(success: true);
    } on AppFailure catch (e) {
      await _queue.markFailed(operation.id, e.message);
      return _SingleResult(success: false);
    } catch (e) {
      await _queue.markFailed(operation.id, e.toString());
      return _SingleResult(success: false);
    }
  }

  Future<int?> _fetchServerVersion(SyncOperation operation) async {
    if (operation.operationType == OperationType.create) return null;
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        '/${operation.entityType}s/${operation.entityId}',
      );
      return response.data?['version'] as int?;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<void> _applyToServer(SyncOperation operation) async {
    switch (operation.operationType) {
      case OperationType.create:
        await _apiClient.post<Map<String, dynamic>>(
          '/${operation.entityType}s',
          data: operation.data,
        );
      case OperationType.update:
        await _apiClient.put<Map<String, dynamic>>(
          '/${operation.entityType}s/${operation.entityId}',
          data: operation.data,
        );
      case OperationType.delete:
        await _apiClient.delete(
          '/${operation.entityType}s/${operation.entityId}',
        );
    }
  }

  Future<AppResult<void>> processPending() async {
    final result = await processAll();
    return result.isSuccess
        ? AppResult.success(null)
        : AppResult.failure(
            result.error ?? UnknownFailure(message: 'Sync failed'));
  }
}

class _SingleResult {
  const _SingleResult({this.success = false, this.conflict = false});
  final bool success;
  final bool conflict;
}
