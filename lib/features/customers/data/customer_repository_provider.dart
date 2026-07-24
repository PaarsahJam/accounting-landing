import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client_provider.dart';
import '../../../core/sync/sync_providers.dart';
import 'customer_api_repository.dart';
import 'customer_repository.dart';
import 'customer_sync_decorator.dart';

part 'customer_repository_provider.g.dart';

const bool _useApi = bool.fromEnvironment('USE_API', defaultValue: false);

@riverpod
CustomerRepository customerRepository(Ref ref) {
  final localRepo = _useApi
      ? CustomerApiRepository(apiClient: ref.watch(apiClientProvider)) as CustomerRepository
      : MockCustomerRepository();

  final queue = ref.watch(syncQueueProvider);
  final engine = ref.watch(syncEngineProvider);
  return CustomerSyncDecorator(inner: localRepo, queue: queue, engine: engine);
}
