import 'permission.dart';

/// An application-level user with a role assignment.
///
/// This is separate from the thin [shared/models/user.dart] `User` which
/// only carries id/name/email for the auth layer. [AppUser] adds role
/// information for permission checks.
class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    this.isActive = true,
  });

  final String id;
  final String name;
  final String email;

  /// The id of this user's [AppRole].
  final String roleId;

  /// Whether the user account is active.
  final bool isActive;

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? roleId,
    bool? isActive,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      roleId: roleId ?? this.roleId,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AppUser(id: $id, name: $name, roleId: $roleId)';
}
