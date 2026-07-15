import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/inventory_repository.dart';
import '../data/inventory_repository_provider.dart';
import 'stock_movement.dart';
import 'stock_record.dart';
import 'warehouse.dart';

part 'warehouse_controller.g.dart';

@riverpod
class WarehouseController extends _$WarehouseController {
  late final InventoryRepository _repository;

  @override
  FutureOr<List<Warehouse>> build() async {
    _repository = ref.watch(inventoryRepositoryProvider);
    final result = await _repository.fetchWarehouses();
    if (result.isSuccess) {
      return result.data ?? const <Warehouse>[];
    }
    AppLogger.warning('Failed to load warehouses', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<List<StockRecord>> fetchStockRecords(String productId) async {
    final result = await _repository.fetchStockRecords(productId);
    if (result.isSuccess) {
      return result.data ?? const <StockRecord>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<List<StockMovement>> fetchMovements(String productId) async {
    final result = await _repository.fetchStockMovements(productId);
    if (result.isSuccess) {
      return result.data ?? const <StockMovement>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }
}
