import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/report.dart';
import '../../../core/finance/financial_calculator.dart';

abstract class ReportRepository {
  Future<AppResult<List<ReportDefinition>>> fetchAvailableReports();
  Future<AppResult<ReportRegistry>> fetchRegistry();
  Future<AppResult<ReportMetadata>> fetchReportMetadata({
    required String reportId,
  });
  Future<AppResult<List<ReportFilter>>> supportedFilters({
    required String reportId,
  });
  Future<AppResult<List<ReportExportFormat>>> supportedExportFormats({
    required String reportId,
  });
  Future<AppResult<ReportData>> generateReport({
    required String reportId,
    required String periodId,
  });
  Future<AppResult<FinancialSummary>> generateFinancialSummary({
    required String reportId,
    required String periodId,
  });
  Future<AppResult<List<ReportPeriod>>> availablePeriods();
}

class MockReportRepository implements ReportRepository {
  final List<ReportDefinition> _definitions = const [
    ReportDefinition(
      id: 'profit-loss',
      title: 'Profit & Loss',
      description: 'Revenue and expense movement for the selected period.',
      defaultAmount: 125000000,
      tags: ['income', 'expense', 'pnl'],
    ),
    ReportDefinition(
      id: 'balance-sheet',
      title: 'Balance Sheet',
      description: 'Assets, liabilities, and equity snapshot.',
      defaultAmount: 850000000,
      tags: ['assets', 'liabilities', 'equity'],
    ),
    ReportDefinition(
      id: 'cash-flow',
      title: 'Cash Flow',
      description: 'Cash movement by operating and investing activities.',
      defaultAmount: 32000000,
      tags: ['cash', 'operating', 'investing'],
    ),
    ReportDefinition(
      id: 'expense-summary',
      title: 'Expense Summary',
      description: 'Grouped expense positions for the selected period.',
      defaultAmount: 18000000,
      tags: ['expenses', 'costs'],
    ),
    ReportDefinition(
      id: 'revenue-summary',
      title: 'Revenue Summary',
      description: 'Revenue breakdown for the selected period.',
      defaultAmount: 250000000,
      tags: ['revenue', 'income'],
    ),
  ];

  final List<ReportPeriod> _periods = const [
    ReportPeriod(id: 'month', label: 'This Month'),
    ReportPeriod(id: 'quarter', label: 'This Quarter'),
    ReportPeriod(id: 'year', label: 'This Year'),
  ];

  final List<ReportFilter> _filters = const [
    ReportFilter(
      id: 'period',
      label: 'Period',
      category: 'date',
      description: 'Select the reporting window.',
    ),
    ReportFilter(
      id: 'department',
      label: 'Department',
      category: 'dimension',
      description: 'Segment by operating department.',
    ),
    ReportFilter(
      id: 'currency',
      label: 'Currency',
      category: 'format',
      description: 'Switch the reporting currency.',
    ),
  ];

  final List<ReportExportFormat> _exportFormats = const [
    ReportExportFormat.pdf,
    ReportExportFormat.csv,
    ReportExportFormat.excel,
  ];

  @override
  Future<AppResult<List<ReportDefinition>>> fetchAvailableReports() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(List<ReportDefinition>.from(_definitions));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<ReportRegistry>> fetchRegistry() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(
        ReportRegistry(
          reports: List<ReportDefinition>.from(_definitions),
          periods: List<ReportPeriod>.from(_periods),
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<ReportMetadata>> fetchReportMetadata({
    required String reportId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      final definition = _definitions.firstWhere(
        (item) => item.id == reportId,
        orElse: () => _definitions.first,
      );
      return AppResult.success(
        ReportMetadata(
          reportId: definition.id,
          summary: '${definition.title} report ready for downstream modules.',
          tags: definition.tags,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ReportFilter>>> supportedFilters({
    required String reportId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (reportId.isEmpty) {
        return AppResult.success(const <ReportFilter>[]);
      }
      return AppResult.success(List<ReportFilter>.from(_filters));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ReportExportFormat>>> supportedExportFormats({
    required String reportId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      if (reportId.isEmpty) {
        return AppResult.success(const <ReportExportFormat>[]);
      }
      return AppResult.success(List<ReportExportFormat>.from(_exportFormats));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<ReportPeriod>>> availablePeriods() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(List<ReportPeriod>.from(_periods));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<ReportData>> generateReport({
    required String reportId,
    required String periodId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      final definition = _definitions.firstWhere(
        (item) => item.id == reportId,
        orElse: () => _definitions.first,
      );
      final period = _periods.firstWhere(
        (item) => item.id == periodId,
        orElse: () => _periods.first,
      );

      final sections = _buildSections(definition, period);
      final total = sections.fold<double>(
        0,
        (sum, section) =>
            sum +
            section.rows.fold<double>(0, (rowSum, row) => rowSum + row.amount),
      );

      return AppResult.success(
        ReportData(
          definition: definition,
          period: period,
          sections: sections,
          total: total,
        ),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<FinancialSummary>> generateFinancialSummary({
    required String reportId,
    required String periodId,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final definition = _definitions.firstWhere(
        (item) => item.id == reportId,
        orElse: () => _definitions.first,
      );
      final period = _periods.firstWhere(
        (item) => item.id == periodId,
        orElse: () => _periods.first,
      );
      // Use the shared financial calculator to produce mock-backed summaries.
      final calculator = const FinancialCalculator();
      final summary = calculator.calculateFinancialSummary(
        baseAmount: definition.defaultAmount,
        periodId: period.id,
      );
      return AppResult.success(summary);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  List<ReportSection> _buildSections(
    ReportDefinition definition,
    ReportPeriod period,
  ) {
    switch (definition.id) {
      case 'profit-loss':
        return [
          ReportSection(
            title: 'Revenue',
            rows: [
              ReportRow(
                label: 'Services',
                amount: definition.defaultAmount * 0.75,
              ),
              ReportRow(
                label: 'Other income',
                amount: definition.defaultAmount * 0.15,
              ),
            ],
          ),
          ReportSection(
            title: 'Expenses',
            rows: [
              ReportRow(
                label: 'Payroll',
                amount: definition.defaultAmount * 0.2,
              ),
              ReportRow(
                label: 'Operations',
                amount: definition.defaultAmount * 0.1,
              ),
            ],
          ),
        ];
      case 'balance-sheet':
        return [
          ReportSection(
            title: 'Assets',
            rows: [
              ReportRow(label: 'Cash', amount: definition.defaultAmount * 0.45),
              ReportRow(
                label: 'Receivables',
                amount: definition.defaultAmount * 0.3,
              ),
            ],
          ),
          ReportSection(
            title: 'Liabilities',
            rows: [
              ReportRow(
                label: 'Loans',
                amount: definition.defaultAmount * 0.15,
              ),
            ],
          ),
        ];
      case 'cash-flow':
        return [
          ReportSection(
            title: 'Operating',
            rows: [
              ReportRow(
                label: 'Collections',
                amount: definition.defaultAmount * 0.6,
              ),
            ],
          ),
          ReportSection(
            title: 'Investing',
            rows: [
              ReportRow(
                label: 'Equipment',
                amount: definition.defaultAmount * -0.1,
              ),
            ],
          ),
        ];
      case 'expense-summary':
        return [
          ReportSection(
            title: 'Operating expenses',
            rows: [
              ReportRow(label: 'Software', amount: 5400000),
              ReportRow(label: 'Travel', amount: 2400000),
            ],
          ),
        ];
      default:
        return [
          ReportSection(
            title: 'Revenue',
            rows: [
              ReportRow(label: 'Subscriptions', amount: 160000000),
              ReportRow(label: 'Consulting', amount: 90000000),
            ],
          ),
        ];
    }
  }
}
