import 'dart:async';

import '../sync_operation.dart';
import '../sync_queue.dart';
import '../sync_status.dart';
import 'sync_queue_storage.dart';

class PersistentSyncQueue implements SyncQueue {
  PersistentSyncQueue({required SyncQueueStorage storage})
      : _storage = storage;

  final SyncQueueStorage _storage;
  final List<SyncOperation> _failed = [];
  SyncOperation? _inFlight;

  final StreamController<SyncStatus> _statusController =
      StreamController<SyncStatus>.broadcast();

  @override
  Future<void> enqueue(SyncOperation operation) async {
    await _storage.append(operation);
    _emitStatus();
  }

  @override
  Future<SyncOperation?> dequeue() async {
    final pending = await _storage.loadPending();
    if (pending.isEmpty) return null;
    final op = pending.first;
    _inFlight = op.copyWith(status: OperationStatus.inFlight);
    _emitStatus();
    return _inFlight;
  }

  @override
  Future<void> markCompleted(String operationId) async {
    if (_inFlight?.id == operationId) {
      await _storage.remove(operationId);
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
      await _storage.remove(operationId);
      _inFlight = null;
      _emitStatus();
    }
  }

  @override
  Future<int> pendingCount() async {
    final pending = await _storage.loadPending();
    return pending.length;
  }

  @override
  Future<List<SyncOperation>> getPending() async =>
      _storage.loadPending();

  @override
  Future<List<SyncOperation>> getFailed() async =>
      List<SyncOperation>.from(_failed);

  @override
  Future<SyncStatus> getStatus() async {
    final pending = await _storage.loadPending();
    return SyncStatus(
      pendingCount: pending.length,
      inFlightCount: _inFlight != null ? 1 : 0,
      failedCount: _failed.length,
    );
  }

  @override
  Stream<SyncStatus> get statusStream => _statusController.stream;

  void _emitStatus() async {
    final status = await getStatus();
    _statusController.add(status);
  }

  void dispose() {
    _statusController.close();
  }

  void clear() {
    _storage.clear();
    _failed.clear();
    _inFlight = null;
  }
}
