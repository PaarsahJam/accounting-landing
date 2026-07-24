import 'dart:async';

import '../../logging/app_logger.dart';
import '../sync_conflict.dart';
import '../sync_operation.dart';
import '../sync_queue.dart';
import '../sync_status.dart';
import 'cloud_sync_config.dart';
import 'sync_transport.dart';

enum SyncState { idle, pushing, pulling, conflict, error }

class SyncLifecycle {
  const SyncLifecycle({
    required this.state,
    this.pushSucceeded = 0,
    this.pushConflicts = 0,
    this.pushFailed = 0,
    this.pullChanges = 0,
    this.status,
    this.errorMessage,
  });

  final SyncState state;
  final int pushSucceeded;
  final int pushConflicts;
  final int pushFailed;
  final int pullChanges;
  final SyncStatus? status;
  final String? errorMessage;

  bool get isIdle => state == SyncState.idle;
  bool get hasError => errorMessage != null;

  SyncLifecycle copyWith({
    SyncState? state,
    int? pushSucceeded,
    int? pushConflicts,
    int? pushFailed,
    int? pullChanges,
    SyncStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) =>
      SyncLifecycle(
        state: state ?? this.state,
        pushSucceeded: pushSucceeded ?? this.pushSucceeded,
        pushConflicts: pushConflicts ?? this.pushConflicts,
        pushFailed: pushFailed ?? this.pushFailed,
        pullChanges: pullChanges ?? this.pullChanges,
        status: status ?? this.status,
        errorMessage: clearError
            ? null
            : errorMessage ?? this.errorMessage,
      );
}

class SyncOrchestrator {
  SyncOrchestrator({
    required SyncQueue queue,
    required SyncTransport transport,
    required CloudSyncConfig config,
    ConflictDetector? conflictDetector,
    ConflictStrategy defaultStrategy = ConflictStrategy.clientWins,
  })  : _queue = queue,
        _transport = transport,
        _config = config,
        _conflictDetector = conflictDetector ?? const ConflictDetector(),
        _defaultStrategy = defaultStrategy;

  final SyncQueue _queue;
  final SyncTransport _transport;
  final ConflictDetector _conflictDetector;
  final ConflictStrategy _defaultStrategy;
  CloudSyncConfig _config;

  final StreamController<SyncLifecycle> _lifecycleController =
      StreamController<SyncLifecycle>.broadcast();

  SyncLifecycle _lifecycle = const SyncLifecycle(state: SyncState.idle);

  SyncLifecycle get lifecycle => _lifecycle;
  CloudSyncConfig get config => _config;
  Stream<SyncLifecycle> get lifecycleStream => _lifecycleController.stream;

  void updateConfig(CloudSyncConfig config) {
    _config = config;
  }

  bool _isPushing = false;

  Future<SyncLifecycle> push() async {
    if (_isPushing) return _lifecycle;
    _isPushing = true;
    _emit(_lifecycle.copyWith(state: SyncState.pushing));

    int succeeded = 0, conflicts = 0, failed = 0;
    String? error;

    try {
      while (true) {
        final operation = await _queue.dequeue();
        if (operation == null) break;

        final result = await _pushSingle(operation);
        if (result.pushConflict) {
          conflicts++;
        } else if (result.pushSuccess) {
          succeeded++;
        } else {
          failed++;
        }
      }
    } catch (e) {
      error = e.toString();
      AppLogger.warning('Push failed', error: e);
    }

    _isPushing = false;
    if (error == null) {
      _config = _config.advancePushCursor(DateTime.now());
    }

    final status = await _queue.getStatus();
    _emit(_lifecycle.copyWith(
      state: error != null ? SyncState.error : SyncState.idle,
      pushSucceeded: succeeded,
      pushConflicts: conflicts,
      pushFailed: failed,
      status: status,
      errorMessage: error,
    ));
    return _lifecycle;
  }

  Future<_PushSingleResult> _pushSingle(SyncOperation operation) async {
    try {
      final serverVersion = await _transport.fetchEntityVersion(
        operation.entityType,
        operation.entityId,
      );

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
            return _PushSingleResult(pushConflict: true);
          }
          if (conflict.resolvedOperation == null) {
            await _queue.markCompleted(operation.id);
            return _PushSingleResult(pushConflict: true);
          }
          await _transport.push(conflict.resolvedOperation!);
          await _queue.markCompleted(operation.id);
          return _PushSingleResult(pushConflict: true);
        }
      }

      await _transport.push(operation);
      await _queue.markCompleted(operation.id);
      return _PushSingleResult(pushSuccess: true);
    } catch (e) {
      await _queue.markFailed(operation.id, e.toString());
      return _PushSingleResult(pushSuccess: false);
    }
  }

  Future<PullResult> pull() async {
    _emit(_lifecycle.copyWith(state: SyncState.pulling));
    try {
      final result = await _transport.pull(
        _config.companyId,
        since: _config.lastPullCursor,
      );
      _config = _config.advancePullCursor(result.cursor);
      _emit(_lifecycle.copyWith(
        state: SyncState.idle,
        pullChanges: result.changes.length,
      ));
      return result;
    } catch (e) {
      _emit(_lifecycle.copyWith(
        state: SyncState.error,
        errorMessage: e.toString(),
      ));
      rethrow;
    }
  }

  Future<void> incrementalSync() async {
    await push();
    if (_lifecycle.hasError || _lifecycle.pushFailed > 0) return;
    try {
      await pull();
    } catch (e) {
      AppLogger.warning('Pull during incremental sync failed', error: e);
    }
  }

  void _emit(SyncLifecycle next) {
    _lifecycle = next;
    _lifecycleController.add(next);
  }

  void dispose() {
    _lifecycleController.close();
  }
}

class _PushSingleResult {
  const _PushSingleResult({this.pushSuccess = false, this.pushConflict = false});
  final bool pushSuccess;
  final bool pushConflict;
}
