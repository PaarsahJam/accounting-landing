// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_bills_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorBillsRepository)
final vendorBillsRepositoryProvider = VendorBillsRepositoryProvider._();

final class VendorBillsRepositoryProvider
    extends
        $FunctionalProvider<
          VendorBillsRepository,
          VendorBillsRepository,
          VendorBillsRepository
        >
    with $Provider<VendorBillsRepository> {
  VendorBillsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorBillsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorBillsRepositoryHash();

  @$internal
  @override
  $ProviderElement<VendorBillsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VendorBillsRepository create(Ref ref) {
    return vendorBillsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorBillsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorBillsRepository>(value),
    );
  }
}

String _$vendorBillsRepositoryHash() =>
    r'acbac8f00f4fd08b231d4690431f59a3e12d1164';
