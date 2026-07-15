import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository_provider.dart';
import 'package:accounting_app/features/vendor_bills/presentation/vendor_bills_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VendorBillsPage renders bills', (tester) async {
    final container = ProviderContainer(
      overrides: [
        vendorBillsRepositoryProvider.overrideWithValue(
          MockVendorBillsRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: VendorBillsPage()),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Bill'), findsWidgets);
    container.dispose();
  });
}
