import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/extensions/menu_button.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../domain/bank_account.dart';
import '../domain/bank_account_status.dart';
import '../domain/bank_account_type.dart';
import '../domain/bank_accounts_controller.dart';

class BankAccountsPage extends ConsumerStatefulWidget {
  const BankAccountsPage({super.key});

  @override
  ConsumerState<BankAccountsPage> createState() => _BankAccountsPageState();
}

class _BankAccountsPageState extends ConsumerState<BankAccountsPage> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accountsAsync = ref.watch(bankAccountsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: context.menuButton,
        title: Text(l10n.bankAccountsPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () =>
                ref.read(bankAccountsControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: accountsAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.bankAccountsLoadError} $error'),
        data: (accounts) {
          final filtered = accounts.where((a) {
            final q = _search.toLowerCase();
            return q.isEmpty ||
                a.name.toLowerCase().contains(q) ||
                a.accountNumber.toLowerCase().contains(q);
          }).toList();

          if (filtered.isEmpty) {
            return AppEmptyState(
              title: l10n.bankAccountsEmptyTitle,
              message: l10n.bankAccountsEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.bankAccountsSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final account = filtered[index];
                    return _BankAccountCard(account: account);
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

class _BankAccountCard extends StatelessWidget {
  const _BankAccountCard({required this.account});

  final BankAccount account;

  Color _statusColor(BankAccountStatus status) {
    switch (status) {
      case BankAccountStatus.active:
        return Colors.green;
      case BankAccountStatus.inactive:
        return Colors.grey;
      case BankAccountStatus.frozen:
        return Colors.blue;
    }
  }

  IconData _typeIcon(BankAccountType type) {
    switch (type) {
      case BankAccountType.checking:
        return Icons.account_balance;
      case BankAccountType.savings:
        return Icons.savings;
      case BankAccountType.cash:
        return Icons.money;
      case BankAccountType.creditCard:
        return Icons.credit_card;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNegative = account.currentBalance < 0;

    return Card(
      child: InkWell(
        onTap: () => context.push(
          '/bank-accounts/${account.id}/transactions',
          extra: account,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _typeIcon(account.accountType),
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${account.accountNumber} • ${account.accountType.label}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${account.currency} ${account.currentBalance.toStringAsFixed(2)}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isNegative ? Colors.red : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(account.status).withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _statusColor(account.status).withAlpha(100),
                      ),
                    ),
                    child: Text(
                      account.status.label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _statusColor(account.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
