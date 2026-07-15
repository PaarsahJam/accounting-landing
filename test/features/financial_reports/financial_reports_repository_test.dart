import 'package:accounting_app/features/financial_reports/data/financial_reports_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialReportsRepository', () {
    late FinancialReportsRepository repository;

    setUp(() {
      repository = MockFinancialReportsRepository();
    });

    test('aggregates trial balance and totals across sources', () async {
      final result = await repository.fetchTrialBalance(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.rows, isNotEmpty);
      expect(result.data!.totalDebits, greaterThan(0));
      expect(result.data!.totalCredits, greaterThan(0));
      expect(result.data!.isBalanced, isTrue);
    });

    test('builds profit and loss statements with totals', () async {
      final result = await repository.fetchProfitAndLoss(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.totalRevenue, greaterThan(0));
      expect(result.data!.totalExpenses, greaterThan(0));
      expect(result.data!.grossProfit, greaterThanOrEqualTo(0));
      expect(result.data!.netProfit, greaterThanOrEqualTo(0));
    });

    test('builds a balance sheet summary and validation state', () async {
      final result = await repository.fetchBalanceSheet(
        asOf: DateTime(2026, 1, 31),
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.assets, greaterThan(0));
      expect(result.data!.liabilities, greaterThanOrEqualTo(0));
      expect(result.data!.equity, greaterThanOrEqualTo(0));
      expect(result.data!.isBalanced, isTrue);
    });

    test('builds cash flow summary from inflows and outflows', () async {
      final result = await repository.fetchCashFlowSummary(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.inflow, greaterThan(0));
      expect(result.data!.outflow, greaterThan(0));
      expect(result.data!.netChange, greaterThanOrEqualTo(0));
    });
  });
}
