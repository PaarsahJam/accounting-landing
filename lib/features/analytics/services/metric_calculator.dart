import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:accounting_app/features/expenses/domain/expense.dart';

import '../domain/kpi_definition.dart';
import '../domain/kpi_value.dart';
import '../domain/time_period.dart';

class MetricSourceData {
  const MetricSourceData({
    this.invoices = const [],
    this.vendorBills = const [],
    this.customerPayments = const [],
    this.vendorPayments = const [],
    this.purchaseOrders = const [],
    this.products = const [],
    this.expenses = const [],
  });

  final List<SalesInvoice> invoices;
  final List<VendorBill> vendorBills;
  final List<CustomerPayment> customerPayments;
  final List<VendorPayment> vendorPayments;
  final List<PurchaseOrder> purchaseOrders;
  final List<Product> products;
  final List<Expense> expenses;
}

class MetricCalculator {
  const MetricCalculator();

  double revenueInPeriod(List<SalesInvoice> invoices, TimePeriod period) {
    return invoices
        .where((inv) => period.contains(inv.invoiceDate))
        .fold<double>(0.0, (sum, inv) => sum + inv.total);
  }

  double expensesInPeriod({
    required List<VendorBill> bills,
    required List<Expense> expenses,
    required TimePeriod period,
  }) {
    final billTotal = bills
        .where((b) => period.contains(b.billDate))
        .fold<double>(0.0, (sum, b) => sum + b.lines.fold<double>(0.0, (s, l) => s + l.unitPrice * l.quantity));
    final expenseTotal = expenses
        .where((e) => period.contains(e.occurredAt))
        .fold<double>(0.0, (sum, e) => sum + e.amount);
    return billTotal + expenseTotal;
  }

  KpiValue calculateRevenue(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final value = revenueInPeriod(data.invoices, period);
    final prev = previousPeriod != null ? revenueInPeriod(data.invoices, previousPeriod) : null;
    return KpiValue(definition: KpiDefinition.revenue, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateExpenses(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final value = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final prev = previousPeriod != null ? expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod) : null;
    return KpiValue(definition: KpiDefinition.expenses, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateGrossProfit(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final rev = revenueInPeriod(data.invoices, period);
    final exp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final value = rev - exp;
    double? prev;
    if (previousPeriod != null) {
      final prevRev = revenueInPeriod(data.invoices, previousPeriod);
      final prevExp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod);
      prev = prevRev - prevExp;
    }
    return KpiValue(definition: KpiDefinition.grossProfit, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateNetProfit(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final rev = revenueInPeriod(data.invoices, period);
    final exp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final value = rev - exp;
    double? prev;
    if (previousPeriod != null) {
      final prevRev = revenueInPeriod(data.invoices, previousPeriod);
      final prevExp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod);
      prev = prevRev - prevExp;
    }
    return KpiValue(definition: KpiDefinition.netProfit, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateGrossMargin(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final rev = revenueInPeriod(data.invoices, period);
    final exp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final value = rev > 0 ? ((rev - exp) / rev) * 100 : 0.0;
    double? prev;
    if (previousPeriod != null) {
      final prevRev = revenueInPeriod(data.invoices, previousPeriod);
      final prevExp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod);
      prev = prevRev > 0 ? ((prevRev - prevExp) / prevRev) * 100 : 0.0;
    }
    return KpiValue(definition: KpiDefinition.grossMargin, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateNetProfitMargin(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final rev = revenueInPeriod(data.invoices, period);
    final exp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final value = rev > 0 ? ((rev - exp) / rev) * 100 : 0.0;
    double? prev;
    if (previousPeriod != null) {
      final prevRev = revenueInPeriod(data.invoices, previousPeriod);
      final prevExp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod);
      prev = prevRev > 0 ? ((prevRev - prevExp) / prevRev) * 100 : 0.0;
    }
    return KpiValue(definition: KpiDefinition.netProfitMargin, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateAccountsReceivable(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final value = data.invoices
        .where((inv) => inv.status.id != 'paid' && inv.status.id != 'cancelled')
        .fold<double>(0.0, (sum, inv) => sum + inv.total);
    final prev = previousPeriod != null
        ? data.invoices
            .where((inv) => previousPeriod.contains(inv.invoiceDate) && inv.status.id != 'paid' && inv.status.id != 'cancelled')
            .fold<double>(0.0, (sum, inv) => sum + inv.total)
        : null;
    return KpiValue(definition: KpiDefinition.accountsReceivable, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateAccountsPayable(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final value = data.vendorBills
        .where((b) => b.status.id != 'paid' && b.status.id != 'cancelled')
        .fold<double>(0.0, (sum, b) => sum + b.lines.fold<double>(0.0, (s, l) => s + l.unitPrice * l.quantity));
    final prev = previousPeriod != null
        ? data.vendorBills
            .where((b) => previousPeriod.contains(b.billDate) && b.status.id != 'paid' && b.status.id != 'cancelled')
            .fold<double>(0.0, (sum, b) => sum + b.lines.fold<double>(0.0, (s, l) => s + l.unitPrice * l.quantity))
        : null;
    return KpiValue(definition: KpiDefinition.accountsPayable, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateCashPosition(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final received = data.customerPayments
        .where((cp) => period.contains(cp.paymentDate))
        .fold<double>(0.0, (sum, cp) => sum + cp.amount);
    final sent = data.vendorPayments
        .where((vp) => period.contains(vp.paymentDate))
        .fold<double>(0.0, (sum, vp) => sum + vp.amount);
    final value = received - sent;
    double? prev;
    if (previousPeriod != null) {
      final prevReceived = data.customerPayments
          .where((cp) => previousPeriod.contains(cp.paymentDate))
          .fold<double>(0.0, (sum, cp) => sum + cp.amount);
      final prevSent = data.vendorPayments
          .where((vp) => previousPeriod.contains(vp.paymentDate))
          .fold<double>(0.0, (sum, vp) => sum + vp.amount);
      prev = prevReceived - prevSent;
    }
    return KpiValue(definition: KpiDefinition.cashPosition, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateCurrentRatio(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final ar = data.invoices
        .where((inv) => inv.status.id != 'paid' && inv.status.id != 'cancelled')
        .fold<double>(0.0, (sum, inv) => sum + inv.total);
    final ap = data.vendorBills
        .where((b) => b.status.id != 'paid' && b.status.id != 'cancelled')
        .fold<double>(0.0, (sum, b) => sum + b.lines.fold<double>(0.0, (s, l) => s + l.unitPrice * l.quantity));
    final cash = data.customerPayments
            .where((cp) => period.contains(cp.paymentDate))
            .fold<double>(0.0, (sum, cp) => sum + cp.amount) -
        data.vendorPayments
            .where((vp) => period.contains(vp.paymentDate))
            .fold<double>(0.0, (sum, vp) => sum + vp.amount);
    final currentAssets = ar + (cash > 0 ? cash : 0.0);
    final value = ap > 0 ? currentAssets / ap : 0.0;
    return KpiValue(definition: KpiDefinition.currentRatio, value: value, period: period);
  }

  KpiValue calculateAverageInvoiceValue(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final periodInvoices = data.invoices.where((inv) => period.contains(inv.invoiceDate)).toList();
    final value = periodInvoices.isEmpty
        ? 0.0
        : periodInvoices.fold<double>(0.0, (sum, inv) => sum + inv.total) / periodInvoices.length;
    double? prev;
    if (previousPeriod != null) {
      final prevInvoices = data.invoices.where((inv) => previousPeriod.contains(inv.invoiceDate)).toList();
      prev = prevInvoices.isEmpty ? 0.0 : prevInvoices.fold<double>(0.0, (sum, inv) => sum + inv.total) / prevInvoices.length;
    }
    return KpiValue(definition: KpiDefinition.averageInvoiceValue, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateInvoiceAging(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final now = DateTime.now();
    final overdueInvoices = data.invoices.where((inv) => inv.dueDate.isBefore(now) && inv.status.id != 'paid' && inv.status.id != 'cancelled').toList();
    final value = overdueInvoices.isEmpty
        ? 0.0
        : overdueInvoices.fold<double>(0.0, (sum, inv) => sum + now.difference(inv.dueDate).inDays) / overdueInvoices.length;
    return KpiValue(definition: KpiDefinition.invoiceAging, value: value, period: period);
  }

  KpiValue calculateRevenueGrowthRate(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final rev = revenueInPeriod(data.invoices, period);
    final prev = previousPeriod != null ? revenueInPeriod(data.invoices, previousPeriod) : null;
    final value = (prev != null && prev > 0) ? ((rev - prev) / prev) * 100 : 0.0;
    return KpiValue(definition: KpiDefinition.revenueGrowthRate, value: value, period: period, previousValue: prev);
  }

  KpiValue calculateExpenseGrowthRate(MetricSourceData data, TimePeriod period, {TimePeriod? previousPeriod}) {
    final exp = expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: period);
    final prev = previousPeriod != null ? expensesInPeriod(bills: data.vendorBills, expenses: data.expenses, period: previousPeriod) : null;
    final value = (prev != null && prev > 0) ? ((exp - prev) / prev) * 100 : 0.0;
    return KpiValue(definition: KpiDefinition.expenseGrowthRate, value: value, period: period, previousValue: prev);
  }

  List<KpiValue> calculateAll({
    required MetricSourceData data,
    required TimePeriod period,
    TimePeriod? previousPeriod,
  }) {
    return [
      calculateRevenue(data, period, previousPeriod: previousPeriod),
      calculateExpenses(data, period, previousPeriod: previousPeriod),
      calculateGrossProfit(data, period, previousPeriod: previousPeriod),
      calculateNetProfit(data, period, previousPeriod: previousPeriod),
      calculateGrossMargin(data, period, previousPeriod: previousPeriod),
      calculateNetProfitMargin(data, period, previousPeriod: previousPeriod),
      calculateAccountsReceivable(data, period, previousPeriod: previousPeriod),
      calculateAccountsPayable(data, period, previousPeriod: previousPeriod),
      calculateCashPosition(data, period, previousPeriod: previousPeriod),
      calculateCurrentRatio(data, period),
      calculateAverageInvoiceValue(data, period, previousPeriod: previousPeriod),
      calculateInvoiceAging(data, period),
      calculateRevenueGrowthRate(data, period, previousPeriod: previousPeriod),
      calculateExpenseGrowthRate(data, period, previousPeriod: previousPeriod),
    ];
  }
}
