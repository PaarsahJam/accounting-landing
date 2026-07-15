import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/bank_reconciliation_repository.dart';
import '../data/bank_reconciliation_repository_provider.dart';
import 'bank_reconciliation_models.dart';

part 'bank_reconciliation_controller.g.dart';

@riverpod
class BankReconciliationController extends _$BankReconciliationController {
  late final BankReconciliationRepository _repository;

  @override
  FutureOr<Map<String, dynamic>> build() async {
    _repository = ref.watch(bankReconciliationRepositoryProvider);
    final accountsResult = await _repository.loadBankAccounts();
    if (!accountsResult.isSuccess) {
      throw accountsResult.error ??
          const UnknownFailure(message: 'Unable to load accounts');
    }

    final firstAccount = accountsResult.data!.first;
    final transactionsResult = await _repository.loadTransactions(
      firstAccount.id,
    );
    if (!transactionsResult.isSuccess) {
      throw transactionsResult.error ??
          const UnknownFailure(message: 'Unable to load transactions');
    }

    return {
      'accounts': accountsResult.data!,
      'selectedAccount': firstAccount,
      'transactions': transactionsResult.data!,
      'session': null,
    };
  }

  Future<void> selectAccount(String accountId) async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final accounts = current['accounts'] as List<BankAccount>;
      final selected = accounts.firstWhere(
        (account) => account.id == accountId,
      );
      final transactionsResult = await _repository.loadTransactions(
        selected.id,
      );
      if (!transactionsResult.isSuccess) {
        throw transactionsResult.error ??
            const UnknownFailure(message: 'Unable to load transactions');
      }
      state = AsyncValue.data({
        ...current,
        'selectedAccount': selected,
        'transactions': transactionsResult.data!,
      });
    } catch (e, st) {
      AppLogger.warning('Failed to select account', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> matchTransaction({
    required String transactionId,
    required String ledgerEntryId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final result = await _repository.matchTransaction(
        transactionId: transactionId,
        ledgerEntryId: ledgerEntryId,
      );
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Unable to match transaction');
      }
      final transactions = (current['transactions'] as List<BankTransaction>)
          .map((item) {
            if (item.id == result.data!.id) {
              return result.data!;
            }
            return item;
          })
          .toList();
      state = AsyncValue.data({...current, 'transactions': transactions});
    } catch (e, st) {
      AppLogger.warning('Failed to match transaction', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> unmatchTransaction(String transactionId) async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final result = await _repository.unmatchTransaction(transactionId);
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Unable to unmatch transaction');
      }
      final transactions = (current['transactions'] as List<BankTransaction>)
          .map((item) {
            if (item.id == result.data!.id) {
              return result.data!;
            }
            return item;
          })
          .toList();
      state = AsyncValue.data({...current, 'transactions': transactions});
    } catch (e, st) {
      AppLogger.warning('Failed to unmatch transaction', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> finalize() async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final selected = current['selectedAccount'] as BankAccount;
      final result = await _repository.finalizeReconciliation(selected.id);
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Unable to finalize reconciliation');
      }
      state = AsyncValue.data({...current, 'session': result.data!});
    } catch (e, st) {
      AppLogger.warning('Failed to finalize reconciliation', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
