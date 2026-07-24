import 'package:dio/dio.dart';

import '../../api/auth_token_storage.dart';
import '../../logging/app_logger.dart';

class AuthTokenRefresher extends Interceptor {
  AuthTokenRefresher({required AuthTokenStorage tokenStorage})
      : _tokenStorage = tokenStorage;

  final AuthTokenStorage _tokenStorage;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    try {
      final newToken = await _refreshToken();
      if (newToken != null) {
        final retryOpts = err.requestOptions;
        retryOpts.headers['Authorization'] = 'Bearer $newToken';
        try {
          final response = await Dio().fetch<void>(retryOpts);
          handler.resolve(response);
          return;
        } catch (_) {}
      }
    } catch (e) {
      AppLogger.warning('Token refresh failed', error: e);
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refresh = await _tokenStorage.refreshToken;
    if (refresh == null || refresh.isEmpty) return null;

    try {
      final response = await Dio().post<Map<String, dynamic>>(
        '${_baseUrl()}/auth/refresh',
        data: {'refresh_token': refresh},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      final data = response.data;
      if (data == null) return null;
      final access = data['access_token'] as String?;
      final newRefresh = data['refresh_token'] as String?;
      if (access != null) {
        await _tokenStorage.saveAccessToken(access);
        if (newRefresh != null) {
          await _tokenStorage.saveRefreshToken(newRefresh);
        }
        return access;
      }
    } catch (e) {
      AppLogger.warning('Refresh token request failed', error: e);
    }
    return null;
  }

  String _baseUrl() {
    try {
      return const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://localhost:8080/api',
      );
    } catch (_) {
      return 'http://localhost:8080/api';
    }
  }
}
