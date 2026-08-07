// test/features/import_export/import_export_widget_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository_provider.dart';
import 'package:accounting_app/features/import_export/presentation/import_export_page.dart';
import 'package:accounting_app/features/user_roles/domain/user_roles_controller.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() {
  return ProviderContainer(
    overrides: [
      auditTrailRepositoryProvider.overrideWithValue(
        MockAuditTrailRepository(),
      ),
      importExportRepositoryProvider.overrideWithValue(
        MockImportExportRepository(
          auditRepository: MockAuditTrailRepository(),
        ),
      ),
    ],
  );
}

Widget _buildApp(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Consumer(
        builder: (context, ref, child) {
          // Load the signed-in user and built-in roles up front so the
          // controller-level permission checks in ImportExportController
          // succeed, mirroring the app's startup behaviour.
          ref.watch(currentUserControllerProvider);
          ref.watch(rolesControllerProvider);
          return const ImportExportPage();
        },
      ),
    ),
  );
}

void main() {
  testWidgets('ImportExportPage shows page title', (tester) async {
    final container = _makeContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(_buildApp(container));
    await tester.pumpAndSettle();

    expect(find.textContaining('Import'), findsWidgets);
  });

  testWidgets('ImportExportPage shows Export and Import buttons', (
    tester,
  ) async {
    final container = _makeContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(_buildApp(container));
    await tester.pumpAndSettle();

    expect(find.text('Export CSV'), findsWidgets);
    expect(find.text('Import CSV'), findsWidgets);
  });

  testWidgets('ImportExportPage shows entity dropdown', (tester) async {
    final container = _makeContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(_buildApp(container));
    await tester.pumpAndSettle();

    expect(find.text('Customers'), findsWidgets);
  });

  testWidgets('ImportExportPage shows empty state initially', (tester) async {
    final container = _makeContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(_buildApp(container));
    await tester.pumpAndSettle();

    expect(find.textContaining('No jobs'), findsWidgets);
  });

  testWidgets('Tapping Export CSV adds a job entry', (tester) async {
    final container = _makeContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(_buildApp(container));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Export CSV'));
    await tester.pumpAndSettle();

    expect(find.text('EXPORT'), findsWidgets);
    expect(find.text('OK'), findsWidgets);
  });
}
