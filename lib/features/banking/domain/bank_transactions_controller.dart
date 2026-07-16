import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/banking_repository.dart';
import '../data/banking_repository_provider.dart';
import 'bank_transaction.dart';
import 'bank_transaction_type.dart';

part 'bank_transactions_controller.g.dart';

/// State for bank transactions with filters applied in the controller.
class BankTransactionsState {
  const BankTransactionsState({
    required this.transactions,
    required this.accountId,
    this.typeFilter,
    this.search = '',
    this.dateFrom,
    this.dateTo,
  });

  final List<BankTransaction> transactions;
  final String accountId;
  final BankTransactionType? typeFilter;
  final String search;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  List<BankTransaction> get filtered {
    return transactions.where((txn) {
      if (typeFilter != null && txn.transactionType != typeFilter) return false;
      if (search.isNotEmpty) {
        final q = search.toLowerCase();
        if (!txn.reference.toLowerCase().contains(q) &&
            !txn.description.toLowerCase().contains(q)) {
          return false;
        }
      }
      if (dateFrom != null && txn.date.isBefore(dateFrom!)) return false;
      if (dateTo != null && txn.date.isAfter(dateTo!)) return false;
      return true;
    }).toList();
  }

  BankTransactionsState copyWith({
    List<BankTransaction>? transactions,
    String? accountId,
    Object? typeFilter = _sentinel,
    String? search,
    Object? dateFrom = _sentinel,
    Object? dateTo = _sentinel,
  }) {
    return BankTransactionsState(
      transactions: transactions ?? this.transactions,
      accountId: accountId ?? this.accountId,
      typeFilter: typeFilter == _sentinel
          ? this.typeFilter
          : typeFilter as BankTransactionType?,
      search: search ?? this.search,
      dateFrom: dateFrom == _sentinel ? this.dateFrom : dateFrom as DateTime?,
      dateTo: dateTo == _sentinel ? this.dateTo : dateTo as DateTime?,
    );
  }
}

const _sentinel = Object();

@riverpod
class BankTransactionsController extends _$BankTransactionsController {
  late final BankingRepository _repository;

  @override
  FutureOr<BankTransactionsState> build(String accountId) async {
    _repository = ref.watch(bankingRepositoryProvider);
    final result = await _repository.fetchTransactions(accountId);
    if (result.isSuccess) {
      return BankTransactionsState(
        transactions: result.data ?? const [],
        accountId: accountId,
      );
    }
    AppLogger.warning('Failed to load bank transactions', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  void setTypeFilter(BankTransactionType? type) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(typeFilter: type));
  }

  void setSearch(String query) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(search: query));
  }

  void setDateRange(DateTime? from, DateTime? to) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(dateFrom: from, dateTo: to));
  }

  Future<void> refresh() async {
    final current = state.value;
    final id = current?.accountId ?? accountId;
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchTransactions(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(
        BankTransactionsState(
          transactions: result.data ?? const [],
          accountId: id,
        ),
      );
    } catch (e, st) {
      AppLogger.warning('Failed to refresh bank transactions', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
