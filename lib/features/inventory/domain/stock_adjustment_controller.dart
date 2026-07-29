import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../../user_roles/domain/authorization.dart';
import '../../user_roles/domain/permission.dart';
import '../data/inventory_repository.dart';
import '../data/inventory_repository_provider.dart';
import 'stock_adjustment.dart';

part 'stock_adjustment_controller.g.dart';

@riverpod
class StockAdjustmentController extends _$StockAdjustmentController {
  late final InventoryRepository _repository;

  @override
  FutureOr<List<StockAdjustment>> build() async {
    _repository = ref.watch(inventoryRepositoryProvider);
    final result = await _repository.fetchAdjustments();
    if (result.isSuccess) {
      return result.data ?? const <StockAdjustment>[];
    }
    AppLogger.warning('Failed to load adjustments', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createAdjustment(StockAdjustment adjustment) async {
    ref.requirePermission(Permission.adjustStock, action: 'create stock adjustments');
    try {
      final result = await _repository.createAdjustment(adjustment);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([result.data!, ...current]);
    } catch (e, st) {
      AppLogger.warning('Failed to create adjustment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchAdjustments();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <StockAdjustment>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh adjustments', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
