import '../domain/app_user.dart';
import '../domain/permission.dart';

/// Pure synchronous permission check service.
///
/// Usage:
/// ```dart
/// final svc = PermissionService();
/// if (svc.can(currentUser, roles, Permission.postJournal)) { … }
/// ```
class PermissionService {
  const PermissionService();

  /// Returns `true` if [user] holds [permission] through their [AppRole].
  ///
  /// [roles] is the full list of roles so the service can look up the user's
  /// role by id. Returns `false` if the user is null, inactive, or their role
  /// is not found.
  bool can(AppUser? user, List<AppRole> roles, Permission permission) {
    if (user == null || !user.isActive) return false;
    final role = _roleFor(user, roles);
    if (role == null) return false;
    return role.has(permission);
  }

  /// Returns `true` if [user] holds **all** of [permissions].
  bool canAll(AppUser? user, List<AppRole> roles, Set<Permission> permissions) {
    if (user == null || !user.isActive) return false;
    final role = _roleFor(user, roles);
    if (role == null) return false;
    return permissions.every(role.has);
  }

  /// Returns `true` if [user] holds **any** of [permissions].
  bool canAny(AppUser? user, List<AppRole> roles, Set<Permission> permissions) {
    if (user == null || !user.isActive) return false;
    final role = _roleFor(user, roles);
    if (role == null) return false;
    return permissions.any(role.has);
  }

  /// Returns the [AppRole] for [user], or `null` if not found.
  AppRole? roleFor(AppUser? user, List<AppRole> roles) {
    if (user == null) return null;
    return _roleFor(user, roles);
  }

  AppRole? _roleFor(AppUser user, List<AppRole> roles) {
    try {
      return roles.firstWhere((r) => r.id == user.roleId);
    } catch (_) {
      return null;
    }
  }
}

/// Singleton instance for convenience in widgets and providers.
const permissionService = PermissionService();
