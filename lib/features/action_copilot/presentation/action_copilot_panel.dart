import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../action_copilot_provider.dart';
import '../domain/action_copilot_draft.dart';
import 'action_copilot_review_sheet.dart';

/// Dashboard entry point for the action copilot.
///
/// Offers three drafting actions (invoice suggestion, financial summary, next
/// best action). Selecting one generates a draft that is shown in the review
/// sheet; nothing is persisted until the user confirms and saves.
class ActionCopilotPanel extends ConsumerWidget {
  const ActionCopilotPanel({super.key});

  Future<void> _generate(BuildContext context, WidgetRef ref, CopilotDraftKind kind) async {
    await ref.read(actionCopilotControllerProvider.notifier).generate(kind);
    if (!context.mounted) return;
    await ActionCopilotReviewSheet.show(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final draft = ref.watch(actionCopilotControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.auto_awesome, color: scheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.actionCopilotTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.actionCopilotSubtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (draft?.status == CopilotDraftStatus.drafting)
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text(l10n.actionCopilotDrafting),
                ],
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ActionButton(
                    icon: Icons.receipt_long_outlined,
                    label: l10n.actionCopilotSuggestInvoice,
                    onPressed: () => _generate(
                      context,
                      ref,
                      CopilotDraftKind.invoiceSuggestion,
                    ),
                  ),
                  _ActionButton(
                    icon: Icons.summarize_outlined,
                    label: l10n.actionCopilotFinancialSummary,
                    onPressed: () => _generate(
                      context,
                      ref,
                      CopilotDraftKind.financialSummary,
                    ),
                  ),
                  _ActionButton(
                    icon: Icons.tips_and_updates_outlined,
                    label: l10n.actionCopilotNextBestAction,
                    onPressed: () => _generate(
                      context,
                      ref,
                      CopilotDraftKind.nextBestAction,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
