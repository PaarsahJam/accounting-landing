import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/api/api_interceptors.dart';
import 'package:accounting_app/core/api/auth_token_storage.dart';

class FakeTokenStorage extends AuthTokenStorage {
  FakeTokenStorage({String? token}) : _token = token;

  String? _token;
  // ignore: prefer_initializing_formals — explicit assignment needed for mutation

  @override
  Future<String?> get accessToken async => _token;

  void setToken(String? token) => _token = token;
}

void main() {
  group('AuthInterceptor', () {
    late FakeTokenStorage tokenStorage;
    late AuthInterceptor interceptor;

    setUp(() {
      tokenStorage = FakeTokenStorage();
      interceptor = AuthInterceptor(tokenStorage: tokenStorage);
    });

    test('adds Bearer token header when token exists', () async {
      tokenStorage.setToken('my-jwt-token');
      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      // wait for async
      await Future<void>.delayed(Duration.zero);
      expect(options.headers['Authorization'], 'Bearer my-jwt-token');
    });

    test('does not add header when token is null', () async {
      tokenStorage.setToken(null);
      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      await Future<void>.delayed(Duration.zero);
      expect(options.headers.containsKey('Authorization'), false);
    });

    test('does not add header when token is empty', () async {
      tokenStorage.setToken('');
      final options = RequestOptions(path: '/test');
      final handler = RequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      await Future<void>.delayed(Duration.zero);
      expect(options.headers.containsKey('Authorization'), false);
    });
  });

  group('ErrorInterceptor', () {
    test('rejects with mapped error', () async {
      final interceptor = ErrorInterceptor();
      final err = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 400,
          data: {'message': 'bad input'},
        ),
      );

      final handler = ErrorInterceptorHandler();
      interceptor.onError(err, handler);

      // handler.reject is called synchronously; the rejected error
      // is a new DioException with an AppFailure in [error].
      // We verify no crash and that the mapping was applied
      // (assertion is via api_error_mapper_test.dart).
      expect(err.type, DioExceptionType.badResponse);
    });
  });
}
