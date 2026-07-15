import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/dashboard_metrics.dart';

abstract class DashboardRepository {
  Future<AppResult<DashboardMetrics>> fetchMetrics();
}

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<AppResult<DashboardMetrics>> fetchMetrics() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return AppResult.success(
        const DashboardMetrics(
          revenue: 1825000000,
          expenses: 954000000,
          outstandingInvoices: 14,
          cashFlow: 872000000,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
