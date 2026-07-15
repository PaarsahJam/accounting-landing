import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/inventory_repository.dart';
import '../data/inventory_repository_provider.dart';
import 'product.dart';
import 'product_category.dart';
import 'stock_movement.dart';
import 'unit_of_measure.dart';
import 'warehouse.dart';

part 'inventory_controller.g.dart';

@riverpod
class InventoryController extends _$InventoryController {
  late final InventoryRepository _repository;

  @override
  FutureOr<List<Product>> build() async {
    _repository = ref.watch(inventoryRepositoryProvider);
    final result = await _repository.fetchProducts();
    if (result.isSuccess) {
      return result.data ?? const <Product>[];
    }
    AppLogger.warning('Failed to load inventory products', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createProduct(Product product) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createProduct(product);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create product', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProduct(Product product) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateProduct(product);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update product', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteProduct(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete product', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<ProductCategory>> fetchCategories() async {
    final result = await _repository.fetchCategories();
    if (result.isSuccess) {
      return result.data ?? const <ProductCategory>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<List<UnitOfMeasure>> fetchUnits() async {
    final result = await _repository.fetchUnits();
    if (result.isSuccess) {
      return result.data ?? const <UnitOfMeasure>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<List<Warehouse>> fetchWarehouses() async {
    final result = await _repository.fetchWarehouses();
    if (result.isSuccess) {
      return result.data ?? const <Warehouse>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<List<StockMovement>> fetchStockMovements(String productId) async {
    final result = await _repository.fetchStockMovements(productId);
    if (result.isSuccess) {
      return result.data ?? const <StockMovement>[];
    }
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchProducts();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Product>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh inventory', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
