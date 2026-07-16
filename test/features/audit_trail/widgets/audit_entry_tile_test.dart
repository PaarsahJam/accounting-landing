// test/features/audit_trail/widgets/audit_entry_tile_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/presentation/widgets/audit_entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject(AuditEntry entry) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: AuditEntryTile(entry: entry),
        ),
      ),
    );
  }

  group('AuditEntryTile', () {
    final base = AuditEntry(
      id: 'AUD-001',
      entityType: AuditEntityType.salesInvoice,
      entityId: 'SI-2026-000001',
      entityLabel: 'Sales Invoice SI-2026-000001',
      action: AuditAction.created,
      performedAt: DateTime(2026, 1, 10, 9, 0),
      performedBy: 'alice',
    );

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildSubject(base));
      expect(find.byType(AuditEntryTile), findsOneWidget);
    });

    testWidgets('displays action label', (tester) async {
      await tester.pumpWidget(buildSubject(base));
      expect(find.text('Created'), findsOneWidget);
    });

    testWidgets('displays performer', (tester) async {
      await tester.pumpWidget(buildSubject(base));
      expect(find.text('by alice'), findsOneWidget);
    });

    testWidgets('does not show change row when no before/after', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject(base));
      expect(find.byIcon(Icons.arrow_forward), findsNothing);
    });

    testWidgets('shows before and after values when present', (tester) async {
      final entry = AuditEntry(
        id: 'AUD-002',
        entityType: AuditEntityType.customer,
        entityId: 'CUST-001',
        entityLabel: 'Acme Corp',
        action: AuditAction.addressChanged,
        performedAt: DateTime(2026, 1, 11),
        performedBy: 'alice',
        previousValue: 'Old St',
        newValue: 'New Ave',
      );
      await tester.pumpWidget(buildSubject(entry));
      expect(find.text('Old St'), findsOneWidget);
      expect(find.text('New Ave'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('shows note when present', (tester) async {
      final entry = AuditEntry(
        id: 'AUD-003',
        entityType: AuditEntityType.salesInvoice,
        entityId: 'SI-2026-000001',
        entityLabel: 'Sales Invoice',
        action: AuditAction.edited,
        performedAt: DateTime(2026, 1, 12),
        performedBy: 'bob',
        note: 'Corrected quantity',
      );
      await tester.pumpWidget(buildSubject(entry));
      expect(find.text('Corrected quantity'), findsOneWidget);
    });

    testWidgets('renders for all action types without throwing', (
      tester,
    ) async {
      for (final action in AuditAction.values) {
        final entry = AuditEntry(
          id: 'AUD-$action',
          entityType: AuditEntityType.salesInvoice,
          entityId: 'SI-001',
          entityLabel: 'Invoice',
          action: action,
          performedAt: DateTime(2026, 1, 1),
          performedBy: 'system',
        );
        await tester.pumpWidget(buildSubject(entry));
        expect(find.byType(AuditEntryTile), findsOneWidget);
      }
    });
  });
}
