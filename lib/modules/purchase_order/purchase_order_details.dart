// lib/modules/purchase_order/purchase_order_details.dart
import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:flutter/material.dart';

class PurchaseOrderDetails extends StatelessWidget {
  final String number;
  final DocumentStatus status;
  final DateTime createdDate;

  const PurchaseOrderDetails({
    super.key,
    required this.number,
    required this.status,
    required this.createdDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Order Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DocumentHeader(
              number: number,
              status: status,
              createdDate: createdDate,
            ),
            const SizedBox(height: 24.0),
            _ApprovalTimeline(timeline: [DocumentStatus.draft, status]),
            const SizedBox(height: 16.0),
            const Text('Additional Details...'),
          ],
        ),
      ),
    );
  }
}

class _DocumentHeader extends StatelessWidget {
  final String number;
  final DocumentStatus status;
  final DateTime createdDate;

  const _DocumentHeader({
    required this.number,
    required this.status,
    required this.createdDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Status: ${status.name}'),
        Text('Created: ${createdDate.toLocal()}'),
      ],
    );
  }
}

class _ApprovalTimeline extends StatelessWidget {
  final List<DocumentStatus> timeline;

  const _ApprovalTimeline({required this.timeline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: timeline.map((status) => Text('- ${status.name}')).toList(),
    );
  }
}
