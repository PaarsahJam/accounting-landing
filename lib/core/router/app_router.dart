import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/company/company_controller.dart';
import '../../core/company/presentation/company_form_page.dart';
import '../../core/company/presentation/company_selection_page.dart';
import '../../core/plugin/plugin_providers.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/dashboard_metrics/presentation/dashboard_page.dart';
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
import '../../features/analytics/presentation/analytics_page.dart';
import '../../features/audit_trail/presentation/audit_trail_page.dart';
import '../../features/fiscal_periods/presentation/fiscal_years_page.dart';
import '../../features/fiscal_periods/presentation/fiscal_periods_page.dart';
import '../../features/fiscal_periods/presentation/year_end_closing_page.dart';
import '../../features/multi_currency/presentation/currencies_page.dart';
import '../../features/notifications/presentation/notification_list_page.dart';
import '../../features/fixed_assets/presentation/fixed_assets_page.dart';
import '../../features/import_export/presentation/import_export_page.dart';
import '../../features/recurring_transactions/presentation/recurring_transactions_page.dart';
import '../../features/tags/presentation/tags_page.dart';
import '../../features/user_roles/presentation/user_roles_page.dart';
import '../../features/crm/presentation/contacts_page.dart';
import '../../features/document_processing/domain/document_processing_job.dart';
import '../../features/document_processing/presentation/document_processing_queue_page.dart';
import '../../features/document_processing/presentation/document_review_page.dart';
import '../../features/crm/presentation/crm_dashboard_page.dart';
import '../../features/crm/presentation/crm_tasks_page.dart';
import '../../features/crm/presentation/pipeline_page.dart';
import '../../features/purchase_orders/domain/purchase_order.dart';
import '../../features/purchase_orders/presentation/goods_receipts_page.dart';
import '../../features/purchase_orders/presentation/purchase_order_detail_page.dart';
import '../../features/backup/presentation/backup_page.dart';
import '../../features/calendar/presentation/calendar_page.dart';
import '../../features/email/presentation/email_page.dart';
import '../../features/sync/presentation/sync_status_page.dart';
import '../../features/ai_assistant/presentation/ai_assistant_page.dart';
import '../../features/approvals/presentation/approvals_page.dart';
import '../../shared/widgets/app_shell.dart';
import '../../shared/widgets/page_transition.dart';
import '../../l10n/app_localizations.dart';

GoRoute _r(
  String path, {
  required Widget child,
  String? name,
}) {
  return GoRoute(
    name: name,
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: PageTransition.slideUpTransition,
    ),
  );
}

GoRoute _rBuilder(
  String path, {
  required Widget Function(BuildContext, GoRouterState) builder,
  String? name,
}) {
  return GoRoute(
    name: name,
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: builder(context, state),
      transitionsBuilder: PageTransition.slideUpTransition,
    ),
  );
}

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

      if (isLoggedIn) {
        final hasCompany = companyAsync.maybeWhen(
          data: (c) => c != null,
          orElse: () => false,
        );
        final goingToCompanySelect =
            state.matchedLocation == '/company/select';
        final goingToCompanyCreate =
            state.matchedLocation == '/company/create';
        if (!hasCompany && !goingToCompanySelect && !goingToCompanyCreate) {
          return '/company/select';
        }
        if (hasCompany && goingToCompanySelect) return '/dashboard';
      }
      return null;
    },
    routes: [
      _r('/company/select', child: const CompanySelectionPage()),
      _r('/company/create', child: const CompanyFormPage()),
      _r('/login', child: const LoginPage()),
      _r('/signup', child: const SignupPage()),
      _r('/search', child: const GlobalSearchPage()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          _r('/dashboard', child: const DashboardPage()),
          _r('/invoices', child: const InvoicesPage()),
          _r('/customers', child: const CustomersPage()),
          _r('/vendors', child: const VendorsPage()),
          _r('/expenses', child: const ExpensesPage()),
          _r('/reports', child: const FinancialReportsPage()),
          _r('/general-ledger', child: const GeneralLedgerPage()),
          _r('/inventory', child: const InventoryPage()),
          _rBuilder(
            '/inventory/stock-ledger/:productId',
            builder: (context, state) {
              final product = state.extra as Product?;
              if (product == null) return const InventoryPage();
              return StockLedgerPage(product: product);
            },
          ),
          _r('/inventory/adjustments', child: const StockAdjustmentPage()),
          _r('/inventory/valuation', child: const InventoryValuationPage()),
          _r('/stock-transfers', child: const StockTransfersPage()),
          _rBuilder(
            '/purchase-orders/:id',
            builder: (context, state) {
              final order = state.extra as PurchaseOrder?;
              if (order == null) return const PurchaseOrdersPage();
              return PurchaseOrderDetailPage(order: order);
            },
          ),
          _r('/purchase-orders', child: const PurchaseOrdersPage()),
          _rBuilder(
            '/vendor-bills/:id',
            builder: (context, state) {
              final bill = state.extra as VendorBill?;
              if (bill == null) return const VendorBillsPage();
              return VendorBillDetailPage(bill: bill);
            },
          ),
          _r('/vendor-bills', child: const VendorBillsPage()),
          _rBuilder(
            '/sales-invoices/:id',
            builder: (context, state) {
              final invoice = state.extra as SalesInvoice?;
              if (invoice == null) return const SalesInvoicesPage();
              return SalesInvoiceDetailPage(invoice: invoice);
            },
          ),
          _r('/sales-invoices', child: const SalesInvoicesPage()),
          _r('/customer-payments', child: const CustomerPaymentsPage()),
          _r('/customer-statements', child: const CustomerStatementsPage()),
          _rBuilder(
            '/customer-payments/:id',
            builder: (context, state) {
              final payment = state.extra as CustomerPayment?;
              if (payment == null) return const CustomerPaymentsPage();
              return CustomerPaymentDetailPage(payment: payment);
            },
          ),
          _r('/vendor-payments', child: const VendorPaymentsPage()),
          _r('/vendor-statements', child: const VendorStatementsPage()),
          _rBuilder(
            '/vendor-payments/:id',
            builder: (context, state) {
              final payment = state.extra as VendorPayment?;
              if (payment == null) return const VendorPaymentsPage();
              return VendorPaymentDetailPage(payment: payment);
            },
          ),
          _rBuilder(
            '/journal-preview/:documentType/:documentId',
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
          _r('/journal-explorer', child: const JournalExplorerPage()),
          _rBuilder(
            '/journal-explorer/:id',
            builder: (context, state) {
              final entry = state.extra as JournalEntry?;
              if (entry == null) return const JournalExplorerPage();
              return JournalEntryDetailPage(entry: entry);
            },
          ),
          _r('/bank-reconciliation', child: const BankReconciliationPage()),
          _r('/bank-statements', child: const BankStatementsPage()),
          _rBuilder(
            '/bank-statements/:id/reconcile',
            builder: (context, state) {
              final stmt = state.extra as BankStatement?;
              if (stmt == null) return const BankStatementsPage();
              return BankReconciliationDetailPage(statement: stmt);
            },
          ),
          _r('/bank-accounts', child: const BankAccountsPage()),
          _rBuilder(
            '/bank-accounts/:id/transactions',
            builder: (context, state) {
              final account = state.extra as BankAccount?;
              if (account == null) return const BankAccountsPage();
              return BankTransactionsPage(account: account);
            },
          ),
          _r('/analytics', child: const AnalyticsPage()),
          _r('/audit-trail', child: const AuditTrailPage()),
          _r('/fiscal-years', child: const FiscalYearsPage()),
          _rBuilder(
            '/fiscal-periods/:yearId',
            builder: (context, state) {
              final yearId = int.tryParse(state.pathParameters['yearId'] ?? '') ?? 0;
              return FiscalPeriodsPage(fiscalYearId: yearId);
            },
          ),
          _r('/notifications', child: const NotificationListPage()),
          _r('/year-end-closing', child: const YearEndClosingPage()),
          _r('/settings', child: const SettingsPage()),
          _r('/tags', child: const TagsPage()),
          _r('/user-roles', child: const UserRolesPage()),
          _r('/currencies', child: const CurrenciesPage()),
          _r('/recurring-transactions', child: const RecurringTransactionsPage()),
          _r('/fixed-assets', child: const FixedAssetsPage()),
          _r('/import-export', child: const ImportExportPage()),
          _rBuilder(
            '/crm/contacts/:customerId',
            builder: (context, state) {
              final customerId = state.pathParameters['customerId'] ?? '';
              return ContactsPage(customerId: customerId);
            },
          ),
          _r('/crm/tasks', child: const CrmTasksPage()),
          _r('/crm/pipeline', child: const PipelinePage()),
          _r('/crm/dashboard', child: const CrmDashboardPage()),
          _r('/document-processing', child: const DocumentProcessingQueuePage()),
          _rBuilder(
            '/document-processing/:id',
            builder: (context, state) {
              final job = state.extra as DocumentProcessingJob?;
              if (job == null) return const DocumentProcessingQueuePage();
              return DocumentReviewPage(job: job);
            },
          ),
          _r('/goods-receipts', child: const GoodsReceiptsPage()),
          _r('/backup', child: const BackupPage()),
          _r('/calendar', child: const CalendarPage()),
          _r('/email', child: const EmailPage()),
          _r('/sync-status', child: const SyncStatusPage()),
          _r('/ai-assistant', child: const AiAssistantPage()),
          _r('/approvals', child: const ApprovalsPage()),
          ...pluginRouteList.map((pr) => pr.toGoRoute()),
        ],
      ),
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
