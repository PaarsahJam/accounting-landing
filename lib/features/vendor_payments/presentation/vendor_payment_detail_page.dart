import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../domain/vendor_payment.dart';

class VendorPaymentDetailPage extends ConsumerWidget {
  const VendorPaymentDetailPage({required this.payment, super.key});

  final VendorPayment payment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');

    return Scaffold(
      appBar: AppBar(title: Text(payment.reference)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              payment.vendorName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('${l10n.vendorPaymentReference}: ${payment.reference}'),
            Text(
              '${l10n.vendorPaymentAmount}: ${payment.amount.toStringAsFixed(2)}',
            ),
            Text('${l10n.vendorPaymentMethod}: ${payment.method.label}'),
            Text('${l10n.vendorPaymentStatus}: ${payment.status.label}'),
            Text('${l10n.vendorPaymentNotes}: ${payment.notes}'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  context.push('/journal-preview/vendor_payment/${payment.id}'),
              icon: const Icon(Icons.preview_outlined),
              label: const Text('Journal Preview'),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.vendorPaymentAllocationsLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...payment.allocations.map(
              (allocation) => Card(
                child: ListTile(
                  title: Text(allocation.billReference),
                  subtitle: Text(
                    '${l10n.vendorPaymentAllocationAmount}: ${allocation.amount.toStringAsFixed(2)}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
