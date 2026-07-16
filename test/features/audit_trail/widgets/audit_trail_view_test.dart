// test/features/audit_trail/widgets/audit_trail_view_test.dart

import 'package:accounting_app/features/audit_trail/domain/audit_action.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entry.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/audit_trail/presentation/widgets/audit_entry_tile.dart';
import 'package:accounting_app/features/audit_trail/presentation/widgets/audit_trail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AuditEntry makeEntry(String id, AuditEntityType type, String entityId) {
    return AuditEntry(
      id: id,
      entityType: type,
      entityId: entityId,
      entityLabel: 'Entity $id',
      action: AuditAction.created,
      performedAt: DateTime(2026, 1, 1),
      performedBy: 'system',
    );
  }

  Widget buildSubject(List<AuditEntry> entries) {
    return MaterialApp(
      home: Scaffold(body: AuditTrailView(entries: entries)),
    );
  }

  group('AuditTrailView', () {
    testWidgets('shows empty state when no entries', (tester) async {
      await tester.pumpWidget(buildSubject(const []));
      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    });

    testWidgets('shows custom empty message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuditTrailView(
              entries: const [],
              emptyMessage: 'Nothing here.',
            ),
          ),
        ),
      );
      expect(find.text('Nothing here.'), findsOneWidget);
    });

    testWidgets('renders one AuditEntryTile per entry', (tester) async {
      final entries = [
        makeEntry('A', AuditEntityType.salesInvoice, 'SI-001'),
        makeEntry('B', AuditEntityType.vendorBill, 'VB-001'),
        makeEntry('C', AuditEntityType.customer, 'CUST-001'),
      ];
      await tester.pumpWidget(buildSubject(entries));
      expect(find.byType(AuditEntryTile), findsNWidgets(3));
    });
  });

  group('AuditTrailView.forEntity', () {
    testWidgets('filters entries to the given entity', (tester) async {
      final all = [
        makeEntry('A', AuditEntityType.salesInvoice, 'SI-001'),
        makeEntry('B', AuditEntityType.salesInvoice, 'SI-001'),
        makeEntry('C', AuditEntityType.vendorBill, 'VB-001'),
      ];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AuditTrailView.forEntity(
                entries: all,
                entityType: AuditEntityType.salesInvoice,
                entityId: 'SI-001',
              ),
            ),
          ),
        ),
      );
      expect(find.byType(AuditEntryTile), findsNWidgets(2));
    });

    testWidgets('shows empty state when entity has no entries', (tester) async {
      final all = [makeEntry('A', AuditEntityType.salesInvoice, 'SI-001')];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuditTrailView.forEntity(
              entries: all,
              entityType: AuditEntityType.customer,
              entityId: 'CUST-999',
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    });
  });
}
