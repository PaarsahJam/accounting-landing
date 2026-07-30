import 'package:accounting_app/features/email/data/email_repository.dart';
import 'package:accounting_app/features/email/presentation/email_page.dart';
import 'package:accounting_app/features/email/services/email_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      emailRepositoryProvider.overrideWithValue(
        MockEmailRepository(),
      ),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: EmailPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('EmailPage renders title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Email History'), findsOneWidget);
  });
}
