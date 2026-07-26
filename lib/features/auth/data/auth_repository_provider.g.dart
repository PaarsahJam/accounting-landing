// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the active [AuthRepository] implementation.
///
/// In debug/test builds this is overridden with [MockAuthRepository] via
/// `ProviderScope(overrides: [...])` in `main.dart`.  In production builds
/// the provider body is never reached because the override is always present;
/// the [UnimplementedError] acts as a compile-time safeguard against
/// accidentally shipping a build that forgot to wire the real backend.

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

/// Provides the active [AuthRepository] implementation.
///
/// In debug/test builds this is overridden with [MockAuthRepository] via
/// `ProviderScope(overrides: [...])` in `main.dart`.  In production builds
/// the provider body is never reached because the override is always present;
/// the [UnimplementedError] acts as a compile-time safeguard against
/// accidentally shipping a build that forgot to wire the real backend.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Provides the active [AuthRepository] implementation.
  ///
  /// In debug/test builds this is overridden with [MockAuthRepository] via
  /// `ProviderScope(overrides: [...])` in `main.dart`.  In production builds
  /// the provider body is never reached because the override is always present;
  /// the [UnimplementedError] acts as a compile-time safeguard against
  /// accidentally shipping a build that forgot to wire the real backend.
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'f31522efb0e3c8cae08bf1e2b493eb4542c503a5';
