import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'bank_reconciliation_repository.dart';

part 'bank_reconciliation_repository_provider.g.dart';

@riverpod
BankReconciliationRepository bankReconciliationRepository(Ref ref) {
  return MockBankReconciliationRepository();
}
