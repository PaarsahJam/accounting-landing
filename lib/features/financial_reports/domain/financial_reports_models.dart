class TrialBalanceRow {
  const TrialBalanceRow({
    required this.accountCode,
    required this.accountName,
    required this.debitTotal,
    required this.creditTotal,
    required this.endingBalance,
  });

  final String accountCode;
  final String accountName;
  final double debitTotal;
  final double creditTotal;
  final double endingBalance;
}

class TrialBalanceReport {
  const TrialBalanceReport({
    required this.rows,
    required this.totalDebits,
    required this.totalCredits,
    required this.isBalanced,
  });

  final List<TrialBalanceRow> rows;
  final double totalDebits;
  final double totalCredits;
  final bool isBalanced;
}

class ProfitAndLossReport {
  const ProfitAndLossReport({
    required this.totalRevenue,
    required this.totalExpenses,
    required this.grossProfit,
    required this.netProfit,
    required this.revenueRows,
    required this.expenseRows,
  });

  final double totalRevenue;
  final double totalExpenses;
  final double grossProfit;
  final double netProfit;
  final List<ReportLine> revenueRows;
  final List<ReportLine> expenseRows;
}

class BalanceSheetReport {
  const BalanceSheetReport({
    required this.cash,
    required this.bank,
    required this.receivables,
    required this.inventory,
    required this.payables,
    required this.equity,
    required this.assets,
    required this.liabilities,
    required this.isBalanced,
  });

  final double cash;
  final double bank;
  final double receivables;
  final double inventory;
  final double payables;
  final double equity;
  final double assets;
  final double liabilities;
  final bool isBalanced;
}

class CashFlowReport {
  const CashFlowReport({
    required this.inflow,
    required this.outflow,
    required this.netChange,
    required this.operatingActivities,
  });

  final double inflow;
  final double outflow;
  final double netChange;
  final List<ReportLine> operatingActivities;
}

class ReportLine {
  const ReportLine({required this.label, required this.amount});

  final String label;
  final double amount;
}

class FinancialReportsState {
  const FinancialReportsState({
    required this.selectedReport,
    required this.startDate,
    required this.endDate,
    required this.searchTerm,
    required this.balanceFilter,
    required this.trialBalance,
    required this.profitAndLoss,
    required this.balanceSheet,
    required this.cashFlow,
  });

  final String selectedReport;
  final DateTime startDate;
  final DateTime endDate;
  final String searchTerm;
  final String balanceFilter;
  final TrialBalanceReport trialBalance;
  final ProfitAndLossReport profitAndLoss;
  final BalanceSheetReport balanceSheet;
  final CashFlowReport cashFlow;
}
