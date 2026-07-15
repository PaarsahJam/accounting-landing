import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key, required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(
        title: l10n.dashboardCreateSalesInvoice,
        icon: Icons.receipt_long,
        route: '/sales-invoices',
      ),
      _QuickAction(
        title: l10n.dashboardCreateVendorBill,
        icon: Icons.receipt,
        route: '/vendor-bills',
      ),
      _QuickAction(
        title: l10n.dashboardReceiveCustomerPayment,
        icon: Icons.payments,
        route: '/customer-payments',
      ),
      _QuickAction(
        title: l10n.dashboardRecordVendorPayment,
        icon: Icons.account_balance_wallet,
        route: '/vendor-payments',
      ),
      _QuickAction(
        title: l10n.dashboardViewJournal,
        icon: Icons.book_outlined,
        route: '/journal-explorer',
      ),
      _QuickAction(
        title: l10n.inventoryPageTitle,
        icon: Icons.inventory_2,
        route: '/inventory',
      ),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final action = actions[index];
          return SizedBox(
            width: 180,
            child: Card(
              child: InkWell(
                onTap: () => context.go(action.route),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(action.icon, size: 28),
                      const Spacer(),
                      Text(
                        action.title,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;
}
