import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/journal_preview_controller.dart';

class JournalPreviewPage extends ConsumerWidget {
  const JournalPreviewPage({
    super.key,
    required this.documentType,
    required this.documentId,
  });

  final String documentType;
  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final previewAsync = ref.watch(
      journalPreviewControllerProvider(documentType, documentId),
    );

    return ResponsivePageScaffold(
      title: l10n.journalPreviewPageTitle,
      child: previewAsync.when(
        loading: () => const AppLoadingState(message: 'Generating preview'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.journalPreviewLoadError} $error'),
        data: (preview) {
          if (preview == null) {
            return AppEmptyState(
              title: l10n.journalPreviewEmptyTitle,
              message: l10n.journalPreviewEmptyMessage,
            );
          }

          return ListView(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        preview.documentReference,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${l10n.journalPreviewDocument}: ${preview.documentType}',
                      ),
                      Text(
                        '${l10n.journalPreviewPostingDate}: ${preview.postingDate.toIso8601String().split('T').first}',
                      ),
                      Text(
                        '${l10n.journalPreviewNarration}: ${preview.narration}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.journalPreviewLinesLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...preview.lines.map(
                (line) => Card(
                  child: ListTile(
                    title: Text(line.accountName),
                    subtitle: Text('${line.accountCode} • ${line.description}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          line.side.toUpperCase(),
                          style: TextStyle(
                            color: line.side == 'debit'
                                ? Colors.green.shade700
                                : Colors.amber.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(line.amount.toStringAsFixed(2)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
