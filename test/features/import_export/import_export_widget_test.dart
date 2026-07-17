// test/features/import_export/import_export_widget_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository_provider.dart';
import 'package:accounting_app/features/import_export/presentation/import_export_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return UncontrolledProviderScope(
    container: ProviderContainer(
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
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const ImportExportPage(),
    ),
  );
}

void main() {
  testWidgets('ImportExportPage shows page title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Import'), findsWidgets);
  });

  testWidgets('ImportExportPage shows Export and Import buttons', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Export CSV'), findsWidgets);
    expect(find.text('Import CSV'), findsWidgets);
  });

  testWidgets('ImportExportPage shows entity dropdown', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Customers'), findsWidgets);
  });

  testWidgets('ImportExportPage shows empty state initially', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('No jobs'), findsWidgets);
  });

  testWidgets('Tapping Export CSV adds a job entry', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Export CSV'));
    await tester.pumpAndSettle();

    expect(find.text('EXPORT'), findsWidgets);
    expect(find.text('OK'), findsWidgets);
  });
}
