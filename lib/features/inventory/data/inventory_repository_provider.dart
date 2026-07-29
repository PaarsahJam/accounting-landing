import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_product_repository.dart';
import 'inventory_repository.dart';

part 'inventory_repository_provider.g.dart';

@Riverpod(keepAlive: true)
InventoryRepository inventoryRepository(Ref ref) {
  // See customer_repository_provider: active company resolved lazily per call;
  // null when no company is selected → repository fails closed.
  final repo = DriftProductRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
