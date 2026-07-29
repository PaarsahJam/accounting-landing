import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_vendor_bills_repository.dart';
import 'vendor_bills_repository.dart';

part 'vendor_bills_repository_provider.g.dart';

@Riverpod(keepAlive: true)
VendorBillsRepository vendorBillsRepository(Ref ref) {
  final repo = DriftVendorBillsRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
