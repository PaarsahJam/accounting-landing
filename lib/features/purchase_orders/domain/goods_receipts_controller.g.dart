// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_receipts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoodsReceiptsController)
final goodsReceiptsControllerProvider = GoodsReceiptsControllerProvider._();

final class GoodsReceiptsControllerProvider
    extends
        $AsyncNotifierProvider<GoodsReceiptsController, List<GoodsReceipt>> {
  GoodsReceiptsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goodsReceiptsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goodsReceiptsControllerHash();

  @$internal
  @override
  GoodsReceiptsController create() => GoodsReceiptsController();
}

String _$goodsReceiptsControllerHash() =>
    r'1eefceee209e27c58a4d0ba446385398980d6383';

abstract class _$GoodsReceiptsController
    extends $AsyncNotifier<List<GoodsReceipt>> {
  FutureOr<List<GoodsReceipt>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<GoodsReceipt>>, List<GoodsReceipt>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GoodsReceipt>>, List<GoodsReceipt>>,
              AsyncValue<List<GoodsReceipt>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
