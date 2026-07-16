// lib/features/document_numbering/widgets/status_badge.dart

import 'package:flutter/material.dart';

import '../document_status.dart';

/// Compact coloured badge that displays a [DocumentStatus].
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final DocumentStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _colorForStatus(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Color _colorForStatus(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.draft:
        return Colors.orange;
      case DocumentStatus.pendingApproval:
        return Colors.blue;
      case DocumentStatus.approved:
        return Colors.green;
      case DocumentStatus.posted:
        return Colors.teal;
      case DocumentStatus.locked:
        return Colors.indigo;
      case DocumentStatus.cancelled:
        return Colors.grey;
    }
  }
}
