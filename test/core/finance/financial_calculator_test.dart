import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/finance/financial_calculator.dart';
import 'package:accounting_app/core/finance/financial_summary.dart';

void main() {
  group('FinancialCalculator', () {
    final calculator = const FinancialCalculator();

    test('calculates revenue with yearly uplift', () {
      final rev = calculator.calculateRevenue(
        baseAmount: 100.0,
        periodId: 'year',
      );
      expect(rev, closeTo(115.0, 1e-6));
    });

    test('calculates expenses as 45% of base', () {
      final exp = calculator.calculateExpenses(baseAmount: 200.0);
      expect(exp, 90.0);
    });

    test('produces a FinancialSummary with expected fields', () {
      final summary = calculator.calculateFinancialSummary(
        baseAmount: 1000.0,
        periodId: 'month',
      );
      expect(summary, isA<FinancialSummary>());
      expect(summary.revenue, greaterThan(0));
      expect(summary.expenses, greaterThan(0));
      expect(summary.netIncome, summary.revenue - summary.expenses);
    });
  });
}
