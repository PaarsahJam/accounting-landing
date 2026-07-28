import 'dart:async';

import 'package:dio/dio.dart';

import '../../api/api_client.dart';
import '../../api/api_config.dart';
import '../../api/auth_token_storage.dart';
import '../../logging/app_logger.dart';

/// A Dio interceptor that transparently refreshes an expired access token.
///
/// Design decisions
/// ─────────────────
/// 1. **Injected Dio instances** — the previous implementation created raw
///    `Dio()` instances inline, bypassing all configured interceptors (timeouts,
///    error mapping, logging).  This class accepts two explicit Dio instances so
///    they can be properly configured and injected in tests.
///
/// 2. **Dedicated refresh Dio** — the refresh call must NOT use the same Dio
///    that has this interceptor attached; doing so would cause a recursive 401
///    loop where a failed refresh triggers another refresh.  [_refreshDio] is
///    a separate, minimal client with no [AuthInterceptor].
///
/// 3. **Concurrency lock** — a [Completer] prevents multiple in-flight
///    requests from each trying to refresh independently when they all receive
///    a 401 simultaneously.  Only the first caller does the refresh; the rest
///    await the same result.
///
/// 4. **Base URL from [ApiConfig]** — the refresh endpoint uses the same
///    centralised base URL as every other API call, eliminating the duplicated
///    `String.fromEnvironment` that previously lived here.
class AuthTokenRefresher extends Interceptor {
  AuthTokenRefresher({
    required AuthTokenStorage tokenStorage,
    /// Dio used exclusively for the `/auth/refresh` call.
    /// Must NOT have an [AuthInterceptor] to avoid recursive 401 loops.
    Dio? refreshDio,
    /// The main application [ApiClient] used to retry the original failed
    /// request after a successful token refresh.
    ApiClient? apiClient,
  })  : _tokenStorage = tokenStorage,
        _refreshDio = refreshDio ?? _buildRefreshDio(),
        _apiClient = apiClient;

  final AuthTokenStorage _tokenStorage;
  final Dio _refreshDio;

  /// Optional reference to the app's [ApiClient] for retrying requests.
  /// When `null`, the retry path is skipped and the original error is forwarded.
  final ApiClient? _apiClient;

  /// Guards against concurrent refresh attempts.
  Completer<String?>? _refreshCompleter;

  // ── Factory ─────────────────────────────────────────────────────────────────

  /// Builds a minimal Dio for the refresh endpoint:
  /// • Uses [ApiConfig.baseUrl] — single source of truth.
  /// • Applies only [ErrorInterceptor] — no [AuthInterceptor] so the refresh
  ///   call never triggers another 401 cycle.
  /// • Applies the same timeouts as the main client.
  static Dio _buildRefreshDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (err, handler) async {
          // if you need custom logic here
          handler.next(err);
        },
      ),
    );

    return dio;
  }

  // ── Interceptor ─────────────────────────────────────────────────────────────

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    try {
      final newToken = await _getOrRefreshToken();
      if (newToken != null && _apiClient != null) {
        // Retry the original request with the fresh token.
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';
        try {
          final response =
              await _apiClient.fetch<void>(retryOptions);
          return handler.resolve(response);
        } on DioException catch (retryErr) {
          // Retry itself failed — fall through to forward the original error.
          AppLogger.warning(
            'Retry after token refresh failed',
            error: retryErr,
          );
        }
      }
    } catch (e) {
      AppLogger.warning('Token refresh failed', error: e);
    }

    handler.next(err);
  }

  // ── Internal helpers ─────────────────────────────────────────────────────────

  /// Returns a fresh access token, de-duplicating concurrent refresh attempts.
  ///
  /// If a refresh is already in progress (because multiple requests received a
  /// 401 simultaneously) the later callers await the ongoing refresh rather
  /// than firing independent requests.
  Future<String?> _getOrRefreshToken() async {
    if (_refreshCompleter != null) {
      // Another refresh is in progress — wait for it.
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<String?>();
    try {
      final token = await _refreshToken();
      _refreshCompleter!.complete(token);
      return token;
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<String?> _refreshToken() async {
    final refresh = await _tokenStorage.refreshToken;
    if (refresh == null || refresh.isEmpty) return null;

    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refresh},
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
}
