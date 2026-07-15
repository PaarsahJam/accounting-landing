import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../domain/customer_payment.dart';

class CustomerPaymentDetailPage extends ConsumerWidget {
  const CustomerPaymentDetailPage({required this.payment, super.key});

  final CustomerPayment payment;

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
              payment.customerName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('${l10n.customerPaymentReference}: ${payment.reference}'),
            Text(
              '${l10n.customerPaymentAmount}: ${payment.amount.toStringAsFixed(2)}',
            ),
            Text('${l10n.customerPaymentStatus}: ${payment.status.label}'),
            Text('${l10n.customerPaymentNotes}: ${payment.notes}'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.push(
                '/journal-preview/customer_payment/${payment.id}',
              ),
              icon: const Icon(Icons.preview_outlined),
              label: const Text('Journal Preview'),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.customerPaymentAllocationsLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...payment.allocations.map(
              (allocation) => Card(
                child: ListTile(
                  title: Text(allocation.invoiceReference),
                  subtitle: Text(
                    '${l10n.customerPaymentAllocationAmount}: ${allocation.amount.toStringAsFixed(2)}',
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
