// lib/features/audit_trail/presentation/widgets/audit_trail_view.dart

import 'package:flutter/material.dart';

import '../../domain/audit_entry.dart';
import '../../domain/audit_entity_type.dart';
import 'audit_entry_tile.dart';

/// Renders a vertical list of [AuditEntry] items with a connecting timeline
/// line, grouped into a scrollable column.
///
/// Use [AuditTrailView.forEntity] when you want to show only entries for a
/// single entity (e.g. inside a document detail page).
class AuditTrailView extends StatelessWidget {
  const AuditTrailView({
    super.key,
    required this.entries,
    this.emptyMessage = 'No activity recorded yet.',
    this.shrinkWrap = false,
  });

  /// Convenience constructor — renders a header label and filters [entries]
  /// to the given entity.
  factory AuditTrailView.forEntity({
    Key? key,
    required List<AuditEntry> entries,
    required AuditEntityType entityType,
    required String entityId,
    String? emptyMessage,
  }) {
    final filtered = entries
        .where((e) => e.entityType == entityType && e.entityId == entityId)
        .toList();
    return AuditTrailView(
      key: key,
      entries: filtered,
      emptyMessage: emptyMessage ?? 'No activity recorded yet.',
      shrinkWrap: true,
    );
  }

  final List<AuditEntry> entries;
  final String emptyMessage;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return _EmptyState(message: emptyMessage);
    }

    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: entries.length,
      separatorBuilder: (context, index) => const _TimelineDivider(),
      itemBuilder: (_, index) => AuditEntryTile(entry: entries[index]),
    );
  }
}

class _TimelineDivider extends StatelessWidget {
  const _TimelineDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 17),
        Container(width: 2, height: 16, color: Colors.grey.shade200),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_outlined, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
