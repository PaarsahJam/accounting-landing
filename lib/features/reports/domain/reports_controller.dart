import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/report_repository.dart';
import '../data/report_repository_provider.dart';
import 'report.dart';

part 'reports_controller.g.dart';

@riverpod
class ReportsController extends _$ReportsController {
  late final ReportRepository _repository;

  @override
  FutureOr<Map<String, dynamic>> build() async {
    _repository = ref.watch(reportRepositoryProvider);
    final registryResult = await _repository.fetchRegistry();
    if (!registryResult.isSuccess) {
      AppLogger.warning(
        'Failed to load report registry',
        error: registryResult.error,
      );
      throw registryResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }

    final defaultReport = registryResult.data!.reports.first;
    final metadataResult = await _repository.fetchReportMetadata(
      reportId: defaultReport.id,
    );
    if (!metadataResult.isSuccess) {
      AppLogger.warning(
        'Failed to load report metadata',
        error: metadataResult.error,
      );
      throw metadataResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }
    final filtersResult = await _repository.supportedFilters(
      reportId: defaultReport.id,
    );
    if (!filtersResult.isSuccess) {
      AppLogger.warning(
        'Failed to load report filters',
        error: filtersResult.error,
      );
      throw filtersResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }
    final exportFormatsResult = await _repository.supportedExportFormats(
      reportId: defaultReport.id,
    );
    if (!exportFormatsResult.isSuccess) {
      AppLogger.warning(
        'Failed to load export formats',
        error: exportFormatsResult.error,
      );
      throw exportFormatsResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }
    final reportResult = await _repository.generateReport(
      reportId: defaultReport.id,
      periodId: registryResult.data!.periods.first.id,
    );
    if (!reportResult.isSuccess) {
      AppLogger.warning('Failed to generate report', error: reportResult.error);
      throw reportResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }
    final summaryResult = await _repository.generateFinancialSummary(
      reportId: defaultReport.id,
      periodId: registryResult.data!.periods.first.id,
    );
    if (!summaryResult.isSuccess) {
      AppLogger.warning(
        'Failed to generate financial summary',
        error: summaryResult.error,
      );
      throw summaryResult.error ??
          const UnknownFailure(message: 'Unknown error');
    }

    return {
      'reports': registryResult.data!.reports,
      'periods': registryResult.data!.periods,
      'selectedReport': defaultReport,
      'selectedPeriod': registryResult.data!.periods.first,
      'metadata': metadataResult.data!,
      'filters': filtersResult.data!,
      'exportFormats': exportFormatsResult.data!,
      'summary': summaryResult.data!,
      'reportData': reportResult.data!,
    };
  }

  Future<void> selectReport(String reportId) async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final reports = current['reports'] as List<ReportDefinition>;
      final selected = reports.firstWhere((item) => item.id == reportId);
      final selectedPeriod = current['selectedPeriod'] as ReportPeriod;
      final metadataResult = await _repository.fetchReportMetadata(
        reportId: selected.id,
      );
      final filtersResult = await _repository.supportedFilters(
        reportId: selected.id,
      );
      final exportFormatsResult = await _repository.supportedExportFormats(
        reportId: selected.id,
      );
      final result = await _repository.generateReport(
        reportId: selected.id,
        periodId: selectedPeriod.id,
      );
      final summaryResult = await _repository.generateFinancialSummary(
        reportId: selected.id,
        periodId: selectedPeriod.id,
      );
      if (!result.isSuccess ||
          !summaryResult.isSuccess ||
          !metadataResult.isSuccess ||
          !filtersResult.isSuccess ||
          !exportFormatsResult.isSuccess) {
        throw const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data({
        ...current,
        'selectedReport': selected,
        'metadata': metadataResult.data!,
        'filters': filtersResult.data!,
        'exportFormats': exportFormatsResult.data!,
        'summary': summaryResult.data!,
        'reportData': result.data!,
      });
    } catch (e, st) {
      AppLogger.warning('Failed to select report', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> selectPeriod(String periodId) async {
    state = const AsyncValue.loading();
    try {
      final current = await future;
      final periods = current['periods'] as List<ReportPeriod>;
      final selected = periods.firstWhere((item) => item.id == periodId);
      final selectedReport = current['selectedReport'] as ReportDefinition;
      final result = await _repository.generateReport(
        reportId: selectedReport.id,
        periodId: selected.id,
      );
      final summaryResult = await _repository.generateFinancialSummary(
        reportId: selectedReport.id,
        periodId: selected.id,
      );
      if (!result.isSuccess || !summaryResult.isSuccess) {
        throw const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data({
        ...current,
        'selectedPeriod': selected,
        'summary': summaryResult.data!,
        'reportData': result.data!,
      });
    } catch (e, st) {
      AppLogger.warning('Failed to select period', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
