import 'package:flutter/material.dart';

import '../../features/invoicing/domain/invoice.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
    required this.invoice,
    required this.onEdit,
    required this.onDelete,
    required this.editTooltip,
    required this.deleteTooltip,
    required this.currencyLabel,
  });

  final Invoice invoice;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String editTooltip;
  final String deleteTooltip;
  final String currencyLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    invoice.id,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(label: Text(invoice.status)),
              ],
            ),
            const SizedBox(height: 12),
            Text(invoice.customer),
            const SizedBox(height: 8),
            Text(invoice.description),
            const SizedBox(height: 12),
            Text('${invoice.amount.toStringAsFixed(0)} $currencyLabel'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  tooltip: editTooltip,
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  tooltip: deleteTooltip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
