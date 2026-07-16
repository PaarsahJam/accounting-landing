import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/tags/data/tags_repository.dart';
import 'package:accounting_app/features/tags/data/tags_repository_provider.dart';
import 'package:accounting_app/features/tags/domain/tags_controller.dart';
import 'package:accounting_app/features/tags/presentation/entity_tags_view.dart';
import 'package:accounting_app/features/tags/presentation/tags_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    tagsRepositoryProvider.overrideWithValue(
      MockTagsRepository(auditRepository: MockAuditTrailRepository()),
    ),
  ],
);

Widget _buildTagsPage() {
  return UncontrolledProviderScope(
    container: _makeContainer(),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const TagsPage(),
    ),
  );
}

Widget _buildEntityTagsView({
  String entityType = 'purchaseOrder',
  String entityId = 'PO-2026-000001',
}) {
  return UncontrolledProviderScope(
    container: _makeContainer(),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: EntityTagsView(entityType: entityType, entityId: entityId),
      ),
    ),
  );
}

void main() {
  group('TagsPage', () {
    testWidgets('renders page title', (tester) async {
      await tester.pumpWidget(_buildTagsPage());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.textContaining('Tags'), findsWidgets);
    });

    testWidgets('renders seeded tag names', (tester) async {
      await tester.pumpWidget(_buildTagsPage());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Urgent'), findsWidgets);
      expect(find.text('Reviewed'), findsWidgets);
    });

    testWidgets('shows new label icon button', (tester) async {
      await tester.pumpWidget(_buildTagsPage());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.new_label_outlined), findsOneWidget);
    });

    testWidgets('opens create dialog when add button tapped', (tester) async {
      await tester.pumpWidget(_buildTagsPage());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.new_label_outlined));
      await tester.pumpAndSettle();

      expect(find.textContaining('New Tag'), findsWidgets);
    });
  });

  group('EntityTagsView', () {
    testWidgets('renders section title', (tester) async {
      await tester.pumpWidget(_buildEntityTagsView());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.textContaining('Tags'), findsWidgets);
    });

    testWidgets('renders seeded assigned tags as chips', (tester) async {
      await tester.pumpWidget(_buildEntityTagsView());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      // PO-2026-000001 has Urgent + Reviewed seeded
      expect(find.text('Urgent'), findsWidgets);
      expect(find.text('Reviewed'), findsWidgets);
    });

    testWidgets('shows Add Tag button', (tester) async {
      await tester.pumpWidget(_buildEntityTagsView());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.label_outline), findsWidgets);
    });

    testWidgets('shows empty state for entity with no tags', (tester) async {
      await tester.pumpWidget(
        _buildEntityTagsView(
          entityType: 'salesInvoice',
          entityId: 'SI-NO-TAGS',
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.textContaining('No tags'), findsWidgets);
    });

    testWidgets('chip has delete icon for removal', (tester) async {
      await tester.pumpWidget(_buildEntityTagsView());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      // Chip delete icon (close icon)
      expect(find.byIcon(Icons.close), findsWidgets);
    });
  });

  test('EntityTagsController family isolates by params', () async {
    final container = _makeContainer();
    const p1 = EntityTagsParams(
      entityType: 'purchaseOrder',
      entityId: 'PO-2026-000001',
    );
    const p2 = EntityTagsParams(
      entityType: 'salesInvoice',
      entityId: 'SI-UNKNOWN',
    );

    container.listen(entityTagsControllerProvider(p1), (_, _) {});
    container.listen(entityTagsControllerProvider(p2), (_, _) {});

    final r1 = await container.read(entityTagsControllerProvider(p1).future);
    final r2 = await container.read(entityTagsControllerProvider(p2).future);

    expect(r1.length, equals(2));
    expect(r2, isEmpty);

    container.dispose();
  });
}
