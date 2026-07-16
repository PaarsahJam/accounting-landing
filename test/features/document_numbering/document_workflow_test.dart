// test/features/document_numbering/document_workflow_test.dart

import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:accounting_app/features/document_numbering/document_workflow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DocumentWorkflow workflow;

  setUp(() {
    workflow = const DocumentWorkflow();
  });

  group('DocumentWorkflow.transition', () {
    test('returns success for valid transition draft → pendingApproval', () {
      final result = workflow.transition(
        DocumentStatus.draft,
        DocumentStatus.pendingApproval,
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, DocumentStatus.pendingApproval);
    });

    test('returns success for valid transition pendingApproval → approved', () {
      final result = workflow.transition(
        DocumentStatus.pendingApproval,
        DocumentStatus.approved,
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, DocumentStatus.approved);
    });

    test('returns success for valid transition approved → posted', () {
      final result = workflow.transition(
        DocumentStatus.approved,
        DocumentStatus.posted,
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, DocumentStatus.posted);
    });

    test('returns success for valid transition posted → locked', () {
      final result = workflow.transition(
        DocumentStatus.posted,
        DocumentStatus.locked,
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, DocumentStatus.locked);
    });

    test('returns success for cancellation from draft', () {
      final result = workflow.transition(
        DocumentStatus.draft,
        DocumentStatus.cancelled,
      );
      expect(result.isSuccess, isTrue);
      expect(result.data, DocumentStatus.cancelled);
    });

    test('returns failure for invalid transition draft → approved', () {
      final result = workflow.transition(
        DocumentStatus.draft,
        DocumentStatus.approved,
      );
      expect(result.isSuccess, isFalse);
      expect(result.error, isNotNull);
      expect(result.error!.message, contains('Draft'));
      expect(result.error!.message, contains('Approved'));
    });

    test('returns failure for invalid transition locked → draft', () {
      final result = workflow.transition(
        DocumentStatus.locked,
        DocumentStatus.draft,
      );
      expect(result.isSuccess, isFalse);
      expect(result.error, isNotNull);
    });

    test('returns failure for cancelled → pendingApproval', () {
      final result = workflow.transition(
        DocumentStatus.cancelled,
        DocumentStatus.pendingApproval,
      );
      expect(result.isSuccess, isFalse);
    });
  });
}
