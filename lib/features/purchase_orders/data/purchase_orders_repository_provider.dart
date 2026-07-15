import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'purchase_orders_repository.dart';

part 'purchase_orders_repository_provider.g.dart';

@riverpod
PurchaseOrdersRepository purchaseOrdersRepository(Ref ref) {
  return MockPurchaseOrdersRepository();
}
