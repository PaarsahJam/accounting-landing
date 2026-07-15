import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'customer_statements_repository.dart';

part 'customer_statements_repository_provider.g.dart';

@riverpod
CustomerStatementsRepository customerStatementsRepository(Ref ref) {
  return MockCustomerStatementsRepository();
}
