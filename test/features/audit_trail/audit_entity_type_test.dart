// test/features/audit_trail/audit_entity_type_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuditEntityType.label', () {
    test('salesInvoice', () {
      expect(AuditEntityType.salesInvoice.label, 'Sales Invoice');
    });
    test('vendorBill', () {
      expect(AuditEntityType.vendorBill.label, 'Vendor Bill');
    });
    test('customer', () {
      expect(AuditEntityType.customer.label, 'Customer');
    });
    test('inventory', () {
      expect(AuditEntityType.inventory.label, 'Inventory');
    });
    test('journalEntry', () {
      expect(AuditEntityType.journalEntry.label, 'Journal Entry');
    });
    test('fiscalPeriod', () {
      expect(AuditEntityType.fiscalPeriod.label, 'Fiscal Period');
    });

    test('all values have non-empty labels', () {
      for (final type in AuditEntityType.values) {
        expect(
          type.label,
          isNotEmpty,
          reason: '${type.name} should have a label',
        );
      }
    });
  });
}
