import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'banking_repository.dart';
import 'drift_banking_repository.dart';

part 'banking_repository_provider.g.dart';

@Riverpod(keepAlive: true)
BankingRepository bankingRepository(Ref ref) {
  final repo = DriftBankingRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
