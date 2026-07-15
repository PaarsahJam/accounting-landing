import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'customer_payments_repository.dart';

part 'customer_payments_repository_provider.g.dart';

@riverpod
CustomerPaymentsRepository customerPaymentsRepository(Ref ref) {
  return MockCustomerPaymentsRepository();
}
