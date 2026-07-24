import 'package:dio/dio.dart';

import '../../api/api_client.dart';
import '../../errors/app_failure.dart';
import '../sync_operation.dart';

class RemoteChange {
  const RemoteChange({
    required this.entityType,
    required this.entityId,
    required this.operationType,
    required this.data,
    required this.version,
    required this.updatedAt,
  });

  final String entityType;
  final String entityId;
  final OperationType operationType;
  final Map<String, dynamic> data;
  final int version;
  final DateTime updatedAt;
}

class PullResult {
  const PullResult({
    required this.changes,
    required this.cursor,
  });

  final List<RemoteChange> changes;
  final DateTime cursor;
}

abstract class SyncTransport {
  Future<void> push(SyncOperation operation);
  Future<PullResult> pull(String companyId, {DateTime? since});
  Future<void> batch(List<SyncOperation> operations);
  Future<int?> fetchEntityVersion(String entityType, String entityId);
}

class RestSyncTransport implements SyncTransport {
  RestSyncTransport({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<void> push(SyncOperation operation) async {
    final path = _buildPath(operation);
    final headers = <String, dynamic>{
      'Idempotency-Key': operation.idempotencyKey,
    };
    final opts = Options(headers: headers);

    switch (operation.operationType) {
      case OperationType.create:
        await _apiClient.post<Map<String, dynamic>>(
          path,
          data: _withIdempotency(operation),
          options: opts,
        );
      case OperationType.update:
        await _apiClient.put<Map<String, dynamic>>(
          path,
          data: _withIdempotency(operation),
          options: opts,
        );
      case OperationType.delete:
        await _apiClient.delete(
          path,
          options: opts,
        );
    }
  }

  @override
  Future<PullResult> pull(String companyId, {DateTime? since}) async {
    final params = <String, dynamic>{
      'company_id': companyId,
      if (since != null) 'since': since.toIso8601String(),
    };
    final response = await _apiClient.get<List<dynamic>>(
      '/changes',
      queryParameters: params,
    );
    final list = response.data ?? <dynamic>[];
    final changes = list.map((e) {
      final m = e as Map<String, dynamic>;
      return RemoteChange(
        entityType: m['entity_type'] as String,
        entityId: m['entity_id'] as String,
        operationType: OperationType.values.byName(m['action'] as String),
        data: Map<String, dynamic>.from(m['data'] as Map),
        version: m['version'] as int,
        updatedAt: DateTime.parse(m['updated_at'] as String),
      );
    }).toList();

    final cursor = changes.isNotEmpty
        ? changes.map((c) => c.updatedAt).reduce(
            (a, b) => a.isAfter(b) ? a : b)
        : (since ?? DateTime.now());

    return PullResult(changes: changes, cursor: cursor);
  }

  @override
  Future<void> batch(List<SyncOperation> operations) async {
    for (final op in operations) {
      await push(op);
    }
  }

  String _buildPath(SyncOperation op) {
    final base = '/${op.entityType}s';
    switch (op.operationType) {
      case OperationType.create:
        return base;
      case OperationType.update:
        return '$base/${op.entityId}';
      case OperationType.delete:
        return '$base/${op.entityId}';
    }
  }

  @override
  Future<int?> fetchEntityVersion(String entityType, String entityId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        '/${entityType}s/$entityId',
      );
      return response.data?['version'] as int?;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Map<String, dynamic> _withIdempotency(SyncOperation operation) =>
      <String, dynamic>{
        ...operation.data,
        'idempotency_key': operation.idempotencyKey,
      };
}

class SyncTransportFailure extends AppFailure {
  const SyncTransportFailure({required String message, this.statusCode})
      : super(message);
  final int? statusCode;
}
