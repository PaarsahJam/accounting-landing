import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/user_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../shared/models/user.dart';
import 'auth_repository.dart';

class DriftAuthRepository implements AuthRepository {
  final AppDatabase _database;
  final SecureStorage _secureStorage;
  late final UserDao _dao;

  static const _sessionTokenKey = 'session_token';
  static const _sessionDuration = Duration(days: 30);

  DriftAuthRepository({
    AppDatabase? database,
    SecureStorage? secureStorage,
  })  : _database = database ?? AppDatabase(),
        _secureStorage = secureStorage ?? SecureStorage.instance {
    _dao = UserDao(_database);
  }

  @override
  Future<AppResult<User?>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userData = await _dao.getUserByEmail(email.trim().toLowerCase());
      if (userData == null) {
        return AppResult.failure(
          const ValidationFailure(message: 'Invalid email or password'),
        );
      }
      final hash = _hashPassword(password);
      if (hash != userData.passwordHash) {
        return AppResult.failure(
          const ValidationFailure(message: 'Invalid email or password'),
        );
      }
      await _createSession(userData.id);
      return AppResult.success(_toUser(userData));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<User?>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final existing = await _dao.getUserByEmail(normalizedEmail);
      if (existing != null) {
        return AppResult.failure(
          const ValidationFailure(
            message: 'An account with this email already exists',
          ),
        );
      }
      final id = _generateId();
      final hash = _hashPassword(password);
      await _dao.insertUser(UsersTableCompanion.insert(
        id: id,
        name: name.trim(),
        email: normalizedEmail,
        passwordHash: hash,
        createdAt: DateTime.now(),
      ));
      await _createSession(id);
      return AppResult.success(
        User(id: id, name: name.trim(), email: normalizedEmail),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> logout() async {
    try {
      final token = await _secureStorage.read(_sessionTokenKey);
      if (token != null) {
        await _dao.deleteSession(token);
        await _secureStorage.delete(_sessionTokenKey);
      }
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<User?>> currentUser() async {
    try {
      final token = await _secureStorage.read(_sessionTokenKey);
      if (token == null) return AppResult.success(null);
      final session = await _dao.getActiveSession(token);
      if (session == null) {
        await _secureStorage.delete(_sessionTokenKey);
        return AppResult.success(null);
      }
      final userData = await _dao.getUserById(session.userId);
      if (userData == null) {
        await _secureStorage.delete(_sessionTokenKey);
        return AppResult.success(null);
      }
      return AppResult.success(_toUser(userData));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> _createSession(String userId) async {
    await _dao.deleteSessionsByUserId(userId);
    final token = _generateId();
    await _dao.insertSession(UserSessionTableCompanion.insert(
      id: _generateId(),
      userId: userId,
      token: token,
      createdAt: DateTime.now(),
      expiresAt: DateTime.now().add(_sessionDuration),
    ));
    await _secureStorage.write(_sessionTokenKey, token);
  }

  String _generateId() {
    final now = DateTime.now().millisecondsSinceEpoch.toString();
    final rand = Random.secure().nextInt(1 << 32).toRadixString(36);
    return '${now}_$rand';
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  User _toUser(UsersTableData data) => User(
        id: data.id,
        name: data.name,
        email: data.email,
      );
}
