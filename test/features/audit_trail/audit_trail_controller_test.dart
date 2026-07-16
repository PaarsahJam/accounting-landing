// test/features/audit_trail/audit_trail_controller_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_filter.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_trail_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuditTrailController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          auditTrailRepositoryProvider.overrideWithValue(
            MockAuditTrailRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads entries successfully', () async {
      final controller = container.read(auditTrailControllerProvider.notifier);
      final entries = await controller.future;
      expect(entries, isNotEmpty);
    });

    test('applyFilter returns only matching entries', () async {
      final controller = container.read(auditTrailControllerProvider.notifier);
      final all = await controller.future;
      final result = controller.applyFilter(
        all,
        const AuditFilter(entityType: AuditEntityType.inventory),
      );
      expect(result, isNotEmpty);
      for (final e in result) {
        expect(e.entityType, AuditEntityType.inventory);
      }
    });

    test('applyFilter with empty filter returns all entries', () async {
      final controller = container.read(auditTrailControllerProvider.notifier);
      final all = await controller.future;
      final filtered = controller.applyFilter(all, const AuditFilter());
      expect(filtered.length, all.length);
    });

    test('addEntry delegates to repository without error', () async {
      final controller = container.read(auditTrailControllerProvider.notifier);
      await controller.future;

      final newEntry = AuditEntry(
        id: 'AUD-CTRL-001',
        entityType: AuditEntityType.vendor,
        entityId: 'V-001',
        entityLabel: 'Test Vendor',
        action: AuditAction.created,
        performedAt: DateTime(2026, 6, 1),
        performedBy: 'tester',
      );
      await expectLater(controller.addEntry(newEntry), completes);
    });
  });

  group('EntityAuditTrailController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          auditTrailRepositoryProvider.overrideWithValue(
            MockAuditTrailRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads entries for a specific entity', () async {
      final entries = await container
          .read(
            entityAuditTrailControllerProvider(
              AuditEntityType.salesInvoice,
              'SI-2026-000001',
            ).notifier,
          )
          .future;
      expect(entries, isNotEmpty);
      for (final e in entries) {
        expect(e.entityType, AuditEntityType.salesInvoice);
        expect(e.entityId, 'SI-2026-000001');
      }
    });

    test('returns empty list for unknown entity', () async {
      final entries = await container
          .read(
            entityAuditTrailControllerProvider(
              AuditEntityType.customer,
              'UNKNOWN-999',
            ).notifier,
          )
          .future;
      expect(entries, isEmpty);
    });
  });
}
