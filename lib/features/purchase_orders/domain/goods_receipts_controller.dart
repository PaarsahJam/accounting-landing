import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/purchase_orders_repository.dart';
import '../data/purchase_orders_repository_provider.dart';
import 'goods_receipt.dart';

part 'goods_receipts_controller.g.dart';

@riverpod
class GoodsReceiptsController extends _$GoodsReceiptsController {
  late final PurchaseOrdersRepository _repository;

  @override
  FutureOr<List<GoodsReceipt>> build() async {
    _repository = ref.watch(purchaseOrdersRepositoryProvider);
    final result = await _repository.fetchGoodsReceipts();
    if (result.isSuccess) {
      return result.data ?? const <GoodsReceipt>[];
    }
    AppLogger.warning('Failed to load goods receipts', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createGoodsReceipt(GoodsReceipt receipt) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createGoodsReceipt(receipt);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create goods receipt', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateGoodsReceipt(GoodsReceipt receipt) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateGoodsReceipt(receipt);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update goods receipt', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchGoodsReceipts();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <GoodsReceipt>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh goods receipts', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
