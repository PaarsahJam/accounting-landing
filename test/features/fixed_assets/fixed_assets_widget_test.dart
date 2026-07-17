// test/features/fixed_assets/fixed_assets_widget_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/fixed_assets/data/fixed_assets_repository.dart';
import 'package:accounting_app/features/fixed_assets/data/fixed_assets_repository_provider.dart';
import 'package:accounting_app/features/fixed_assets/presentation/fixed_assets_page.dart';
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
        fixedAssetsRepositoryProvider.overrideWithValue(
          MockFixedAssetsRepository(
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
      home: const FixedAssetsPage(),
    ),
  );
}

void main() {
  testWidgets('FixedAssetsPage shows page title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Fixed Assets'), findsWidgets);
  });

  testWidgets('FixedAssetsPage shows seeded asset names', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Office Computer'), findsWidgets);
    expect(find.textContaining('Company Vehicle'), findsWidgets);
  });

  testWidgets('FixedAssetsPage shows ACTIVE badge', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('ACTIVE'), findsWidgets);
  });

  testWidgets('FixedAssetsPage shows DISPOSED badge for FA-004', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('DISPOSED'), findsWidgets);
  });

  testWidgets('FixedAssetsPage shows method badges (SL and DB)', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('SL'), findsWidgets);
    expect(find.text('DB'), findsWidgets);
  });

  testWidgets('FixedAssetsPage shows add button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsWidgets);
  });
}
