import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository.dart';
import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository_provider.dart';
import 'package:accounting_app/features/vendor_statements/presentation/vendor_statements_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the vendor statements page shell', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          vendorStatementsRepositoryProvider.overrideWithValue(
            MockVendorStatementsRepository(),
          ),
        ],
        child: const MaterialApp(home: VendorStatementsPage()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Vendor Statements'), findsOneWidget);
  });
}
