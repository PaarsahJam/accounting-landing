import 'package:accounting_app/features/customer_statements/data/customer_statements_repository.dart';
import 'package:accounting_app/features/customer_statements/data/customer_statements_repository_provider.dart';
import 'package:accounting_app/features/customer_statements/presentation/customer_statements_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the statements page shell', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          customerStatementsRepositoryProvider.overrideWithValue(
            MockCustomerStatementsRepository(),
          ),
        ],
        child: const MaterialApp(home: CustomerStatementsPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Customer Statements'), findsOneWidget);
  });
}
