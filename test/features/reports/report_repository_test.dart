import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/reports/data/report_repository.dart';
import 'package:accounting_app/features/reports/domain/report_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockReportRepository', () {
    late MockReportRepository repository;

    setUp(() {
      repository = MockReportRepository();
    });

    test(
      'fetchAvailableReports returns available report definitions',
      () async {
        final result = await repository.fetchAvailableReports();

        expect(result, isA<AppResult<List<ReportDefinition>>>());
        expect(result.isSuccess, isTrue);
        expect(result.data, isNotEmpty);
        expect(result.data!.first.title, isNotEmpty);
      },
    );

    test('availablePeriods returns supported periods', () async {
      final result = await repository.availablePeriods();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.any((period) => period.id == 'month'), isTrue);
    });

    test('fetchRegistry returns the reporting registry', () async {
      final result = await repository.fetchRegistry();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.reports, isNotEmpty);
      expect(result.data!.periods, isNotEmpty);
    });

    test('fetchReportMetadata returns metadata for a report', () async {
      final result = await repository.fetchReportMetadata(
        reportId: 'profit-loss',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.reportId, 'profit-loss');
    });

    test('supportedFilters returns filters for a report', () async {
      final result = await repository.supportedFilters(reportId: 'profit-loss');

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.first.label, isNotEmpty);
    });

    test('supportedExportFormats returns export options', () async {
      final result = await repository.supportedExportFormats(
        reportId: 'profit-loss',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.contains(ReportExportFormat.pdf), isTrue);
    });

    test(
      'generateReport returns sections and totals for the selected report',
      () async {
        final result = await repository.generateReport(
          reportId: 'profit-loss',
          periodId: 'quarter',
        );

        expect(result.isSuccess, isTrue);
        expect(result.data, isNotNull);
        expect(result.data!.sections, isNotEmpty);
        expect(result.data!.total, greaterThan(0));
      },
    );

    test('generateFinancialSummary returns a mock summary', () async {
      final result = await repository.generateFinancialSummary(
        reportId: 'profit-loss',
        periodId: 'quarter',
      );

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotNull);
      expect(result.data!.netIncome, greaterThan(0));
    });
  });
}
