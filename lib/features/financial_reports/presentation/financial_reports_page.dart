import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/financial_reports_controller.dart';
import '../domain/financial_reports_models.dart';

class FinancialReportsPage extends ConsumerWidget {
  const FinancialReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(financialReportsControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return ResponsivePageScaffold(
      title: l10n.financialReportsPageTitle,
      child: stateAsync.when(
        loading: () =>
            AppLoadingState(message: l10n.financialReportsLoadingMessage),
        error: (error, stackTrace) => AppErrorState(message: '$error'),
        data: (state) {
          if (state.trialBalance.rows.isEmpty) {
            return AppEmptyState(
              title: l10n.financialReportsNoReportsTitle,
              message: l10n.financialReportsNoReportsMessage,
            );
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              _HeaderCard(state: state),
              const SizedBox(height: 16),
              _SummaryCards(state: state),
              const SizedBox(height: 16),
              _ReportBody(state: state),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderCard extends ConsumerWidget {
  const _HeaderCard({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.financialReportsPageTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: Text(l10n.financialReportsTrialBalance),
                  selected: state.selectedReport == 'tb',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setReportType('tb'),
                ),
                FilterChip(
                  label: Text(l10n.financialReportsProfitAndLoss),
                  selected: state.selectedReport == 'pnl',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setReportType('pnl'),
                ),
                FilterChip(
                  label: Text(l10n.financialReportsBalanceSheet),
                  selected: state.selectedReport == 'bs',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setReportType('bs'),
                ),
                FilterChip(
                  label: Text(l10n.financialReportsCashFlow),
                  selected: state.selectedReport == 'cf',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setReportType('cf'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: l10n.financialReportsSearchAccount,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => ref
                  .read(financialReportsControllerProvider.notifier)
                  .setSearchTerm(value),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.startDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      await ref
                          .read(financialReportsControllerProvider.notifier)
                          .setRange(picked, state.endDate);
                    }
                  },
                  child: Text(
                    '${l10n.financialReportsStartLabel}: ${state.startDate.year}-${state.startDate.month.toString().padLeft(2, '0')}',
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: state.endDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      await ref
                          .read(financialReportsControllerProvider.notifier)
                          .setRange(state.startDate, picked);
                    }
                  },
                  child: Text(
                    '${l10n.financialReportsEndLabel}: ${state.endDate.year}-${state.endDate.month.toString().padLeft(2, '0')}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: Text(l10n.financialReportsFilterAll),
                  selected: state.balanceFilter == 'all',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setBalanceFilter('all'),
                ),
                FilterChip(
                  label: Text(l10n.financialReportsFilterDebit),
                  selected: state.balanceFilter == 'debit',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setBalanceFilter('debit'),
                ),
                FilterChip(
                  label: Text(l10n.financialReportsFilterCredit),
                  selected: state.balanceFilter == 'credit',
                  onSelected: (_) => ref
                      .read(financialReportsControllerProvider.notifier)
                      .setBalanceFilter('credit'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => context.go('/customer-statements'),
                  icon: const Icon(Icons.receipt_long),
                  label: Text(l10n.financialReportsArAging),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.go('/vendor-statements'),
                  icon: const Icon(Icons.account_balance_wallet),
                  label: Text(l10n.financialReportsApAging),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _MetricCard(
          title: l10n.financialReportsRevenue,
          value: state.profitAndLoss.totalRevenue.toStringAsFixed(0),
        ),
        _MetricCard(
          title: l10n.financialReportsExpenses,
          value: state.profitAndLoss.totalExpenses.toStringAsFixed(0),
        ),
        _MetricCard(
          title: l10n.financialReportsNetProfit,
          value: state.profitAndLoss.netProfit.toStringAsFixed(0),
        ),
        _MetricCard(
          title: l10n.financialReportsBalanced,
          value: state.trialBalance.isBalanced
              ? l10n.financialReportsYes
              : l10n.financialReportsNo,
        ),
      ],
    );
  }
}

class _ReportBody extends StatelessWidget {
  const _ReportBody({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final visibleRows = state.trialBalance.rows
        .where((row) {
          final search = state.searchTerm.toLowerCase();
          if (search.isEmpty) {
            return true;
          }
          return row.accountName.toLowerCase().contains(search) ||
              row.accountCode.toLowerCase().contains(search);
        })
        .where((row) {
          switch (state.balanceFilter) {
            case 'debit':
              return row.endingBalance > 0;
            case 'credit':
              return row.endingBalance < 0;
            default:
              return true;
          }
        })
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.selectedReport == 'pnl'
                  ? l10n.financialReportsProfitAndLoss
                  : state.selectedReport == 'bs'
                  ? l10n.financialReportsBalanceSheet
                  : state.selectedReport == 'cf'
                  ? l10n.financialReportsCashFlow
                  : l10n.financialReportsTrialBalance,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (state.selectedReport == 'pnl')
              _ProfitAndLossSection(state: state)
            else if (state.selectedReport == 'bs')
              _BalanceSheetSection(state: state)
            else if (state.selectedReport == 'cf')
              _CashFlowSection(state: state)
            else
              _TrialBalanceSection(rows: visibleRows),
          ],
        ),
      ),
    );
  }
}

class _TrialBalanceSection extends StatelessWidget {
  const _TrialBalanceSection({required this.rows});

  final List<TrialBalanceRow> rows;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text(l10n.financialReportsAccountCode)),
          DataColumn(label: Text(l10n.financialReportsAccountName)),
          DataColumn(label: Text(l10n.financialReportsDebit)),
          DataColumn(label: Text(l10n.financialReportsCredit)),
          DataColumn(label: Text(l10n.financialReportsEndingBalance)),
        ],
        rows: rows.map((row) {
          return DataRow(
            cells: [
              DataCell(Text(row.accountCode)),
              DataCell(Text(row.accountName)),
              DataCell(Text(row.debitTotal.toStringAsFixed(0))),
              DataCell(Text(row.creditTotal.toStringAsFixed(0))),
              DataCell(Text(row.endingBalance.toStringAsFixed(0))),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ProfitAndLossSection extends StatelessWidget {
  const _ProfitAndLossSection({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          title: l10n.financialReportsRevenue,
          items: state.profitAndLoss.revenueRows,
        ),
        const SizedBox(height: 12),
        _Section(
          title: l10n.financialReportsExpenses,
          items: state.profitAndLoss.expenseRows,
        ),
      ],
    );
  }
}

class _BalanceSheetSection extends StatelessWidget {
  const _BalanceSheetSection({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          title: l10n.financialReportsAssets,
          items: [
            ReportLine(
              label: l10n.financialReportsCash,
              amount: state.balanceSheet.cash,
            ),
            ReportLine(
              label: l10n.financialReportsBank,
              amount: state.balanceSheet.bank,
            ),
            ReportLine(
              label: l10n.financialReportsReceivables,
              amount: state.balanceSheet.receivables,
            ),
            ReportLine(
              label: l10n.financialReportsInventory,
              amount: state.balanceSheet.inventory,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _Section(
          title: l10n.financialReportsLiabilities,
          items: [
            ReportLine(
              label: l10n.financialReportsPayables,
              amount: state.balanceSheet.payables,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _Section(
          title: l10n.financialReportsEquity,
          items: [
            ReportLine(
              label: l10n.financialReportsCapital,
              amount: state.balanceSheet.equity,
            ),
          ],
        ),
      ],
    );
  }
}

class _CashFlowSection extends StatelessWidget {
  const _CashFlowSection({required this.state});

  final FinancialReportsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _Section(
      title: l10n.financialReportsOperatingActivities,
      items: state.cashFlow.operatingActivities,
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});

  final String title;
  final List<ReportLine> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(child: Text(item.label)),
                Text(item.amount.toStringAsFixed(0)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
