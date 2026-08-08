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
import '../data/vendor_payments_repository_provider.dart';
import '../domain/vendor_payment.dart';
import '../domain/vendor_payment_allocation.dart';
import '../domain/vendor_payment_method.dart';
import '../domain/vendor_payment_status.dart';
import '../domain/vendor_payments_controller.dart';

class VendorPaymentsPage extends ConsumerStatefulWidget {
  const VendorPaymentsPage({super.key});

  @override
  ConsumerState<VendorPaymentsPage> createState() => _VendorPaymentsPageState();
}

class _VendorPaymentsPageState extends ConsumerState<VendorPaymentsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _methodId = 'bank_transfer';
  String _statusId = 'pending';
  String _search = '';
  final List<VendorPaymentAllocation> _allocations = [];

  @override
  void dispose() {
    _referenceController.dispose();
    _vendorController.dispose();
    _notesController.dispose();
    _amountController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  VendorPaymentMethod _methodForSelection(String id) {
    switch (id) {
      case 'cash':
        return const VendorPaymentMethod(
          id: 'cash',
          label: 'Cash',
          icon: 'cash',
        );
      case 'check':
        return const VendorPaymentMethod(
          id: 'check',
          label: 'Check',
          icon: 'receipt_long',
        );
      case 'credit_card':
        return const VendorPaymentMethod(
          id: 'credit_card',
          label: 'Credit Card',
          icon: 'credit_card',
        );
      case 'bank_transfer':
      default:
        return const VendorPaymentMethod(
          id: 'bank_transfer',
          label: 'Bank Transfer',
          icon: 'account_balance',
        );
    }
  }

  VendorPaymentStatus _statusForSelection(String id) {
    switch (id) {
      case 'paid':
        return const VendorPaymentStatus(
          id: 'paid',
          label: 'Paid',
          color: 'green',
        );
      case 'partial':
        return const VendorPaymentStatus(
          id: 'partial',
          label: 'Partial',
          color: 'blue',
        );
      case 'pending':
      default:
        return const VendorPaymentStatus(
          id: 'pending',
          label: 'Pending',
          color: 'amber',
        );
    }
  }

  double _outstandingBalance(double amount) {
    return amount > 0 ? amount : 0;
  }

  Future<void> _submitPayment({VendorPayment? existingPayment}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(vendorPaymentsControllerProvider.notifier);
    final payment =
        (existingPayment ??
                VendorPayment(
                  id: '',
                  vendorId: '',
                  vendorName: '',
                  reference: '',
                  notes: '',
                  paymentDate: DateTime.now(),
                  createdAt: DateTime.now(),
                  amount: 0,
                  method: const VendorPaymentMethod(
                    id: 'bank_transfer',
                    label: 'Bank Transfer',
                    icon: 'account_balance',
                  ),
                  status: const VendorPaymentStatus(
                    id: 'pending',
                    label: 'Pending',
                    color: 'amber',
                  ),
                  allocations: const [],
                ))
            .copyWith(
              id:
                  existingPayment?.id ??
                  'VP-${DateTime.now().millisecondsSinceEpoch}',
              vendorId: _vendorController.text.trim(),
              vendorName: _vendorController.text.trim(),
              reference: _referenceController.text.trim(),
              notes: _notesController.text.trim(),
              amount: double.tryParse(_amountController.text.trim()) ?? 0,
              paymentDate: DateTime.now(),
              createdAt: DateTime.now(),
              method: _methodForSelection(_methodId),
              status: _statusForSelection(_statusId),
              allocations: _allocations,
            );

    if (existingPayment == null) {
      await controller.createVendorPayment(payment);
    } else {
      await controller.updateVendorPayment(payment);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showPaymentDialog({VendorPayment? payment}) async {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final repository = ref.read(vendorPaymentsRepositoryProvider);
    final billsResult = await repository.fetchVendorBills();

    if (payment != null) {
      _referenceController.text = payment.reference;
      _vendorController.text = payment.vendorName;
      _notesController.text = payment.notes;
      _amountController.text = payment.amount.toString();
      _methodId = payment.method.id;
      _statusId = payment.status.id;
      _allocations
        ..clear()
        ..addAll(payment.allocations);
    } else {
      _referenceController.clear();
      _vendorController.clear();
      _notesController.clear();
      _amountController.clear();
      _methodId = 'bank_transfer';
      _statusId = 'pending';
      _allocations.clear();
    }

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            payment == null
                ? l10n.vendorPaymentAddTitle
                : l10n.vendorPaymentEditTitle,
          ),
          content: SizedBox(
            width: 520,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorPaymentReference,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _vendorController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorPaymentVendor,
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
                        labelText: l10n.vendorPaymentAmount,
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
                        labelText: l10n.vendorPaymentMethod,
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
                        labelText: l10n.vendorPaymentStatus,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        DropdownMenuItem(
                          value: 'partial',
                          child: Text('Partial'),
                        ),
                        DropdownMenuItem(value: 'paid', child: Text('Paid')),
                      ],
                      onChanged: (value) =>
                          setState(() => _statusId = value ?? 'pending'),
                    ),
                    const SizedBox(height: 12),
                    if (billsResult.isSuccess &&
                        (billsResult.data?.isNotEmpty ?? false)) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.vendorPaymentAllocationsLabel,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: billsResult.data!.map((bill) {
                          final alreadyAllocated = _allocations.any(
                            (item) => item.billId == bill.id,
                          );
                          return FilterChip(
                            label: Text('${bill.reference} • ${bill.title}'),
                            selected: alreadyAllocated,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _allocations.add(
                                    VendorPaymentAllocation(
                                      billId: bill.id,
                                      billReference: bill.reference,
                                      amount: bill.lines.isEmpty
                                          ? 0
                                          : bill.lines.first.unitPrice,
                                    ),
                                  );
                                } else {
                                  _allocations.removeWhere(
                                    (item) => item.billId == bill.id,
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
                        labelText: l10n.vendorPaymentNotes,
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
                    ? l10n.vendorPaymentCreate
                    : l10n.vendorPaymentSave,
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
    final paymentsAsync = ref.watch(vendorPaymentsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.vendorPaymentsPageTitle,
          key: GuidanceTourKeys.vendorPaymentsHeader,
        ),
        actions: [
          ConceptHelpButton(conceptId: ConceptIds.payment),
          IconButton(
            onPressed: () => _showPaymentDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.vendorPaymentAddTitle,
          ),
        ],
      ),
      body: paymentsAsync.when(
        loading: () =>
            const AppLoadingState(message: 'Loading vendor payments'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.vendorPaymentsLoadError} $error'),
        data: (payments) {
          final filtered = payments.where((payment) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                payment.reference.toLowerCase().contains(query) ||
                payment.vendorName.toLowerCase().contains(query);
          }).toList();

          if (filtered.isEmpty) {
            return AppEmptyState(
              title: l10n.vendorPaymentsEmptyTitle,
              message: l10n.vendorPaymentsEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: l10n.vendorPaymentSearchHint,
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
                    final outstanding = _outstandingBalance(payment.amount);
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${payment.reference} • ${payment.vendorName}',
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
                                '/vendor-payments/${payment.id}',
                                extra: payment,
                              ),
                              icon: const Icon(Icons.visibility),
                              tooltip: l10n.vendorPaymentDetailTitle,
                            ),
                            IconButton(
                              onPressed: () =>
                                  _showPaymentDialog(payment: payment),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.vendorPaymentEditTitle,
                            ),
                            IconButton(
                              onPressed: () async => ref
                                  .read(
                                    vendorPaymentsControllerProvider.notifier,
                                  )
                                  .deleteVendorPayment(payment.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.vendorPaymentDeleteTitle,
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
