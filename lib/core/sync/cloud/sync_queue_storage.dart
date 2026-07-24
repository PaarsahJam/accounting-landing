import 'dart:convert';
import 'dart:io' as io;

import '../sync_operation.dart';

abstract class SyncQueueStorage {
  Future<List<SyncOperation>> loadPending();
  Future<void> savePending(List<SyncOperation> operations);
  Future<void> append(SyncOperation operation);
  Future<void> remove(String operationId);
  Future<void> clear();
}

class MemorySyncQueueStorage implements SyncQueueStorage {
  final List<SyncOperation> _store = [];

  @override
  Future<List<SyncOperation>> loadPending() async =>
      List<SyncOperation>.from(_store);

  @override
  Future<void> savePending(List<SyncOperation> operations) async {
    _store
      ..clear()
      ..addAll(operations);
  }

  @override
  Future<void> append(SyncOperation operation) async {
    _store.add(operation);
  }

  @override
  Future<void> remove(String operationId) async {
    _store.removeWhere((op) => op.id == operationId);
  }

  @override
  Future<void> clear() async {
    _store.clear();
  }
}

class FileSyncQueueStorage implements SyncQueueStorage {
  FileSyncQueueStorage({required String filePath})
      : _filePath = filePath;

  final String _filePath;
  List<SyncOperation>? _cache;

  @override
  Future<List<SyncOperation>> loadPending() async {
    if (_cache != null) return List.from(_cache!);
    try {
      final file = await _getFile();
      if (!file.existsSync()) return [];
      final content = file.readAsStringSync();
      if (content.trim().isEmpty) return [];
      final list = jsonDecode(content) as List<dynamic>;
      _cache = list
          .map((e) => SyncOperation.fromJson(e as Map<String, dynamic>))
          .toList();
      return List.from(_cache!);
    } catch (_) {
      _cache = [];
      return [];
    }
  }

  @override
  Future<void> savePending(List<SyncOperation> operations) async {
    _cache = List.from(operations);
    await _writeAll(operations);
  }

  @override
  Future<void> append(SyncOperation operation) async {
    final ops = await loadPending();
    ops.add(operation);
    _cache = ops;
    await _writeAll(ops);
  }

  @override
  Future<void> remove(String operationId) async {
    final ops = await loadPending();
    ops.removeWhere((op) => op.id == operationId);
    _cache = ops;
    await _writeAll(ops);
  }

  @override
  Future<void> clear() async {
    _cache = [];
    final file = await _getFile();
    if (file.existsSync()) file.deleteSync();
  }

  Future<void> _writeAll(List<SyncOperation> operations) async {
    final file = await _getFile();
    final json = jsonEncode(operations.map((op) => op.toJson()).toList());
    file.writeAsStringSync(json);
  }

  Future<io.File> _getFile() async => io.File(_filePath);
}
