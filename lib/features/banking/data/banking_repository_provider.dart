import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'banking_repository.dart';

part 'banking_repository_provider.g.dart';

@riverpod
BankingRepository bankingRepository(Ref ref) {
  return MockBankingRepository();
}
