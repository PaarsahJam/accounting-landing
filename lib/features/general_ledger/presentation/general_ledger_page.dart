import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/finance/balance_snapshot.dart';
import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/ledger_account.dart';
import '../../../core/finance/ledger_account_type.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/general_ledger_controller.dart';
import '../domain/general_ledger_view_data.dart';
import 'account_detail_page.dart';
import 'journal_entry_detail_page.dart';

class GeneralLedgerPage extends ConsumerStatefulWidget {
  const GeneralLedgerPage({super.key});

  @override
  ConsumerState<GeneralLedgerPage> createState() => _GeneralLedgerPageState();
}

class _GeneralLedgerPageState extends ConsumerState<GeneralLedgerPage> {
  String _search = '';
  String _selectedTab = 'accounts';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final ledgerAsync = ref.watch(generalLedgerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.generalLedgerPageTitle),
        actions: [
          IconButton(
            onPressed: () =>
                ref.read(generalLedgerControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
          ),
        ],
      ),
      body: ledgerAsync.when(
        loading: () => const AppLoadingState(message: 'Loading ledger'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.generalLedgerLoadError} $error'),
        data: (data) {
          final filteredAccounts = data.accounts.where((account) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                account.name.toLowerCase().contains(query) ||
                account.code.toLowerCase().contains(query);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.generalLedgerSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'accounts',
                      label: Text(l10n.chartOfAccountsTitle),
                    ),
                    ButtonSegment(
                      value: 'entries',
                      label: Text(l10n.journalEntriesTitle),
                    ),
                    ButtonSegment(
                      value: 'trial',
                      label: Text(l10n.trialBalanceTitle),
                    ),
                  ],
                  selected: {_selectedTab},
                  onSelectionChanged: (selection) =>
                      setState(() => _selectedTab = selection.first),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildContent(l10n, data, filteredAccounts)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(
    AppLocalizations l10n,
    GeneralLedgerViewData data,
    List<LedgerAccount> filteredAccounts,
  ) {
    if (_selectedTab == 'entries') {
      return _JournalEntriesTab(entries: data.entries, l10n: l10n);
    }
    if (_selectedTab == 'trial') {
      return _TrialBalanceTab(trialBalance: data.trialBalance, l10n: l10n);
    }
    return _AccountsTab(
      accounts: filteredAccounts,
      l10n: l10n,
      snapshot: data.snapshot,
    );
  }
}

class _AccountsTab extends StatelessWidget {
  const _AccountsTab({
    required this.accounts,
    required this.l10n,
    required this.snapshot,
  });

  final List<LedgerAccount> accounts;
  final AppLocalizations l10n;
  final BalanceSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.generalLedgerEmptyTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(l10n.generalLedgerEmptyMessage),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: accounts.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final account = accounts[index];
        final balance = snapshot.balances[account.id] ?? 0.0;
        return Card(
          child: ListTile(
            title: Text('${account.code} ${account.name}'),
            subtitle: Text(
              '${l10n.ledgerAccountTypeLabel}: ${_accountTypeLabel(account.type, l10n)}',
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${balance.toStringAsFixed(0)} ${l10n.currencyUnit}'),
                Text(
                  account.active
                      ? l10n.generalLedgerActive
                      : l10n.generalLedgerInactive,
                ),
              ],
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => AccountDetailPage(accountId: account.id),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _JournalEntriesTab extends StatelessWidget {
  const _JournalEntriesTab({required this.entries, required this.l10n});

  final List<JournalEntry> entries;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.generalLedgerEmptyTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(l10n.generalLedgerEmptyMessage),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          child: ListTile(
            title: Text(entry.reference),
            subtitle: Text(
              '${entry.date.toLocal().toString().split(' ').first} • ${entry.memo ?? l10n.journalEntryNoMemo}',
            ),
            trailing: Text(
              entry.isBalanced
                  ? l10n.generalLedgerBalanced
                  : l10n.generalLedgerUnbalanced,
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) =>
                    JournalEntryDetailPage(entry: entry, l10n: l10n),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TrialBalanceTab extends StatelessWidget {
  const _TrialBalanceTab({required this.trialBalance, required this.l10n});

  final List<TrialBalanceLine> trialBalance;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    if (trialBalance.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.generalLedgerEmptyTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(l10n.generalLedgerEmptyMessage),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: trialBalance.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final line = trialBalance[index];
        return Card(
          child: ListTile(
            title: Text(line.account.name),
            subtitle: Text(
              '${l10n.ledgerAccountTypeLabel}: ${_accountTypeLabel(line.account.type, l10n)}',
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l10n.trialBalanceDebitLabel}: ${line.debit.toStringAsFixed(0)}',
                ),
                Text(
                  '${l10n.trialBalanceCreditLabel}: ${line.credit.toStringAsFixed(0)}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _accountTypeLabel(LedgerAccountType type, AppLocalizations l10n) {
  switch (type) {
    case LedgerAccountType.asset:
      return l10n.ledgerAccountAsset;
    case LedgerAccountType.liability:
      return l10n.ledgerAccountLiability;
    case LedgerAccountType.equity:
      return l10n.ledgerAccountEquity;
    case LedgerAccountType.revenue:
      return l10n.ledgerAccountRevenue;
    case LedgerAccountType.expense:
      return l10n.ledgerAccountExpense;
  }
}
