// test/features/document_numbering/approval_workflow_repository_test.dart

import 'package:accounting_app/features/document_numbering/data/approval_workflow_repository.dart';
import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockApprovalWorkflowRepository repository;

  setUp(() {
    repository = MockApprovalWorkflowRepository();
  });

  group('MockApprovalWorkflowRepository', () {
    test('fetchDocuments returns a non-empty list', () async {
      final result = await repository.fetchDocuments();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('fetchDocument returns a specific record by id', () async {
      final allResult = await repository.fetchDocuments();
      final id = allResult.data!.first.id;

      final result = await repository.fetchDocument(id);
      expect(result.isSuccess, isTrue);
      expect(result.data!.id, id);
    });

    test('fetchDocument returns failure for unknown id', () async {
      final result = await repository.fetchDocument('UNKNOWN-999');
      expect(result.isSuccess, isFalse);
      expect(result.error, isNotNull);
    });

    test('seeds all expected document types', () async {
      final result = await repository.fetchDocuments();
      final types = result.data!.map((d) => d.documentType).toSet();
      expect(
        types,
        containsAll([
          'Purchase Order',
          'Goods Receipt',
          'Vendor Bill',
          'Vendor Payment',
          'Sales Invoice',
          'Customer Payment',
          'Journal Voucher',
        ]),
      );
    });

    test('document numbers use the correct prefix format', () async {
      final result = await repository.fetchDocuments();
      for (final doc in result.data!) {
        expect(doc.documentNumber, matches(RegExp(r'^[A-Z]+-\d{4}-\d+$')));
      }
    });

    group('transition', () {
      test(
        'successfully transitions a draft document to pendingApproval',
        () async {
          final allResult = await repository.fetchDocuments();
          final draft = allResult.data!.firstWhere(
            (d) => d.status == DocumentStatus.draft,
          );

          final result = await repository.transition(
            draft.id,
            DocumentStatus.pendingApproval,
          );
          expect(result.isSuccess, isTrue);
          expect(result.data!.status, DocumentStatus.pendingApproval);
        },
      );

      test('returns failure for invalid transition', () async {
        final allResult = await repository.fetchDocuments();
        final draft = allResult.data!.firstWhere(
          (d) => d.status == DocumentStatus.draft,
        );

        final result = await repository.transition(
          draft.id,
          DocumentStatus.posted, // skipping steps
        );
        expect(result.isSuccess, isFalse);
        expect(result.error, isNotNull);
      });

      test(
        'sets approvedAt timestamp when transitioning to approved',
        () async {
          final allResult = await repository.fetchDocuments();
          final pending = allResult.data!.firstWhere(
            (d) => d.status == DocumentStatus.pendingApproval,
          );

          final result = await repository.transition(
            pending.id,
            DocumentStatus.approved,
          );
          expect(result.isSuccess, isTrue);
          expect(result.data!.approvedAt, isNotNull);
        },
      );

      test('returns failure for unknown document id', () async {
        final result = await repository.transition(
          'UNKNOWN-999',
          DocumentStatus.pendingApproval,
        );
        expect(result.isSuccess, isFalse);
      });
    });
  });
}
