import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/vendor_statement.dart';
import '../domain/vendor_statements_controller.dart';

class VendorStatementsPage extends ConsumerStatefulWidget {
  const VendorStatementsPage({super.key});

  @override
  ConsumerState<VendorStatementsPage> createState() =>
      _VendorStatementsPageState();
}

class _VendorStatementsPageState extends ConsumerState<VendorStatementsPage> {
  String? _selectedVendorId;
  DateTimeRange? _selectedRange;

  VendorStatement? _selectedStatementFor(List<VendorStatement> statements) {
    if (statements.isEmpty) {
      return null;
    }
    _selectedVendorId ??= statements.first.vendorId;
    final matches = statements.where(
      (item) => item.vendorId == _selectedVendorId,
    );
    return matches.isEmpty ? null : matches.first;
  }

  List<VendorStatementEntry> _filteredEntries(VendorStatement statement) {
    if (_selectedRange == null) {
      return statement.entries;
    }
    return statement.entries.where((entry) {
      final inRange =
          !entry.date.isBefore(_selectedRange!.start) &&
          !entry.date.isAfter(_selectedRange!.end);
      return inRange;
    }).toList();
  }

  List<VendorStatementBill> _filteredBills(VendorStatement statement) {
    if (_selectedRange == null) {
      return statement.billHistory;
    }
    return statement.billHistory.where((bill) {
      final inRange =
          !bill.billDate.isBefore(_selectedRange!.start) &&
          !bill.billDate.isAfter(_selectedRange!.end);
      return inRange;
    }).toList();
  }

  List<VendorStatementPayment> _filteredPayments(VendorStatement statement) {
    if (_selectedRange == null) {
      return statement.paymentHistory;
    }
    return statement.paymentHistory.where((payment) {
      final inRange =
          !payment.paymentDate.isBefore(_selectedRange!.start) &&
          !payment.paymentDate.isAfter(_selectedRange!.end);
      return inRange;
    }).toList();
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDateRange: _selectedRange,
    );
    if (picked != null) {
      setState(() => _selectedRange = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final statementsAsync = ref.watch(vendorStatementsControllerProvider);

    return ResponsivePageScaffold(
      title: l10n.vendorStatementsPageTitle,
      child: statementsAsync.when(
        loading: () => const AppLoadingState(message: 'Loading statements'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.vendorStatementsLoadError} $error'),
        data: (statements) {
          if (statements.isEmpty) {
            return AppEmptyState(
              title: l10n.vendorStatementsEmptyTitle,
              message: l10n.vendorStatementsEmptyMessage,
            );
          }

          final selectedStatement = _selectedStatementFor(statements);
          if (selectedStatement == null) {
            return const AppEmptyState(
              title: 'No statement available',
              message: 'Try refreshing the data',
            );
          }

          final visibleEntries = _filteredEntries(selectedStatement);
          final visibleBills = _filteredBills(selectedStatement);
          final visiblePayments = _filteredPayments(selectedStatement);

          return ListView(
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedVendorId,
                              decoration: InputDecoration(
                                labelText: l10n.vendorStatementsSelectVendor,
                              ),
                              items: statements.map((statement) {
                                return DropdownMenuItem<String>(
                                  value: statement.vendorId,
                                  child: Text(statement.vendorName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedVendorId = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: _pickDateRange,
                            icon: const Icon(Icons.date_range),
                            label: Text(
                              _selectedRange == null
                                  ? l10n.vendorStatementsDateRange
                                  : '${_selectedRange!.start.year}/${_selectedRange!.start.month}/${_selectedRange!.start.day} – ${_selectedRange!.end.year}/${_selectedRange!.end.month}/${_selectedRange!.end.day}',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _SummaryCard(
                            title: l10n.vendorStatementsOpeningBalance,
                            value:
                                '${selectedStatement.openingBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.vendorStatementsRunningBalance,
                            value:
                                '${selectedStatement.runningBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.vendorStatementsOutstandingBalance,
                            value:
                                '${selectedStatement.outstandingBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                        ],
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
                      Text(
                        l10n.vendorStatementsBillHistory,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visibleBills.isEmpty)
                        Text(l10n.vendorStatementsNoBills)
                      else
                        ...visibleBills.map(
                          (bill) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${bill.reference} • ${bill.status}',
                                  ),
                                ),
                                Text(
                                  '${bill.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
                                ),
                              ],
                            ),
                          ),
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
                      Text(
                        l10n.vendorStatementsPaymentHistory,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visiblePayments.isEmpty)
                        Text(l10n.vendorStatementsNoPayments)
                      else
                        ...visiblePayments.map(
                          (payment) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${payment.reference} • ${payment.method}',
                                  ),
                                ),
                                Text(
                                  '${payment.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
                                ),
                              ],
                            ),
                          ),
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
                      Text(
                        l10n.vendorStatementsAgingTitle,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedStatement.agingBuckets.map((bucket) {
                          return SizedBox(
                            width: 140,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(bucket.label),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${bucket.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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
                      Text(
                        l10n.vendorStatementsRunningBalance,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visibleEntries.isEmpty)
                        Text(l10n.vendorStatementsNoEntries)
                      else
                        ...visibleEntries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(child: Text(entry.description)),
                                Text(
                                  '${entry.runningBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
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
    return SizedBox(
      width: 180,
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
