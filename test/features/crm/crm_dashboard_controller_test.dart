import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/features/crm/data/crm_repository.dart';
import '../../../lib/features/crm/data/crm_repository_provider.dart';
import '../../../lib/features/crm/domain/crm_dashboard_controller.dart';

void main() {
  late MockCrmRepository repository;

  setUp(() {
    repository = MockCrmRepository();
  });

  group('CrmDashboardController', () {
    test('dashboard returns all aggregate metrics', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final dashboard =
          await container.read(crmDashboardControllerProvider.future);
      expect(dashboard.totalContacts, greaterThan(0));
      expect(dashboard.totalTasks, greaterThan(0));
      expect(dashboard.overdueTasks, greaterThanOrEqualTo(0));
      expect(dashboard.activeOpportunities, greaterThan(0));
      expect(dashboard.pipelineValue, greaterThan(0));
      expect(dashboard.wonValueThisMonth, greaterThanOrEqualTo(0));
    });

    test('dashboard aggregate values are consistent', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final dashboard =
          await container.read(crmDashboardControllerProvider.future);
      expect(dashboard.openTasks, lessThanOrEqualTo(dashboard.totalTasks));
      expect(
        dashboard.activeOpportunities,
        lessThanOrEqualTo(dashboard.totalLeads),
      );
    });
  });
}
