// test/features/document_numbering/widgets/status_badge_test.dart

import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:accounting_app/features/document_numbering/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusBadge', () {
    Widget buildSubject(DocumentStatus status) {
      return MaterialApp(
        home: Scaffold(body: StatusBadge(status: status)),
      );
    }

    for (final status in DocumentStatus.values) {
      testWidgets('renders for $status', (tester) async {
        await tester.pumpWidget(buildSubject(status));
        expect(find.byType(StatusBadge), findsOneWidget);
      });
    }

    testWidgets('displays label text for draft', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.draft));
      expect(find.text('Draft'), findsOneWidget);
    });

    testWidgets('displays label text for pendingApproval', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.pendingApproval));
      expect(find.text('Pending Approval'), findsOneWidget);
    });

    testWidgets('displays label text for approved', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.approved));
      expect(find.text('Approved'), findsOneWidget);
    });

    testWidgets('displays label text for posted', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.posted));
      expect(find.text('Posted'), findsOneWidget);
    });

    testWidgets('displays label text for locked', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.locked));
      expect(find.text('Locked'), findsOneWidget);
    });

    testWidgets('displays label text for cancelled', (tester) async {
      await tester.pumpWidget(buildSubject(DocumentStatus.cancelled));
      expect(find.text('Cancelled'), findsOneWidget);
    });
  });
}
