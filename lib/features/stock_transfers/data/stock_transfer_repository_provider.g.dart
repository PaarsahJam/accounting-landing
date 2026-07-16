// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfer_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stockTransferRepository)
final stockTransferRepositoryProvider = StockTransferRepositoryProvider._();

final class StockTransferRepositoryProvider
    extends
        $FunctionalProvider<
          StockTransferRepository,
          StockTransferRepository,
          StockTransferRepository
        >
    with $Provider<StockTransferRepository> {
  StockTransferRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockTransferRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockTransferRepositoryHash();

  @$internal
  @override
  $ProviderElement<StockTransferRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StockTransferRepository create(Ref ref) {
    return stockTransferRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StockTransferRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StockTransferRepository>(value),
    );
  }
}

String _$stockTransferRepositoryHash() =>
    r'39e69f32bb553d75dda98ea8d37ed8f1e9dfa5e7';
