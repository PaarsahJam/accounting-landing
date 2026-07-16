import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/bank_account.dart';
import '../domain/bank_transaction.dart';
import '../domain/bank_transaction_type.dart';
import '../domain/bank_transactions_controller.dart';

class BankTransactionsPage extends ConsumerStatefulWidget {
  const BankTransactionsPage({super.key, required this.account});

  final BankAccount account;

  @override
  ConsumerState<BankTransactionsPage> createState() =>
      _BankTransactionsPageState();
}

class _BankTransactionsPageState extends ConsumerState<BankTransactionsPage> {
  BankTransactionType? _typeFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final txnAsync = ref.watch(
      bankTransactionsControllerProvider(widget.account.id),
    );
    final controller = ref.read(
      bankTransactionsControllerProvider(widget.account.id).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: txnAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.bankTransactionsLoadError} $error'),
        data: (txnState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AccountSummaryCard(account: widget.account, l10n: l10n),
              _FilterBar(
                typeFilter: _typeFilter,
                l10n: l10n,
                onTypeChanged: (type) {
                  setState(() => _typeFilter = type);
                  controller.setTypeFilter(type);
                },
                onSearchChanged: controller.setSearch,
              ),
              Expanded(
                child: txnState.filtered.isEmpty
                    ? AppEmptyState(
                        title: l10n.bankTransactionsEmptyTitle,
                        message: l10n.bankTransactionsEmptyMessage,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: txnState.filtered.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final txn = txnState.filtered[index];
                          return _TransactionTile(txn: txn);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AccountSummaryCard extends StatelessWidget {
  const _AccountSummaryCard({required this.account, required this.l10n});

  final BankAccount account;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNegative = account.currentBalance < 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.primaryContainer.withAlpha(60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.bankAccountsBalanceLabel,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${account.currency} ${account.currentBalance.toStringAsFixed(2)}',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isNegative ? Colors.red : theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            account.accountNumber,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatefulWidget {
  const _FilterBar({
    required this.typeFilter,
    required this.l10n,
    required this.onTypeChanged,
    required this.onSearchChanged,
  });

  final BankTransactionType? typeFilter;
  final AppLocalizations l10n;
  final ValueChanged<BankTransactionType?> onTypeChanged;
  final ValueChanged<String> onSearchChanged;

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: l10n.bankTransactionsSearchHint,
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              onChanged: widget.onSearchChanged,
            ),
          ),
          const SizedBox(width: 12),
          DropdownButton<BankTransactionType?>(
            value: widget.typeFilter,
            hint: Text(l10n.bankTransactionsAllTypes),
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(l10n.bankTransactionsAllTypes),
              ),
              ...BankTransactionType.values.map(
                (t) => DropdownMenuItem(value: t, child: Text(t.label)),
              ),
            ],
            onChanged: widget.onTypeChanged,
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.txn});

  final BankTransaction txn;

  Color _typeColor(BankTransactionType type) {
    switch (type) {
      case BankTransactionType.deposit:
      case BankTransactionType.interest:
        return Colors.green;
      case BankTransactionType.withdrawal:
      case BankTransactionType.bankFee:
        return Colors.red;
      case BankTransactionType.transfer:
        return Colors.blue;
      case BankTransactionType.adjustment:
        return Colors.orange;
    }
  }

  IconData _typeIcon(BankTransactionType type) {
    switch (type) {
      case BankTransactionType.deposit:
        return Icons.arrow_downward;
      case BankTransactionType.withdrawal:
        return Icons.arrow_upward;
      case BankTransactionType.transfer:
        return Icons.swap_horiz;
      case BankTransactionType.interest:
        return Icons.percent;
      case BankTransactionType.bankFee:
        return Icons.account_balance;
      case BankTransactionType.adjustment:
        return Icons.tune;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _typeColor(txn.transactionType);
    final isCredit = txn.amount >= 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _typeIcon(txn.transactionType),
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txn.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${txn.reference} • '
                    '${txn.date.year}-${txn.date.month.toString().padLeft(2, '0')}-${txn.date.day.toString().padLeft(2, '0')}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? '+' : ''}${txn.amount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isCredit ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Bal: ${txn.runningBalance.toStringAsFixed(2)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
