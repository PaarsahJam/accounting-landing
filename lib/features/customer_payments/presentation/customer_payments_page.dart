import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../guidance/domain/concept.dart';
import '../../guidance/presentation/concept_help_button.dart';
import '../../guidance/presentation/guidance_tour_keys.dart';
import '../../workflows/presentation/workflow_keys.dart';
import '../data/customer_payments_repository_provider.dart';
import '../domain/customer_payment.dart';
import '../domain/customer_payment_allocation.dart';
import '../domain/customer_payment_method.dart';
import '../domain/customer_payment_status.dart';
import '../domain/customer_payments_controller.dart';

class CustomerPaymentsPage extends ConsumerStatefulWidget {
  const CustomerPaymentsPage({super.key});

  @override
  ConsumerState<CustomerPaymentsPage> createState() =>
      _CustomerPaymentsPageState();
}

class _CustomerPaymentsPageState extends ConsumerState<CustomerPaymentsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _methodId = 'bank_transfer';
  String _statusId = 'pending';
  String _search = '';
  final List<CustomerPaymentAllocation> _allocations = [];

  @override
  void dispose() {
    _referenceController.dispose();
    _customerController.dispose();
    _notesController.dispose();
    _amountController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  CustomerPaymentMethod _methodForSelection(String id) {
    switch (id) {
      case 'cash':
        return const CustomerPaymentMethod(
          id: 'cash',
          label: 'Cash',
          icon: 'cash',
        );
      case 'check':
        return const CustomerPaymentMethod(
          id: 'check',
          label: 'Check',
          icon: 'receipt_long',
        );
      case 'credit_card':
        return const CustomerPaymentMethod(
          id: 'credit_card',
          label: 'Credit Card',
          icon: 'credit_card',
        );
      case 'bank_transfer':
      default:
        return const CustomerPaymentMethod(
          id: 'bank_transfer',
          label: 'Bank Transfer',
          icon: 'account_balance',
        );
    }
  }

  CustomerPaymentStatus _statusForSelection(String id) {
    switch (id) {
      case 'received':
        return const CustomerPaymentStatus(
          id: 'received',
          label: 'Received',
          color: 'green',
        );
      case 'partial':
        return const CustomerPaymentStatus(
          id: 'partial',
          label: 'Partially Applied',
          color: 'blue',
        );
      case 'pending':
      default:
        return const CustomerPaymentStatus(
          id: 'pending',
          label: 'Pending',
          color: 'amber',
        );
    }
  }

  Future<void> _submitPayment({CustomerPayment? existingPayment}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(customerPaymentsControllerProvider.notifier);
    final payment =
        (existingPayment ??
                CustomerPayment(
                  id: '',
                  customerId: '',
                  customerName: '',
                  reference: '',
                  notes: '',
                  paymentDate: DateTime.now(),
                  receivedAt: DateTime.now(),
                  amount: 0,
                  method: const CustomerPaymentMethod(
                    id: 'bank_transfer',
                    label: 'Bank Transfer',
                    icon: 'account_balance',
                  ),
                  status: const CustomerPaymentStatus(
                    id: 'pending',
                    label: 'Pending',
                    color: 'amber',
                  ),
                  allocations: const [],
                ))
            .copyWith(
              id:
                  existingPayment?.id ??
                  'CP-${DateTime.now().millisecondsSinceEpoch}',
              customerId: _customerController.text.trim(),
              customerName: _customerController.text.trim(),
              reference: _referenceController.text.trim(),
              notes: _notesController.text.trim(),
              amount: double.tryParse(_amountController.text.trim()) ?? 0,
              paymentDate: DateTime.now(),
              receivedAt: DateTime.now(),
              method: _methodForSelection(_methodId),
              status: _statusForSelection(_statusId),
              allocations: _allocations,
            );

    if (existingPayment == null) {
      await controller.createCustomerPayment(payment);
    } else {
      await controller.updateCustomerPayment(payment);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showPaymentDialog({CustomerPayment? payment}) async {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final repository = ref.read(customerPaymentsRepositoryProvider);
    final invoicesResult = await repository.fetchSalesInvoices();

    if (!mounted) return;
    if (payment != null) {
      _referenceController.text = payment.reference;
      _customerController.text = payment.customerName;
      _notesController.text = payment.notes;
      _amountController.text = payment.amount.toString();
      _methodId = payment.method.id;
      _statusId = payment.status.id;
      _allocations
        ..clear()
        ..addAll(payment.allocations);
    } else {
      _referenceController.clear();
      _customerController.clear();
      _notesController.clear();
      _amountController.clear();
      _methodId = 'bank_transfer';
      _statusId = 'pending';
      _allocations.clear();
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            payment == null
                ? l10n.customerPaymentAddTitle
                : l10n.customerPaymentEditTitle,
          ),
          content: SizedBox(
            width: 480,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentReference,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _customerController,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentCustomer,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentAmount,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _methodId,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentMethod,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'cash', child: Text('Cash')),
                        DropdownMenuItem(
                          value: 'bank_transfer',
                          child: Text('Bank Transfer'),
                        ),
                        DropdownMenuItem(value: 'check', child: Text('Check')),
                        DropdownMenuItem(
                          value: 'credit_card',
                          child: Text('Credit Card'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _methodId = value ?? 'bank_transfer'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _statusId,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentStatus,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        DropdownMenuItem(
                          value: 'partial',
                          child: Text('Partially Applied'),
                        ),
                        DropdownMenuItem(
                          value: 'received',
                          child: Text('Received'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _statusId = value ?? 'pending'),
                    ),
                    const SizedBox(height: 12),
                    if (invoicesResult.isSuccess &&
                        (invoicesResult.data?.isNotEmpty ?? false)) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.customerPaymentAllocationsLabel,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: invoicesResult.data!.map((invoice) {
                          final alreadyAllocated = _allocations.any(
                            (item) => item.invoiceId == invoice.id,
                          );
                          return FilterChip(
                            label: Text(
                              '${invoice.reference} • ${invoice.title}',
                            ),
                            selected: alreadyAllocated,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _allocations.add(
                                    CustomerPaymentAllocation(
                                      invoiceId: invoice.id,
                                      invoiceReference: invoice.reference,
                                      amount: invoice.total,
                                    ),
                                  );
                                } else {
                                  _allocations.removeWhere(
                                    (item) => item.invoiceId == invoice.id,
                                  );
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.customerPaymentNotes,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.invoiceCancel),
            ),
            FilledButton(
              onPressed: () => _submitPayment(existingPayment: payment),
              child: Text(
                payment == null
                    ? l10n.customerPaymentCreate
                    : l10n.customerPaymentSave,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final paymentsAsync = ref.watch(customerPaymentsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.customerPaymentsPageTitle,
          key: GuidanceTourKeys.customerPaymentsHeader,
        ),
        actions: [
          ConceptHelpButton(conceptId: ConceptIds.payment),
          IconButton(
            key: WorkflowKeys.customerPaymentsAddButton,
            onPressed: () => _showPaymentDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.customerPaymentAddTitle,
          ),
        ],
      ),
      body: paymentsAsync.when(
        loading: () =>
            const AppLoadingState(message: 'Loading customer payments'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.customerPaymentsLoadError} $error'),
        data: (payments) {
          final filtered = payments.where((payment) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                payment.reference.toLowerCase().contains(query) ||
                payment.customerName.toLowerCase().contains(query);
          }).toList();

          if (filtered.isEmpty) {
            return AppEmptyState(
              title: l10n.customerPaymentsEmptyTitle,
              message: l10n.customerPaymentsEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: l10n.customerPaymentSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final payment = filtered[index];
                    final outstanding = payment.amount;
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${payment.reference} • ${payment.customerName}',
                        ),
                        subtitle: Text(
                          '${payment.amount.toStringAsFixed(0)} • ${payment.allocations.length} allocation(s) • Outstanding ${outstanding.toStringAsFixed(0)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(label: Text(payment.status.label)),
                            IconButton(
                              onPressed: () => context.push(
                                '/customer-payments/${payment.id}',
                                extra: payment,
                              ),
                              icon: const Icon(Icons.visibility),
                              tooltip: l10n.customerPaymentDetailTitle,
                            ),
                            IconButton(
                              onPressed: () =>
                                  _showPaymentDialog(payment: payment),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.customerPaymentEditTitle,
                            ),
                            IconButton(
                              onPressed: () async => ref
                                  .read(
                                    customerPaymentsControllerProvider.notifier,
                                  )
                                  .deleteCustomerPayment(payment.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.customerPaymentDeleteTitle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
