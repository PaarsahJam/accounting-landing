import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'drift_vendor_repository.dart';
import 'vendor_repository.dart';

part 'vendor_repository_provider.g.dart';

@Riverpod(keepAlive: true)
VendorRepository vendorRepository(Ref ref) {
  // See customer_repository_provider: active company resolved lazily per call;
  // null when no company is selected → repository fails closed.
  final repo = DriftVendorRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
