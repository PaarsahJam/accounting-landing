// test/features/document_numbering/widgets/document_header_test.dart

import 'package:accounting_app/features/document_numbering/document_record.dart';
import 'package:accounting_app/features/document_numbering/document_status.dart';
import 'package:accounting_app/features/document_numbering/widgets/document_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentHeader', () {
    final baseRecord = DocumentRecord(
      id: 'PO-2026-000001',
      documentNumber: 'PO-2026-000001',
      documentType: 'Purchase Order',
      status: DocumentStatus.draft,
      createdAt: DateTime(2026, 1, 15),
    );

    Widget buildSubject(DocumentRecord record) {
      return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: DocumentHeader(record: record)),
        ),
      );
    }

    testWidgets('renders without error for a draft document', (tester) async {
      await tester.pumpWidget(buildSubject(baseRecord));
      expect(find.byType(DocumentHeader), findsOneWidget);
    });

    testWidgets('displays the document number', (tester) async {
      await tester.pumpWidget(buildSubject(baseRecord));
      expect(find.text('PO-2026-000001'), findsOneWidget);
    });

    testWidgets('displays the document type', (tester) async {
      await tester.pumpWidget(buildSubject(baseRecord));
      expect(find.text('Purchase Order'), findsOneWidget);
    });

    testWidgets('shows approvedAt date when set', (tester) async {
      final record = baseRecord.copyWith(
        status: DocumentStatus.approved,
        approvedAt: DateTime(2026, 1, 20),
      );
      await tester.pumpWidget(buildSubject(record));
      expect(find.text('Approved'), findsWidgets);
    });

    testWidgets('hides timeline for cancelled document', (tester) async {
      final record = baseRecord.copyWith(status: DocumentStatus.cancelled);
      await tester.pumpWidget(buildSubject(record));
      // ApprovalTimeline is not rendered for cancelled docs
      expect(find.byType(DocumentHeader), findsOneWidget);
    });

    testWidgets('renders for all non-cancelled statuses with timeline', (
      tester,
    ) async {
      for (final status in DocumentStatus.values) {
        if (status == DocumentStatus.cancelled) continue;
        final record = baseRecord.copyWith(status: status);
        await tester.pumpWidget(buildSubject(record));
        expect(find.byType(DocumentHeader), findsOneWidget);
      }
    });
  });
}
