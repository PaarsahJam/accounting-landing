class ApiConfig {
  ApiConfig._();

  // ---------------------------------------------------------------------------
  // Base URL
  // ---------------------------------------------------------------------------

  /// The compile-time value of the `API_BASE_URL` dart-define.
  /// Empty string when the flag was not provided.
  static const String _envUrl = String.fromEnvironment('API_BASE_URL');

  /// The API base URL used by [ApiClient] and [AuthTokenRefresher].
  ///
  /// Resolution order:
  ///   1. The `--dart-define=API_BASE_URL=<value>` compile-time flag (always
  ///      used in production builds via CI).
  ///   2. `http://localhost:8080/api` — debug/test fallback only.
  ///
  /// An assertion fires in debug builds when [_envUrl] is empty, making it
  /// immediately visible during development if the flag is missing.  In a
  /// release build the assertion is stripped and the localhost fallback is used,
  /// but a release build that forgets the flag will produce visibly broken
  /// network calls rather than silently hitting the wrong host.
  static String get baseUrl {
    assert(
      _envUrl.isNotEmpty ||
          !const bool.fromEnvironment('dart.vm.product'),
      'API_BASE_URL is not set. '
      'Pass --dart-define=API_BASE_URL=https://your.api.com at build time.',
    );
    return _envUrl.isNotEmpty ? _envUrl : 'http://localhost:8080/api';
  }

  // ---------------------------------------------------------------------------
  // Timeouts
  // ---------------------------------------------------------------------------

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 10);

  // ---------------------------------------------------------------------------
  // Secure-storage keys
  // ---------------------------------------------------------------------------

  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
}
