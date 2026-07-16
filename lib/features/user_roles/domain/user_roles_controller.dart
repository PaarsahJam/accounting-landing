import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/user_repository_provider.dart';
import '../domain/app_user.dart';
import '../domain/permission.dart';
import '../domain/permission_service.dart';

part 'user_roles_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Roles list
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class RolesController extends _$RolesController {
  @override
  FutureOr<List<AppRole>> build() async {
    final repo = ref.watch(userRepositoryProvider);
    final result = await repo.fetchRoles();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load roles', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Users list
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class UsersController extends _$UsersController {
  @override
  FutureOr<List<AppUser>> build() async {
    final repo = ref.watch(userRepositoryProvider);
    final result = await repo.fetchUsers();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning('Failed to load users', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<AppUser>?> createUser(AppUser user) async {
    try {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo.createUser(user);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to create user', error: result.error);
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([...current, result.data!]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error creating user', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> assignRole(String userId, String roleId) async {
    try {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo.assignRole(userId, roleId);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to assign role', error: result.error);
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error assigning role', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deactivateUser(String userId) async {
    try {
      final repo = ref.read(userRepositoryProvider);
      final result = await repo.deactivateUser(userId);
      if (!result.isSuccess) {
        AppLogger.warning('Failed to deactivate user', error: result.error);
        return false;
      }
      // Update in-state: mark isActive = false
      final current = state.value ?? const [];
      state = AsyncValue.data(
        current
            .map((u) => u.id == userId ? u.copyWith(isActive: false) : u)
            .toList(),
      );
      return true;
    } catch (e, st) {
      AppLogger.warning('Unexpected error deactivating user', error: e);
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void _replaceInState(AppUser updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((u) => u.id == updated.id ? updated : u).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Current signed-in app user
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class CurrentUserController extends _$CurrentUserController {
  @override
  FutureOr<AppUser?> build() async {
    final repo = ref.watch(userRepositoryProvider);
    final result = await repo.currentUser();
    if (result.isSuccess) return result.data;
    AppLogger.warning('Failed to load current user', error: result.error);
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Permission check helper provider
// ─────────────────────────────────────────────────────────────────────────────

/// Returns `true` if the current user has [permission].
///
/// Usage:
/// ```dart
/// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
/// ```
@riverpod
bool hasPermission(Ref ref, Permission permission) {
  final userAsync = ref.watch(currentUserControllerProvider);
  final rolesAsync = ref.watch(rolesControllerProvider);

  final user = userAsync.value;
  final roles = rolesAsync.value ?? const [];

  return permissionService.can(user, roles, permission);
}
