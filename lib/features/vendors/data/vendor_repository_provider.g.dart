// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorRepository)
final vendorRepositoryProvider = VendorRepositoryProvider._();

final class VendorRepositoryProvider
    extends
        $FunctionalProvider<
          VendorRepository,
          VendorRepository,
          VendorRepository
        >
    with $Provider<VendorRepository> {
  VendorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorRepositoryHash();

  @$internal
  @override
  $ProviderElement<VendorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VendorRepository create(Ref ref) {
    return vendorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorRepository>(value),
    );
  }
}

String _$vendorRepositoryHash() => r'4474bec80c716e568c4cf2d8c27dffd985de3f5f';
