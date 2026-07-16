import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/bank_statement_repository.dart';
import '../data/bank_statement_repository_provider.dart';
import 'bank_statement.dart';
import 'bank_statement_status.dart';

part 'bank_reconciliation_detail_controller.g.dart';

/// State for a single statement reconciliation session.
class ReconciliationDetailState {
  const ReconciliationDetailState({required this.statement});

  final BankStatement statement;

  double get difference =>
      statement.closingBalance -
      statement.openingBalance -
      statement.transactions.fold(0.0, (sum, t) => sum + t.amount);

  bool get isBalanced => difference.abs() < 0.01;

  bool get canFinalize =>
      statement.status != BankStatementStatus.reconciled &&
      statement.transactions.isNotEmpty;

  ReconciliationDetailState copyWith({BankStatement? statement}) {
    return ReconciliationDetailState(statement: statement ?? this.statement);
  }
}

@riverpod
class BankReconciliationDetailController
    extends _$BankReconciliationDetailController {
  late final BankStatementRepository _repository;

  @override
  FutureOr<ReconciliationDetailState> build(String statementId) async {
    _repository = ref.watch(bankStatementRepositoryProvider);
    final result = await _repository.fetchStatement(statementId);
    if (result.isSuccess) {
      return ReconciliationDetailState(statement: result.data!);
    }
    AppLogger.warning(
      'Failed to load statement $statementId',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> matchTransaction({
    required String transactionId,
    required String erpEntryId,
    required String erpEntryLabel,
  }) async {
    final current = state.value;
    if (current == null) return;
    try {
      final result = await _repository.matchTransaction(
        statementId: current.statement.id,
        transactionId: transactionId,
        erpEntryId: erpEntryId,
        erpEntryLabel: erpEntryLabel,
      );
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Match failed');
      }
      state = AsyncValue.data(current.copyWith(statement: result.data!));
    } catch (e, st) {
      AppLogger.warning('Failed to match transaction', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> unmatchTransaction(String transactionId) async {
    final current = state.value;
    if (current == null) return;
    try {
      final result = await _repository.unmatchTransaction(
        statementId: current.statement.id,
        transactionId: transactionId,
      );
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unmatch failed');
      }
      state = AsyncValue.data(current.copyWith(statement: result.data!));
    } catch (e, st) {
      AppLogger.warning('Failed to unmatch transaction', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> autoMatch() async {
    final current = state.value;
    if (current == null) return;
    try {
      final result = await _repository.autoMatch(current.statement.id);
      if (!result.isSuccess) {
        throw result.error ??
            const UnknownFailure(message: 'Auto-match failed');
      }
      state = AsyncValue.data(current.copyWith(statement: result.data!));
    } catch (e, st) {
      AppLogger.warning('Failed to auto-match', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> finalizeStatement() async {
    final current = state.value;
    if (current == null) return;
    try {
      final result = await _repository.finalizeStatement(current.statement.id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Finalize failed');
      }
      state = AsyncValue.data(current.copyWith(statement: result.data!));
    } catch (e, st) {
      AppLogger.warning('Failed to finalize statement', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
