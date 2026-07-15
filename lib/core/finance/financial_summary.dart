class FinancialSummary {
  final double revenue;
  final double expenses;
  final double netIncome;
  final double cashBalance;
  final double assets;
  final double liabilities;
  final double equity;

  const FinancialSummary({
    required this.revenue,
    required this.expenses,
    required this.netIncome,
    required this.cashBalance,
    this.assets = 0,
    this.liabilities = 0,
    this.equity = 0,
  });

  FinancialSummary copyWith({
    double? revenue,
    double? expenses,
    double? netIncome,
    double? cashBalance,
    double? assets,
    double? liabilities,
    double? equity,
  }) {
    return FinancialSummary(
      revenue: revenue ?? this.revenue,
      expenses: expenses ?? this.expenses,
      netIncome: netIncome ?? this.netIncome,
      cashBalance: cashBalance ?? this.cashBalance,
      assets: assets ?? this.assets,
      liabilities: liabilities ?? this.liabilities,
      equity: equity ?? this.equity,
    );
  }
}
