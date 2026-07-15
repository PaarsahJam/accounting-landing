import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/bank_reconciliation_controller.dart';
import '../domain/bank_reconciliation_models.dart';

class BankReconciliationPage extends ConsumerWidget {
  const BankReconciliationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final stateAsync = ref.watch(bankReconciliationControllerProvider);
    final isWide = MediaQuery.of(context).size.width >= 900;

    return ResponsivePageScaffold(
      title: l10n.bankReconciliationPageTitle,
      child: stateAsync.when(
        loading: () => const AppLoadingState(message: 'Loading reconciliation'),
        error: (error, stackTrace) => AppErrorState(
          message: '${l10n.bankReconciliationLoadError} $error',
        ),
        data: (data) {
          final accounts = data['accounts'] as List<BankAccount>;
          final selectedAccount = data['selectedAccount'] as BankAccount;
          final transactions = data['transactions'] as List<BankTransaction>;
          final session = data['session'] as ReconciliationSession?;
          final matched = transactions.where((item) => item.matched).toList();
          final unmatched = transactions
              .where((item) => !item.matched)
              .toList();
          final completionPercent = transactions.isEmpty
              ? 0
              : (matched.length / transactions.length * 100).round();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.bankAccountSelector,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: selectedAccount.id,
                        items: accounts
                            .map(
                              (account) => DropdownMenuItem(
                                value: account.id,
                                child: Text(
                                  '${account.name} (${account.accountNumber})',
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(
                                  bankReconciliationControllerProvider.notifier,
                                )
                                .selectAccount(value);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.bankReconciliationSummary,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _SummaryChip(
                            label: l10n.bankMatchedTransactions,
                            value: '${matched.length}',
                          ),
                          _SummaryChip(
                            label: l10n.bankUnmatchedTransactions,
                            value: '${unmatched.length}',
                          ),
                          _SummaryChip(
                            label: l10n.bankProgress,
                            value: '$completionPercent%',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: transactions.isEmpty
                            ? 0
                            : matched.length / transactions.length,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (session != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.bankCompletionDialogTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${l10n.bankMatchedTransactions}: ${session.matchedCount}',
                        ),
                        Text(
                          '${l10n.bankUnmatchedTransactions}: ${session.unmatchedCount}',
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (transactions.isEmpty)
                AppEmptyState(
                  title: l10n.bankNoTransactions,
                  message: l10n.bankNoTransactionsMessage,
                )
              else
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _TransactionList(
                              title: l10n.bankMatchedTransactions,
                              transactions: matched,
                              onUnmatch: (tx) => ref
                                  .read(
                                    bankReconciliationControllerProvider
                                        .notifier,
                                  )
                                  .unmatchTransaction(tx.id),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _TransactionList(
                              title: l10n.bankUnmatchedTransactions,
                              transactions: unmatched,
                              onMatch: (tx) => ref
                                  .read(
                                    bankReconciliationControllerProvider
                                        .notifier,
                                  )
                                  .matchTransaction(
                                    transactionId: tx.id,
                                    ledgerEntryId: 'ledger-1002',
                                  ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _TransactionList(
                            title: l10n.bankMatchedTransactions,
                            transactions: matched,
                            onUnmatch: (tx) => ref
                                .read(
                                  bankReconciliationControllerProvider.notifier,
                                )
                                .unmatchTransaction(tx.id),
                          ),
                          const SizedBox(height: 16),
                          _TransactionList(
                            title: l10n.bankUnmatchedTransactions,
                            transactions: unmatched,
                            onMatch: (tx) => ref
                                .read(
                                  bankReconciliationControllerProvider.notifier,
                                )
                                .matchTransaction(
                                  transactionId: tx.id,
                                  ledgerEntryId: 'ledger-1002',
                                ),
                          ),
                        ],
                      ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () async {
                    await ref
                        .read(bankReconciliationControllerProvider.notifier)
                        .finalize();
                    if (context.mounted) {
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(l10n.bankCompletionDialogTitle),
                          content: Text(l10n.bankCompletionDialogMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(l10n.bankDone),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(l10n.bankFinalize),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value'),
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({
    required this.title,
    required this.transactions,
    this.onMatch,
    this.onUnmatch,
  });

  final String title;
  final List<BankTransaction> transactions;
  final ValueChanged<BankTransaction>? onMatch;
  final ValueChanged<BankTransaction>? onUnmatch;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (transactions.isEmpty)
              Text('—')
            else
              ...transactions.map(
                (transaction) => ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(
                    '${transaction.reference} • ${transaction.amount.toStringAsFixed(0)}',
                  ),
                  trailing: onMatch != null
                      ? FilledButton(
                          onPressed: () => onMatch!(transaction),
                          child: const Text('Match'),
                        )
                      : OutlinedButton(
                          onPressed: () => onUnmatch!(transaction),
                          child: const Text('Unmatch'),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
