// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_payments_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorPaymentsRepository)
final vendorPaymentsRepositoryProvider = VendorPaymentsRepositoryProvider._();

final class VendorPaymentsRepositoryProvider
    extends
        $FunctionalProvider<
          VendorPaymentsRepository,
          VendorPaymentsRepository,
          VendorPaymentsRepository
        >
    with $Provider<VendorPaymentsRepository> {
  VendorPaymentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorPaymentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorPaymentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<VendorPaymentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VendorPaymentsRepository create(Ref ref) {
    return vendorPaymentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorPaymentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorPaymentsRepository>(value),
    );
  }
}

String _$vendorPaymentsRepositoryHash() =>
    r'717ab31aaf99356c1a8de1e787504c6ec313bd24';
