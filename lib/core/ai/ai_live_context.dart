import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/customers/domain/customers_controller.dart';
import '../../features/dashboard_metrics/domain/financial_dashboard_controller.dart';
import '../../features/general_ledger/domain/general_ledger_controller.dart';
import '../../features/invoicing/domain/invoices_controller.dart';

/// Gathers live business context for the AI assistant.
///
/// Depending on the user's question, it collects a structured plain-text
/// snapshot of the relevant domain data (dashboard, invoices, customers, or
/// general ledger) that is then fed to the AI model alongside the question.
class AiLiveContext {
  AiLiveContext(this._ref);

  final Ref _ref;

  static const List<String> _invoiceKeywords = [
    'invoice',
    'invoices',
    'فاکتور',
    'صورتحساب',
    'ֆակտուրա',
    'հաշիվ-ապրանքագիր',
  ];

  static const List<String> _customerKeywords = [
    'customer',
    'customers',
    'client',
    'مشتری',
    'հաճախորդ',
  ];

  static const List<String> _ledgerKeywords = [
    'ledger',
    'journal',
    'account',
    'accounts',
    'trial balance',
    'دفتر کل',
    'سند',
    'ماتյան',
  ];

  /// Builds the most relevant business context for [query].
  Future<String> contextForQuery(String query) async {
    final q = query.toLowerCase();
    try {
      if (_containsAny(q, _invoiceKeywords)) {
        return await _invoicesContext();
      }
      if (_containsAny(q, _customerKeywords)) {
        return await _customersContext();
      }
      if (_containsAny(q, _ledgerKeywords)) {
        return await _ledgerContext();
      }
      return await _dashboardContext();
    } catch (_) {
      return _fallbackContext();
    }
  }

  bool _containsAny(String query, List<String> keywords) =>
      keywords.any(query.contains);

  Future<String> _dashboardContext() async {
    final d = await _ref.read(financialDashboardControllerProvider.future);
    final ar = d.accountsReceivable;
    final ap = d.accountsPayable;
    final inv = d.inventory;
    final cash = d.cashPosition;
    final profit = d.profitOverview;
    final activity = d.recentActivity
        .take(5)
        .map(
          (a) => '  - ${a.type} | ${a.title} (${a.reference}) | ${_num(a.amount)}',
        )
        .join('\n');

    return '''
--- Business Overview ---
Revenue: ${_num(profit.revenue)}
Expenses: ${_num(profit.expenses)}
Gross Profit: ${_num(profit.grossProfit)}
Net Profit: ${_num(profit.netProfit)}
Cash: ${_num(cash.cash)}
Bank: ${_num(cash.bank)}
Total Liquid Assets: ${_num(cash.totalLiquidAssets)}

Accounts Receivable: ${ar.totalOutstandingInvoices} outstanding invoices, ${ar.overdueInvoices} overdue, ${_num(ar.amountReceivedThisMonth)} received this month
Accounts Payable: ${ap.outstandingVendorBills} outstanding bills, ${ap.overdueBills} overdue, ${_num(ap.paymentsMadeThisMonth)} paid this month
Inventory: ${inv.productCount} products, ${inv.lowStockProducts} low stock, ${_num(inv.totalStockQuantity)} units, ${inv.warehouseCount} warehouses

Recent Activity:
${activity.isEmpty ? '  (none)' : activity}
''';
  }

  Future<String> _invoicesContext() async {
    final invoices = await _ref.read(invoicesControllerProvider.future);
    final total = invoices.fold<double>(0, (sum, i) => sum + i.amount);
    final lines = invoices.isEmpty
        ? '  (no invoices)'
        : invoices
            .map(
              (i) => '  - ${i.id} | ${i.customer} | ${_num(i.amount)} | ${i.status}',
            )
            .join('\n');

    return '''
--- Sales Invoices ---
Count: ${invoices.length}
Total Amount: ${_num(total)}

$lines
''';
  }

  Future<String> _customersContext() async {
    final customers = await _ref.read(customersControllerProvider.future);
    final total = customers.fold<double>(0, (sum, c) => sum + c.outstandingBalance);
    final lines = customers.isEmpty
        ? '  (no customers)'
        : customers
            .map(
              (c) => '  - ${c.name} | ${c.company} | ${c.email} | ${_num(c.outstandingBalance)} | ${c.status}',
            )
            .join('\n');

    return '''
--- Customers ---
Count: ${customers.length}
Total Outstanding Balance: ${_num(total)}

$lines
''';
  }

  Future<String> _ledgerContext() async {
    final data = await _ref.read(generalLedgerControllerProvider.future);
    final accounts = data.accounts
        .map(
          (a) => '  - ${a.code} | ${a.name} | ${a.type.name} | opening ${_num(a.openingBalance)}',
        )
        .join('\n');
    final entries = data.entries.take(10).map((e) {
      final date = '${e.date.year}-${_pad(e.date.month)}-${_pad(e.date.day)}';
      return '  - ${e.reference} | $date | ${e.memo ?? '(no memo)'} | lines: ${e.lines.length}';
    }).join('\n');

    return '''
--- General Ledger ---
Accounts:
${accounts.isEmpty ? '  (no accounts)' : accounts}

Recent Journal Entries:
${entries.isEmpty ? '  (no entries)' : entries}
''';
  }

  Future<String> _fallbackContext() async {
    try {
      return await _dashboardContext();
    } catch (_) {
      return '--- Business Overview ---\n(No live data available at the moment.)\n';
    }
  }

  String _num(double? value) =>
      (value ?? 0).toStringAsFixed(0);

  String _pad(int value) => value.toString().padLeft(2, '0');
}
