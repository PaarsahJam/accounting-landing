// test/features/document_numbering/widgets/approval_timeline_test.dart

import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:accounting_app/features/document_numbering/widgets/approval_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApprovalTimeline', () {
    Widget buildSubject(DocumentStatus status) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 600,
            child: ApprovalTimeline(currentStatus: status),
          ),
        ),
      );
    }

    for (final status in DocumentStatus.values) {
      testWidgets('renders without error for $status', (tester) async {
        await tester.pumpWidget(buildSubject(status));
        expect(find.byType(ApprovalTimeline), findsOneWidget);
      });
    }

    testWidgets('shows cancelled indicator for cancelled status', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.cancelled));
      expect(find.text('Cancelled'), findsOneWidget);
    });

    testWidgets('shows timeline steps for draft status', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.draft));
      // All 5 timeline steps should be rendered as Tooltip-wrapped nodes
      expect(find.byType(Tooltip), findsWidgets);
    });
  });
}
