import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/auth_repository.dart';
import '../../../shared/models/user.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _repo;

  @override
  FutureOr<User?> build() async {
    _repo = MockAuthRepository();
    final result = await _repo.currentUser();
    if (result.isSuccess) {
      return result.data;
    }
    AppLogger.warning('Failed to load current user', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repo.login(email: email, password: password);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data);
    } catch (e, st) {
      AppLogger.warning('Failed to login', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    final result = await _repo.logout();
    if (!result.isSuccess) {
      AppLogger.warning('Failed to logout', error: result.error);
      return;
    }
    state = const AsyncValue.data(null);
  }
}
