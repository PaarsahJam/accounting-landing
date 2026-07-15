import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/purchase_orders_repository.dart';
import '../data/purchase_orders_repository_provider.dart';
import 'purchase_order.dart';

part 'purchase_orders_controller.g.dart';

@riverpod
class PurchaseOrdersController extends _$PurchaseOrdersController {
  late final PurchaseOrdersRepository _repository;

  @override
  FutureOr<List<PurchaseOrder>> build() async {
    _repository = ref.watch(purchaseOrdersRepositoryProvider);
    final result = await _repository.fetchPurchaseOrders();
    if (result.isSuccess) {
      return result.data ?? const <PurchaseOrder>[];
    }
    AppLogger.warning('Failed to load purchase orders', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createPurchaseOrder(PurchaseOrder order) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createPurchaseOrder(order);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create purchase order', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updatePurchaseOrder(PurchaseOrder order) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updatePurchaseOrder(order);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update purchase order', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deletePurchaseOrder(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deletePurchaseOrder(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete purchase order', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchPurchaseOrders();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <PurchaseOrder>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh purchase orders', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
