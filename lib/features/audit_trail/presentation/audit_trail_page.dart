// lib/features/audit_trail/presentation/audit_trail_page.dart
//
// Stand-alone page that shows the global audit trail with filtering UI.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/audit_entity_type.dart';
import '../domain/audit_filter.dart';
import '../domain/audit_trail_controller.dart';
import 'widgets/audit_trail_view.dart';

class AuditTrailPage extends ConsumerStatefulWidget {
  const AuditTrailPage({super.key});

  @override
  ConsumerState<AuditTrailPage> createState() => _AuditTrailPageState();
}

class _AuditTrailPageState extends ConsumerState<AuditTrailPage> {
  AuditEntityType? _entityTypeFilter;

  @override
  Widget build(BuildContext context) {
    final asyncEntries = ref.watch(auditTrailControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Trail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            tooltip: 'Refresh',
            onPressed: () =>
                ref.read(auditTrailControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Filter bar ──────────────────────────────────────────────────
          _FilterBar(
            selected: _entityTypeFilter,
            onChanged: (t) => setState(() => _entityTypeFilter = t),
          ),
          const Divider(height: 1),
          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: asyncEntries.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text(
                  'Error loading audit trail: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              data: (entries) {
                final filter = AuditFilter(entityType: _entityTypeFilter);
                final filtered = ref
                    .read(auditTrailControllerProvider.notifier)
                    .applyFilter(entries, filter);
                return AuditTrailView(entries: filtered);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.selected, required this.onChanged});

  final AuditEntityType? selected;
  final ValueChanged<AuditEntityType?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            selected: selected == null,
            onTap: () => onChanged(null),
          ),
          const SizedBox(width: 6),
          for (final type in AuditEntityType.values) ...[
            _FilterChip(
              label: type.label,
              selected: selected == type,
              onTap: () => onChanged(selected == type ? null : type),
            ),
            const SizedBox(width: 6),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? color.withAlpha(20) : Colors.transparent,
          border: Border.all(color: selected ? color : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            color: selected ? color : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
