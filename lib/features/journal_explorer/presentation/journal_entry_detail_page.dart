import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/journal_entry.dart';
import '../domain/journal_source_types.dart';
import 'journal_source_navigation.dart';

class JournalEntryDetailPage extends ConsumerWidget {
  const JournalEntryDetailPage({required this.entry, super.key});

  final JournalEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final sourceLabel = journalSourceTypeLabel(entry.sourceDocumentType, l10n);

    return ResponsivePageScaffold(
      title: entry.journalNumber,
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.sourceReference,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('${l10n.journalExplorerSourceType}: $sourceLabel'),
                  Text(
                    '${l10n.journalExplorerPostingDate}: ${entry.postingDate.toIso8601String().split('T').first}',
                  ),
                  Text('${l10n.journalExplorerNarration}: ${entry.narration}'),
                  Text(
                    '${l10n.journalExplorerPostingStatus}: ${entry.postingStatus}',
                  ),
                  Text(
                    '${l10n.journalExplorerTotalDebit}: ${entry.totalDebit.toStringAsFixed(2)}',
                  ),
                  Text(
                    '${l10n.journalExplorerTotalCredit}: ${entry.totalCredit.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () =>
                            navigateToSourceDocument(context, ref, entry),
                        icon: const Icon(Icons.description_outlined),
                        label: Text(l10n.journalExplorerViewSource),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => context.push(
                          '/journal-preview/${entry.sourceDocumentType}/${entry.sourceDocumentId}',
                        ),
                        icon: const Icon(Icons.preview_outlined),
                        label: Text(l10n.journalPreviewPageTitle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.journalExplorerLinesLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...entry.lines.map(
            (line) => Card(
              child: ListTile(
                title: Text('${line.accountCode} • ${line.accountName}'),
                subtitle: Text(line.notes.isEmpty ? '—' : line.notes),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Dr ${line.debit.toStringAsFixed(2)}'),
                    Text('Cr ${line.credit.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
