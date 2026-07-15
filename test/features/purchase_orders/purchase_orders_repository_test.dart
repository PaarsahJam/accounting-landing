import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('repository exposes purchase orders', () async {
    final repository = MockPurchaseOrdersRepository();
    final result = await repository.fetchPurchaseOrders();

    expect(result.isSuccess, isTrue);
    expect(result.data, isNotEmpty);
  });
}
