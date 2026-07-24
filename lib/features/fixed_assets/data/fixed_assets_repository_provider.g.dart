// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_assets_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fixedAssetsRepository)
final fixedAssetsRepositoryProvider = FixedAssetsRepositoryProvider._();

final class FixedAssetsRepositoryProvider
    extends
        $FunctionalProvider<
          FixedAssetsRepository,
          FixedAssetsRepository,
          FixedAssetsRepository
        >
    with $Provider<FixedAssetsRepository> {
  FixedAssetsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fixedAssetsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fixedAssetsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FixedAssetsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FixedAssetsRepository create(Ref ref) {
    return fixedAssetsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FixedAssetsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FixedAssetsRepository>(value),
    );
  }
}

String _$fixedAssetsRepositoryHash() =>
    r'3031a317320dd03493186b87fb80556ee1b1f5ef';
