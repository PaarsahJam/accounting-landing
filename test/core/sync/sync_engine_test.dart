import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/core/api/api_client.dart';
import 'package:accounting_app/core/sync/sync_conflict.dart';
import 'package:accounting_app/core/sync/sync_engine.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/sync_queue.dart';

class _MockApiClient extends ApiClient {
  _MockApiClient() : super();

  bool getCalled = false;
  bool putCalled = false;
  bool postCalled = false;
  bool deleteCalled = false;
  Map<String, dynamic>? serverState;
  int callCount = 0;
  bool _throwNext = false;
  late DioException _throwError;

  void throwOnNextCall(DioException error) {
    _throwNext = true;
    _throwError = error;
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    getCalled = true;
    callCount++;
    if (_throwNext) {
      _throwNext = false;
      throw _throwError;
    }
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      data: (serverState ?? {'version': 1}) as T,
      statusCode: 200,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    postCalled = true;
    callCount++;
    if (_throwNext) {
      _throwNext = false;
      throw _throwError;
    }
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      data: data as T,
      statusCode: 201,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    putCalled = true;
    callCount++;
    if (_throwNext) {
      _throwNext = false;
      throw _throwError;
    }
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      data: data as T,
      statusCode: 200,
    );
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    deleteCalled = true;
    callCount++;
    if (_throwNext) {
      _throwNext = false;
      throw _throwError;
    }
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 204,
    );
  }
}

SyncOperation op(String id,
        {OperationType type = OperationType.create,
        int localVersion = 1}) =>
    SyncOperation(
      id: 'op-$id',
      operationType: type,
      entityType: 'customer',
      entityId: 'CUST-$id',
      data: {'id': 'CUST-$id', 'name': 'Test'},
      localVersion: localVersion,
      createdAt: DateTime.now(),
    );

void main() {
  late InMemorySyncQueue queue;
  late _MockApiClient mockApi;

  setUp(() {
    queue = InMemorySyncQueue();
    mockApi = _MockApiClient();
  });

  group('processAll with empty queue', () {
    test('returns zero counts when queue is empty', () async {
      final engine = SyncEngine(queue: queue, apiClient: mockApi);
      final result = await engine.processAll();
      expect(result.processed, equals(0));
      expect(result.isSuccess, isTrue);
    });
  });

  group('processAll with operations', () {
    test('processes create operation successfully', () async {
      await queue.enqueue(op('1', type: OperationType.create));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.succeeded, equals(1));
      expect(mockApi.postCalled, isTrue);
      expect(await queue.pendingCount(), equals(0));
    });

    test('processes update operation and checks version first', () async {
      await queue.enqueue(op('2', type: OperationType.update, localVersion: 2));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.succeeded, equals(1));
      expect(mockApi.getCalled, isTrue);
      expect(mockApi.putCalled, isTrue);
      expect(await queue.pendingCount(), equals(0));
    });

    test('processes delete operation', () async {
      await queue.enqueue(op('3', type: OperationType.delete));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.succeeded, equals(1));
      expect(mockApi.getCalled, isTrue);
      expect(mockApi.deleteCalled, isTrue);
      expect(await queue.pendingCount(), equals(0));
    });
  });

  group('conflict scenarios', () {
    test('detects version conflict and applies clientWins', () async {
      mockApi.serverState = {'version': 5};
      await queue.enqueue(op('10', type: OperationType.update, localVersion: 1));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.conflicts, equals(1));
      expect(mockApi.putCalled, isTrue);
    });

    test('abort strategy marks operation as failed', () async {
      mockApi.serverState = {'version': 10};
      await queue.enqueue(op('20', type: OperationType.update, localVersion: 1));
      final engine = SyncEngine(
        queue: queue,
        apiClient: mockApi,
        defaultStrategy: ConflictStrategy.abort,
      );

      final result = await engine.processAll();

      expect(result.conflicts, equals(1));
      expect(result.failed, equals(0));
      final failed = await queue.getFailed();
      expect(failed, isNotEmpty);
      expect(failed.first.failureReason, contains('manual resolution'));
    });

    test('serverWins discards local operation', () async {
      mockApi.serverState = {'version': 10};
      await queue.enqueue(op('30', type: OperationType.update, localVersion: 1));
      final engine = SyncEngine(
        queue: queue,
        apiClient: mockApi,
        defaultStrategy: ConflictStrategy.serverWins,
      );

      final result = await engine.processAll();

      expect(result.conflicts, equals(1));
      expect(result.succeeded, equals(0));
      expect(mockApi.putCalled, isFalse);
      expect(await queue.pendingCount(), equals(0));
    });
  });

  group('error handling', () {
    test('marks operation failed on network error', () async {
      mockApi.throwOnNextCall(DioException(
        requestOptions: RequestOptions(path: '/customers'),
        type: DioExceptionType.connectionError,
      ));
      await queue.enqueue(op('99', type: OperationType.create));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.failed, equals(1));
      final failed = await queue.getFailed();
      expect(failed, hasLength(1));
    });

    test('skips processing when already running', () async {
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result1 = await engine.processAll();
      final result2 = await engine.processAll();

      expect(result1.processed, equals(0));
      expect(result2.processed, equals(0));
    });
  });

  group('replay / sequential ops', () {
    test('processes multiple operations in order', () async {
      await queue.enqueue(op('A', type: OperationType.create));
      await queue.enqueue(op('B', type: OperationType.create));
      await queue.enqueue(op('C', type: OperationType.create));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      final result = await engine.processAll();

      expect(result.succeeded, equals(3));
      expect(await queue.pendingCount(), equals(0));
      expect(await queue.getFailed(), isEmpty);
    });

    test('continues processing remaining ops after one failure', () async {
      await queue.enqueue(op('X', type: OperationType.create));
      await queue.enqueue(op('Y', type: OperationType.create));
      final engine = SyncEngine(queue: queue, apiClient: mockApi);

      mockApi.throwOnNextCall(DioException(
        requestOptions: RequestOptions(path: '/customers'),
        type: DioExceptionType.connectionError,
      ));

      final result = await engine.processAll();

      expect(result.processed, equals(2));
      expect(result.failed, equals(1));
      expect(result.succeeded, equals(1));
    });
  });

  group('processPending', () {
    test('wraps result in AppResult.success on clean sync', () async {
      final engine = SyncEngine(queue: queue, apiClient: mockApi);
      final result = await engine.processPending();
      expect(result.isSuccess, isTrue);
    });
  });
}
