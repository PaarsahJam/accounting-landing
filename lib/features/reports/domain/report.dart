import 'package:freezed_annotation/freezed_annotation.dart';

// FinancialSummary has been moved to the core finance module. Re-export it
// so other consumers of the reports domain can continue to refer to
// `FinancialSummary` via this file.
export '../../../core/finance/financial_summary.dart';

part 'report.freezed.dart';

@freezed
abstract class ReportDefinition with _$ReportDefinition {
  const factory ReportDefinition({
    required String id,
    required String title,
    required String description,
    required double defaultAmount,
    required List<String> tags,
  }) = _ReportDefinition;
}

@freezed
abstract class ReportSection with _$ReportSection {
  const factory ReportSection({
    required String title,
    required List<ReportRow> rows,
  }) = _ReportSection;
}

@freezed
abstract class ReportRow with _$ReportRow {
  const factory ReportRow({
    required String label,
    required double amount,
    String? note,
  }) = _ReportRow;
}

@freezed
abstract class ReportFilter with _$ReportFilter {
  const factory ReportFilter({
    required String id,
    required String label,
    required String category,
    required String description,
  }) = _ReportFilter;
}

@freezed
abstract class ReportPeriod with _$ReportPeriod {
  const factory ReportPeriod({required String id, required String label}) =
      _ReportPeriod;
}

@freezed
abstract class ReportMetadata with _$ReportMetadata {
  const factory ReportMetadata({
    required String reportId,
    required String summary,
    required List<String> tags,
  }) = _ReportMetadata;
}

@freezed
abstract class ReportRegistry with _$ReportRegistry {
  const factory ReportRegistry({
    required List<ReportDefinition> reports,
    required List<ReportPeriod> periods,
  }) = _ReportRegistry;
}

@freezed
abstract class ReportData with _$ReportData {
  const factory ReportData({
    required ReportDefinition definition,
    required ReportPeriod period,
    required List<ReportSection> sections,
    required double total,
  }) = _ReportData;
}

enum ReportExportFormat { pdf, csv, excel }
