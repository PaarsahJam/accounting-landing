import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settingsAsync = ref.watch(settingsControllerProvider);

    return ResponsivePageScaffold(
      title: l10n.settingsPageTitle,
      child: settingsAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.settingsLoadError} $error'),
        data: (settings) {
          return ListView(
            children: [
              ...settings.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  trailing: Text(entry.value),
                );
              }),
              ListTile(
                title: Text(l10n.customersPageTitle),
                trailing: const Icon(Icons.people),
                onTap: () => context.go('/customers'),
              ),
              ListTile(
                title: Text(l10n.vendorsPageTitle),
                trailing: const Icon(Icons.business),
                onTap: () => context.go('/vendors'),
              ),
              ListTile(
                title: Text(l10n.generalLedgerPageTitle),
                trailing: const Icon(Icons.account_balance_outlined),
                onTap: () => context.go('/general-ledger'),
              ),
              ListTile(
                title: Text(l10n.inventoryPageTitle),
                trailing: const Icon(Icons.inventory_2),
                onTap: () => context.go('/inventory'),
              ),
              ListTile(
                title: Text(l10n.purchaseOrdersPageTitle),
                trailing: const Icon(Icons.shopping_cart),
                onTap: () => context.go('/purchase-orders'),
              ),
              ListTile(
                title: Text(l10n.vendorBillsPageTitle),
                trailing: const Icon(Icons.receipt),
                onTap: () => context.go('/vendor-bills'),
              ),
              ListTile(
                title: Text(l10n.salesInvoicesPageTitle),
                trailing: const Icon(Icons.receipt_long),
                onTap: () => context.go('/sales-invoices'),
              ),
              ListTile(
                title: Text(l10n.customerPaymentsPageTitle),
                trailing: const Icon(Icons.payments),
                onTap: () => context.go('/customer-payments'),
              ),
              ListTile(
                title: Text(l10n.customerStatementsPageTitle),
                trailing: const Icon(Icons.receipt_long),
                onTap: () => context.go('/customer-statements'),
              ),
              ListTile(
                title: Text(l10n.vendorPaymentsPageTitle),
                trailing: const Icon(Icons.account_balance_wallet),
                onTap: () => context.go('/vendor-payments'),
              ),
              ListTile(
                title: Text(l10n.vendorStatementsPageTitle),
                trailing: const Icon(Icons.receipt),
                onTap: () => context.go('/vendor-statements'),
              ),
              ListTile(
                title: Text(l10n.journalExplorerPageTitle),
                trailing: const Icon(Icons.book_outlined),
                onTap: () => context.go('/journal-explorer'),
              ),
              ListTile(
                title: Text(l10n.bankReconciliationPageTitle),
                trailing: const Icon(Icons.account_balance),
                onTap: () => context.go('/bank-reconciliation'),
              ),
              ListTile(
                title: Text(l10n.bankStatementsPageTitle),
                trailing: const Icon(Icons.description_outlined),
                onTap: () => context.go('/bank-statements'),
              ),
              ListTile(
                title: Text(l10n.bankAccountsPageTitle),
                trailing: const Icon(Icons.account_balance_wallet),
                onTap: () => context.go('/bank-accounts'),
              ),
              ListTile(
                title: Text(l10n.stockAdjustmentPageTitle),
                trailing: const Icon(Icons.tune),
                onTap: () => context.go('/inventory/adjustments'),
              ),
              ListTile(
                title: Text(l10n.inventoryValuationPageTitle),
                trailing: const Icon(Icons.bar_chart),
                onTap: () => context.go('/inventory/valuation'),
              ),
              ListTile(
                title: Text(l10n.stockTransferPageTitle),
                trailing: const Icon(Icons.swap_horiz),
                onTap: () => context.go('/stock-transfers'),
              ),
              ListTile(
                title: Text(l10n.currenciesPageTitle),
                trailing: const Icon(Icons.currency_exchange),
                onTap: () => context.go('/currencies'),
              ),
              ListTile(
                title: Text(l10n.userRolesPageTitle),
                trailing: const Icon(Icons.manage_accounts_outlined),
                onTap: () => context.go('/user-roles'),
              ),
            ],
          );
        },
      ),
    );
  }
}
