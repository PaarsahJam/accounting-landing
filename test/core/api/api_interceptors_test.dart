import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/api/api_interceptors.dart';
import 'package:accounting_app/core/api/auth_token_storage.dart';
import 'package:accounting_app/core/errors/app_failure.dart';

class FakeTokenStorage extends AuthTokenStorage {
  FakeTokenStorage({String? token}) : _token = token;

  String? _token;
  // ignore: prefer_initializing_formals — explicit assignment needed for mutation

  @override
  Future<String?> get accessToken async => _token;

  void setToken(String? token) => _token = token;
}

class _RecordingErrorHandler extends ErrorInterceptorHandler {
  DioException? rejected;

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = false]) {
    rejected = error;
  }
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

      final handler = _RecordingErrorHandler();
      interceptor.onError(err, handler);

      expect(handler.rejected, isNotNull);
      expect(handler.rejected!.type, DioExceptionType.badResponse);
      expect(handler.rejected!.requestOptions.path, '/test');
      // The mapped AppFailure (message extracted from the response body)
      // is attached to the rejected DioException.
      expect(handler.rejected!.error, isA<AppFailure>());
      expect((handler.rejected!.error! as AppFailure).message, 'bad input');
    });
  });
}
