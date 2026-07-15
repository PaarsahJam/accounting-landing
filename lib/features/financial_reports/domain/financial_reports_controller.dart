import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/financial_reports_repository.dart';
import '../data/financial_reports_repository_provider.dart';
import 'financial_reports_models.dart';

part 'financial_reports_controller.g.dart';

@riverpod
class FinancialReportsController extends _$FinancialReportsController {
  late final FinancialReportsRepository _repository;

  @override
  FutureOr<FinancialReportsState> build() async {
    _repository = ref.watch(financialReportsRepositoryProvider);
    final startDate = DateTime(2026, 1, 1);
    final endDate = DateTime(2026, 1, 31);
    return _loadState(
      selectedReport: 'tb',
      startDate: startDate,
      endDate: endDate,
      searchTerm: '',
      balanceFilter: 'all',
    );
  }

  Future<void> setReportType(String reportType) async {
    if (!ref.mounted) {
      return;
    }
    final current = state.value;
    if (current == null) {
      return;
    }

    try {
      final nextState = await _loadState(
        selectedReport: reportType,
        startDate: current.startDate,
        endDate: current.endDate,
        searchTerm: current.searchTerm,
        balanceFilter: current.balanceFilter,
      );
      if (!ref.mounted) {
        return;
      }
      state = AsyncValue.data(nextState);
    } catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }
      AppLogger.warning('Failed to change report type', error: error);
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> setRange(DateTime startDate, DateTime endDate) async {
    if (!ref.mounted) {
      return;
    }
    final current = state.value;
    if (current == null) {
      return;
    }

    try {
      final nextState = await _loadState(
        selectedReport: current.selectedReport,
        startDate: startDate,
        endDate: endDate,
        searchTerm: current.searchTerm,
        balanceFilter: current.balanceFilter,
      );
      if (!ref.mounted) {
        return;
      }
      state = AsyncValue.data(nextState);
    } catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }
      AppLogger.warning('Failed to update report range', error: error);
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> setSearchTerm(String searchTerm) async {
    if (!ref.mounted) {
      return;
    }
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncValue.data(current.copyWith(searchTerm: searchTerm));
  }

  Future<void> setBalanceFilter(String balanceFilter) async {
    if (!ref.mounted) {
      return;
    }
    final current = state.value;
    if (current == null) {
      return;
    }
    state = AsyncValue.data(current.copyWith(balanceFilter: balanceFilter));
  }

  Future<FinancialReportsState> _loadState({
    required String selectedReport,
    required DateTime startDate,
    required DateTime endDate,
    required String searchTerm,
    required String balanceFilter,
  }) async {
    final trialBalanceResult = await _repository.fetchTrialBalance(
      startDate: startDate,
      endDate: endDate,
    );
    if (!trialBalanceResult.isSuccess) {
      throw trialBalanceResult.error ??
          const UnknownFailure(message: 'Unable to load trial balance');
    }
    final pnlResult = await _repository.fetchProfitAndLoss(
      startDate: startDate,
      endDate: endDate,
    );
    if (!pnlResult.isSuccess) {
      throw pnlResult.error ??
          const UnknownFailure(message: 'Unable to load profit and loss');
    }
    final balanceSheetResult = await _repository.fetchBalanceSheet(
      asOf: endDate,
    );
    if (!balanceSheetResult.isSuccess) {
      throw balanceSheetResult.error ??
          const UnknownFailure(message: 'Unable to load balance sheet');
    }
    final cashFlowResult = await _repository.fetchCashFlowSummary(
      startDate: startDate,
      endDate: endDate,
    );
    if (!cashFlowResult.isSuccess) {
      throw cashFlowResult.error ??
          const UnknownFailure(message: 'Unable to load cash flow');
    }

    return FinancialReportsState(
      selectedReport: selectedReport,
      startDate: startDate,
      endDate: endDate,
      searchTerm: searchTerm,
      balanceFilter: balanceFilter,
      trialBalance: trialBalanceResult.data!,
      profitAndLoss: pnlResult.data!,
      balanceSheet: balanceSheetResult.data!,
      cashFlow: cashFlowResult.data!,
    );
  }
}

extension FinancialReportsStateX on FinancialReportsState {
  FinancialReportsState copyWith({
    String? selectedReport,
    DateTime? startDate,
    DateTime? endDate,
    String? searchTerm,
    String? balanceFilter,
    TrialBalanceReport? trialBalance,
    ProfitAndLossReport? profitAndLoss,
    BalanceSheetReport? balanceSheet,
    CashFlowReport? cashFlow,
  }) {
    return FinancialReportsState(
      selectedReport: selectedReport ?? this.selectedReport,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      searchTerm: searchTerm ?? this.searchTerm,
      balanceFilter: balanceFilter ?? this.balanceFilter,
      trialBalance: trialBalance ?? this.trialBalance,
      profitAndLoss: profitAndLoss ?? this.profitAndLoss,
      balanceSheet: balanceSheet ?? this.balanceSheet,
      cashFlow: cashFlow ?? this.cashFlow,
    );
  }
}
