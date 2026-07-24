import 'dart:async';
import 'dart:collection';

import 'sync_operation.dart';
import 'sync_status.dart';

abstract class SyncQueue {
  Future<void> enqueue(SyncOperation operation);
  Future<SyncOperation?> dequeue();
  Future<void> markCompleted(String operationId);
  Future<void> markFailed(String operationId, String reason);
  Future<int> pendingCount();
  Future<List<SyncOperation>> getPending();
  Future<List<SyncOperation>> getFailed();
  Future<SyncStatus> getStatus();
  Stream<SyncStatus> get statusStream;
}

class InMemorySyncQueue implements SyncQueue {
  final Queue<SyncOperation> _queue = Queue<SyncOperation>();
  final List<SyncOperation> _failed = [];
  SyncOperation? _inFlight;

  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  @override
  Future<void> enqueue(SyncOperation operation) async {
    _queue.add(operation);
    _emitStatus();
  }

  @override
  Future<SyncOperation?> dequeue() async {
    if (_queue.isEmpty) return null;
    final op = _queue.removeFirst();
    _inFlight = op.copyWith(status: OperationStatus.inFlight);
    _emitStatus();
    return _inFlight;
  }

  @override
  Future<void> markCompleted(String operationId) async {
    if (_inFlight?.id == operationId) {
      _inFlight = null;
      _emitStatus();
    }
  }

  @override
  Future<void> markFailed(String operationId, String reason) async {
    if (_inFlight?.id == operationId) {
      final failed = _inFlight!.copyWith(
        status: OperationStatus.failed,
        failureReason: reason,
        retryCount: _inFlight!.retryCount + 1,
      );
      _failed.add(failed);
      _inFlight = null;
      _emitStatus();
    }
  }

  @override
  Future<int> pendingCount() async => _queue.length;

  @override
  Future<List<SyncOperation>> getPending() async => _queue.toList();

  @override
  Future<List<SyncOperation>> getFailed() async =>
      List<SyncOperation>.from(_failed);

  @override
  Future<SyncStatus> getStatus() async => SyncStatus(
        pendingCount: _queue.length,
        inFlightCount: _inFlight != null ? 1 : 0,
        failedCount: _failed.length,
      );

  @override
  Stream<SyncStatus> get statusStream => _statusController.stream;

  void _emitStatus() {
    _statusController.add(SyncStatus(
      pendingCount: _queue.length,
      inFlightCount: _inFlight != null ? 1 : 0,
      failedCount: _failed.length,
    ));
  }

  void dispose() {
    _statusController.close();
  }

  /// For testing: clear queue for a fresh start.
  void clear() {
    _queue.clear();
    _failed.clear();
    _inFlight = null;
  }
}
