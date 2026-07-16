import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'bank_statement_repository.dart';

part 'bank_statement_repository_provider.g.dart';

@riverpod
BankStatementRepository bankStatementRepository(Ref ref) {
  return MockBankStatementRepository();
}
