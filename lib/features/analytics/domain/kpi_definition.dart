enum KpiCategory {
  revenue,
  profitability,
  liquidity,
  efficiency,
  growth,
}

enum KpiUnit {
  amount,
  percentage,
  ratio,
  count,
  days,
}

class KpiDefinition {
  const KpiDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.unit,
    required this.decimalPlaces,
    this.isPercentage = false,
    this.isHigherBetter = true,
    this.tags = const [],
  });

  final String id;
  final String name;
  final String description;
  final KpiCategory category;
  final KpiUnit unit;
  final int decimalPlaces;
  final bool isPercentage;
  final bool isHigherBetter;
  final List<String> tags;

  static const revenue = KpiDefinition(
    id: 'revenue',
    name: 'Revenue',
    description: 'Total sales invoice amounts for the period',
    category: KpiCategory.revenue,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    tags: ['financial', 'core'],
  );

  static const expenses = KpiDefinition(
    id: 'expenses',
    name: 'Expenses',
    description: 'Total vendor bills and operational costs for the period',
    category: KpiCategory.revenue,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    isHigherBetter: false,
    tags: ['financial', 'core'],
  );

  static const grossProfit = KpiDefinition(
    id: 'grossProfit',
    name: 'Gross Profit',
    description: 'Revenue minus cost of goods sold',
    category: KpiCategory.profitability,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    tags: ['financial', 'profitability'],
  );

  static const netProfit = KpiDefinition(
    id: 'netProfit',
    name: 'Net Profit',
    description: 'Revenue minus total expenses',
    category: KpiCategory.profitability,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    tags: ['financial', 'profitability'],
  );

  static const grossMargin = KpiDefinition(
    id: 'grossMargin',
    name: 'Gross Margin',
    description: 'Gross profit as a percentage of revenue',
    category: KpiCategory.profitability,
    unit: KpiUnit.percentage,
    decimalPlaces: 1,
    isPercentage: true,
    tags: ['financial', 'profitability'],
  );

  static const netProfitMargin = KpiDefinition(
    id: 'netProfitMargin',
    name: 'Net Profit Margin',
    description: 'Net profit as a percentage of revenue',
    category: KpiCategory.profitability,
    unit: KpiUnit.percentage,
    decimalPlaces: 1,
    isPercentage: true,
    tags: ['financial', 'profitability'],
  );

  static const accountsReceivable = KpiDefinition(
    id: 'accountsReceivable',
    name: 'Accounts Receivable',
    description: 'Total outstanding invoice amounts',
    category: KpiCategory.liquidity,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    isHigherBetter: false,
    tags: ['financial', 'liquidity'],
  );

  static const accountsPayable = KpiDefinition(
    id: 'accountsPayable',
    name: 'Accounts Payable',
    description: 'Total outstanding vendor bill amounts',
    category: KpiCategory.liquidity,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    isHigherBetter: false,
    tags: ['financial', 'liquidity'],
  );

  static const cashPosition = KpiDefinition(
    id: 'cashPosition',
    name: 'Cash Position',
    description: 'Current liquid assets (payments received minus payments made)',
    category: KpiCategory.liquidity,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    tags: ['financial', 'liquidity'],
  );

  static const currentRatio = KpiDefinition(
    id: 'currentRatio',
    name: 'Current Ratio',
    description: 'Current assets divided by current liabilities',
    category: KpiCategory.liquidity,
    unit: KpiUnit.ratio,
    decimalPlaces: 2,
    isHigherBetter: true,
    tags: ['financial', 'liquidity'],
  );

  static const revenueGrowthRate = KpiDefinition(
    id: 'revenueGrowthRate',
    name: 'Revenue Growth',
    description: 'Period-over-period revenue growth rate',
    category: KpiCategory.growth,
    unit: KpiUnit.percentage,
    decimalPlaces: 1,
    isPercentage: true,
    isHigherBetter: true,
    tags: ['financial', 'growth'],
  );

  static const expenseGrowthRate = KpiDefinition(
    id: 'expenseGrowthRate',
    name: 'Expense Growth',
    description: 'Period-over-period expense growth rate',
    category: KpiCategory.growth,
    unit: KpiUnit.percentage,
    decimalPlaces: 1,
    isPercentage: true,
    isHigherBetter: false,
    tags: ['financial', 'growth'],
  );

  static const averageInvoiceValue = KpiDefinition(
    id: 'averageInvoiceValue',
    name: 'Avg Invoice Value',
    description: 'Average value of sales invoices in the period',
    category: KpiCategory.efficiency,
    unit: KpiUnit.amount,
    decimalPlaces: 0,
    tags: ['financial', 'efficiency'],
  );

  static const invoiceAging = KpiDefinition(
    id: 'invoiceAging',
    name: 'Invoice Aging',
    description: 'Average days invoices are overdue',
    category: KpiCategory.efficiency,
    unit: KpiUnit.days,
    decimalPlaces: 0,
    isHigherBetter: false,
    tags: ['financial', 'efficiency'],
  );

  static const all = [
    revenue,
    expenses,
    grossProfit,
    netProfit,
    grossMargin,
    netProfitMargin,
    accountsReceivable,
    accountsPayable,
    cashPosition,
    currentRatio,
    revenueGrowthRate,
    expenseGrowthRate,
    averageInvoiceValue,
    invoiceAging,
  ];

  static const byCategory = {
    KpiCategory.revenue: [revenue, expenses],
    KpiCategory.profitability: [grossProfit, netProfit, grossMargin, netProfitMargin],
    KpiCategory.liquidity: [accountsReceivable, accountsPayable, cashPosition, currentRatio],
    KpiCategory.growth: [revenueGrowthRate, expenseGrowthRate],
    KpiCategory.efficiency: [averageInvoiceValue, invoiceAging],
  };
}
