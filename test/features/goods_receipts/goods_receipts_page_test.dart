import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository_provider.dart';
import 'package:accounting_app/features/purchase_orders/presentation/goods_receipts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return ProviderScope(
    overrides: [
      purchaseOrdersRepositoryProvider.overrideWithValue(
        MockPurchaseOrdersRepository(),
      ),
    ],
    child: const MaterialApp(
      home: Scaffold(
        body: GoodsReceiptsPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('GoodsReceiptsPage renders title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Goods Receipts'), findsOneWidget);
  });
}
