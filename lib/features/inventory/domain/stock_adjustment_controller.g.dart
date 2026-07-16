// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_adjustment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StockAdjustmentController)
final stockAdjustmentControllerProvider = StockAdjustmentControllerProvider._();

final class StockAdjustmentControllerProvider
    extends
        $AsyncNotifierProvider<
          StockAdjustmentController,
          List<StockAdjustment>
        > {
  StockAdjustmentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockAdjustmentControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockAdjustmentControllerHash();

  @$internal
  @override
  StockAdjustmentController create() => StockAdjustmentController();
}

String _$stockAdjustmentControllerHash() =>
    r'7acae6583596425737e4d5d9eb60967ca78cdf90';

abstract class _$StockAdjustmentController
    extends $AsyncNotifier<List<StockAdjustment>> {
  FutureOr<List<StockAdjustment>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<StockAdjustment>>, List<StockAdjustment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<StockAdjustment>>,
                List<StockAdjustment>
              >,
              AsyncValue<List<StockAdjustment>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
