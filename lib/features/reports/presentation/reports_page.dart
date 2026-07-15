import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../../../shared/widgets/section_header.dart';
import '../domain/report.dart';
import '../domain/reports_controller.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reportsAsync = ref.watch(reportsControllerProvider);

    return ResponsivePageScaffold(
      title: l10n.reportsPageTitle,
      child: reportsAsync.when(
        loading: () => const AppLoadingState(message: 'Loading reports'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.reportsLoadError} $error'),
        data: (data) {
          final reports = data['reports'] as List<ReportDefinition>;
          final periods = data['periods'] as List<ReportPeriod>;
          final selectedReport = data['selectedReport'] as ReportDefinition;
          final selectedPeriod = data['selectedPeriod'] as ReportPeriod;
          final metadata = data['metadata'] as ReportMetadata;
          final filters = data['filters'] as List<ReportFilter>;
          final exportFormats =
              data['exportFormats'] as List<ReportExportFormat>;
          final summary = data['summary'] as FinancialSummary;
          final reportData = data['reportData'] as ReportData;

          if (reports.isEmpty) {
            return AppEmptyState(
              title: l10n.reportsEmptyTitle,
              message: l10n.reportsEmptyMessage,
            );
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: l10n.reportsPageTitle,
                        subtitle:
                            '${selectedReport.title} • ${selectedPeriod.label}',
                      ),
                      const SizedBox(height: 16),
                      Text(
                        metadata.summary,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.reportPeriodLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: selectedPeriod.id,
                        items: periods
                            .map(
                              (period) => DropdownMenuItem(
                                value: period.id,
                                child: Text(period.label),
                              ),
                            )
                            .toList(),
                        onChanged: (periodId) {
                          if (periodId != null) {
                            ref
                                .read(reportsControllerProvider.notifier)
                                .selectPeriod(periodId);
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.reportSelectLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: reports.map((report) {
                          final isSelected = report.id == selectedReport.id;
                          return FilterChip(
                            label: Text(report.title),
                            selected: isSelected,
                            onSelected: (_) {
                              ref
                                  .read(reportsControllerProvider.notifier)
                                  .selectReport(report.id);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.supportedFiltersLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: filters
                            .map(
                              (filter) => Chip(
                                label: Text(filter.label),
                                avatar: const Icon(Icons.tune, size: 18),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.exportOptionsLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: exportFormats
                            .map(
                              (format) => InputChip(
                                label: Text(format.name.toUpperCase()),
                                onPressed: null,
                                tooltip: l10n.mockOnlyLabel,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              reportData.definition.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Text(
                            '${reportData.total.toStringAsFixed(0)} ${l10n.currencyUnit}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _SummaryCard(
                            title: l10n.revenueSummaryLabel,
                            value:
                                '${summary.revenue.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.expensesSummaryLabel,
                            value:
                                '${summary.expenses.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.netIncomeSummaryLabel,
                            value:
                                '${summary.netIncome.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.cashBalanceSummaryLabel,
                            value:
                                '${summary.cashBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(reportData.definition.description),
                      const SizedBox(height: 16),
                      ...reportData.sections.map(
                        (section) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                section.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...section.rows.map(
                                (row) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text(row.label)),
                                      Text(
                                        '${row.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 180),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
