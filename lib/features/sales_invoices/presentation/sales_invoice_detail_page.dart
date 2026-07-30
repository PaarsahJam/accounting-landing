import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/section_header.dart';
import '../../attachments/presentation/entity_attachments_view.dart';
import '../../comments/presentation/entity_comments_view.dart';
import '../domain/sales_invoice.dart';

class SalesInvoiceDetailPage extends ConsumerWidget {
  const SalesInvoiceDetailPage({super.key, required this.invoice});

  final SalesInvoice invoice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.salesInvoiceDetailTitle} ${invoice.reference}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              invoice.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('${l10n.salesInvoiceCustomer}: ${invoice.customerName}'),
            Text('${l10n.salesInvoiceStatus}: ${invoice.status.label}'),
            Text(
              '${l10n.salesInvoiceDueDate}: ${invoice.dueDate.toIso8601String().split('T').first}',
            ),
            const SizedBox(height: 16),
            Text(l10n.salesInvoiceLinesLabel),
            const SizedBox(height: 8),
            ...invoice.lines.map(
              (line) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(line.description),
                subtitle: Text(
                  '${line.quantity} × ${line.unitPrice.toStringAsFixed(2)}',
                ),
                trailing: Text(line.amount.toStringAsFixed(2)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${l10n.salesInvoiceSubtotal}: ${invoice.subtotal.toStringAsFixed(2)}',
            ),
            Text('${l10n.salesInvoiceTax}: ${invoice.tax.toStringAsFixed(2)}'),
            Text(
              '${l10n.salesInvoiceTotal}: ${invoice.total.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 16),
            Text('${l10n.salesInvoiceNotes}: ${invoice.notes}'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  context.push('/journal-preview/sales_invoice/${invoice.id}'),
              icon: const Icon(Icons.preview_outlined),
              label: const Text('Journal Preview'),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Attachments'),
            const SizedBox(height: 8),
            EntityAttachmentsView(
              entityType: 'salesInvoice',
              entityId: invoice.id,
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Comments'),
            const SizedBox(height: 8),
            EntityCommentsView(
              entityType: 'salesInvoice',
              entityId: invoice.id,
            ),
          ],
        ),
      ),
    );
  }
}
