import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/app_user.dart';
import '../domain/permission.dart';

abstract class UserRepository {
  /// Returns all defined roles.
  Future<AppResult<List<AppRole>>> fetchRoles();

  /// Returns all users.
  Future<AppResult<List<AppUser>>> fetchUsers();

  /// Returns the currently "signed-in" user (mock: always alice).
  Future<AppResult<AppUser?>> currentUser();

  /// Assigns a different role to a user.
  Future<AppResult<AppUser>> assignRole(String userId, String roleId);

  /// Updates user details (name / email).
  Future<AppResult<AppUser>> updateUser(AppUser user);

  /// Creates a new user.
  Future<AppResult<AppUser>> createUser(AppUser user);

  /// Deactivates (soft-deletes) a user.
  Future<AppResult<void>> deactivateUser(String userId);
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockUserRepository implements UserRepository {
  MockUserRepository() {
    _seed();
  }

  final List<AppRole> _roles = [];
  final List<AppUser> _users = [];
  int _seq = 1;

  String _nextUserId() => 'USR-${(_seq++).toString().padLeft(4, '0')}';

  void _seed() {
    _roles.addAll(BuiltInRoles.all);

    _users.addAll([
      const AppUser(
        id: 'USR-0001',
        name: 'Alice Admin',
        email: 'alice@example.com',
        roleId: 'role-admin',
      ),
      const AppUser(
        id: 'USR-0002',
        name: 'Bob Manager',
        email: 'bob@example.com',
        roleId: 'role-manager',
      ),
      const AppUser(
        id: 'USR-0003',
        name: 'Carol Accountant',
        email: 'carol@example.com',
        roleId: 'role-accountant',
      ),
      const AppUser(
        id: 'USR-0004',
        name: 'Dave Accountant',
        email: 'dave@example.com',
        roleId: 'role-accountant',
        isActive: false,
      ),
    ]);
    _seq = 5;
  }

  @override
  Future<AppResult<List<AppRole>>> fetchRoles() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_roles));
  }

  @override
  Future<AppResult<List<AppUser>>> fetchUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return AppResult.success(List.unmodifiable(_users));
  }

  @override
  Future<AppResult<AppUser?>> currentUser() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    // Mock: alice is always the signed-in user
    final user = _users.firstWhere(
      (u) => u.id == 'USR-0001',
      orElse: () => const AppUser(
        id: 'USR-0001',
        name: 'Alice Admin',
        email: 'alice@example.com',
        roleId: 'role-admin',
      ),
    );
    return AppResult.success(user);
  }

  @override
  Future<AppResult<AppUser>> assignRole(String userId, String roleId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final userIdx = _users.indexWhere((u) => u.id == userId);
    if (userIdx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'User not found'));
    }
    final roleExists = _roles.any((r) => r.id == roleId);
    if (!roleExists) {
      return AppResult.failure(const UnknownFailure(message: 'Role not found'));
    }
    final updated = _users[userIdx].copyWith(roleId: roleId);
    _users[userIdx] = updated;
    return AppResult.success(updated);
  }

  @override
  Future<AppResult<AppUser>> updateUser(AppUser user) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _users.indexWhere((u) => u.id == user.id);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'User not found'));
    }
    _users[idx] = user;
    return AppResult.success(user);
  }

  @override
  Future<AppResult<AppUser>> createUser(AppUser user) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final roleExists = _roles.any((r) => r.id == user.roleId);
    if (!roleExists) {
      return AppResult.failure(const UnknownFailure(message: 'Role not found'));
    }
    final stored = user.id.isEmpty ? user.copyWith(id: _nextUserId()) : user;
    _users.add(stored);
    return AppResult.success(stored);
  }

  @override
  Future<AppResult<void>> deactivateUser(String userId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));
    final idx = _users.indexWhere((u) => u.id == userId);
    if (idx < 0) {
      return AppResult.failure(const UnknownFailure(message: 'User not found'));
    }
    _users[idx] = _users[idx].copyWith(isActive: false);
    return AppResult.success(null);
  }
}
