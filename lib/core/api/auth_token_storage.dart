import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_config.dart';

class AuthTokenStorage {
  const AuthTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<String?> get accessToken =>
      _storage.read(key: ApiConfig.tokenKey);

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: ApiConfig.tokenKey, value: token);

  Future<void> clearAccessToken() =>
      _storage.delete(key: ApiConfig.tokenKey);

  Future<String?> get refreshToken =>
      _storage.read(key: ApiConfig.refreshTokenKey);

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: ApiConfig.refreshTokenKey, value: token);

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
