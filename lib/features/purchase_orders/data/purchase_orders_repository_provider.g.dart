// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_orders_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(purchaseOrdersRepository)
final purchaseOrdersRepositoryProvider = PurchaseOrdersRepositoryProvider._();

final class PurchaseOrdersRepositoryProvider
    extends
        $FunctionalProvider<
          PurchaseOrdersRepository,
          PurchaseOrdersRepository,
          PurchaseOrdersRepository
        >
    with $Provider<PurchaseOrdersRepository> {
  PurchaseOrdersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseOrdersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseOrdersRepositoryHash();

  @$internal
  @override
  $ProviderElement<PurchaseOrdersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchaseOrdersRepository create(Ref ref) {
    return purchaseOrdersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseOrdersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseOrdersRepository>(value),
    );
  }
}

String _$purchaseOrdersRepositoryHash() =>
    r'416a6ab5994712cc993f15c83952dc67cbad8c3d';
