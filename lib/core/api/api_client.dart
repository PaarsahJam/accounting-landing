import 'package:dio/dio.dart';

import 'api_config.dart';
import 'api_interceptors.dart';
import 'auth_token_storage.dart';

class ApiClient {
  ApiClient({
    Dio? dio,
    AuthTokenStorage? tokenStorage,
    List<Interceptor>? extraInterceptors,
  }) : _dio = dio ??
            _createDio(
              tokenStorage ?? const AuthTokenStorage(),
              extraInterceptors,
            );

  final Dio _dio;

  static Dio _createDio(
    AuthTokenStorage tokenStorage,
    List<Interceptor>? extraInterceptors,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.addAll([
      AuthInterceptor(tokenStorage: tokenStorage),
      ErrorInterceptor(),
      if (const bool.fromEnvironment('API_LOGGING', defaultValue: false))
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          // ignore: avoid_print — debug-only logging behind env flag
          logPrint: (o) => print('[DIO] $o'),
        ),
      if (extraInterceptors != null) ...extraInterceptors,
    ]);
    return dio;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.get<T>(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.post<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.put<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.patch<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _dio.delete<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken);

  Future<Response<T>> fetch<T>(RequestOptions requestOptions) =>
      _dio.fetch<T>(requestOptions);
}
