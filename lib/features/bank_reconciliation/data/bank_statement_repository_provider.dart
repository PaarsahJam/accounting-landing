import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/company/company_controller.dart';
import 'bank_statement_repository.dart';
import 'drift_bank_statement_repository.dart';

part 'bank_statement_repository_provider.g.dart';

@Riverpod(keepAlive: true)
BankStatementRepository bankStatementRepository(Ref ref) {
  final repo = DriftBankStatementRepository(
    companyId: () => ref.read(currentCompanyProvider).asData?.value?.id,
  );
  ref.onDispose(() => repo.close());
  return repo;
}
