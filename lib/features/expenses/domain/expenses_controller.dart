import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/expense_repository.dart';
import '../data/expense_repository_provider.dart';
import 'expense.dart';

part 'expenses_controller.g.dart';

@riverpod
class ExpensesController extends _$ExpensesController {
  late final ExpenseRepository _repository;

  @override
  FutureOr<List<Expense>> build() async {
    _repository = ref.watch(expenseRepositoryProvider);
    final result = await _repository.fetchExpenses();
    if (result.isSuccess) {
      return result.data ?? const <Expense>[];
    }
    AppLogger.warning('Failed to load expenses', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createExpense(Expense expense) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createExpense(expense);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create expense', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateExpense(Expense expense) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateExpense(expense);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update expense', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteExpense(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteExpense(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete expense', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchExpenses();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Expense>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh expenses', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
