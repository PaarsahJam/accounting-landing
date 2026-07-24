import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client_provider.dart';
import 'customer_api_repository.dart';
import 'customer_repository.dart';

part 'customer_repository_provider.g.dart';

const bool _useApi = bool.fromEnvironment('USE_API', defaultValue: false);

@riverpod
CustomerRepository customerRepository(Ref ref) {
  if (_useApi) {
    final apiClient = ref.watch(apiClientProvider);
    return CustomerApiRepository(apiClient: apiClient);
  }
  return MockCustomerRepository();
}
