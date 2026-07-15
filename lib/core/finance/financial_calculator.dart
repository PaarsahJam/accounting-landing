import 'financial_summary.dart';

class FinancialCalculator {
  const FinancialCalculator();

  double calculateRevenue({
    required double baseAmount,
    required String periodId,
  }) {
    // Mock growth for yearly aggregates
    return baseAmount * (periodId == 'year' ? 1.15 : 1.0);
  }

  double calculateExpenses({required double baseAmount}) => baseAmount * 0.45;

  double calculateNetIncome({
    required double revenue,
    required double expenses,
  }) => revenue - expenses;

  double calculateCashFlow({required double baseAmount}) => baseAmount * 0.35;

  double calculateAssets({required double baseAmount}) => baseAmount * 0.9;

  double calculateLiabilities({required double baseAmount}) =>
      baseAmount * 0.15;

  double calculateEquity({
    required double assets,
    required double liabilities,
  }) => assets - liabilities;

  FinancialSummary calculateFinancialSummary({
    required double baseAmount,
    required String periodId,
  }) {
    final revenue = calculateRevenue(
      baseAmount: baseAmount,
      periodId: periodId,
    );
    final expenses = calculateExpenses(baseAmount: baseAmount);
    final netIncome = calculateNetIncome(revenue: revenue, expenses: expenses);
    final cashBalance = calculateCashFlow(baseAmount: baseAmount);
    final assets = calculateAssets(baseAmount: baseAmount);
    final liabilities = calculateLiabilities(baseAmount: baseAmount);
    final equity = calculateEquity(assets: assets, liabilities: liabilities);

    return FinancialSummary(
      revenue: revenue,
      expenses: expenses,
      netIncome: netIncome,
      cashBalance: cashBalance,
      assets: assets,
      liabilities: liabilities,
      equity: equity,
    );
  }
}
