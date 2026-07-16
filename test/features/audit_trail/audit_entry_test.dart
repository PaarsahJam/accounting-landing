// test/features/audit_trail/audit_entry_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = AuditEntry(
    id: 'AUD-001',
    entityType: AuditEntityType.salesInvoice,
    entityId: 'SI-2026-000001',
    entityLabel: 'Sales Invoice SI-2026-000001',
    action: AuditAction.created,
    performedAt: DateTime(2026, 1, 10),
    performedBy: 'alice',
  );

  group('AuditEntry', () {
    test('equality is based on id', () {
      final copy = AuditEntry(
        id: base.id,
        entityType: AuditEntityType.vendorBill,
        entityId: 'OTHER',
        entityLabel: 'Other',
        action: AuditAction.edited,
        performedAt: DateTime(2025),
      );
      expect(base, equals(copy));
    });

    test('different ids are not equal', () {
      final other = AuditEntry(
        id: 'AUD-002',
        entityType: base.entityType,
        entityId: base.entityId,
        entityLabel: base.entityLabel,
        action: base.action,
        performedAt: base.performedAt,
      );
      expect(base, isNot(equals(other)));
    });

    test('hashCode matches for equal entries', () {
      final copy = AuditEntry(
        id: base.id,
        entityType: AuditEntityType.vendorBill,
        entityId: 'OTHER',
        entityLabel: 'Other',
        action: AuditAction.edited,
        performedAt: DateTime(2025),
      );
      expect(base.hashCode, equals(copy.hashCode));
    });

    test('defaults performedBy to system', () {
      final entry = AuditEntry(
        id: 'AUD-999',
        entityType: AuditEntityType.inventory,
        entityId: 'PROD-001',
        entityLabel: 'Product',
        action: AuditAction.stockAdjusted,
        performedAt: DateTime(2026, 1, 1),
      );
      expect(entry.performedBy, 'system');
    });

    test('optional fields are null by default', () {
      expect(base.note, isNull);
      expect(base.previousValue, isNull);
      expect(base.newValue, isNull);
    });

    test('toString includes id, entityType, and action', () {
      expect(base.toString(), contains('AUD-001'));
      expect(base.toString(), contains('Created'));
    });
  });
}
