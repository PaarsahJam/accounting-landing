import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import '../../../features/inventory/data/inventory_repository_provider.dart';
import 'stock_transfer_repository.dart';

part 'stock_transfer_repository_provider.g.dart';

@riverpod
StockTransferRepository stockTransferRepository(Ref ref) {
  return MockStockTransferRepository(
    inventoryRepository: ref.watch(inventoryRepositoryProvider),
    auditTrailRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
