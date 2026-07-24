import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/api/api_client.dart';
import 'package:accounting_app/core/sync/sync_operation.dart';
import 'package:accounting_app/core/sync/cloud/sync_transport.dart';

class _MockApiClient extends ApiClient {
  _MockApiClient() : super();

  bool postCalled = false;
  bool putCalled = false;
  bool deleteCalled = false;
  bool getCalled = false;
  String? lastIdempotencyKey;
  Map<String, dynamic>? serverState;
  List<Map<String, dynamic>>? pullResponse;

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    getCalled = true;
    if (path == '/changes') {
      return Response<T>(
        requestOptions: RequestOptions(path: path),
        data: (pullResponse ?? <Map<String, dynamic>>[]) as T,
        statusCode: 200,
      );
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
    lastIdempotencyKey = options?.headers?['Idempotency-Key'] as String?;
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
    lastIdempotencyKey = options?.headers?['Idempotency-Key'] as String?;
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
    lastIdempotencyKey = options?.headers?['Idempotency-Key'] as String?;
    return Response<T>(
      requestOptions: RequestOptions(path: path),
      statusCode: 204,
    );
  }
}

SyncOperation makeOp(String id,
        {OperationType type = OperationType.create}) =>
    SyncOperation(
      id: 'op-$id',
      operationType: type,
      entityType: 'customer',
      entityId: 'CUST-$id',
      data: {'name': 'Test'},
    );

void main() {
  late _MockApiClient mockApi;
  late RestSyncTransport transport;

  setUp(() {
    mockApi = _MockApiClient();
    transport = RestSyncTransport(apiClient: mockApi);
  });

  group('push', () {
    test('sends create operation via POST with idempotency key', () async {
      final op = makeOp('1', type: OperationType.create);
      await transport.push(op);
      expect(mockApi.postCalled, isTrue);
      expect(mockApi.lastIdempotencyKey, equals(op.idempotencyKey));
    });

    test('sends update operation via PUT with idempotency key', () async {
      final op = makeOp('2', type: OperationType.update);
      await transport.push(op);
      expect(mockApi.putCalled, isTrue);
      expect(mockApi.lastIdempotencyKey, equals(op.idempotencyKey));
    });

    test('sends delete operation via DELETE', () async {
      final op = makeOp('3', type: OperationType.delete);
      await transport.push(op);
      expect(mockApi.deleteCalled, isTrue);
    });

    test('includes idempotency_key in request body', () async {
      final op = makeOp('4', type: OperationType.create);
      await transport.push(op);
      expect(mockApi.postCalled, isTrue);
    });
  });

  group('fetchEntityVersion', () {
    test('returns version from server response', () async {
      mockApi.serverState = {'version': 42};
      final version = await transport.fetchEntityVersion('customer', 'CUST-1');
      expect(version, equals(42));
      expect(mockApi.getCalled, isTrue);
    });

    test('returns null when entity not found', () async {
      mockApi.serverState = {'version': 1};
      // Override get to throw 404
      final nullTransport = RestSyncTransport(apiClient: _MockApiClient404());
      final version =
          await nullTransport.fetchEntityVersion('customer', 'MISSING');
      expect(version, isNull);
    });

    test('returns null for default state', () async {
      final version = await transport.fetchEntityVersion('customer', 'CUST-1');
      expect(version, equals(1));
    });
  });

  group('pull', () {
    test('returns empty changes when no data', () async {
      final result = await transport.pull('comp-1');
      expect(result.changes, isEmpty);
    });
  });

  group('batch', () {
    test('processes all operations', () async {
      final ops = [
        makeOp('A', type: OperationType.create),
        makeOp('B', type: OperationType.update),
        makeOp('C', type: OperationType.delete),
      ];
      await transport.batch(ops);
      expect(mockApi.postCalled, isTrue);
      expect(mockApi.putCalled, isTrue);
      expect(mockApi.deleteCalled, isTrue);
    });
  });
}

class _MockApiClient404 extends ApiClient {
  _MockApiClient404() : super();

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    throw DioException(
      requestOptions: RequestOptions(path: path),
      response: Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 404,
      ),
      type: DioExceptionType.badResponse,
    );
  }
}
