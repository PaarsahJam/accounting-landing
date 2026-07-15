import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/account_detail_controller.dart';
import 'journal_entry_detail_page.dart';

class AccountDetailPage extends ConsumerWidget {
  const AccountDetailPage({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final detailAsync = ref.watch(accountDetailControllerProvider(accountId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountDetailPageTitle)),
      body: detailAsync.when(
        loading: () =>
            AppLoadingState(message: l10n.accountDetailLoadingMessage),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.generalLedgerLoadError} $error'),
        data: (data) {
          if (data.transactions.isEmpty) {
            return AppEmptyState(
              title: l10n.accountDetailNoTransactionsTitle,
              message: l10n.accountDetailNoTransactionsMessage,
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.account.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('${data.account.code} • ${data.account.currency}'),
                const SizedBox(height: 8),
                Text(
                  '${l10n.accountDetailBalanceLabel}: ${data.currentBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.accountDetailTransactionsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.separated(
                    itemCount: data.transactions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final transaction = data.transactions[index];
                      return Card(
                        child: ListTile(
                          title: Text(transaction.description),
                          subtitle: Text(
                            '${transaction.entry.reference} • ${transaction.entry.date.toLocal().toString().split(' ').first}',
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${transaction.isDebit ? l10n.journalEntryDebit : l10n.journalEntryCredit} ${transaction.amount.toStringAsFixed(0)}',
                              ),
                              Text(
                                transaction.isDebit
                                    ? l10n.journalEntryDebit
                                    : l10n.journalEntryCredit,
                              ),
                            ],
                          ),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (context) => JournalEntryDetailPage(
                                entry: transaction.entry,
                                l10n: l10n,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
