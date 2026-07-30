// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_orders_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PurchaseOrdersController)
final purchaseOrdersControllerProvider = PurchaseOrdersControllerProvider._();

final class PurchaseOrdersControllerProvider
    extends
        $AsyncNotifierProvider<PurchaseOrdersController, List<PurchaseOrder>> {
  PurchaseOrdersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseOrdersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseOrdersControllerHash();

  @$internal
  @override
  PurchaseOrdersController create() => PurchaseOrdersController();
}

String _$purchaseOrdersControllerHash() =>
    r'8caf417496a8670046874e659e1a08f2d08ee3ce';

abstract class _$PurchaseOrdersController
    extends $AsyncNotifier<List<PurchaseOrder>> {
  FutureOr<List<PurchaseOrder>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PurchaseOrder>>, List<PurchaseOrder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PurchaseOrder>>, List<PurchaseOrder>>,
              AsyncValue<List<PurchaseOrder>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
