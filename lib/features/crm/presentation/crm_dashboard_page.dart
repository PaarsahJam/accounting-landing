import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../domain/crm_dashboard_controller.dart';
import '../domain/crm_dashboard_data.dart';

class CrmDashboardPage extends ConsumerWidget {
  const CrmDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final dashboardAsync = ref.watch(crmDashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.crmDashboard)),
      body: dashboardAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) => AppErrorState(
          message: e.toString(),
          onRetry: () =>
              ref.invalidate(crmDashboardControllerProvider),
        ),
        data: (data) => _DashboardGrid(data: data),
      ),
    );
  }
}

class _DashboardGrid extends StatelessWidget {
  final CrmDashboardData data;

  const _DashboardGrid({required this.data});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###', 'fa');

    return RefreshIndicator(
      onRefresh: () async {},
      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          _MetricCard(
            label: 'Total Contacts',
            value: data.totalContacts.toString(),
            icon: Icons.people,
            color: Colors.blue,
          ),
          _MetricCard(
            label: 'Open Tasks',
            value: data.openTasks.toString(),
            icon: Icons.task,
            color: Colors.orange,
          ),
          _MetricCard(
            label: 'Overdue Tasks',
            value: data.overdueTasks.toString(),
            icon: Icons.warning,
            color: data.overdueTasks > 0 ? Colors.red : Colors.grey,
          ),
          _MetricCard(
            label: 'Active Opportunities',
            value: data.activeOpportunities.toString(),
            icon: Icons.trending_up,
            color: Colors.green,
          ),
          _MetricCard(
            label: 'Pipeline Value',
            value: '${currencyFormat.format(data.pipelineValue)} IRR',
            icon: Icons.account_balance,
            color: Colors.indigo,
          ),
          _MetricCard(
            label: 'Won This Month',
            value: '${currencyFormat.format(data.wonValueThisMonth)} IRR',
            icon: Icons.emoji_events,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
