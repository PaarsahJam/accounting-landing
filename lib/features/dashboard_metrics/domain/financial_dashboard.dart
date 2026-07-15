class AccountsReceivableMetrics {
  const AccountsReceivableMetrics({
    required this.totalOutstandingInvoices,
    required this.overdueInvoices,
    required this.amountReceivedThisMonth,
  });

  final int totalOutstandingInvoices;
  final int overdueInvoices;
  final double amountReceivedThisMonth;
}

class AccountsPayableMetrics {
  const AccountsPayableMetrics({
    required this.outstandingVendorBills,
    required this.overdueBills,
    required this.paymentsMadeThisMonth,
  });

  final int outstandingVendorBills;
  final int overdueBills;
  final double paymentsMadeThisMonth;
}

class InventoryMetrics {
  const InventoryMetrics({
    required this.productCount,
    required this.lowStockProducts,
    required this.totalStockQuantity,
    required this.warehouseCount,
  });

  final int productCount;
  final int lowStockProducts;
  final double totalStockQuantity;
  final int warehouseCount;
}

class CashPosition {
  const CashPosition({
    required this.cash,
    required this.bank,
    required this.totalLiquidAssets,
  });

  final double cash;
  final double bank;
  final double totalLiquidAssets;
}

class MonthlyDataPoint {
  const MonthlyDataPoint({
    required this.year,
    required this.month,
    required this.amount,
  });

  final int year;
  final int month;
  final double amount;
}

class ProfitOverview {
  const ProfitOverview({
    required this.revenue,
    required this.expenses,
    required this.grossProfit,
    required this.netProfit,
  });

  final double revenue;
  final double expenses;
  final double grossProfit;
  final double netProfit;
}

class DashboardActivityItem {
  const DashboardActivityItem({
    required this.id,
    required this.type,
    required this.title,
    required this.reference,
    required this.occurredAt,
    this.amount,
  });

  final String id;
  final String type;
  final String title;
  final String reference;
  final DateTime occurredAt;
  final double? amount;
}

class FinancialDashboard {
  const FinancialDashboard({
    required this.accountsReceivable,
    required this.accountsPayable,
    required this.inventory,
    required this.cashPosition,
    required this.monthlyRevenue,
    required this.monthlyExpenses,
    required this.profitOverview,
    required this.recentActivity,
  });

  final AccountsReceivableMetrics accountsReceivable;
  final AccountsPayableMetrics accountsPayable;
  final InventoryMetrics inventory;
  final CashPosition cashPosition;
  final List<MonthlyDataPoint> monthlyRevenue;
  final List<MonthlyDataPoint> monthlyExpenses;
  final ProfitOverview profitOverview;
  final List<DashboardActivityItem> recentActivity;
}
