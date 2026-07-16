// test/features/import_export/import_export_controller_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository_provider.dart';
import 'package:accounting_app/features/import_export/domain/import_export_controller.dart';
import 'package:accounting_app/features/import_export/domain/import_export_job.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    importExportRepositoryProvider.overrideWithValue(
      MockImportExportRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

void main() {
  group('ImportExportController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('initial state is empty list', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final jobs =
          await container.read(importExportControllerProvider.future);
      expect(jobs, isEmpty);
    });

    test('exportCsv adds job to state', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier =
          container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.exportCsv(ExportEntityType.customers);
      expect(result!.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.export));

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(1));
      expect(state.first.entityType, equals(ExportEntityType.customers));
    });

    test('importCsv adds job to state', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier =
          container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.importCsv(ExportEntityType.vendors);
      expect(result!.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.import));

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(1));
    });

    test('multiple operations accumulate in state newest-first', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier =
          container.read(importExportControllerProvider.notifier);
      await notifier.future;

      await notifier.exportCsv(ExportEntityType.customers);
      await notifier.importCsv(ExportEntityType.vendors);
      await notifier.exportCsv(ExportEntityType.products);

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(3));
      // newest first
      expect(state.first.entityType, equals(ExportEntityType.products));
    });

    test('exportCsv result has csvPreview', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier =
          container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.exportCsv(ExportEntityType.salesInvoices);
      expect(result!.data!.csvPreview, isNotNull);
      expect(result.data!.csvPreview, contains('id,reference'));
    });
  });
}
