// lib/features/recurring_transactions/domain/recurring_transactions_controller.dart

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../../core/logging/app_logger.dart';
import '../data/recurring_transactions_repository_provider.dart';
import 'recurring_transaction.dart';

part 'recurring_transactions_controller.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Main list controller
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
class RecurringTransactionsController
    extends _$RecurringTransactionsController {
  @override
  FutureOr<List<RecurringTransaction>> build() async {
    final repo = ref.watch(recurringTransactionsRepositoryProvider);
    final result = await repo.fetchRecurringTransactions();
    if (result.isSuccess) return result.data ?? const [];
    AppLogger.warning(
      'Failed to load recurring transactions',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<AppResult<RecurringTransaction>?> create(
    RecurringTransaction transaction,
  ) async {
    try {
      final repo = ref.read(recurringTransactionsRepositoryProvider);
      final result = await repo.createRecurringTransaction(transaction);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to create recurring transaction',
          error: result.error,
        );
        return result;
      }
      final current = state.value ?? const [];
      state = AsyncValue.data([...current, result.data!]);
      return result;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error creating recurring transaction',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<AppResult<RecurringTransaction>?> updateTransaction(
    RecurringTransaction transaction,
  ) async {
    try {
      final repo = ref.read(recurringTransactionsRepositoryProvider);
      final result = await repo.updateRecurringTransaction(transaction);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to update recurring transaction',
          error: result.error,
        );
        return result;
      }
      _replaceInState(result.data!);
      return result;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error updating recurring transaction',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> activate(String id) async {
    try {
      final repo = ref.read(recurringTransactionsRepositoryProvider);
      final result = await repo.activate(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to activate recurring transaction',
          error: result.error,
        );
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error activating recurring transaction',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deactivate(String id) async {
    try {
      final repo = ref.read(recurringTransactionsRepositoryProvider);
      final result = await repo.deactivate(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to deactivate recurring transaction',
          error: result.error,
        );
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error deactivating recurring transaction',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> executeNow(String id) async {
    try {
      final repo = ref.read(recurringTransactionsRepositoryProvider);
      final result = await repo.executeNow(id);
      if (!result.isSuccess) {
        AppLogger.warning(
          'Failed to execute recurring transaction',
          error: result.error,
        );
        return false;
      }
      _replaceInState(result.data!);
      return true;
    } catch (e, st) {
      AppLogger.warning(
        'Unexpected error executing recurring transaction',
        error: e,
      );
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  void _replaceInState(RecurringTransaction updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(
      current.map((t) => t.id == updated.id ? updated : t).toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filtered view providers
// ─────────────────────────────────────────────────────────────────────────────

@riverpod
List<RecurringTransaction> activeRecurringTransactions(Ref ref) {
  final all = ref.watch(recurringTransactionsControllerProvider).value;
  if (all == null) return const [];
  return all.where((t) => t.isActive).toList();
}

@riverpod
List<RecurringTransaction> inactiveRecurringTransactions(Ref ref) {
  final all = ref.watch(recurringTransactionsControllerProvider).value;
  if (all == null) return const [];
  return all.where((t) => !t.isActive).toList();
}
