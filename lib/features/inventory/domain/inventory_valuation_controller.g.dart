// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_valuation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InventoryValuationController)
final inventoryValuationControllerProvider =
    InventoryValuationControllerProvider._();

final class InventoryValuationControllerProvider
    extends
        $AsyncNotifierProvider<InventoryValuationController, ValuationState> {
  InventoryValuationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inventoryValuationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inventoryValuationControllerHash();

  @$internal
  @override
  InventoryValuationController create() => InventoryValuationController();
}

String _$inventoryValuationControllerHash() =>
    r'fbcee5379e86d396696b4a9e88fa07f610c930ef';

abstract class _$InventoryValuationController
    extends $AsyncNotifier<ValuationState> {
  FutureOr<ValuationState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ValuationState>, ValuationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ValuationState>, ValuationState>,
              AsyncValue<ValuationState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
