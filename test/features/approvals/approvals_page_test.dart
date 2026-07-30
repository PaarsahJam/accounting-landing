import 'package:accounting_app/features/approvals/presentation/approvals_page.dart';
import 'package:accounting_app/features/document_numbering/data/approval_workflow_repository.dart';
import 'package:accounting_app/features/document_numbering/data/approval_workflow_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      approvalWorkflowRepositoryProvider.overrideWithValue(
        MockApprovalWorkflowRepository(),
      ),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: ApprovalsPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('ApprovalsPage renders title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Approvals'), findsOneWidget);
  });
}
