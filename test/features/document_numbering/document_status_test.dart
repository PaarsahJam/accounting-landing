// test/features/document_numbering/document_status_test.dart

import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentStatus.label', () {
    test('draft label', () => expect(DocumentStatus.draft.label, 'Draft'));
    test(
      'pendingApproval label',
      () => expect(DocumentStatus.pendingApproval.label, 'Pending Approval'),
    );
    test(
      'approved label',
      () => expect(DocumentStatus.approved.label, 'Approved'),
    );
    test('posted label', () => expect(DocumentStatus.posted.label, 'Posted'));
    test('locked label', () => expect(DocumentStatus.locked.label, 'Locked'));
    test(
      'cancelled label',
      () => expect(DocumentStatus.cancelled.label, 'Cancelled'),
    );
  });

  group('StatusTransition.canTransitionTo', () {
    // Valid transitions
    test('draft → pendingApproval is allowed', () {
      expect(
        DocumentStatus.draft.canTransitionTo(DocumentStatus.pendingApproval),
        isTrue,
      );
    });
    test('draft → cancelled is allowed', () {
      expect(
        DocumentStatus.draft.canTransitionTo(DocumentStatus.cancelled),
        isTrue,
      );
    });
    test('pendingApproval → approved is allowed', () {
      expect(
        DocumentStatus.pendingApproval.canTransitionTo(DocumentStatus.approved),
        isTrue,
      );
    });
    test('pendingApproval → cancelled is allowed', () {
      expect(
        DocumentStatus.pendingApproval.canTransitionTo(
          DocumentStatus.cancelled,
        ),
        isTrue,
      );
    });
    test('approved → posted is allowed', () {
      expect(
        DocumentStatus.approved.canTransitionTo(DocumentStatus.posted),
        isTrue,
      );
    });
    test('approved → cancelled is allowed', () {
      expect(
        DocumentStatus.approved.canTransitionTo(DocumentStatus.cancelled),
        isTrue,
      );
    });
    test('posted → locked is allowed', () {
      expect(
        DocumentStatus.posted.canTransitionTo(DocumentStatus.locked),
        isTrue,
      );
    });

    // Invalid transitions
    test('draft → approved is rejected', () {
      expect(
        DocumentStatus.draft.canTransitionTo(DocumentStatus.approved),
        isFalse,
      );
    });
    test('draft → posted is rejected', () {
      expect(
        DocumentStatus.draft.canTransitionTo(DocumentStatus.posted),
        isFalse,
      );
    });
    test('draft → locked is rejected', () {
      expect(
        DocumentStatus.draft.canTransitionTo(DocumentStatus.locked),
        isFalse,
      );
    });
    test('posted → cancelled is rejected', () {
      expect(
        DocumentStatus.posted.canTransitionTo(DocumentStatus.cancelled),
        isFalse,
      );
    });
    test('locked → any transition is rejected', () {
      for (final s in DocumentStatus.values) {
        expect(
          DocumentStatus.locked.canTransitionTo(s),
          isFalse,
          reason: 'locked → $s should be rejected',
        );
      }
    });
    test('cancelled → any transition is rejected', () {
      for (final s in DocumentStatus.values) {
        expect(
          DocumentStatus.cancelled.canTransitionTo(s),
          isFalse,
          reason: 'cancelled → $s should be rejected',
        );
      }
    });
  });

  group('StatusTransition.timeline', () {
    test('contains the expected ordered steps', () {
      expect(StatusTransition.timeline, [
        DocumentStatus.draft,
        DocumentStatus.pendingApproval,
        DocumentStatus.approved,
        DocumentStatus.posted,
        DocumentStatus.locked,
      ]);
    });
    test('does not include cancelled', () {
      expect(
        StatusTransition.timeline.contains(DocumentStatus.cancelled),
        isFalse,
      );
    });
  });
}
