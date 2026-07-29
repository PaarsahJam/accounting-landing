abstract class AppFailure {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class ValidationFailure extends AppFailure {
  const ValidationFailure({required String message}) : super(message);
}

/// Raised when the current user lacks the permission required to perform an
/// action. Extends [ValidationFailure] so existing call sites and tests that
/// match `isA<ValidationFailure>()` keep working, while a distinct type allows
/// callers to detect authorization denials specifically.
class AuthorizationFailure extends ValidationFailure {
  const AuthorizationFailure({required String message})
      : super(message: message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure({required String message}) : super(message);
}

class StorageFailure extends AppFailure {
  const StorageFailure({required String message}) : super(message);
}

class UnknownFailure extends AppFailure {
  const UnknownFailure({required String message}) : super(message);
}

class SyncFailure extends AppFailure {
  const SyncFailure({required String message, this.conflictingVersion})
      : super(message);
  final int? conflictingVersion;
}

class EmailFailure extends AppFailure {
  const EmailFailure({required String message}) : super(message);
}
