// lib/features/document_numbering/widgets/document_header.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../document_record.dart';
import '../document_status.dart';
import 'approval_timeline.dart';
import 'number_chip.dart';
import 'status_badge.dart';

/// Reusable header widget that displays document metadata:
/// number, type, status, created / approved / posted dates, and an
/// approval-lifecycle timeline.
class DocumentHeader extends StatelessWidget {
  const DocumentHeader({super.key, required this.record});

  final DocumentRecord record;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat.yMMMd();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: number chip + type label + status badge ──────────
            Row(
              children: [
                NumberChip(number: record.documentNumber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    record.documentType,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatusBadge(status: record.status),
              ],
            ),
            const SizedBox(height: 12),
            // ── Row 2: dates ────────────────────────────────────────────
            Wrap(
              spacing: 20,
              runSpacing: 6,
              children: [
                _DateLabel(
                  icon: Icons.calendar_today_outlined,
                  label: 'Created',
                  date: dateFormat.format(record.createdAt),
                ),
                if (record.approvedAt != null)
                  _DateLabel(
                    icon: Icons.check_circle_outline,
                    label: 'Approved',
                    date: dateFormat.format(record.approvedAt!),
                  ),
                if (record.postedAt != null)
                  _DateLabel(
                    icon: Icons.publish_outlined,
                    label: 'Posted',
                    date: dateFormat.format(record.postedAt!),
                  ),
              ],
            ),
            if (record.status != DocumentStatus.cancelled) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              // ── Row 3: approval timeline ────────────────────────────
              ApprovalTimeline(currentStatus: record.status),
            ],
          ],
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({
    required this.icon,
    required this.label,
    required this.date,
  });

  final IconData icon;
  final String label;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          date,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
