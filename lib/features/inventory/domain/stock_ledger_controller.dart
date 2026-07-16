import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/inventory_repository.dart';
import '../data/inventory_repository_provider.dart';
import 'stock_ledger_entry.dart';

part 'stock_ledger_controller.g.dart';

/// State for the stock ledger: all entries for a product (optionally filtered
/// to one warehouse) with a summary.
class StockLedgerState {
  const StockLedgerState({
    required this.productId,
    required this.entries,
    this.warehouseFilter,
  });

  final String productId;
  final List<StockLedgerEntry> entries;
  final String? warehouseFilter;

  double get currentBalance =>
      entries.isEmpty ? 0 : entries.last.runningBalance;

  double get totalInbound => entries
      .where((e) => e.quantity > 0)
      .fold(0, (sum, e) => sum + e.quantity);

  double get totalOutbound => entries
      .where((e) => e.quantity < 0)
      .fold(0, (sum, e) => sum + e.quantity.abs());

  double get totalValue => entries.fold(0, (sum, e) => sum + e.lineValue);

  StockLedgerState copyWith({
    String? productId,
    List<StockLedgerEntry>? entries,
    Object? warehouseFilter = _sentinel,
  }) {
    return StockLedgerState(
      productId: productId ?? this.productId,
      entries: entries ?? this.entries,
      warehouseFilter: warehouseFilter == _sentinel
          ? this.warehouseFilter
          : warehouseFilter as String?,
    );
  }
}

const _sentinel = Object();

@riverpod
class StockLedgerController extends _$StockLedgerController {
  late final InventoryRepository _repository;

  @override
  FutureOr<StockLedgerState> build(String productId) async {
    _repository = ref.watch(inventoryRepositoryProvider);
    final result = await _repository.fetchLedger(productId: productId);
    if (result.isSuccess) {
      return StockLedgerState(
        productId: productId,
        entries: result.data ?? const [],
      );
    }
    AppLogger.warning('Failed to load stock ledger', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  void setWarehouseFilter(String? warehouseId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(warehouseFilter: warehouseId));
  }

  Future<void> refresh() async {
    final current = state.value;
    final id = current?.productId ?? productId;
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchLedger(productId: id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(
        StockLedgerState(productId: id, entries: result.data ?? const []),
      );
    } catch (e, st) {
      AppLogger.warning('Failed to refresh stock ledger', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
