import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository_provider.dart';
import 'package:accounting_app/features/journal_explorer/domain/journal_entry.dart';
import 'package:accounting_app/features/journal_explorer/domain/journal_line.dart';
import 'package:accounting_app/features/journal_explorer/presentation/journal_entry_detail_page.dart';
import 'package:accounting_app/features/journal_explorer/presentation/journal_explorer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  final sampleEntry = JournalEntry(
    journalNumber: 'JE-VB-1001',
    postingDate: DateTime(2024, 1, 15),
    sourceDocumentType: 'vendor_bill',
    sourceDocumentId: 'VB-1001',
    sourceReference: 'VB-1001',
    narration: 'Preview posting for vendor bill VB-1001',
    postingStatus: 'Preview',
    totalDebit: 100,
    totalCredit: 100,
    lines: const [
      JournalLine(
        accountCode: '5100',
        accountName: 'Expenses',
        debit: 100,
        credit: 0,
        notes: 'Expense posting',
      ),
      JournalLine(
        accountCode: '2000',
        accountName: 'Accounts Payable',
        debit: 0,
        credit: 100,
        notes: 'Payable',
      ),
    ],
  );

  testWidgets('shows the journal explorer page shell', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          journalExplorerRepositoryProvider.overrideWithValue(
            MockJournalExplorerRepository(),
          ),
        ],
        child: const MaterialApp(home: JournalExplorerPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('General Journal'), findsOneWidget);
  });

  testWidgets('shows journal entry detail page', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: JournalEntryDetailPage(entry: sampleEntry)),
      ),
    );

    expect(find.text('JE-VB-1001'), findsOneWidget);
    expect(find.text('View source document'), findsOneWidget);
    expect(find.text('5100 • Expenses'), findsOneWidget);
  });

  testWidgets('navigates to journal entry detail from list', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const JournalExplorerPage(),
        ),
        GoRoute(
          path: '/journal-explorer/:id',
          builder: (context, state) {
            final entry = state.extra as JournalEntry?;
            return JournalEntryDetailPage(entry: entry!);
          },
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          journalExplorerRepositoryProvider.overrideWithValue(
            MockJournalExplorerRepository(),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    expect(find.text('View source document'), findsOneWidget);
  });
}
