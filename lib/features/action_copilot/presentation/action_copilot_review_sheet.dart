import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../action_copilot_provider.dart';
import '../domain/action_copilot_draft.dart';

/// Bottom sheet that lets the user review, edit and confirm a generated draft.
///
/// The sheet renders the audit-safe lifecycle states:
/// - review: read-only preview with Edit / Confirm & Save
/// - editing: editable text field with Save / Discard
/// - confirming: explicit confirmation dialog (financial mutations get a
///   stronger, audit-trail-aware message)
/// - saved: success confirmation
/// - error: fallback message when the AI is unavailable
class ActionCopilotReviewSheet extends ConsumerStatefulWidget {
  const ActionCopilotReviewSheet({super.key});

  /// Opens the sheet for the current draft.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ActionCopilotReviewSheet(),
    );
  }

  @override
  ConsumerState<ActionCopilotReviewSheet> createState() =>
      _ActionCopilotReviewSheetState();
}

class _ActionCopilotReviewSheetState
    extends ConsumerState<ActionCopilotReviewSheet> {
  final _editController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  AppLocalizations get _l10n =>
      AppLocalizations.of(context) ?? AppLocalizationsEn('en');

  void _startEditing(ActionCopilotDraft draft) {
    _editController.text = draft.content;
    setState(() => _isEditing = true);
  }

  void _saveEdit() {
    ref.read(actionCopilotControllerProvider.notifier).edit(
          _editController.text.trim(),
        );
    setState(() => _isEditing = false);
  }

  Future<void> _confirmAndSave(ActionCopilotDraft draft) async {
    final confirmed = await _showConfirmationDialog(draft);
    if (confirmed != true || !mounted) return;

    final controller = ref.read(actionCopilotControllerProvider.notifier);
    controller.confirm();
    await controller.save();
  }

  Future<bool?> _showConfirmationDialog(ActionCopilotDraft draft) {
    final l10n = _l10n;
    final body = draft.requiresConfirmation
        ? l10n.actionCopilotFinancialConfirmBody(draft.content)
        : l10n.actionCopilotConfirmBody(draft.content);

    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.actionCopilotConfirmTitle),
        content: SingleChildScrollView(
          child: SelectableText(body),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.actionCopilotConfirmLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    final draft = ref.watch(actionCopilotControllerProvider);

    if (draft == null) {
      return _SheetScaffold(
        child: Center(child: Text(l10n.actionCopilotSubtitle)),
      );
    }

    return _SheetScaffold(
      child: _buildDraftBody(draft, l10n),
    );
  }

  Widget _buildDraftBody(ActionCopilotDraft draft, AppLocalizations l10n) {
    switch (draft.status) {
      case CopilotDraftStatus.saved:
        return _StatusView(
          icon: Icons.check_circle,
          color: Colors.green,
          message: l10n.actionCopilotSaved,
          detail: draft.auditNote,
        );
      case CopilotDraftStatus.error:
        return _StatusView(
          icon: Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          message: l10n.actionCopilotError,
          detail: draft.errorMessage,
        );
      case CopilotDraftStatus.drafting:
      case CopilotDraftStatus.saving:
      case CopilotDraftStatus.confirming:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          ),
        );
      case CopilotDraftStatus.review:
      case CopilotDraftStatus.editing:
        return _buildEditableDraft(draft, l10n);
      case CopilotDraftStatus.idle:
        return Center(child: Text(l10n.actionCopilotSubtitle));
    }
  }

  Widget _buildEditableDraft(ActionCopilotDraft draft, AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;
    final isEditing = _isEditing || draft.status == CopilotDraftStatus.editing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.description_outlined, color: scheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _kindLabel(draft.kind, l10n),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            if (draft.requiresConfirmation)
              Chip(
                label: Text(l10n.actionCopilotEditedLabel),
                backgroundColor: scheme.errorContainer,
                labelStyle: TextStyle(color: scheme.onErrorContainer),
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: isEditing
              ? TextField(
                  controller: _editController,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: l10n.actionCopilotEditHint,
                    border: const OutlineInputBorder(),
                  ),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(draft.content),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => ref
                  .read(actionCopilotControllerProvider.notifier)
                  .discard(),
              child: Text(l10n.actionCopilotDiscard),
            ),
            if (!isEditing) ...[
              TextButton.icon(
                onPressed: () => _startEditing(draft),
                icon: const Icon(Icons.edit_outlined),
                label: Text(l10n.actionCopilotEditDraft),
              ),
              FilledButton.icon(
                onPressed: () => _confirmAndSave(draft),
                icon: const Icon(Icons.lock_outline),
                label: Text(l10n.actionCopilotConfirmAndSave),
              ),
            ] else
              FilledButton.icon(
                onPressed: _saveEdit,
                icon: const Icon(Icons.save_outlined),
                label: Text(l10n.actionCopilotSaveDraft),
              ),
          ],
        ),
      ],
    );
  }

  String _kindLabel(CopilotDraftKind kind, AppLocalizations l10n) =>
      switch (kind) {
        CopilotDraftKind.invoiceSuggestion =>
          l10n.actionCopilotSuggestInvoice,
        CopilotDraftKind.financialSummary =>
          l10n.actionCopilotFinancialSummary,
        CopilotDraftKind.nextBestAction => l10n.actionCopilotNextBestAction,
      };
}

class _SheetScaffold extends StatelessWidget {
  const _SheetScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: child,
        ),
      ),
    );
  }
}

class _StatusView extends StatelessWidget {
  const _StatusView({
    required this.icon,
    required this.color,
    required this.message,
    this.detail,
  });

  final IconData icon;
  final Color color;
  final String message;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (detail != null && detail!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                detail!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
