import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/financial_reports/data/financial_reports_repository.dart';
import 'package:accounting_app/features/financial_reports/data/financial_reports_repository_provider.dart';
import 'package:accounting_app/features/financial_reports/domain/financial_reports_controller.dart';
import 'package:accounting_app/features/financial_reports/domain/financial_reports_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('controller loads report data and supports filtering', () async {
    final repository = _FakeFinancialReportsRepository();
    final container = ProviderContainer(
      overrides: [
        financialReportsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(
      financialReportsControllerProvider.notifier,
    );
    final state = await container.read(
      financialReportsControllerProvider.future,
    );

    expect(state, isNotNull);
    expect(state.trialBalance.rows, isNotEmpty);
    expect(state.selectedReport, isNotNull);

    await controller.setReportType('pnl');
    final updated = await container.read(
      financialReportsControllerProvider.future,
    );
    expect(updated.selectedReport, 'pnl');
  });
}

class _FakeFinancialReportsRepository implements FinancialReportsRepository {
  @override
  Future<AppResult<BalanceSheetReport>> fetchBalanceSheet({
    required DateTime asOf,
  }) async {
    return AppResult.success(
      const BalanceSheetReport(
        cash: 1000,
        bank: 500,
        receivables: 200,
        inventory: 300,
        payables: 150,
        equity: 1850,
        assets: 1500,
        liabilities: 150,
        isBalanced: true,
      ),
    );
  }

  @override
  Future<AppResult<CashFlowReport>> fetchCashFlowSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return AppResult.success(
      const CashFlowReport(
        inflow: 4000,
        outflow: 2500,
        netChange: 1500,
        operatingActivities: [ReportLine(label: 'Operating', amount: 4000)],
      ),
    );
  }

  @override
  Future<AppResult<ProfitAndLossReport>> fetchProfitAndLoss({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return AppResult.success(
      const ProfitAndLossReport(
        totalRevenue: 5000,
        totalExpenses: 3000,
        grossProfit: 2000,
        netProfit: 2000,
        revenueRows: [ReportLine(label: 'Revenue', amount: 5000)],
        expenseRows: [ReportLine(label: 'Expenses', amount: 3000)],
      ),
    );
  }

  @override
  Future<AppResult<TrialBalanceReport>> fetchTrialBalance({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return AppResult.success(
      const TrialBalanceReport(
        rows: [
          TrialBalanceRow(
            accountCode: '1000',
            accountName: 'Cash',
            debitTotal: 1000,
            creditTotal: 0,
            endingBalance: 1000,
          ),
        ],
        totalDebits: 1000,
        totalCredits: 0,
        isBalanced: true,
      ),
    );
  }
}
