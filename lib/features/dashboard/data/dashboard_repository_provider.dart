import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dashboard_repository.dart';

part 'dashboard_repository_provider.g.dart';

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  return MockDashboardRepository();
}
