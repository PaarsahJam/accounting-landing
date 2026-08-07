import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/bank_statement.dart';
import '../domain/bank_statement_status.dart';
import '../domain/bank_statements_controller.dart';

class BankStatementsPage extends ConsumerWidget {
  const BankStatementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final statementsAsync = ref.watch(bankStatementsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.bankStatementsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () =>
                ref.read(bankStatementsControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: statementsAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.bankStatementsLoadError} $error'),
        data: (statements) {
          if (statements.isEmpty) {
            return AppEmptyState(
              title: l10n.bankStatementsEmptyTitle,
              message: l10n.bankStatementsEmptyMessage,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: statements.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final statement = statements[index];
              return _BankStatementCard(statement: statement);
            },
          );
        },
      ),
    );
  }
}

class _BankStatementCard extends StatelessWidget {
  const _BankStatementCard({required this.statement});

  final BankStatement statement;

  Color _statusColor(BankStatementStatus status) {
    switch (status) {
      case BankStatementStatus.reconciled:
        return Colors.green;
      case BankStatementStatus.inProgress:
        return Colors.blue;
      case BankStatementStatus.needsAttention:
        return Colors.red;
      case BankStatementStatus.draft:
        return Colors.grey;
    }
  }

  String _formatDate(BuildContext context, DateTime date) =>
      AppFormatters.formatIsoDate(
        date,
        locale: Localizations.localeOf(context).languageCode,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _statusColor(statement.status);

    return Card(
      child: InkWell(
        onTap: () => context.push(
          '/bank-statements/${statement.id}/reconcile',
          extra: statement,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statement.bankAccountName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_formatDate(context, statement.periodStart)} – ${_formatDate(context, statement.periodEnd)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: statusColor.withAlpha(100)),
                    ),
                    child: Text(
                      statement.status.label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _BalanceCell(
                      label: 'Opening',
                      amount: statement.openingBalance,
                      currency: 'USD',
                    ),
                  ),
                  Expanded(
                    child: _BalanceCell(
                      label: 'Closing',
                      amount: statement.closingBalance,
                      currency: 'USD',
                    ),
                  ),
                  Expanded(
                    child: _BalanceCell(
                      label: 'Unreconciled',
                      amount: statement.unreconciledAmount,
                      currency: 'USD',
                      highlight: statement.unreconciledAmount > 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: statement.progressPercent,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
              const SizedBox(height: 4),
              Text(
                '${statement.matched.length} / ${statement.transactions.length} matched',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCell extends StatelessWidget {
  const _BalanceCell({
    required this.label,
    required this.amount,
    required this.currency,
    this.highlight = false,
  });

  final String label;
  final double amount;
  final String currency;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          '$currency ${amount.toStringAsFixed(2)}',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: highlight ? Colors.orange : null,
          ),
        ),
      ],
    );
  }
}
