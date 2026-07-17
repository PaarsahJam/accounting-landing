import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/financial_dashboard.dart';

class ActivityTimeline extends StatelessWidget {
  const ActivityTimeline({
    super.key,
    required this.items,
    required this.l10n,
    this.emptyMessage,
  });

  final List<DashboardActivityItem> items;
  final AppLocalizations l10n;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            emptyMessage ?? l10n.dashboardNoRecentActivity,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    final dateFormat = DateFormat.yMMMd();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        final typeLabel = _labelForType(item.type, l10n);
        final amountStr = item.amount != null
            ? '${item.amount?.toStringAsFixed(0)} ${l10n.currencyUnit}'
            : null;
        final semanticLabel = [
          typeLabel,
          item.title,
          item.reference,
          dateFormat.format(item.occurredAt),
          ?amountStr,
        ].join(', ');
        return Semantics(
          label: semanticLabel,
          child: ListTile(
            leading: Semantics(
              excludeSemantics: true,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(_iconForType(item.type), size: 18),
              ),
            ),
            title: Text(item.title),
            subtitle: Text('$typeLabel • ${item.reference}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(dateFormat.format(item.occurredAt)),
                if (amountStr != null)
                  Text(
                    amountStr,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _iconForType(String type) {
    return switch (type) {
      'purchase_order' => Icons.shopping_cart_outlined,
      'goods_receipt' => Icons.local_shipping_outlined,
      'vendor_bill' => Icons.receipt_outlined,
      'vendor_payment' => Icons.account_balance_wallet_outlined,
      'sales_invoice' => Icons.receipt_long_outlined,
      'customer_payment' => Icons.payments_outlined,
      'journal_entry' => Icons.book_outlined,
      _ => Icons.circle_outlined,
    };
  }

  String _labelForType(String type, AppLocalizations l10n) {
    return switch (type) {
      'purchase_order' => l10n.dashboardActivityPurchaseOrder,
      'goods_receipt' => l10n.dashboardActivityGoodsReceipt,
      'vendor_bill' => l10n.dashboardActivityVendorBill,
      'vendor_payment' => l10n.dashboardActivityVendorPayment,
      'sales_invoice' => l10n.dashboardActivitySalesInvoice,
      'customer_payment' => l10n.dashboardActivityCustomerPayment,
      'journal_entry' => l10n.dashboardActivityJournalEntry,
      _ => type,
    };
  }
}
