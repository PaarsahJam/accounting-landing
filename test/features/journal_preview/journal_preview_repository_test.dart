import 'package:accounting_app/features/journal_preview/data/journal_preview_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JournalPreviewRepository', () {
    test('returns a preview for a supported document', () async {
      final repository = MockJournalPreviewRepository();

      final result = await repository.fetchJournalPreview(
        'purchase_order',
        'PO-1001',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.documentReference, 'PO-1001');
      expect(result.data!.lines, isNotEmpty);
    });
  });
}
