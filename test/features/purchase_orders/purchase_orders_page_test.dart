import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository_provider.dart';
import 'package:accounting_app/features/purchase_orders/presentation/purchase_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PurchaseOrdersPage renders orders', (tester) async {
    final container = ProviderContainer(
      overrides: [
        purchaseOrdersRepositoryProvider.overrideWithValue(
          MockPurchaseOrdersRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: PurchaseOrdersPage()),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Office'), findsOneWidget);
    expect(find.text('Receipts'), findsOneWidget);
    container.dispose();
  });
}
