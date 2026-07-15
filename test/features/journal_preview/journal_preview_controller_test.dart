import 'package:accounting_app/features/journal_preview/data/journal_preview_repository.dart';
import 'package:accounting_app/features/journal_preview/data/journal_preview_repository_provider.dart';
import 'package:accounting_app/features/journal_preview/domain/journal_preview_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads journal preview through the controller', () async {
    final container = ProviderContainer(
      overrides: [
        journalPreviewRepositoryProvider.overrideWithValue(
          MockJournalPreviewRepository(),
        ),
      ],
    );

    addTearDown(container.dispose);

    final controller = container.read(
      journalPreviewControllerProvider('purchase_order', 'PO-1001').notifier,
    );
    final preview = await controller.loadPreview('purchase_order', 'PO-1001');

    expect(preview, isNotNull);
    expect(preview!.documentReference, 'PO-1001');
  });
}
