// test/features/document_numbering/widgets/number_chip_test.dart

import 'package:accounting_app/features/document_numbering/widgets/number_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NumberChip', () {
    testWidgets('renders for a given document number', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: NumberChip(number: 'PO-2026-000001')),
        ),
      );
      expect(find.byType(NumberChip), findsOneWidget);
      expect(find.text('PO-2026-000001'), findsOneWidget);
    });

    testWidgets('renders for any prefix format', (tester) async {
      for (final number in [
        'GR-2026-000001',
        'VB-2026-000001',
        'SI-2026-000001',
        'JV-2026-000001',
      ]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: NumberChip(number: number)),
          ),
        );
        expect(find.text(number), findsOneWidget);
      }
    });
  });
}
