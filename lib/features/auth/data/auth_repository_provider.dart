import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_repository.dart';

part 'auth_repository_provider.g.dart';

/// Provides the active [AuthRepository] implementation.
///
/// In debug/test builds this is overridden with [MockAuthRepository] via
/// `ProviderScope(overrides: [...])` in `main.dart`.  In production builds
/// the provider body is never reached because the override is always present;
/// the [UnimplementedError] acts as a compile-time safeguard against
/// accidentally shipping a build that forgot to wire the real backend.
@riverpod
AuthRepository authRepository(Ref ref) {
  throw UnimplementedError(
    'authRepositoryProvider must be overridden with a real or mock '
    'AuthRepository before the app starts. '
    'See lib/main.dart for the override pattern.',
  );
}
