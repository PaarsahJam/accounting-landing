// lib/features/document_numbering/data/approval_workflow_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'approval_workflow_repository.dart';

part 'approval_workflow_repository_provider.g.dart';

@riverpod
ApprovalWorkflowRepository approvalWorkflowRepository(Ref ref) {
  return MockApprovalWorkflowRepository();
}
