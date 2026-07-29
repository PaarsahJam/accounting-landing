import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_purchase_orders_repository.dart';
import 'purchase_orders_repository.dart';

part 'purchase_orders_repository_provider.g.dart';

@Riverpod(keepAlive: true)
PurchaseOrdersRepository purchaseOrdersRepository(Ref ref) {
  final repo = DriftPurchaseOrdersRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
