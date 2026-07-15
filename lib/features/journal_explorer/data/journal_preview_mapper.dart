import '../../journal_preview/domain/journal_preview.dart';
import '../domain/journal_entry.dart';
import '../domain/journal_line.dart';

JournalEntry journalEntryFromPreview(JournalPreview preview) {
  final lines = preview.lines.map((line) {
    final isDebit = line.side == 'debit';
    return JournalLine(
      accountCode: line.accountCode,
      accountName: line.accountName,
      debit: isDebit ? line.amount : 0,
      credit: isDebit ? 0 : line.amount,
      notes: line.description,
    );
  }).toList();

  final totalDebit = lines.fold<double>(0.0, (sum, line) => sum + line.debit);
  final totalCredit = lines.fold<double>(0.0, (sum, line) => sum + line.credit);

  return JournalEntry(
    journalNumber: 'JE-${preview.documentReference}',
    postingDate: preview.postingDate,
    sourceDocumentType: preview.documentType,
    sourceDocumentId: preview.documentId,
    sourceReference: preview.documentReference,
    narration: preview.narration,
    postingStatus: 'Preview',
    totalDebit: totalDebit,
    totalCredit: totalCredit,
    lines: lines,
  );
}
