// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WarehouseController)
final warehouseControllerProvider = WarehouseControllerProvider._();

final class WarehouseControllerProvider
    extends $AsyncNotifierProvider<WarehouseController, List<Warehouse>> {
  WarehouseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'warehouseControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$warehouseControllerHash();

  @$internal
  @override
  WarehouseController create() => WarehouseController();
}

String _$warehouseControllerHash() =>
    r'1cd062b55fbfcbd05f9b4677ee6050e998813e56';

abstract class _$WarehouseController extends $AsyncNotifier<List<Warehouse>> {
  FutureOr<List<Warehouse>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Warehouse>>, List<Warehouse>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Warehouse>>, List<Warehouse>>,
              AsyncValue<List<Warehouse>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
