// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_ledger_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StockLedgerController)
final stockLedgerControllerProvider = StockLedgerControllerFamily._();

final class StockLedgerControllerProvider
    extends $AsyncNotifierProvider<StockLedgerController, StockLedgerState> {
  StockLedgerControllerProvider._({
    required StockLedgerControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'stockLedgerControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$stockLedgerControllerHash();

  @override
  String toString() {
    return r'stockLedgerControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StockLedgerController create() => StockLedgerController();

  @override
  bool operator ==(Object other) {
    return other is StockLedgerControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$stockLedgerControllerHash() =>
    r'827034b8562efb0577dfd7356b702cd509ab6a1e';

final class StockLedgerControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          StockLedgerController,
          AsyncValue<StockLedgerState>,
          StockLedgerState,
          FutureOr<StockLedgerState>,
          String
        > {
  StockLedgerControllerFamily._()
    : super(
        retry: null,
        name: r'stockLedgerControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StockLedgerControllerProvider call(String productId) =>
      StockLedgerControllerProvider._(argument: productId, from: this);

  @override
  String toString() => r'stockLedgerControllerProvider';
}

abstract class _$StockLedgerController
    extends $AsyncNotifier<StockLedgerState> {
  late final _$args = ref.$arg as String;
  String get productId => _$args;

  FutureOr<StockLedgerState> build(String productId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<StockLedgerState>, StockLedgerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StockLedgerState>, StockLedgerState>,
              AsyncValue<StockLedgerState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
