import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/company/company_controller.dart';
import '../../core/company/presentation/company_selection_page.dart';
import '../../core/plugin/plugin_providers.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/dashboard/presentation/dashboard_page.dart';
import '../../features/auth/domain/auth_notifier.dart';
import '../../features/invoicing/presentation/invoices_page.dart';
import '../../features/expenses/presentation/expenses_page.dart';
import '../../features/bank_reconciliation/presentation/bank_reconciliation_page.dart';
import '../../features/financial_reports/presentation/financial_reports_page.dart';
import '../../features/customers/presentation/customers_page.dart';
import '../../features/vendors/presentation/vendors_page.dart';
import '../../features/general_ledger/presentation/general_ledger_page.dart';
import '../../features/inventory/domain/product.dart';
import '../../features/inventory/presentation/inventory_page.dart';
import '../../features/inventory/presentation/inventory_valuation_page.dart';
import '../../features/inventory/presentation/stock_adjustment_page.dart';
import '../../features/inventory/presentation/stock_ledger_page.dart';
import '../../features/stock_transfers/presentation/stock_transfers_page.dart';
import '../../features/purchase_orders/presentation/purchase_orders_page.dart';
import '../../features/sales_invoices/domain/sales_invoice.dart';
import '../../features/sales_invoices/presentation/sales_invoice_detail_page.dart';
import '../../features/sales_invoices/presentation/sales_invoices_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../features/vendor_bills/domain/vendor_bill.dart';
import '../../features/vendor_bills/presentation/vendor_bill_detail_page.dart';
import '../../features/vendor_bills/presentation/vendor_bills_page.dart';
import '../../features/customer_payments/domain/customer_payment.dart';
import '../../features/customer_payments/presentation/customer_payment_detail_page.dart';
import '../../features/customer_payments/presentation/customer_payments_page.dart';
import '../../features/customer_statements/presentation/customer_statements_page.dart';
import '../../features/vendor_payments/domain/vendor_payment.dart';
import '../../features/vendor_payments/presentation/vendor_payment_detail_page.dart';
import '../../features/vendor_payments/presentation/vendor_payments_page.dart';
import '../../features/vendor_statements/presentation/vendor_statements_page.dart';
import '../../features/journal_preview/presentation/journal_preview_page.dart';
import '../../features/journal_explorer/domain/journal_entry.dart';
import '../../features/journal_explorer/presentation/journal_entry_detail_page.dart';
import '../../features/journal_explorer/presentation/journal_explorer_page.dart';
import '../../features/banking/domain/bank_account.dart';
import '../../features/banking/presentation/bank_accounts_page.dart';
import '../../features/banking/presentation/bank_transactions_page.dart';
import '../../features/bank_reconciliation/domain/bank_statement.dart';
import '../../features/bank_reconciliation/presentation/bank_statements_page.dart';
import '../../features/bank_reconciliation/presentation/bank_reconciliation_detail_page.dart';
import '../../features/global_search/presentation/global_search_page.dart';
import '../../features/multi_currency/presentation/currencies_page.dart';
import '../../features/fixed_assets/presentation/fixed_assets_page.dart';
import '../../features/import_export/presentation/import_export_page.dart';
import '../../features/recurring_transactions/presentation/recurring_transactions_page.dart';
import '../../features/tags/presentation/tags_page.dart';
import '../../features/user_roles/presentation/user_roles_page.dart';
import '../../features/crm/presentation/contacts_page.dart';
import '../../features/crm/presentation/crm_dashboard_page.dart';
import '../../features/crm/presentation/crm_tasks_page.dart';
import '../../features/crm/presentation/pipeline_page.dart';
import '../../l10n/app_localizations.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  final companyAsync = ref.watch(currentCompanyProvider);
  final pluginRouteList = ref.watch(pluginRoutesProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isLoggedIn = auth.maybeWhen(
        data: (u) => u != null,
        orElse: () => false,
      );
      final goingToLogin =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';
      if (!isLoggedIn && !goingToLogin) return '/login';
      if (isLoggedIn && goingToLogin) return '/dashboard';

      // Company selection guard – only when logged in
      if (isLoggedIn) {
        final hasCompany = companyAsync.maybeWhen(
          data: (c) => c != null,
          orElse: () => false,
        );
        final goingToCompanySelect =
            state.matchedLocation == '/company/select';
        if (!hasCompany && !goingToCompanySelect) return '/company/select';
        if (hasCompany && goingToCompanySelect) return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(
        name: 'company-select',
        path: '/company/select',
        builder: (c, s) => const CompanySelectionPage(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (c, s) => const LoginPage(),
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (c, s) => const SignupPage(),
      ),
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        builder: (c, s) => const DashboardPage(),
      ),
      GoRoute(
        name: 'invoices',
        path: '/invoices',
        builder: (c, s) => const InvoicesPage(),
      ),
      GoRoute(
        name: 'expenses',
        path: '/expenses',
        builder: (c, s) => const ExpensesPage(),
      ),
      GoRoute(
        name: 'reports',
        path: '/reports',
        builder: (c, s) => const FinancialReportsPage(),
      ),
      GoRoute(
        name: 'customers',
        path: '/customers',
        builder: (c, s) => const CustomersPage(),
      ),
      GoRoute(
        name: 'vendors',
        path: '/vendors',
        builder: (c, s) => const VendorsPage(),
      ),
      GoRoute(
        name: 'general-ledger',
        path: '/general-ledger',
        builder: (c, s) => const GeneralLedgerPage(),
      ),
      GoRoute(
        name: 'inventory',
        path: '/inventory',
        builder: (c, s) => const InventoryPage(),
      ),
      GoRoute(
        name: 'stock-ledger',
        path: '/inventory/stock-ledger/:productId',
        builder: (context, state) {
          final product = state.extra as Product?;
          if (product == null) {
            return const InventoryPage();
          }
          return StockLedgerPage(product: product);
        },
      ),
      GoRoute(
        name: 'stock-adjustments',
        path: '/inventory/adjustments',
        builder: (c, s) => const StockAdjustmentPage(),
      ),
      GoRoute(
        name: 'inventory-valuation',
        path: '/inventory/valuation',
        builder: (c, s) => const InventoryValuationPage(),
      ),
      GoRoute(
        name: 'stock-transfers',
        path: '/stock-transfers',
        builder: (c, s) => const StockTransfersPage(),
      ),
      GoRoute(
        name: 'purchase-orders',
        path: '/purchase-orders',
        builder: (c, s) => const PurchaseOrdersPage(),
      ),
      GoRoute(
        name: 'vendor-bills',
        path: '/vendor-bills',
        builder: (c, s) => const VendorBillsPage(),
      ),
      GoRoute(
        name: 'vendor-bill-detail',
        path: '/vendor-bills/:id',
        builder: (context, state) {
          final bill = state.extra as VendorBill?;
          if (bill == null) {
            return const VendorBillsPage();
          }
          return VendorBillDetailPage(bill: bill);
        },
      ),
      GoRoute(
        name: 'sales-invoices',
        path: '/sales-invoices',
        builder: (c, s) => const SalesInvoicesPage(),
      ),
      GoRoute(
        name: 'sales-invoice-detail',
        path: '/sales-invoices/:id',
        builder: (context, state) {
          final invoice = state.extra as SalesInvoice?;
          if (invoice == null) {
            return const SalesInvoicesPage();
          }
          return SalesInvoiceDetailPage(invoice: invoice);
        },
      ),
      GoRoute(
        name: 'customer-payments',
        path: '/customer-payments',
        builder: (c, s) => const CustomerPaymentsPage(),
      ),
      GoRoute(
        name: 'customer-statements',
        path: '/customer-statements',
        builder: (c, s) => const CustomerStatementsPage(),
      ),
      GoRoute(
        name: 'customer-payment-detail',
        path: '/customer-payments/:id',
        builder: (context, state) {
          final payment = state.extra as CustomerPayment?;
          if (payment == null) {
            return const CustomerPaymentsPage();
          }
          return CustomerPaymentDetailPage(payment: payment);
        },
      ),
      GoRoute(
        name: 'vendor-payments',
        path: '/vendor-payments',
        builder: (c, s) => const VendorPaymentsPage(),
      ),
      GoRoute(
        name: 'vendor-statements',
        path: '/vendor-statements',
        builder: (c, s) => const VendorStatementsPage(),
      ),
      GoRoute(
        name: 'vendor-payment-detail',
        path: '/vendor-payments/:id',
        builder: (context, state) {
          final payment = state.extra as VendorPayment?;
          if (payment == null) {
            return const VendorPaymentsPage();
          }
          return VendorPaymentDetailPage(payment: payment);
        },
      ),
      GoRoute(
        name: 'journal-preview',
        path: '/journal-preview/:documentType/:documentId',
        builder: (context, state) {
          final documentType = state.pathParameters['documentType'];
          final documentId = state.pathParameters['documentId'];
          if (documentType == null || documentId == null) {
            return const DashboardPage();
          }
          return JournalPreviewPage(
            documentType: documentType,
            documentId: documentId,
          );
        },
      ),
      GoRoute(
        name: 'journal-explorer',
        path: '/journal-explorer',
        builder: (c, s) => const JournalExplorerPage(),
      ),
      GoRoute(
        name: 'journal-entry-detail',
        path: '/journal-explorer/:id',
        builder: (context, state) {
          final entry = state.extra as JournalEntry?;
          if (entry == null) {
            return const JournalExplorerPage();
          }
          return JournalEntryDetailPage(entry: entry);
        },
      ),
      GoRoute(
        name: 'bank-reconciliation',
        path: '/bank-reconciliation',
        builder: (c, s) => const BankReconciliationPage(),
      ),
      GoRoute(
        name: 'bank-statements',
        path: '/bank-statements',
        builder: (c, s) => const BankStatementsPage(),
      ),
      GoRoute(
        name: 'bank-statement-reconcile',
        path: '/bank-statements/:id/reconcile',
        builder: (context, state) {
          final stmt = state.extra as BankStatement?;
          if (stmt == null) {
            return const BankStatementsPage();
          }
          return BankReconciliationDetailPage(statement: stmt);
        },
      ),
      GoRoute(
        name: 'bank-accounts',
        path: '/bank-accounts',
        builder: (c, s) => const BankAccountsPage(),
      ),
      GoRoute(
        name: 'bank-account-transactions',
        path: '/bank-accounts/:id/transactions',
        builder: (context, state) {
          final account = state.extra as BankAccount?;
          if (account == null) {
            return const BankAccountsPage();
          }
          return BankTransactionsPage(account: account);
        },
      ),
      GoRoute(
        name: 'settings',
        path: '/settings',
        builder: (c, s) => const SettingsPage(),
      ),
      GoRoute(
        name: 'global-search',
        path: '/search',
        builder: (c, s) => const GlobalSearchPage(),
      ),
      GoRoute(name: 'tags', path: '/tags', builder: (c, s) => const TagsPage()),
      GoRoute(
        name: 'user-roles',
        path: '/user-roles',
        builder: (c, s) => const UserRolesPage(),
      ),
      GoRoute(
        name: 'currencies',
        path: '/currencies',
        builder: (c, s) => const CurrenciesPage(),
      ),
      GoRoute(
        name: 'recurring-transactions',
        path: '/recurring-transactions',
        builder: (c, s) => const RecurringTransactionsPage(),
      ),
      GoRoute(
        name: 'fixed-assets',
        path: '/fixed-assets',
        builder: (c, s) => const FixedAssetsPage(),
      ),
      GoRoute(
        name: 'import-export',
        path: '/import-export',
        builder: (c, s) => const ImportExportPage(),
      ),
      GoRoute(
        name: 'crm-contacts',
        path: '/crm/contacts/:customerId',
        builder: (context, state) {
          final customerId = state.pathParameters['customerId'] ?? '';
          return ContactsPage(customerId: customerId);
        },
      ),
      GoRoute(
        name: 'crm-tasks',
        path: '/crm/tasks',
        builder: (c, s) => const CrmTasksPage(),
      ),
      GoRoute(
        name: 'crm-pipeline',
        path: '/crm/pipeline',
        builder: (c, s) => const PipelinePage(),
      ),
      GoRoute(
        name: 'crm-dashboard',
        path: '/crm/dashboard',
        builder: (c, s) => const CrmDashboardPage(),
      ),
      // Plugin-injected routes — registered by PluginRegistrar
      ...pluginRouteList.map((pr) => pr.toGoRoute()),
    ],
    errorBuilder: (context, state) {
      final l10n = AppLocalizations.of(context)!;
      return Scaffold(
        body: Center(
          child: Semantics(
            label: l10n.pageNotFound(state.matchedLocation),
            child: Text(l10n.pageNotFound(state.matchedLocation)),
          ),
        ),
      );
    },
  );
});
