import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/tag.dart';
import '../domain/tags_controller.dart';

/// Drop-in widget that shows the tags assigned to any entity and allows
/// assigning / removing tags inline.
///
/// ```dart
/// EntityTagsView(
///   entityType: 'purchaseOrder',
///   entityId: 'PO-2026-000001',
/// )
/// ```
class EntityTagsView extends ConsumerWidget {
  const EntityTagsView({
    super.key,
    required this.entityType,
    required this.entityId,
  });

  final String entityType;
  final String entityId;

  EntityTagsParams get _params =>
      EntityTagsParams(entityType: entityType, entityId: entityId);

  /// Parses a `'#RRGGBB'` hex colour and returns a [Color].
  Color _hexColor(String hex) {
    final clean = hex.replaceFirst('#', '');
    if (clean.length != 6) return Colors.grey;
    return Color(int.parse('FF$clean', radix: 16));
  }

  Future<void> _showAssignDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    List<Tag> allTags,
    List<Tag> assigned,
  ) async {
    final assignedIds = assigned.map((t) => t.id).toSet();
    final available = allTags
        .where((t) => !assignedIds.contains(t.id))
        .toList();

    if (available.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.tagNoAvailable)));
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: Text(l10n.tagAssignTitle),
          content: SizedBox(
            width: 320,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: available.length,
              itemBuilder: (_, i) {
                final tag = available[i];
                return ListTile(
                  dense: true,
                  leading: _TagChip(tag: tag, hexColor: _hexColor),
                  title: Text(tag.name),
                  subtitle: tag.description.isNotEmpty
                      ? Text(
                          tag.description,
                          style: const TextStyle(fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () async {
                    await ref
                        .read(entityTagsControllerProvider(_params).notifier)
                        .assignTag(tag.id);
                    if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.invoiceCancel),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tagsAsync = ref.watch(entityTagsControllerProvider(_params));
    final allTagsAsync = ref.watch(tagsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Text(
                l10n.tagsSectionTitle,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  final allTags = allTagsAsync.value ?? const [];
                  final assigned = tagsAsync.value ?? const [];
                  _showAssignDialog(context, ref, l10n, allTags, assigned);
                },
                icon: const Icon(Icons.label_outline, size: 16),
                label: Text(l10n.tagAssign),
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
        tagsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: AppLoadingState(),
          ),
          error: (e, _) => AppErrorState(message: '${l10n.tagLoadError} $e'),
          data: (tags) {
            if (tags.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AppEmptyState(
                  title: l10n.tagEmptyTitle,
                  message: l10n.tagEmptyMessage,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                children: tags.map((tag) {
                  return _RemovableTagChip(
                    tag: tag,
                    hexColor: _hexColor,
                    onRemove: () => ref
                        .read(entityTagsControllerProvider(_params).notifier)
                        .removeTag(tag.id),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal chip widgets
// ─────────────────────────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  const _TagChip({required this.tag, required this.hexColor});

  final Tag tag;
  final Color Function(String) hexColor;

  @override
  Widget build(BuildContext context) {
    final color = hexColor(tag.color);
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _RemovableTagChip extends StatelessWidget {
  const _RemovableTagChip({
    required this.tag,
    required this.hexColor,
    required this.onRemove,
  });

  final Tag tag;
  final Color Function(String) hexColor;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final color = hexColor(tag.color);
    final theme = Theme.of(context);
    return Chip(
      avatar: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      label: Text(
        tag.name,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      deleteIcon: const Icon(Icons.close, size: 14),
      onDeleted: onRemove,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
