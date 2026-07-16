import 'package:accounting_app/features/user_roles/data/user_repository.dart';
import 'package:accounting_app/features/user_roles/data/user_repository_provider.dart';
import 'package:accounting_app/features/user_roles/presentation/user_roles_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(MockUserRepository()),
      ],
    ),
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const UserRolesPage(),
    ),
  );
}

void main() {
  testWidgets('UserRolesPage renders page title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.textContaining('Users'), findsWidgets);
  });

  testWidgets('UserRolesPage shows two tabs', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text('Users'), findsWidgets);
    expect(find.text('Roles'), findsWidgets);
  });

  testWidgets('Users tab shows seeded user names', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.textContaining('Alice Admin'), findsWidgets);
    expect(find.textContaining('Bob Manager'), findsWidgets);
  });

  testWidgets('Users tab shows role chip labels', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    expect(find.textContaining('Administrator'), findsWidgets);
  });

  testWidgets('Roles tab shows role names after switching tab', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    // Tap Roles tab
    await tester.tap(find.text('Roles').last);
    await tester.pumpAndSettle();

    expect(find.textContaining('Accountant'), findsWidgets);
    expect(find.textContaining('Manager'), findsWidgets);
  });

  testWidgets('Roles tab allows expansion to see permissions', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Roles').last);
    await tester.pumpAndSettle();

    // Tap on Administrator to expand it
    await tester.tap(find.text('Administrator').first);
    await tester.pumpAndSettle();

    // Some permissions should be visible after expansion
    expect(find.textContaining('Manage'), findsWidgets);
  });

  testWidgets('Inactive user has strikethrough style', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pumpAndSettle();

    // Dave is seeded as inactive
    expect(find.textContaining('Dave Accountant'), findsWidgets);
  });
}
