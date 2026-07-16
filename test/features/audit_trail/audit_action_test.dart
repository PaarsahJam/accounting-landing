// test/features/audit_trail/audit_action_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuditAction.label', () {
    test('created', () => expect(AuditAction.created.label, 'Created'));
    test('edited', () => expect(AuditAction.edited.label, 'Edited'));
    test('deleted', () => expect(AuditAction.deleted.label, 'Deleted'));
    test('submittedForApproval', () {
      expect(AuditAction.submittedForApproval.label, 'Submitted for Approval');
    });
    test('approved', () => expect(AuditAction.approved.label, 'Approved'));
    test('rejected', () => expect(AuditAction.rejected.label, 'Rejected'));
    test('posted', () => expect(AuditAction.posted.label, 'Posted'));
    test('locked', () => expect(AuditAction.locked.label, 'Locked'));
    test('cancelled', () => expect(AuditAction.cancelled.label, 'Cancelled'));
    test('paid', () => expect(AuditAction.paid.label, 'Paid'));
    test('printed', () => expect(AuditAction.printed.label, 'Printed'));
    test('stockAdjusted', () {
      expect(AuditAction.stockAdjusted.label, 'Stock Adjusted');
    });
    test('journalGenerated', () {
      expect(AuditAction.journalGenerated.label, 'Journal Generated');
    });
    test('addressChanged', () {
      expect(AuditAction.addressChanged.label, 'Address Changed');
    });
    test('periodOpened', () {
      expect(AuditAction.periodOpened.label, 'Period Opened');
    });
    test('periodClosed', () {
      expect(AuditAction.periodClosed.label, 'Period Closed');
    });

    test('all values have non-empty labels', () {
      for (final action in AuditAction.values) {
        expect(
          action.label,
          isNotEmpty,
          reason: '${action.name} should have a label',
        );
      }
    });
  });
}
