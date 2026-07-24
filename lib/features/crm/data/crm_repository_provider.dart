import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'crm_repository.dart';

part 'crm_repository_provider.g.dart';

@riverpod
CrmRepository crmRepository(Ref ref) {
  return MockCrmRepository();
}
