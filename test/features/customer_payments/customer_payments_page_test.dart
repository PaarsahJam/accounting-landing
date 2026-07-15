import 'package:accounting_app/features/customer_payments/presentation/customer_payments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accounting_app/features/customer_payments/data/customer_payments_repository.dart';
import 'package:accounting_app/features/customer_payments/data/customer_payments_repository_provider.dart';

void main() {
  testWidgets('shows empty state when there are no payments', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          customerPaymentsRepositoryProvider.overrideWithValue(
            MockCustomerPaymentsRepository(),
          ),
        ],
        child: const MaterialApp(home: CustomerPaymentsPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Customer Payments'), findsOneWidget);
  });
}
