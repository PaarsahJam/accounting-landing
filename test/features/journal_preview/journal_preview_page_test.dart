import 'package:accounting_app/features/journal_preview/data/journal_preview_repository.dart';
import 'package:accounting_app/features/journal_preview/data/journal_preview_repository_provider.dart';
import 'package:accounting_app/features/journal_preview/presentation/journal_preview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the journal preview page shell', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          journalPreviewRepositoryProvider.overrideWithValue(
            MockJournalPreviewRepository(),
          ),
        ],
        child: const MaterialApp(
          home: JournalPreviewPage(
            documentType: 'purchase_order',
            documentId: 'PO-1001',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Journal Preview'), findsOneWidget);
  });
}
