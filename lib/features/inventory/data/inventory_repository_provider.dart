import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'drift_product_repository.dart';
import 'inventory_repository.dart';

part 'inventory_repository_provider.g.dart';

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) {
  final repo = DriftProductRepository();
  ref.onDispose(() => repo.close());
  return repo;
}
