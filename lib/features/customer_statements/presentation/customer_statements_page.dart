import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/customer_statement.dart';
import '../domain/customer_statements_controller.dart';

class CustomerStatementsPage extends ConsumerStatefulWidget {
  const CustomerStatementsPage({super.key});

  @override
  ConsumerState<CustomerStatementsPage> createState() =>
      _CustomerStatementsPageState();
}

class _CustomerStatementsPageState
    extends ConsumerState<CustomerStatementsPage> {
  String? _selectedCustomerId;
  DateTimeRange? _selectedRange;

  CustomerStatement? _selectedStatementFor(List<CustomerStatement> statements) {
    if (statements.isEmpty) {
      return null;
    }
    if (_selectedCustomerId == null) {
      _selectedCustomerId = statements.first.customerId;
    }
    final matches = statements.where(
      (item) => item.customerId == _selectedCustomerId,
    );
    return matches.isEmpty ? null : matches.first;
  }

  List<CustomerStatementEntry> _filteredEntries(CustomerStatement statement) {
    final entries = statement.entries;
    if (_selectedRange == null) {
      return entries;
    }
    return entries.where((entry) {
      final inRange =
          !entry.date.isBefore(_selectedRange!.start) &&
          !entry.date.isAfter(_selectedRange!.end);
      return inRange;
    }).toList();
  }

  List<CustomerStatementInvoice> _filteredInvoices(
    CustomerStatement statement,
  ) {
    final invoices = statement.invoiceHistory;
    if (_selectedRange == null) {
      return invoices;
    }
    return invoices.where((invoice) {
      final inRange =
          !invoice.invoiceDate.isBefore(_selectedRange!.start) &&
          !invoice.invoiceDate.isAfter(_selectedRange!.end);
      return inRange;
    }).toList();
  }

  List<CustomerStatementPayment> _filteredPayments(
    CustomerStatement statement,
  ) {
    final payments = statement.paymentHistory;
    if (_selectedRange == null) {
      return payments;
    }
    return payments.where((payment) {
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
    final statementsAsync = ref.watch(customerStatementsControllerProvider);

    return ResponsivePageScaffold(
      title: l10n.customerStatementsPageTitle,
      child: statementsAsync.when(
        loading: () => const AppLoadingState(message: 'Loading statements'),
        error: (error, stackTrace) => AppErrorState(
          message: '${l10n.customerStatementsLoadError} $error',
        ),
        data: (statements) {
          if (statements.isEmpty) {
            return AppEmptyState(
              title: l10n.customerStatementsEmptyTitle,
              message: l10n.customerStatementsEmptyMessage,
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
          final visibleInvoices = _filteredInvoices(selectedStatement);
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
                              initialValue: _selectedCustomerId,
                              decoration: InputDecoration(
                                labelText:
                                    l10n.customerStatementsSelectCustomer,
                              ),
                              items: statements.map((statement) {
                                return DropdownMenuItem<String>(
                                  value: statement.customerId,
                                  child: Text(statement.customerName),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() => _selectedCustomerId = value);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: _pickDateRange,
                            icon: const Icon(Icons.date_range),
                            label: Text(
                              _selectedRange == null
                                  ? l10n.customerStatementsDateRange
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
                            title: l10n.customerStatementsOpeningBalance,
                            value:
                                '${selectedStatement.openingBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.customerStatementsRunningBalance,
                            value:
                                '${selectedStatement.runningBalance.toStringAsFixed(0)} ${l10n.currencyUnit}',
                          ),
                          _SummaryCard(
                            title: l10n.customerStatementsOutstandingBalance,
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
                        l10n.customerStatementsInvoiceHistory,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visibleInvoices.isEmpty)
                        Text(l10n.customerStatementsNoInvoices)
                      else
                        ...visibleInvoices.map(
                          (invoice) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${invoice.reference} • ${invoice.status}',
                                  ),
                                ),
                                Text(
                                  '${invoice.amount.toStringAsFixed(0)} ${l10n.currencyUnit}',
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
                        l10n.customerStatementsPaymentHistory,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visiblePayments.isEmpty)
                        Text(l10n.customerStatementsNoPayments)
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
                        l10n.customerStatementsAgingTitle,
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
                        l10n.customerStatementsRunningBalance,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (visibleEntries.isEmpty)
                        Text(l10n.customerStatementsNoEntries)
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
