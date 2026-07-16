import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/bank_reconciliation_detail_controller.dart';
import '../domain/bank_statement.dart';
import '../domain/bank_statement_status.dart';
import '../domain/bank_statement_transaction.dart';

class BankReconciliationDetailPage extends ConsumerWidget {
  const BankReconciliationDetailPage({super.key, required this.statement});

  final BankStatement statement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final detailAsync = ref.watch(
      bankReconciliationDetailControllerProvider(statement.id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${l10n.bankReconciliationPageTitle} — ${statement.bankAccountName}',
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: Text(l10n.bankReconciliationAutoMatch),
            onPressed: () => ref
                .read(
                  bankReconciliationDetailControllerProvider(
                    statement.id,
                  ).notifier,
                )
                .autoMatch(),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(
          message: '${l10n.bankReconciliationLoadError} $error',
        ),
        data: (detail) {
          final matched = detail.statement.matched;
          final unmatched = detail.statement.unmatched;

          return Column(
            children: [
              _ReconciliationSummaryBar(detail: detail, l10n: l10n),
              Expanded(
                child: _ReconciliationBody(
                  matched: matched,
                  unmatched: unmatched,
                  statementId: statement.id,
                  ref: ref,
                  l10n: l10n,
                ),
              ),
              _ReconciliationFooter(
                detail: detail,
                statementId: statement.id,
                ref: ref,
                l10n: l10n,
                context: context,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReconciliationSummaryBar extends StatelessWidget {
  const _ReconciliationSummaryBar({required this.detail, required this.l10n});

  final ReconciliationDetailState detail;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statement = detail.statement;

    return Container(
      color: theme.colorScheme.primaryContainer.withAlpha(60),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              label: l10n.bankStatementsOpeningBalance,
              value: statement.openingBalance.toStringAsFixed(2),
            ),
          ),
          Expanded(
            child: _SummaryItem(
              label: l10n.bankStatementsClosingBalance,
              value: statement.closingBalance.toStringAsFixed(2),
            ),
          ),
          Expanded(
            child: _SummaryItem(
              label: l10n.bankReconciliationDifference,
              value: detail.difference.toStringAsFixed(2),
              highlight: !detail.isBalanced,
            ),
          ),
          Expanded(
            child: _SummaryItem(
              label: l10n.bankProgress,
              value:
                  '${statement.matched.length}/${statement.transactions.length}',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _statusColor(statement.status).withAlpha(30),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _statusColor(statement.status).withAlpha(100),
              ),
            ),
            child: Text(
              statement.status.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: _statusColor(statement.status),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
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
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: highlight ? Colors.red : null,
          ),
        ),
      ],
    );
  }
}

class _ReconciliationBody extends StatelessWidget {
  const _ReconciliationBody({
    required this.matched,
    required this.unmatched,
    required this.statementId,
    required this.ref,
    required this.l10n,
  });

  final List<BankStatementTransaction> matched;
  final List<BankStatementTransaction> unmatched;
  final String statementId;
  final WidgetRef ref;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _TransactionPanel(
              title: l10n.bankMatchedTransactions,
              transactions: matched,
              isMatched: true,
              statementId: statementId,
              ref: ref,
              l10n: l10n,
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _TransactionPanel(
              title: l10n.bankUnmatchedTransactions,
              transactions: unmatched,
              isMatched: false,
              statementId: statementId,
              ref: ref,
              l10n: l10n,
            ),
          ),
        ],
      );
    }

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: l10n.bankMatchedTransactions),
              Tab(text: l10n.bankUnmatchedTransactions),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _TransactionPanel(
                  title: l10n.bankMatchedTransactions,
                  transactions: matched,
                  isMatched: true,
                  statementId: statementId,
                  ref: ref,
                  l10n: l10n,
                ),
                _TransactionPanel(
                  title: l10n.bankUnmatchedTransactions,
                  transactions: unmatched,
                  isMatched: false,
                  statementId: statementId,
                  ref: ref,
                  l10n: l10n,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionPanel extends StatelessWidget {
  const _TransactionPanel({
    required this.title,
    required this.transactions,
    required this.isMatched,
    required this.statementId,
    required this.ref,
    required this.l10n,
  });

  final String title;
  final List<BankStatementTransaction> transactions;
  final bool isMatched;
  final String statementId;
  final WidgetRef ref;
  final AppLocalizations l10n;

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (transactions.isEmpty) {
      return Center(
        child: Text(
          l10n.bankReconciliationNoTransactions,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final txn = transactions[index];
        final isCredit = txn.amount >= 0;

        return ListTile(
          dense: true,
          leading: Icon(
            isCredit ? Icons.arrow_downward : Icons.arrow_upward,
            color: isCredit ? Colors.green : Colors.red,
            size: 18,
          ),
          title: Text(txn.description, style: theme.textTheme.bodySmall),
          subtitle: Text(
            '${txn.reference} · ${_formatDate(txn.date)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${isCredit ? '+' : ''}${txn.amount.toStringAsFixed(2)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isCredit ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              if (isMatched)
                OutlinedButton(
                  onPressed: () => ref
                      .read(
                        bankReconciliationDetailControllerProvider(
                          statementId,
                        ).notifier,
                      )
                      .unmatchTransaction(txn.id),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 28),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(l10n.bankReconciliationUnmatch),
                )
              else
                FilledButton(
                  onPressed: () => ref
                      .read(
                        bankReconciliationDetailControllerProvider(
                          statementId,
                        ).notifier,
                      )
                      .matchTransaction(
                        transactionId: txn.id,
                        erpEntryId: 'ERP-${txn.reference}',
                        erpEntryLabel: txn.description,
                      ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 28),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(l10n.bankReconciliationMatch),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ReconciliationFooter extends StatelessWidget {
  const _ReconciliationFooter({
    required this.detail,
    required this.statementId,
    required this.ref,
    required this.l10n,
    required this.context,
  });

  final ReconciliationDetailState detail;
  final String statementId;
  final WidgetRef ref;
  final AppLocalizations l10n;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          if (!detail.isBalanced)
            Expanded(
              child: Text(
                '${l10n.bankReconciliationDifference}: ${detail.difference.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.red.shade700),
              ),
            )
          else
            Expanded(
              child: Text(
                l10n.bankReconciliationBalanced,
                style: const TextStyle(color: Colors.green),
              ),
            ),
          FilledButton(
            onPressed: detail.canFinalize
                ? () async {
                    await ref
                        .read(
                          bankReconciliationDetailControllerProvider(
                            statementId,
                          ).notifier,
                        )
                        .finalizeStatement();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.bankReconciliationFinalized),
                        ),
                      );
                    }
                  }
                : null,
            child: Text(l10n.bankFinalize),
          ),
        ],
      ),
    );
  }
}
