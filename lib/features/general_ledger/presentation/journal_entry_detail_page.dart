import 'package:flutter/material.dart';

import '../../../core/finance/journal_entry.dart';
import '../../../core/finance/transaction_line.dart';
import '../../../l10n/app_localizations.dart';

class JournalEntryDetailPage extends StatelessWidget {
  const JournalEntryDetailPage({
    super.key,
    required this.entry,
    required this.l10n,
  });

  final JournalEntry entry;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(l10n.journalEntryDetailTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('${l10n.journalEntryReferenceLabel}: ${entry.reference}'),
            const SizedBox(height: 8),
            Text(
              '${l10n.journalEntryDateLabel}: ${entry.date.toLocal().toString().split(' ').first}',
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.journalEntryMemoLabel}: ${entry.memo ?? l10n.journalEntryNoMemo}',
            ),
            const SizedBox(height: 12),
            Text(l10n.journalEntryLinesLabel),
            const SizedBox(height: 8),
            ...entry.lines.map((line) => _LineTile(line: line, l10n: l10n)),
          ],
        ),
      ),
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({required this.line, required this.l10n});

  final TransactionLine line;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(line.description ?? l10n.journalEntryLineDefault),
        subtitle: Text(
          '${line.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
        ),
        trailing: Text(
          line.amount >= 0 ? l10n.journalEntryDebit : l10n.journalEntryCredit,
        ),
      ),
    );
  }
}
