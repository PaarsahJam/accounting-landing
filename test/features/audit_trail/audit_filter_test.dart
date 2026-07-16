// test/features/audit_trail/audit_filter_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final entry = AuditEntry(
    id: 'AUD-001',
    entityType: AuditEntityType.salesInvoice,
    entityId: 'SI-2026-000001',
    entityLabel: 'Sales Invoice SI-2026-000001',
    action: AuditAction.approved,
    performedAt: DateTime(2026, 1, 15),
    performedBy: 'bob',
  );

  group('AuditFilter', () {
    test('empty filter matches everything', () {
      const filter = AuditFilter();
      expect(filter.matches(entry), isTrue);
      expect(filter.isEmpty, isTrue);
    });

    test('entityType filter matches matching entry', () {
      const filter = AuditFilter(entityType: AuditEntityType.salesInvoice);
      expect(filter.matches(entry), isTrue);
    });

    test('entityType filter rejects non-matching entry', () {
      const filter = AuditFilter(entityType: AuditEntityType.vendorBill);
      expect(filter.matches(entry), isFalse);
    });

    test('entityId filter matches matching entry', () {
      const filter = AuditFilter(entityId: 'SI-2026-000001');
      expect(filter.matches(entry), isTrue);
    });

    test('entityId filter rejects non-matching entry', () {
      const filter = AuditFilter(entityId: 'OTHER-999');
      expect(filter.matches(entry), isFalse);
    });

    test('action filter matches matching entry', () {
      const filter = AuditFilter(action: AuditAction.approved);
      expect(filter.matches(entry), isTrue);
    });

    test('action filter rejects non-matching entry', () {
      const filter = AuditFilter(action: AuditAction.created);
      expect(filter.matches(entry), isFalse);
    });

    test('performedBy filter matches correct performer', () {
      const filter = AuditFilter(performedBy: 'bob');
      expect(filter.matches(entry), isTrue);
    });

    test('from filter accepts entry on boundary', () {
      final filter = AuditFilter(from: DateTime(2026, 1, 15));
      expect(filter.matches(entry), isTrue);
    });

    test('from filter rejects entry before range', () {
      final filter = AuditFilter(from: DateTime(2026, 1, 16));
      expect(filter.matches(entry), isFalse);
    });

    test('to filter accepts entry on boundary', () {
      final filter = AuditFilter(to: DateTime(2026, 1, 15));
      expect(filter.matches(entry), isTrue);
    });

    test('to filter rejects entry after range', () {
      final filter = AuditFilter(to: DateTime(2026, 1, 14));
      expect(filter.matches(entry), isFalse);
    });

    test('combined filter matches when all criteria pass', () {
      final filter = AuditFilter(
        entityType: AuditEntityType.salesInvoice,
        action: AuditAction.approved,
        performedBy: 'bob',
        from: DateTime(2026, 1, 1),
        to: DateTime(2026, 1, 31),
      );
      expect(filter.matches(entry), isTrue);
    });

    test('copyWith clearEntityType clears field', () {
      final filter = const AuditFilter(
        entityType: AuditEntityType.vendorBill,
      ).copyWith(clearEntityType: true);
      expect(filter.entityType, isNull);
    });

    test('isEmpty returns false when any criterion is set', () {
      const filter = AuditFilter(entityType: AuditEntityType.salesInvoice);
      expect(filter.isEmpty, isFalse);
    });
  });
}
