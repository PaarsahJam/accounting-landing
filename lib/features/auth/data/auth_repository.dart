import 'dart:async';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../shared/models/user.dart';

abstract class AuthRepository {
  Future<AppResult<User?>> login({
    required String email,
    required String password,
  });

  Future<AppResult<User?>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AppResult<void>> logout();
  Future<AppResult<User?>> currentUser();
}

class MockAuthRepository implements AuthRepository {
  User? _user;

  @override
  Future<AppResult<User?>> login({
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _user = User(id: '1', name: 'Demo User', email: email);
      return AppResult.success(_user);
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
      await Future.delayed(const Duration(milliseconds: 500));
      _user = User(id: '1', name: name, email: email);
      return AppResult.success(_user);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> logout() async {
    try {
      _user = null;
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<User?>> currentUser() async {
    try {
      return AppResult.success(_user);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
