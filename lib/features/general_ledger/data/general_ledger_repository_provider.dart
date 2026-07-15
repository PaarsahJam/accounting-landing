import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'general_ledger_repository.dart';

part 'general_ledger_repository_provider.g.dart';

@riverpod
GeneralLedgerRepository generalLedgerRepository(Ref ref) {
  return MockGeneralLedgerRepository();
}
