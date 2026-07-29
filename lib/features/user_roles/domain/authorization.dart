import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import 'permission.dart';
import 'user_roles_controller.dart';

/// Controller-side authorization helpers.
///
/// These centralize permission enforcement so protected actions cannot be
/// invoked by bypassing widget-level guards. Call one of these at the top of
/// any controller method that performs a protected mutation/action, matching
/// the method's existing error style:
///
/// * AppResult-returning methods:
///   ```dart
///   final denied = ref.checkPermission(Permission.manageUsers, action: 'create users');
///   if (denied != null) return AppResult.failure(denied);
///   ```
/// * Throw-based methods:
///   ```dart
///   ref.requirePermission(Permission.manageSettings, action: 'execute this transition');
///   ```
/// * AsyncValue.error-based methods:
///   ```dart
///   final denied = ref.checkPermission(Permission.manageSettings, action: 'switch companies');
///   if (denied != null) { state = AsyncValue.error(denied, StackTrace.current); return; }
///   ```
extension AuthorizationX on Ref {
  /// Returns `true` if the current user holds [permission].
  bool can(Permission permission) => read(hasPermissionProvider(permission));

  /// Returns an [AuthorizationFailure] describing the denial when the current
  /// user lacks [permission], or `null` when the action is authorized.
  ///
  /// [action] is a short verb phrase used in both the log line and the
  /// user-facing message (e.g. `'create users'` → "You do not have permission
  /// to create users.").
  AuthorizationFailure? checkPermission(
    Permission permission, {
    required String action,
  }) {
    if (read(hasPermissionProvider(permission))) return null;
    AppLogger.warning(
      'Unauthorized: attempt to $action without ${permission.name} permission.',
    );
    return AuthorizationFailure(
      message: 'You do not have permission to $action.',
    );
  }

  /// Throws an [AuthorizationFailure] when the current user lacks [permission].
  ///
  /// Use in throw-based controller methods.
  void requirePermission(
    Permission permission, {
    required String action,
  }) {
    final failure = checkPermission(permission, action: action);
    if (failure != null) throw failure;
  }
}
