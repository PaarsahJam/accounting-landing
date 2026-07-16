// test/features/document_numbering/approval_workflow_controller_test.dart

import 'package:accounting_app/features/document_numbering/data/approval_workflow_repository.dart';
import 'package:accounting_app/features/document_numbering/data/approval_workflow_repository_provider.dart';
import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:accounting_app/features/document_numbering/domain/approval_workflow_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApprovalWorkflowController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          approvalWorkflowRepositoryProvider.overrideWithValue(
            MockApprovalWorkflowRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads documents successfully', () async {
      final controller = container.read(
        approvalWorkflowControllerProvider.notifier,
      );
      final docs = await controller.future;
      expect(docs, isNotEmpty);
    });

    test('transitionDocument returns updated record with new status', () async {
      final controller = container.read(
        approvalWorkflowControllerProvider.notifier,
      );
      final docs = await controller.future;
      final draft = docs.firstWhere((d) => d.status == DocumentStatus.draft);

      final updated = await controller.transitionDocument(
        draft.id,
        DocumentStatus.pendingApproval,
      );
      expect(updated.status, DocumentStatus.pendingApproval);
    });

    test('transitionDocument throws on invalid transition', () async {
      final controller = container.read(
        approvalWorkflowControllerProvider.notifier,
      );
      final docs = await controller.future;
      final draft = docs.firstWhere((d) => d.status == DocumentStatus.draft);

      await expectLater(
        controller.transitionDocument(draft.id, DocumentStatus.locked),
        throwsA(isA<Object>()),
      );
    });
  });
}
