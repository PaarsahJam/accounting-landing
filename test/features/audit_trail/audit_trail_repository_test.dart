// test/features/audit_trail/audit_trail_repository_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockAuditTrailRepository repository;

  setUp(() {
    repository = MockAuditTrailRepository();
  });

  group('MockAuditTrailRepository', () {
    test('fetchEntries returns seeded entries', () async {
      final result = await repository.fetchEntries();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('entries are sorted newest first', () async {
      final result = await repository.fetchEntries();
      final dates = result.data!.map((e) => e.performedAt).toList();
      for (int i = 0; i < dates.length - 1; i++) {
        expect(
          dates[i].isAfter(dates[i + 1]) ||
              dates[i].isAtSameMomentAs(dates[i + 1]),
          isTrue,
          reason: 'Entry $i should be >= entry ${i + 1}',
        );
      }
    });

    test('seeds entries for all required entity types', () async {
      final result = await repository.fetchEntries();
      final types = result.data!.map((e) => e.entityType).toSet();
      expect(
        types,
        containsAll([
          AuditEntityType.salesInvoice,
          AuditEntityType.vendorBill,
          AuditEntityType.customer,
          AuditEntityType.inventory,
          AuditEntityType.purchaseOrder,
          AuditEntityType.journalEntry,
          AuditEntityType.fiscalPeriod,
        ]),
      );
    });

    test('fetchEntriesForEntity filters by entityType and entityId', () async {
      final result = await repository.fetchEntriesForEntity(
        AuditEntityType.salesInvoice,
        'SI-2026-000001',
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      for (final e in result.data!) {
        expect(e.entityType, AuditEntityType.salesInvoice);
        expect(e.entityId, 'SI-2026-000001');
      }
    });

    test(
      'fetchEntriesForEntity returns empty list for unknown entity',
      () async {
        final result = await repository.fetchEntriesForEntity(
          AuditEntityType.customer,
          'UNKNOWN-999',
        );
        expect(result.isSuccess, isTrue);
        expect(result.data, isEmpty);
      },
    );

    test(
      'fetchEntries with entityType filter returns only matching entries',
      () async {
        final filter = const AuditFilter(entityType: AuditEntityType.inventory);
        final result = await repository.fetchEntries(filter: filter);
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
        for (final e in result.data!) {
          expect(e.entityType, AuditEntityType.inventory);
        }
      },
    );

    test('addEntry inserts entry and it appears in fetchEntries', () async {
      final entry = AuditEntry(
        id: 'AUD-TEST-001',
        entityType: AuditEntityType.vendor,
        entityId: 'V-001',
        entityLabel: 'Test Vendor',
        action: AuditAction.created,
        performedAt: DateTime(2026, 3, 1),
        performedBy: 'tester',
      );
      final addResult = await repository.addEntry(entry);
      expect(addResult.isSuccess, isTrue);
      expect(addResult.data!.id, 'AUD-TEST-001');

      final all = await repository.fetchEntries();
      expect(all.data!.any((e) => e.id == 'AUD-TEST-001'), isTrue);
    });

    test('addEntry places entry at the head (newest first)', () async {
      final entry = AuditEntry(
        id: 'AUD-NEW-001',
        entityType: AuditEntityType.vendor,
        entityId: 'V-001',
        entityLabel: 'Test Vendor',
        action: AuditAction.edited,
        performedAt: DateTime(2099, 12, 31),
        performedBy: 'tester',
      );
      await repository.addEntry(entry);
      final all = await repository.fetchEntries();
      expect(all.data!.first.id, 'AUD-NEW-001');
    });

    test('sales invoice has the full lifecycle (created→paid)', () async {
      final result = await repository.fetchEntriesForEntity(
        AuditEntityType.salesInvoice,
        'SI-2026-000001',
      );
      final actions = result.data!.map((e) => e.action).toSet();
      expect(actions, contains(AuditAction.created));
      expect(actions, contains(AuditAction.approved));
      expect(actions, contains(AuditAction.posted));
      expect(actions, contains(AuditAction.printed));
      expect(actions, contains(AuditAction.paid));
    });

    test('some entries carry before/after values', () async {
      final all = await repository.fetchEntries();
      final withChange = all.data!
          .where((e) => e.previousValue != null || e.newValue != null)
          .toList();
      expect(withChange, isNotEmpty);
    });

    test('some entries carry notes', () async {
      final all = await repository.fetchEntries();
      final withNote = all.data!.where((e) => e.note != null).toList();
      expect(withNote, isNotEmpty);
    });
  });
}
