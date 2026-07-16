import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/comments/data/comments_repository.dart';
import 'package:accounting_app/features/comments/data/comments_repository_provider.dart';
import 'package:accounting_app/features/comments/domain/comments_controller.dart';
import 'package:accounting_app/features/comments/presentation/entity_comments_view.dart';
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
        commentsRepositoryProvider.overrideWithValue(
          MockCommentsRepository(auditRepository: MockAuditTrailRepository()),
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
        body: EntityCommentsView(entityType: entityType, entityId: entityId),
      ),
    ),
  );
}

void main() {
  testWidgets('EntityCommentsView renders section title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Comments'), findsWidgets);
  });

  testWidgets('EntityCommentsView renders seeded comment messages', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Seeded purchase order comments contain "delivery"
    expect(find.textContaining('delivery'), findsWidgets);
  });

  testWidgets('EntityCommentsView shows Add Comment button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add_comment_outlined), findsWidgets);
  });

  testWidgets(
    'EntityCommentsView shows empty state for entity with no comments',
    (tester) async {
      await tester.pumpWidget(
        _buildApp(entityType: 'salesInvoice', entityId: 'SI-NO-COMMENTS'),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(find.textContaining('No comments'), findsWidgets);
    },
  );

  testWidgets('EntityCommentsView shows edited label for edited comments', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Seeded comment CMT-2026-0003 has editedAt set
    expect(find.text('edited'), findsWidgets);
  });

  test('CommentsController family isolates by params', () async {
    final container = ProviderContainer(
      overrides: [
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        commentsRepositoryProvider.overrideWithValue(
          MockCommentsRepository(auditRepository: MockAuditTrailRepository()),
        ),
      ],
    );

    const p1 = CommentsParams(
      entityType: 'purchaseOrder',
      entityId: 'PO-2026-000001',
    );
    const p2 = CommentsParams(
      entityType: 'salesInvoice',
      entityId: 'SI-2026-000001',
    );

    container.listen(commentsControllerProvider(p1), (_, _) {});
    container.listen(commentsControllerProvider(p2), (_, _) {});

    final r1 = await container.read(commentsControllerProvider(p1).future);
    final r2 = await container.read(commentsControllerProvider(p2).future);

    expect(r1.every((c) => c.entityId == 'PO-2026-000001'), isTrue);
    expect(r2.every((c) => c.entityId == 'SI-2026-000001'), isTrue);

    container.dispose();
  });
}
