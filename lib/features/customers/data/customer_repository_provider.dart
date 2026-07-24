import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'customer_repository.dart';
import 'drift_customer_repository.dart';

part 'customer_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CustomerRepository customerRepository(Ref ref) {
  final repo = DriftCustomerRepository();
  ref.onDispose(() => repo.close());
  return repo;
}
