import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository.dart';
import 'package:accounting_app/features/dashboard_metrics/data/financial_dashboard_repository_provider.dart';
import 'package:accounting_app/features/dashboard_metrics/domain/financial_dashboard_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FinancialDashboardController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          financialDashboardRepositoryProvider.overrideWithValue(
            MockFinancialDashboardRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads financial dashboard successfully', () async {
      final dashboard = await container.read(
        financialDashboardControllerProvider.future,
      );

      expect(dashboard.accountsReceivable.totalOutstandingInvoices, 1);
      expect(dashboard.inventory.productCount, 2);
      expect(dashboard.monthlyRevenue, hasLength(12));
    });

    test('refresh reloads dashboard data', () async {
      final subscription = container.listen(
        financialDashboardControllerProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      final controller = container.read(
        financialDashboardControllerProvider.notifier,
      );
      await controller.future;

      await controller.refresh();
      final state = container.read(financialDashboardControllerProvider);

      expect(state.hasValue, isTrue);
      expect(state.value!.recentActivity, isNotEmpty);
    });
  });
}
