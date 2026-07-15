import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'journal_source_type.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/journal_explorer_repository.dart';
import '../data/journal_explorer_repository_provider.dart';
import 'journal_entry.dart';

part 'journal_explorer_controller.g.dart';

@riverpod
class JournalExplorerController extends _$JournalExplorerController {
  late final JournalExplorerRepository _repository;

  @override
  FutureOr<List<JournalEntry>> build() async {
    _repository = ref.watch(journalExplorerRepositoryProvider);
    final result = await _repository.fetchJournalEntries();
    if (result.isSuccess) {
      return result.data ?? const <JournalEntry>[];
    }
    AppLogger.warning('Failed to load journal entries', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchJournalEntries();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      if (ref.mounted) {
        state = AsyncValue.data(result.data ?? const <JournalEntry>[]);
      }
    } catch (e, st) {
      AppLogger.warning('Failed to refresh journal entries', error: e);
      if (ref.mounted) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  List<JournalEntry> applyFilters({
    required List<JournalEntry> entries,
    String query = '',
    String sourceType = journalSourceTypeAll,
    DateTimeRange? dateRange,
    String accountCode = '',
    String sortOrder = 'newest',
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    final normalizedAccountCode = accountCode.trim().toLowerCase();

    var filtered = entries.where((entry) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          entry.journalNumber.toLowerCase().contains(normalizedQuery) ||
          entry.sourceReference.toLowerCase().contains(normalizedQuery);
      final matchesSource =
          sourceType == journalSourceTypeAll ||
          entry.sourceDocumentType == sourceType;
      final matchesAccount =
          normalizedAccountCode.isEmpty ||
          entry.lines.any(
            (line) =>
                line.accountCode.toLowerCase().contains(normalizedAccountCode),
          );
      final matchesDate =
          dateRange == null ||
          (!entry.postingDate.isBefore(dateRange.start) &&
              !entry.postingDate.isAfter(dateRange.end));
      return matchesQuery && matchesSource && matchesAccount && matchesDate;
    }).toList();

    filtered.sort((a, b) {
      final comparison = a.postingDate.compareTo(b.postingDate);
      return sortOrder == 'oldest' ? comparison : -comparison;
    });

    return filtered;
  }
}
