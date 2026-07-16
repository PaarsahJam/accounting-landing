import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'multi_currency_repository.dart';

part 'multi_currency_repository_provider.g.dart';

@riverpod
MultiCurrencyRepository multiCurrencyRepository(Ref ref) {
  return MockMultiCurrencyRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
