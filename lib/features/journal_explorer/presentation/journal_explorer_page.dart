import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/journal_entry.dart';
import '../domain/journal_explorer_controller.dart';
import '../domain/journal_source_types.dart';

class JournalExplorerPage extends ConsumerStatefulWidget {
  const JournalExplorerPage({super.key});

  @override
  ConsumerState<JournalExplorerPage> createState() =>
      _JournalExplorerPageState();
}

class _JournalExplorerPageState extends ConsumerState<JournalExplorerPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  String _sourceType = journalSourceTypeAll;
  String _sortOrder = 'newest';
  DateTimeRange? _dateRange;

  @override
  void dispose() {
    _searchController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDateRange: _dateRange,
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }

  void _openEntryDetail(JournalEntry entry) {
    context.push('/journal-explorer/${entry.sourceDocumentId}', extra: entry);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final entriesAsync = ref.watch(journalExplorerControllerProvider);

    return ResponsivePageScaffold(
      title: l10n.journalExplorerPageTitle,
      child: entriesAsync.when(
        loading: () => AppLoadingState(message: l10n.journalExplorerLoading),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.journalExplorerLoadError} $error'),
        data: (entries) {
          final filteredEntries = ref
              .read(journalExplorerControllerProvider.notifier)
              .applyFilters(
                entries: entries,
                query: _searchController.text,
                sourceType: _sourceType,
                dateRange: _dateRange,
                accountCode: _accountController.text,
                sortOrder: _sortOrder,
              );

          if (entries.isEmpty) {
            return AppEmptyState(
              title: l10n.journalExplorerEmptyTitle,
              message: l10n.journalExplorerEmptyMessage,
            );
          }

          if (filteredEntries.isEmpty) {
            return Column(
              children: [
                _buildFilters(l10n),
                Expanded(
                  child: AppEmptyState(
                    title: l10n.journalExplorerEmptyTitle,
                    message: l10n.journalExplorerEmptyMessage,
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              _buildFilters(l10n),
              Expanded(
                child: ListView.separated(
                  itemCount: filteredEntries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final entry = filteredEntries[index];
                    final sourceLabel = journalSourceTypeLabel(
                      entry.sourceDocumentType,
                      l10n,
                    );
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${entry.journalNumber} • ${entry.sourceReference}',
                        ),
                        subtitle: Text('$sourceLabel • ${entry.narration}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(entry.postingStatus),
                            Text(
                              entry.postingDate
                                  .toIso8601String()
                                  .split('T')
                                  .first,
                            ),
                          ],
                        ),
                        onTap: () => _openEntryDetail(entry),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilters(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 240,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: l10n.journalExplorerSearchHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: _sourceType,
                  decoration: InputDecoration(
                    labelText: l10n.journalExplorerSourceType,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: journalSourceTypeAll,
                      child: Text(
                        l10n.journalExplorerSourceAll,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ...journalSourceTypes.map(
                      (type) => DropdownMenuItem(
                        value: type.id,
                        child: Text(
                          journalSourceTypeLabel(type.id, l10n),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(
                    () => _sourceType = value ?? journalSourceTypeAll,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: l10n.journalExplorerAccountCode,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: _sortOrder,
                  decoration: InputDecoration(
                    labelText: l10n.journalExplorerSortBy,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'newest',
                      child: Text(l10n.journalExplorerNewest),
                    ),
                    DropdownMenuItem(
                      value: 'oldest',
                      child: Text(l10n.journalExplorerOldest),
                    ),
                  ],
                  onChanged: (value) =>
                      setState(() => _sortOrder = value ?? 'newest'),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _pickDateRange,
                icon: const Icon(Icons.date_range),
                label: Text(
                  _dateRange == null
                      ? l10n.journalExplorerDateRange
                      : '${_dateRange!.start.year}/${_dateRange!.start.month}/${_dateRange!.start.day} – ${_dateRange!.end.year}/${_dateRange!.end.month}/${_dateRange!.end.day}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
