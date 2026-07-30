// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StockTransfersController)
final stockTransfersControllerProvider = StockTransfersControllerProvider._();

final class StockTransfersControllerProvider
    extends
        $AsyncNotifierProvider<
          StockTransfersController,
          List<StockTransferRecord>
        > {
  StockTransfersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockTransfersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockTransfersControllerHash();

  @$internal
  @override
  StockTransfersController create() => StockTransfersController();
}

String _$stockTransfersControllerHash() =>
    r'b0eacbc714c72e091b7e9ced52a7e035e8601a9f';

abstract class _$StockTransfersController
    extends $AsyncNotifier<List<StockTransferRecord>> {
  FutureOr<List<StockTransferRecord>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<StockTransferRecord>>,
              List<StockTransferRecord>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<StockTransferRecord>>,
                List<StockTransferRecord>
              >,
              AsyncValue<List<StockTransferRecord>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
