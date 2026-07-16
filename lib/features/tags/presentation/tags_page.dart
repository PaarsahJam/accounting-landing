import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/tag.dart';
import '../domain/tags_controller.dart';

/// Full-page view for managing all tags (create, rename, change colour, delete).
class TagsPage extends ConsumerWidget {
  const TagsPage({super.key});

  Color _hexColor(String hex) {
    final clean = hex.replaceFirst('#', '');
    if (clean.length != 6) return Colors.grey;
    return Color(int.parse('FF$clean', radix: 16));
  }

  Future<void> _showCreateDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String selectedColor = '#1E88E5';
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(l10n.tagCreateTitle),
              content: SizedBox(
                width: 360,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: InputDecoration(labelText: l10n.tagName),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.requiredField
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.tagDescription,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      _ColorPicker(
                        selected: selectedColor,
                        onChanged: (c) =>
                            setDialogState(() => selectedColor = c),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: Text(l10n.invoiceCancel),
                ),
                FilledButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    await ref
                        .read(tagsControllerProvider.notifier)
                        .createTag(
                          Tag(
                            id: '',
                            name: nameCtrl.text.trim(),
                            color: selectedColor,
                            description: descCtrl.text.trim(),
                          ),
                        );
                    if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                  },
                  child: Text(l10n.createButton),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Tag tag,
  ) async {
    final nameCtrl = TextEditingController(text: tag.name);
    final descCtrl = TextEditingController(text: tag.description);
    String selectedColor = tag.color;
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(l10n.tagEditTitle),
              content: SizedBox(
                width: 360,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtrl,
                        decoration: InputDecoration(labelText: l10n.tagName),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? l10n.requiredField
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        decoration: InputDecoration(
                          labelText: l10n.tagDescription,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      _ColorPicker(
                        selected: selectedColor,
                        onChanged: (c) =>
                            setDialogState(() => selectedColor = c),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: Text(l10n.invoiceCancel),
                ),
                FilledButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final notifier = ref.read(tagsControllerProvider.notifier);
                    final newName = nameCtrl.text.trim();
                    if (newName != tag.name) {
                      await notifier.renameTag(tag.id, newName);
                    }
                    if (selectedColor != tag.color) {
                      await notifier.changeColor(tag.id, selectedColor);
                    }
                    if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                  },
                  child: Text(l10n.invoiceSave),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Tag tag,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.tagDeleteTitle),
          content: Text(l10n.tagDeleteConfirm(tag.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(l10n.tagDeleteAction),
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      await ref.read(tagsControllerProvider.notifier).deleteTag(tag.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tagsAsync = ref.watch(tagsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tagsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.new_label_outlined),
            tooltip: l10n.tagCreateTitle,
            onPressed: () => _showCreateDialog(context, ref, l10n),
          ),
        ],
      ),
      body: tagsAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) => AppErrorState(message: '${l10n.tagLoadError} $e'),
        data: (tags) {
          if (tags.isEmpty) {
            return AppEmptyState(
              title: l10n.tagEmptyTitle,
              message: l10n.tagEmptyPageMessage,
            );
          }
          return ListView.separated(
            itemCount: tags.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (ctx, i) {
              final tag = tags[i];
              final color = _hexColor(tag.color);
              return ListTile(
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: const SizedBox.shrink(),
                ),
                title: Text(
                  tag.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: tag.description.isNotEmpty
                    ? Text(
                        tag.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                trailing: PopupMenuButton<_TagAction>(
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: _TagAction.edit,
                      child: Text(l10n.tagEditAction),
                    ),
                    PopupMenuItem(
                      value: _TagAction.delete,
                      child: Text(
                        l10n.tagDeleteAction,
                        style: TextStyle(
                          color: Theme.of(ctx).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                  onSelected: (action) {
                    switch (action) {
                      case _TagAction.edit:
                        _showEditDialog(context, ref, l10n, tag);
                      case _TagAction.delete:
                        _confirmDelete(context, ref, l10n, tag);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

enum _TagAction { edit, delete }

// ─────────────────────────────────────────────────────────────────────────────
// Colour picker (preset swatches)
// ─────────────────────────────────────────────────────────────────────────────

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({required this.selected, required this.onChanged});

  final String selected;
  final ValueChanged<String> onChanged;

  static const _colors = [
    '#E53935',
    '#FB8C00',
    '#FDD835',
    '#43A047',
    '#1E88E5',
    '#8E24AA',
    '#00ACC1',
    '#757575',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _colors.map((hex) {
        final clean = hex.replaceFirst('#', '');
        final color = Color(int.parse('FF$clean', radix: 16));
        final isSelected = selected == hex;
        return GestureDetector(
          onTap: () => onChanged(hex),
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 2,
                    )
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
