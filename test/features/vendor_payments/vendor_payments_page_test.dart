import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository.dart';
import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository_provider.dart';
import 'package:accounting_app/features/vendor_payments/presentation/vendor_payments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VendorPaymentsPage renders payments', (tester) async {
    final container = ProviderContainer(
      overrides: [
        vendorPaymentsRepositoryProvider.overrideWithValue(
          MockVendorPaymentsRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: VendorPaymentsPage()),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('VP-'), findsWidgets);
    container.dispose();
  });
}
