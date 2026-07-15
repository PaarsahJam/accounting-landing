import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository_provider.dart';
import 'package:accounting_app/features/journal_explorer/domain/journal_explorer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JournalExplorerController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          journalExplorerRepositoryProvider.overrideWithValue(
            MockJournalExplorerRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads journal entries through the controller', () async {
      final controller = container.read(
        journalExplorerControllerProvider.notifier,
      );
      final entries = await controller.future;

      expect(entries, isNotEmpty);
    });

    test('filters journal entries by query and source type', () async {
      final controller = container.read(
        journalExplorerControllerProvider.notifier,
      );
      final entries = await controller.future;
      final filtered = controller.applyFilters(
        entries: entries,
        query: 'PO-1001',
        sourceType: 'purchase_order',
      );

      expect(filtered, isNotEmpty);
      expect(filtered.first.sourceDocumentType, 'purchase_order');
    });

    test('filters journal entries by account code and date range', () async {
      final controller = container.read(
        journalExplorerControllerProvider.notifier,
      );
      final entries = await controller.future;
      final postingDate = entries.first.postingDate;
      final filtered = controller.applyFilters(
        entries: entries,
        accountCode: entries.first.lines.first.accountCode,
        dateRange: DateTimeRange(
          start: postingDate.subtract(const Duration(days: 1)),
          end: postingDate.add(const Duration(days: 1)),
        ),
        sortOrder: 'oldest',
      );

      expect(filtered, isNotEmpty);
    });
  });
}
