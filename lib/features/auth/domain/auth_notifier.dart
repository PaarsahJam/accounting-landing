import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/auth_token_storage_provider.dart';
import '../../../core/company/company_controller.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/auth_repository.dart';
import '../data/auth_repository_provider.dart';
import '../../../shared/models/user.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _repo;

  @override
  FutureOr<User?> build() async {
    // Repository is injected via authRepositoryProvider so that tests and
    // main.dart can supply a mock or real implementation through
    // ProviderScope overrides — never hardcoded here.
    _repo = ref.watch(authRepositoryProvider);
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

    // 1. Wipe all persisted auth tokens so they cannot be reused across
    //    process restarts or by a different user on the same device.
    await ref.read(authTokenStorageProvider).clearAll();

    // 2. Reset company context so the next user always starts from a clean
    //    company selection rather than inheriting the previous session's
    //    active company.
    ref.invalidate(currentCompanyProvider);

    state = const AsyncValue.data(null);
  }
}
