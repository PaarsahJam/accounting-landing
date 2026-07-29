import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../../user_roles/domain/authorization.dart';
import '../../user_roles/domain/permission.dart';
import '../data/stock_transfer_repository_provider.dart';
import '../domain/create_transfer_request.dart';
import '../domain/stock_transfer_record.dart';

part 'stock_transfers_controller.g.dart';

@riverpod
class StockTransfersController extends _$StockTransfersController {
  @override
  FutureOr<List<StockTransferRecord>> build() async {
    final repository = ref.watch(stockTransferRepositoryProvider);
    final result = await repository.fetchTransfers();
    if (result.isSuccess) {
      return result.data ?? const [];
    }
    AppLogger.warning('Failed to load stock transfers', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<StockTransferRecord>?> createTransfer(
    CreateTransferRequest request,
  ) async {
    final denied = ref.checkPermission(Permission.adjustStock, action: 'create stock transfers');
    if (denied != null) {
      AppLogger.warning('Unauthorized: create stock transfer denied');
      return AppResult.failure(denied);
    }
    try {
      final repository = ref.read(stockTransferRepositoryProvider);
      final result = await repository.createTransfer(request);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to create transfer',
          error: result.error?.message,
        );
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([result.data!, ...current]);
      return result;
    } catch (e, st) {
      AppLogger.warning('Unexpected error creating transfer', error: e);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> completeTransfer(String id) async {
    final denied = ref.checkPermission(Permission.adjustStock, action: 'complete stock transfers');
    if (denied != null) {
      AppLogger.warning('Unauthorized: complete stock transfer denied');
      state = AsyncValue.error(denied, StackTrace.current);
      return;
    }
    try {
      final repository = ref.read(stockTransferRepositoryProvider);
      final result = await repository.completeTransfer(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to complete transfer',
          error: result.error?.message,
        );
        return;
      }
      _replaceInState(result.data!);
    } catch (e, st) {
      AppLogger.warning('Unexpected error completing transfer', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelTransfer(String id) async {
    final denied = ref.checkPermission(Permission.adjustStock, action: 'cancel stock transfers');
    if (denied != null) {
      AppLogger.warning('Unauthorized: cancel stock transfer denied');
      state = AsyncValue.error(denied, StackTrace.current);
      return;
    }
    try {
      final repository = ref.read(stockTransferRepositoryProvider);
      final result = await repository.cancelTransfer(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to cancel transfer',
          error: result.error?.message,
        );
        return;
      }
      _replaceInState(result.data!);
    } catch (e, st) {
      AppLogger.warning('Unexpected error cancelling transfer', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(stockTransferRepositoryProvider);
      final result = await repository.fetchTransfers();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const []);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh transfers', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  void _replaceInState(StockTransferRecord updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((r) => r.id == updated.id ? updated : r).toList(),
    );
  }
}
