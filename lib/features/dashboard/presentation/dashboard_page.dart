import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/section_header.dart';
import '../../dashboard_metrics/domain/financial_dashboard_controller.dart';
import '../../dashboard_metrics/presentation/widgets/activity_timeline.dart';
import '../../dashboard_metrics/presentation/widgets/dashboard_metric_card.dart';
import '../../dashboard_metrics/presentation/widgets/dashboard_quick_actions.dart';
import '../../dashboard_metrics/presentation/widgets/monthly_bar_chart.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  String _formatAmount(double amount, AppLocalizations l10n) {
    return '${amount.toStringAsFixed(0)} ${l10n.currencyUnit}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final dashboardAsync = ref.watch(financialDashboardControllerProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 600 && width < 1024;
    final columnCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    return Shortcuts(
      shortcuts: {
        const SingleActivator(LogicalKeyboardKey.keyR, control: true):
            const _RefreshDashboardIntent(),
      },
      child: Actions(
        actions: {
          _RefreshDashboardIntent: CallbackAction<_RefreshDashboardIntent>(
            onInvoke: (_) async {
              await ref
                  .read(financialDashboardControllerProvider.notifier)
                  .refresh();
              return null;
            },
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(l10n.dashboard),
            actions: [
              IconButton(
                onPressed: () => ref
                    .read(financialDashboardControllerProvider.notifier)
                    .refresh(),
                icon: const Icon(Icons.refresh),
                tooltip: l10n.refresh,
              ),
            ],
          ),
          body: dashboardAsync.when(
            loading: () => AppLoadingState(message: l10n.dashboardLoading),
            error: (error, stackTrace) =>
                AppErrorState(message: '${l10n.dashboardLoadError} $error'),
            data: (dashboard) {
              final ar = dashboard.accountsReceivable;
              final ap = dashboard.accountsPayable;
              final inventory = dashboard.inventory;
              final cash = dashboard.cashPosition;
              final profit = dashboard.profitOverview;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: l10n.dashboardOverview,
                      subtitle: l10n.dashboardFinancialSubtitle,
                    ),
                    const SizedBox(height: 16),
                    DashboardQuickActions(l10n: l10n),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth =
                            (constraints.maxWidth - (columnCount - 1) * 16) /
                            columnCount;
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            SizedBox(
                              width: isDesktop || isTablet
                                  ? cardWidth
                                  : double.infinity,
                              child: DashboardMetricCard(
                                title: l10n.dashboardAccountsReceivable,
                                icon: Icons.arrow_downward,
                                accent: Colors.green,
                                metrics: [
                                  DashboardMetricRow(
                                    label:
                                        l10n.dashboardTotalOutstandingInvoices,
                                    value: '${ar.totalOutstandingInvoices}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardOverdueInvoices,
                                    value: '${ar.overdueInvoices}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardReceivedThisMonth,
                                    value: _formatAmount(
                                      ar.amountReceivedThisMonth,
                                      l10n,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: isDesktop || isTablet
                                  ? cardWidth
                                  : double.infinity,
                              child: DashboardMetricCard(
                                title: l10n.dashboardAccountsPayable,
                                icon: Icons.arrow_upward,
                                accent: Colors.orange,
                                metrics: [
                                  DashboardMetricRow(
                                    label: l10n.dashboardOutstandingVendorBills,
                                    value: '${ap.outstandingVendorBills}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardOverdueBills,
                                    value: '${ap.overdueBills}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardPaymentsMadeThisMonth,
                                    value: _formatAmount(
                                      ap.paymentsMadeThisMonth,
                                      l10n,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: isDesktop || isTablet
                                  ? cardWidth
                                  : double.infinity,
                              child: DashboardMetricCard(
                                title: l10n.dashboardInventory,
                                icon: Icons.inventory_2,
                                accent: Colors.blue,
                                metrics: [
                                  DashboardMetricRow(
                                    label: l10n.dashboardProductCount,
                                    value: '${inventory.productCount}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardLowStockProducts,
                                    value: '${inventory.lowStockProducts}',
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardTotalStockQuantity,
                                    value: inventory.totalStockQuantity
                                        .toStringAsFixed(0),
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardWarehouseCount,
                                    value: '${inventory.warehouseCount}',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: isDesktop || isTablet
                                  ? cardWidth
                                  : double.infinity,
                              child: DashboardMetricCard(
                                title: l10n.dashboardCashPosition,
                                icon: Icons.account_balance_wallet,
                                accent: Colors.teal,
                                metrics: [
                                  DashboardMetricRow(
                                    label: l10n.dashboardCash,
                                    value: _formatAmount(cash.cash, l10n),
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardBank,
                                    value: _formatAmount(cash.bank, l10n),
                                  ),
                                  DashboardMetricRow(
                                    label: l10n.dashboardTotalLiquidAssets,
                                    value: _formatAmount(
                                      cash.totalLiquidAssets,
                                      l10n,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ChartCard(
                              title: l10n.dashboardMonthlyRevenue,
                              child: MonthlyBarChart(
                                data: dashboard.monthlyRevenue,
                                barColor: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _ChartCard(
                              title: l10n.dashboardMonthlyExpenses,
                              child: MonthlyBarChart(
                                data: dashboard.monthlyExpenses,
                                barColor: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _ChartCard(
                        title: l10n.dashboardMonthlyRevenue,
                        child: MonthlyBarChart(
                          data: dashboard.monthlyRevenue,
                          barColor: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _ChartCard(
                        title: l10n.dashboardMonthlyExpenses,
                        child: MonthlyBarChart(
                          data: dashboard.monthlyExpenses,
                          barColor: Colors.orange,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(title: l10n.dashboardProfitOverview),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 24,
                              runSpacing: 12,
                              children: [
                                _ProfitStat(
                                  label: l10n.dashboardRevenue,
                                  value: _formatAmount(profit.revenue, l10n),
                                  color: Colors.green,
                                ),
                                _ProfitStat(
                                  label: l10n.dashboardExpenses,
                                  value: _formatAmount(profit.expenses, l10n),
                                  color: Colors.orange,
                                ),
                                _ProfitStat(
                                  label: l10n.dashboardGrossProfit,
                                  value: _formatAmount(
                                    profit.grossProfit,
                                    l10n,
                                  ),
                                  color: Colors.blue,
                                ),
                                _ProfitStat(
                                  label: l10n.dashboardNetProfit,
                                  value: _formatAmount(profit.netProfit, l10n),
                                  color: Colors.teal,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SectionHeader(title: l10n.dashboardRecentActivity),
                    const SizedBox(height: 8),
                    Card(
                      child: ActivityTimeline(
                        items: dashboard.recentActivity.take(10).toList(),
                        l10n: l10n,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RefreshDashboardIntent extends Intent {
  const _RefreshDashboardIntent();
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ProfitStat extends StatelessWidget {
  const _ProfitStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label: $value',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
