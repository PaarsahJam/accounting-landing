// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_statements_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vendorStatementsRepository)
final vendorStatementsRepositoryProvider =
    VendorStatementsRepositoryProvider._();

final class VendorStatementsRepositoryProvider
    extends
        $FunctionalProvider<
          VendorStatementsRepository,
          VendorStatementsRepository,
          VendorStatementsRepository
        >
    with $Provider<VendorStatementsRepository> {
  VendorStatementsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vendorStatementsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vendorStatementsRepositoryHash();

  @$internal
  @override
  $ProviderElement<VendorStatementsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VendorStatementsRepository create(Ref ref) {
    return vendorStatementsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VendorStatementsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VendorStatementsRepository>(value),
    );
  }
}

String _$vendorStatementsRepositoryHash() =>
    r'59a2af694d76ecda763eb189eeeb5d8f6ad6c362';
