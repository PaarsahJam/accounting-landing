import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/interaction.dart';
import '../domain/interactions_controller.dart';

/// Drop-in widget that shows interaction history for any contact.
class EntityInteractionsView extends ConsumerWidget {
  const EntityInteractionsView({
    super.key,
    required this.contactId,
    required this.customerId,
    this.performedBy = 'current_user',
  });

  final String contactId;
  final String customerId;
  final String performedBy;

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final subjectController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    InteractionType selectedType = InteractionType.note;

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(l10n.interactionAddTitle),
              content: SizedBox(
                width: 380,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<InteractionType>(
                        initialValue: selectedType,
                        decoration: InputDecoration(labelText: l10n.interactionType),
                        items: InteractionType.values.map((t) {
                          return DropdownMenuItem(value: t, child: Text(t.label));
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) setDialogState(() => selectedType = v);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(labelText: l10n.interactionSubject),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: l10n.interactionDescription),
                        maxLines: 4,
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
                    final interaction = Interaction(
                      id: '',
                      contactId: contactId,
                      customerId: customerId,
                      type: selectedType,
                      subject: subjectController.text.trim(),
                      description: descriptionController.text.trim(),
                      occurredAt: DateTime.now(),
                      performedBy: performedBy,
                      createdAt: DateTime.now(),
                    );
                    await ref
                        .read(interactionsControllerProvider(contactId).notifier)
                        .createInteraction(interaction);
                    if (!dialogCtx.mounted) return;
                    Navigator.of(dialogCtx).pop();
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

  IconData _iconForType(InteractionType type) {
    switch (type) {
      case InteractionType.call:
        return Icons.phone;
      case InteractionType.email:
        return Icons.email;
      case InteractionType.meeting:
        return Icons.groups;
      case InteractionType.note:
        return Icons.note;
      case InteractionType.task:
        return Icons.task_alt;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final interactionsAsync = ref.watch(interactionsControllerProvider(contactId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Text(
                l10n.interactionsSectionTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _showAddDialog(context, ref, l10n),
                icon: const Icon(Icons.add_circle_outline, size: 16),
                label: Text(l10n.interactionAdd),
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              ),
            ],
          ),
        ),
        interactionsAsync.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: AppLoadingState(),
          ),
          error: (error, _) =>
              AppErrorState(message: '${l10n.interactionsLoadError} $error'),
          data: (interactions) {
            if (interactions.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: AppEmptyState(
                  title: l10n.interactionsEmptyTitle,
                  message: l10n.interactionsEmptyMessage,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: interactions.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final interaction = interactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .secondaryContainer,
                    child: Icon(
                      _iconForType(interaction.type),
                      size: 18,
                    ),
                  ),
                  title: Text(interaction.subject),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${interaction.type.label} - ${_formatDateTime(context, interaction.occurredAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (interaction.description.isNotEmpty)
                        Text(
                          interaction.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    onPressed: () async {
                      await ref
                          .read(interactionsControllerProvider(contactId).notifier)
                          .deleteInteraction(interaction.id);
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatDateTime(BuildContext context, DateTime dt) {
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} ${_pad(dt.hour)}:${_pad(dt.minute)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}
