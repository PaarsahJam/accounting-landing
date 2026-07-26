// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the singleton [AuthTokenStorage] used by both [AuthNotifier]
/// (to clear tokens on logout) and [ApiClient] (to attach tokens to requests).
///
/// Declared `keepAlive: true` because token storage is a long-lived,
/// process-wide resource that should never be auto-disposed.

@ProviderFor(authTokenStorage)
final authTokenStorageProvider = AuthTokenStorageProvider._();

/// Provides the singleton [AuthTokenStorage] used by both [AuthNotifier]
/// (to clear tokens on logout) and [ApiClient] (to attach tokens to requests).
///
/// Declared `keepAlive: true` because token storage is a long-lived,
/// process-wide resource that should never be auto-disposed.

final class AuthTokenStorageProvider
    extends
        $FunctionalProvider<
          AuthTokenStorage,
          AuthTokenStorage,
          AuthTokenStorage
        >
    with $Provider<AuthTokenStorage> {
  /// Provides the singleton [AuthTokenStorage] used by both [AuthNotifier]
  /// (to clear tokens on logout) and [ApiClient] (to attach tokens to requests).
  ///
  /// Declared `keepAlive: true` because token storage is a long-lived,
  /// process-wide resource that should never be auto-disposed.
  AuthTokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenStorageHash();

  @$internal
  @override
  $ProviderElement<AuthTokenStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthTokenStorage create(Ref ref) {
    return authTokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthTokenStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthTokenStorage>(value),
    );
  }
}

String _$authTokenStorageHash() => r'455f421541bc720801df4ca74c716131050af091';
