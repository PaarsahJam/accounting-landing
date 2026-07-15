import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_preview_mapper.dart';
import 'package:accounting_app/features/journal_preview/domain/journal_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JournalExplorerRepository', () {
    test('returns journal entries from mocked documents', () async {
      final repository = MockJournalExplorerRepository();

      final result = await repository.fetchJournalEntries();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.first.journalNumber, isNotEmpty);
    });

    test('builds entries from journal preview data', () async {
      final preview = JournalPreview(
        documentType: 'vendor_bill',
        documentId: 'VB-1001',
        documentReference: 'VB-1001',
        postingDate: DateTime(2024, 1, 15),
        narration: 'Preview posting for vendor bill VB-1001',
        lines: const [
          JournalPreviewLine(
            accountName: 'Expenses',
            accountCode: '5100',
            amount: 100,
            side: 'debit',
            description: 'Expense posting',
          ),
          JournalPreviewLine(
            accountName: 'Accounts Payable',
            accountCode: '2000',
            amount: 100,
            side: 'credit',
            description: 'Payable',
          ),
        ],
      );

      final entry = journalEntryFromPreview(preview);

      expect(entry.sourceDocumentType, 'vendor_bill');
      expect(entry.totalDebit, 100);
      expect(entry.totalCredit, 100);
      expect(entry.lines, hasLength(2));
    });
  });
}
