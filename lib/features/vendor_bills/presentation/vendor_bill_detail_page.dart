import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/section_header.dart';
import '../../attachments/presentation/entity_attachments_view.dart';
import '../../comments/presentation/entity_comments_view.dart';
import '../domain/vendor_bill.dart';

class VendorBillDetailPage extends ConsumerWidget {
  const VendorBillDetailPage({required this.bill, super.key});

  final VendorBill bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(bill.reference)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(bill.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('${l10n.purchaseOrderReference}: ${bill.reference}'),
            Text('${l10n.purchaseOrderVendor}: ${bill.vendorId}'),
            Text('${l10n.purchaseOrderTitle}: ${bill.title}'),
            Text('${l10n.purchaseOrderNotes}: ${bill.notes}'),
            const SizedBox(height: 12),
            Chip(label: Text(bill.status.label)),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  context.push('/journal-preview/vendor_bill/${bill.id}'),
              icon: const Icon(Icons.preview_outlined),
              label: const Text('Journal Preview'),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.vendorBillLinesLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...bill.lines.map(
              (line) => Card(
                child: ListTile(
                  title: Text(line.description),
                  subtitle: Text('${line.quantity} × ${line.unitPrice}'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Attachments'),
            const SizedBox(height: 8),
            EntityAttachmentsView(
              entityType: 'vendorBill',
              entityId: bill.id,
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Comments'),
            const SizedBox(height: 8),
            EntityCommentsView(
              entityType: 'vendorBill',
              entityId: bill.id,
            ),
          ],
        ),
      ),
    );
  }
}
