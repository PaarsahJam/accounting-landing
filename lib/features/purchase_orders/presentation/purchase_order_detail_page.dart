import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/section_header.dart';
import '../../attachments/presentation/entity_attachments_view.dart';
import '../../comments/presentation/entity_comments_view.dart';
import '../domain/purchase_order.dart';

class PurchaseOrderDetailPage extends ConsumerWidget {
  const PurchaseOrderDetailPage({required this.order, super.key});

  final PurchaseOrder order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(order.reference)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('${l10n.purchaseOrderReference}: ${order.reference}'),
            Text('${l10n.purchaseOrderVendor}: ${order.vendorId}'),
            Text('${l10n.purchaseOrderTitle}: ${order.title}'),
            Text('${l10n.purchaseOrderNotes}: ${order.notes}'),
            const SizedBox(height: 12),
            Chip(label: Text(order.status.label)),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () =>
                  context.push('/journal-preview/purchase_order/${order.id}'),
              icon: const Icon(Icons.preview_outlined),
              label: const Text('Journal Preview'),
            ),
            const SizedBox(height: 16),
            Text(
              'Lines',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...order.lines.map(
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
              entityType: 'purchaseOrder',
              entityId: order.id,
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Comments'),
            const SizedBox(height: 8),
            EntityCommentsView(
              entityType: 'purchaseOrder',
              entityId: order.id,
            ),
          ],
        ),
      ),
    );
  }
}
