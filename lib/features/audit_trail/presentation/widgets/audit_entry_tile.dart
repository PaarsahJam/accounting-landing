// lib/features/audit_trail/presentation/widgets/audit_entry_tile.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/audit_action.dart';
import '../../domain/audit_entry.dart';

/// A single row in an audit trail list.
///
/// Displays action icon, action label, performer, timestamp,
/// and optional before/after values or a note.
class AuditEntryTile extends StatelessWidget {
  const AuditEntryTile({super.key, required this.entry});

  final AuditEntry entry;

  static final _dateFormat = DateFormat('d MMM yyyy, HH:mm');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _colorForAction(entry.action);
    final icon = _iconForAction(entry.action);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Icon bubble ──────────────────────────────────────────────────
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(30),
              border: Border.all(color: color, width: 1.5),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          // ── Content ──────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action label + performer
                Row(
                  children: [
                    Text(
                      entry.action.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'by ${entry.performedBy}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Timestamp
                Text(
                  _dateFormat.format(entry.performedAt.toLocal()),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
                // Before/after values
                if (entry.previousValue != null || entry.newValue != null) ...[
                  const SizedBox(height: 4),
                  _ChangeRow(
                    previous: entry.previousValue,
                    next: entry.newValue,
                  ),
                ],
                // Note
                if (entry.note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    entry.note!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Color _colorForAction(AuditAction action) {
    switch (action) {
      case AuditAction.created:
        return Colors.blue;
      case AuditAction.edited:
        return Colors.orange;
      case AuditAction.deleted:
        return Colors.red;
      case AuditAction.approved:
      case AuditAction.paid:
      case AuditAction.periodOpened:
      case AuditAction.unarchived:
      case AuditAction.journalReviewed:
        return Colors.green;
      case AuditAction.posted:
      case AuditAction.journalGenerated:
        return Colors.teal;
      case AuditAction.locked:
      case AuditAction.periodClosed:
        return Colors.indigo;
      case AuditAction.cancelled:
      case AuditAction.rejected:
      case AuditAction.archived:
        return Colors.grey;
      case AuditAction.submittedForApproval:
      case AuditAction.reopened:
        return Colors.purple;
      case AuditAction.partiallyPaid:
      case AuditAction.refunded:
        return Colors.amber.shade700;
      case AuditAction.printed:
      case AuditAction.exported:
        return Colors.blueGrey;
      case AuditAction.stockAdjusted:
      case AuditAction.stockTransferred:
      case AuditAction.stockCounted:
        return Colors.deepOrange;
      case AuditAction.addressChanged:
      case AuditAction.contactChanged:
        return Colors.cyan.shade700;
    }
  }

  static IconData _iconForAction(AuditAction action) {
    switch (action) {
      case AuditAction.created:
        return Icons.add_circle_outline;
      case AuditAction.edited:
        return Icons.edit_outlined;
      case AuditAction.deleted:
        return Icons.delete_outline;
      case AuditAction.submittedForApproval:
        return Icons.send_outlined;
      case AuditAction.approved:
        return Icons.check_circle_outline;
      case AuditAction.rejected:
        return Icons.cancel_outlined;
      case AuditAction.posted:
        return Icons.publish_outlined;
      case AuditAction.locked:
        return Icons.lock_outline;
      case AuditAction.cancelled:
        return Icons.block_outlined;
      case AuditAction.reopened:
        return Icons.restart_alt_outlined;
      case AuditAction.paid:
        return Icons.payments_outlined;
      case AuditAction.partiallyPaid:
        return Icons.money_outlined;
      case AuditAction.refunded:
        return Icons.undo_outlined;
      case AuditAction.printed:
        return Icons.print_outlined;
      case AuditAction.exported:
        return Icons.download_outlined;
      case AuditAction.stockAdjusted:
        return Icons.tune_outlined;
      case AuditAction.stockTransferred:
        return Icons.swap_horiz_outlined;
      case AuditAction.stockCounted:
        return Icons.inventory_2_outlined;
      case AuditAction.journalGenerated:
        return Icons.auto_awesome_outlined;
      case AuditAction.journalReviewed:
        return Icons.fact_check_outlined;
      case AuditAction.addressChanged:
        return Icons.location_on_outlined;
      case AuditAction.contactChanged:
        return Icons.phone_outlined;
      case AuditAction.archived:
        return Icons.archive_outlined;
      case AuditAction.unarchived:
        return Icons.unarchive_outlined;
      case AuditAction.periodOpened:
        return Icons.calendar_today_outlined;
      case AuditAction.periodClosed:
        return Icons.event_busy_outlined;
    }
  }
}

class _ChangeRow extends StatelessWidget {
  const _ChangeRow({this.previous, this.next});
  final String? previous;
  final String? next;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (previous != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red.withAlpha(20),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Text(
              previous!,
              style: const TextStyle(fontSize: 11, color: Colors.red),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
          ),
        ],
        if (next != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(20),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Text(
              next!,
              style: const TextStyle(fontSize: 11, color: Colors.green),
            ),
          ),
      ],
    );
  }
}
