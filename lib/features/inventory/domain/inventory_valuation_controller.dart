import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/inventory_repository.dart';
import '../data/inventory_repository_provider.dart';
import 'inventory_valuation.dart';

part 'inventory_valuation_controller.g.dart';

/// State for inventory valuation — all products across all warehouses.
class ValuationState {
  const ValuationState({required this.valuations, required this.valuationDate});

  final List<InventoryValuation> valuations;
  final DateTime valuationDate;

  double get grandTotalValue =>
      valuations.fold(0, (sum, v) => sum + v.totalValue);

  int get totalProducts => valuations.map((v) => v.productId).toSet().length;

  int get totalWarehouses =>
      valuations.map((v) => v.warehouseId).toSet().length;
}

@riverpod
class InventoryValuationController extends _$InventoryValuationController {
  late final InventoryRepository _repository;

  @override
  FutureOr<ValuationState> build() async {
    _repository = ref.watch(inventoryRepositoryProvider);
    final result = await _repository.fetchValuation();
    if (result.isSuccess) {
      return ValuationState(
        valuations: result.data ?? const [],
        valuationDate: DateTime.now(),
      );
    }
    AppLogger.warning(
      'Failed to load inventory valuation',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchValuation();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(
        ValuationState(
          valuations: result.data ?? const [],
          valuationDate: DateTime.now(),
        ),
      );
    } catch (e, st) {
      AppLogger.warning('Failed to refresh valuation', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
