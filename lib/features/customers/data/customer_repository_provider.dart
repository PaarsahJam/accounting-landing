import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'customer_repository.dart';

part 'customer_repository_provider.g.dart';

@riverpod
CustomerRepository customerRepository(Ref ref) {
  return MockCustomerRepository();
}
