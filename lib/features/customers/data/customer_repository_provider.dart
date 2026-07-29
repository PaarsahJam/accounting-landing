import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'customer_repository.dart';
import 'drift_customer_repository.dart';

part 'customer_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) {
  // Resolve the active company lazily per call so a company switch is picked up
  // without rebuilding this keepAlive repository. Returns null when no company
  // is loaded/selected, which makes the repository fail closed.
  final repo = DriftCustomerRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
