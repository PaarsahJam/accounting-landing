import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:accounting_app/features/inventory/presentation/product_stock_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProductStockDetailPage renders stock details', (tester) async {
    final container = ProviderContainer(
      overrides: [
        inventoryRepositoryProvider.overrideWithValue(
          MockInventoryRepository(),
        ),
      ],
    );

    const product = Product(
      id: 'P-1001',
      sku: 'SKU-1001',
      name: 'Laptop Stand',
      description: 'Ergonomic aluminum stand',
      categoryId: 'CAT-001',
      unitId: 'UOM-001',
      price: 89,
      stockOnHand: 12,
      active: true,
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ProductStockDetailPage(product: product),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('12'), findsWidgets);
    expect(find.textContaining('Receipt'), findsOneWidget);
    container.dispose();
  });
}
