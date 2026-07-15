import 'package:freezed_annotation/freezed_annotation.dart';

import 'journal_line.dart';

part 'journal_entry.freezed.dart';

@freezed
abstract class JournalEntry with _$JournalEntry {
  const factory JournalEntry({
    required String journalNumber,
    required DateTime postingDate,
    required String sourceDocumentType,
    required String sourceDocumentId,
    required String sourceReference,
    required String narration,
    required String postingStatus,
    required double totalDebit,
    required double totalCredit,
    required List<JournalLine> lines,
  }) = _JournalEntry;
}
