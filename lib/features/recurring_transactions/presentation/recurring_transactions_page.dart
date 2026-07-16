// lib/features/recurring_transactions/presentation/recurring_transactions_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/recurring_transaction.dart';
import '../domain/recurring_transactions_controller.dart';

class RecurringTransactionsPage extends ConsumerWidget {
  const RecurringTransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final transactionsAsync = ref.watch(recurringTransactionsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recurringTransactionsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: l10n.recurringTransactionCreateTitle,
            onPressed: () => _showCreateEditDialog(context, ref, l10n, null),
          ),
        ],
      ),
      body: transactionsAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) => AppErrorState(
          message: '${l10n.recurringTransactionsLoadError} $e',
        ),
        data: (transactions) {
          if (transactions.isEmpty) {
            return AppEmptyState(
              title: l10n.recurringTransactionsEmptyTitle,
              message: l10n.recurringTransactionsEmptyMessage,
            );
          }
          return ListView.separated(
            itemCount: transactions.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (ctx, i) {
              final tx = transactions[i];
              return _RecurringTransactionTile(
                transaction: tx,
                l10n: l10n,
                ref: ref,
                onEdit: () =>
                    _showCreateEditDialog(context, ref, l10n, tx),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showCreateEditDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    RecurringTransaction? existing,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dCtx) => _CreateEditDialog(
        existing: existing,
        l10n: l10n,
        ref: ref,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile
// ─────────────────────────────────────────────────────────────────────────────

class _RecurringTransactionTile extends StatelessWidget {
  const _RecurringTransactionTile({
    required this.transaction,
    required this.l10n,
    required this.ref,
    required this.onEdit,
  });

  final RecurringTransaction transaction;
  final AppLocalizations l10n;
  final WidgetRef ref;
  final VoidCallback onEdit;

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: transaction.isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.repeat,
          size: 20,
          color: transaction.isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              transaction.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          _FrequencyBadge(transaction.frequency),
          const SizedBox(width: 4),
          if (transaction.isActive)
            _StatusBadge(l10n.recurringTransactionBadgeActive, Colors.green)
          else
            _StatusBadge(l10n.recurringTransactionBadgeInactive, Colors.grey),
        ],
      ),
      subtitle: Text(
        '${l10n.recurringTransactionNextRun}: ${_formatDate(transaction.nextRun)}'
        '  •  ${transaction.sourceDocumentType}',
      ),
      trailing: _TileActions(
        transaction: transaction,
        l10n: l10n,
        ref: ref,
        onEdit: onEdit,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tile actions (popup menu)
// ─────────────────────────────────────────────────────────────────────────────

class _TileActions extends StatelessWidget {
  const _TileActions({
    required this.transaction,
    required this.l10n,
    required this.ref,
    required this.onEdit,
  });

  final RecurringTransaction transaction;
  final AppLocalizations l10n;
  final WidgetRef ref;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.play_circle_outline, size: 20),
          tooltip: l10n.recurringTransactionExecuteNow,
          onPressed: transaction.isActive
              ? () async {
                  await ref
                      .read(recurringTransactionsControllerProvider.notifier)
                      .executeNow(transaction.id);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.recurringTransactionExecuted(transaction.name),
                        ),
                      ),
                    );
                  }
                }
              : null,
        ),
        PopupMenuButton<String>(
          onSelected: (value) async {
            final notifier = ref.read(
              recurringTransactionsControllerProvider.notifier,
            );
            switch (value) {
              case 'edit':
                onEdit();
              case 'activate':
                await notifier.activate(transaction.id);
              case 'deactivate':
                await notifier.deactivate(transaction.id);
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: const Icon(Icons.edit_outlined, size: 18),
                title: Text(l10n.recurringTransactionEditTitle),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            if (!transaction.isActive)
              PopupMenuItem(
                value: 'activate',
                child: ListTile(
                  leading: const Icon(Icons.check_circle_outline, size: 18),
                  title: Text(l10n.recurringTransactionActivate),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            if (transaction.isActive)
              PopupMenuItem(
                value: 'deactivate',
                child: ListTile(
                  leading: const Icon(Icons.pause_circle_outline, size: 18),
                  title: Text(l10n.recurringTransactionDeactivate),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Create / Edit dialog
// ─────────────────────────────────────────────────────────────────────────────

class _CreateEditDialog extends StatefulWidget {
  const _CreateEditDialog({
    required this.existing,
    required this.l10n,
    required this.ref,
  });

  final RecurringTransaction? existing;
  final AppLocalizations l10n;
  final WidgetRef ref;

  @override
  State<_CreateEditDialog> createState() => _CreateEditDialogState();
}

class _CreateEditDialogState extends State<_CreateEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _sourceIdCtrl;
  late final TextEditingController _sourceTypeCtrl;
  late final TextEditingController _notesCtrl;
  late RecurrenceFrequency _frequency;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameCtrl = TextEditingController(text: e?.name ?? '');
    _sourceIdCtrl = TextEditingController(text: e?.sourceDocumentId ?? '');
    _sourceTypeCtrl = TextEditingController(
      text: e?.sourceDocumentType ?? 'Vendor Bill',
    );
    _notesCtrl = TextEditingController(text: e?.notes ?? '');
    _frequency = e?.frequency ?? RecurrenceFrequency.monthly;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _sourceIdCtrl.dispose();
    _sourceTypeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isEdit = widget.existing != null;
    return AlertDialog(
      title: Text(
        isEdit
            ? l10n.recurringTransactionEditTitle
            : l10n.recurringTransactionCreateTitle,
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.recurringTransactionName,
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<RecurrenceFrequency>(
                  value: _frequency,
                  decoration: InputDecoration(
                    labelText: l10n.recurringTransactionFrequency,
                  ),
                  items: RecurrenceFrequency.values.map((f) {
                    return DropdownMenuItem(
                      value: f,
                      child: Text(_frequencyLabel(l10n, f)),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _frequency = v);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sourceIdCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.recurringTransactionSourceId,
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _sourceTypeCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.recurringTransactionSourceType,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _notesCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.recurringTransactionNotes,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.invoiceCancel),
        ),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final notifier = widget.ref.read(
              recurringTransactionsControllerProvider.notifier,
            );
            final now = DateTime.now();
            final tx = RecurringTransaction(
              id: widget.existing?.id ?? '',
              name: _nameCtrl.text.trim(),
              sourceDocumentId: _sourceIdCtrl.text.trim(),
              sourceDocumentType: _sourceTypeCtrl.text.trim().isEmpty
                  ? 'Vendor Bill'
                  : _sourceTypeCtrl.text.trim(),
              frequency: _frequency,
              nextRun: widget.existing?.nextRun ??
                  DateTime(now.year, now.month + 1, 1),
              lastRun: widget.existing?.lastRun,
              isActive: widget.existing?.isActive ?? true,
              notes: _notesCtrl.text.trim().isEmpty
                  ? null
                  : _notesCtrl.text.trim(),
            );
            if (widget.existing == null) {
              await notifier.create(tx);
            } else {
              await notifier.updateTransaction(tx);
            }
            if (context.mounted) Navigator.of(context).pop();
          },
          child: Text(l10n.invoiceSave),
        ),
      ],
    );
  }

  String _frequencyLabel(AppLocalizations l10n, RecurrenceFrequency f) {
    switch (f) {
      case RecurrenceFrequency.daily:
        return l10n.recurringFrequencyDaily;
      case RecurrenceFrequency.weekly:
        return l10n.recurringFrequencyWeekly;
      case RecurrenceFrequency.monthly:
        return l10n.recurringFrequencyMonthly;
      case RecurrenceFrequency.quarterly:
        return l10n.recurringFrequencyQuarterly;
      case RecurrenceFrequency.yearly:
        return l10n.recurringFrequencyYearly;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small badge widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        border: Border.all(color: color.withAlpha(120)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FrequencyBadge extends StatelessWidget {
  const _FrequencyBadge(this.frequency);

  final RecurrenceFrequency frequency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        frequency.label.toUpperCase(),
        style: TextStyle(
          fontSize: 9,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
