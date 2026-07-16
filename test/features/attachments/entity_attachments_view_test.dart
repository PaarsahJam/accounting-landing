import 'package:accounting_app/features/attachments/data/attachments_repository.dart';
import 'package:accounting_app/features/attachments/data/attachments_repository_provider.dart';
import 'package:accounting_app/features/attachments/domain/attachments_controller.dart';
import 'package:accounting_app/features/attachments/presentation/entity_attachments_view.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp({
  String entityType = 'purchaseOrder',
  String entityId = 'PO-2026-000001',
}) {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        attachmentsRepositoryProvider.overrideWithValue(
          MockAttachmentsRepository(
            auditRepository: MockAuditTrailRepository(),
          ),
        ),
      ],
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: EntityAttachmentsView(entityType: entityType, entityId: entityId),
      ),
    ),
  );
}

void main() {
  testWidgets('EntityAttachmentsView renders section title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Attachments'), findsWidgets);
  });

  testWidgets('EntityAttachmentsView renders seeded attachment filenames', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('.pdf'), findsWidgets);
  });

  testWidgets('EntityAttachmentsView shows Add button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.attach_file), findsWidgets);
  });

  testWidgets(
    'EntityAttachmentsView shows empty state for entity with no attachments',
    (tester) async {
      await tester.pumpWidget(
        _buildApp(entityType: 'salesInvoice', entityId: 'SI-NO-ATTACHMENTS'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.textContaining('No attachments'), findsWidgets);
    },
  );

  test('AttachmentsController family isolates by params', () async {
    final container = ProviderContainer(
      overrides: [
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        attachmentsRepositoryProvider.overrideWithValue(
          MockAttachmentsRepository(
            auditRepository: MockAuditTrailRepository(),
          ),
        ),
      ],
    );

    const p1 = AttachmentsParams(
      entityType: 'purchaseOrder',
      entityId: 'PO-2026-000001',
    );
    const p2 = AttachmentsParams(
      entityType: 'salesInvoice',
      entityId: 'SI-2026-000001',
    );

    container.listen(attachmentsControllerProvider(p1), (_, _) {});
    container.listen(attachmentsControllerProvider(p2), (_, _) {});

    final r1 = await container.read(attachmentsControllerProvider(p1).future);
    final r2 = await container.read(attachmentsControllerProvider(p2).future);

    expect(r1.every((a) => a.entityId == 'PO-2026-000001'), isTrue);
    expect(r2.every((a) => a.entityId == 'SI-2026-000001'), isTrue);

    container.dispose();
  });
}
