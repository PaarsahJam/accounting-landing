import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/kpi_value.dart';
import '../providers/analytics_providers.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(currentPeriodProvider);
    final asyncDashboard = ref.watch(analyticsDashboardProvider(period));

    return ResponsivePageScaffold(
      title: 'Analytics & BI',
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            // Period switching handled by provider.
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'current',
              child: Text('Current period'),
            ),
            const PopupMenuItem(
              value: 'previous',
              child: Text('Previous period'),
            ),
          ],
        ),
      ],
      child: asyncDashboard.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (dashboard) {
          if (dashboard.kpis.isEmpty) {
            return const AppEmptyState(
              title: 'No analytics data',
              message: 'Data will appear once transactions are recorded.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(analyticsDashboardProvider(period));
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _KpiGrid(kpis: dashboard.kpis),
                const SizedBox(height: 24),
                if (dashboard.trends.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trends',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          for (final entry in dashboard.trends.entries.take(5))
                            ListTile(
                              dense: true,
                              title: Text(entry.key),
                              subtitle: Text(
                                'Trend: ${entry.value.direction.name} (avg: ${entry.value.avg?.toStringAsFixed(1) ?? 'N/A'})',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.kpis});

  final List<KpiValue> kpis;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: kpis.map((kpi) => _KpiCard(kpi: kpi)).toList(),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.kpi});

  final KpiValue kpi;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kpi.definition.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                kpi.formattedValue,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (kpi.periodOverPeriodPercentChange != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      kpi.periodOverPeriodPercentChange! >= 0
                          ? Icons.trending_up
                          : Icons.trending_down,
                      size: 16,
                      color: kpi.periodOverPeriodPercentChange! >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${kpi.periodOverPeriodPercentChange!.toStringAsFixed(1)}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: kpi.periodOverPeriodPercentChange! >= 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
