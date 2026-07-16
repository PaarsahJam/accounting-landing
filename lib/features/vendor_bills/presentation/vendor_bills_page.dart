import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../purchase_orders/domain/goods_receipt.dart';
import '../data/vendor_bills_repository_provider.dart';
import '../domain/vendor_bill.dart';
import '../domain/vendor_bill_line.dart';
import '../domain/vendor_bill_status.dart';
import '../domain/vendor_bills_controller.dart';

class VendorBillsPage extends ConsumerStatefulWidget {
  const VendorBillsPage({super.key});

  @override
  ConsumerState<VendorBillsPage> createState() => _VendorBillsPageState();
}

class _VendorBillsPageState extends ConsumerState<VendorBillsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _purchaseOrderController =
      TextEditingController();
  final TextEditingController _goodsReceiptController = TextEditingController();
  String _statusId = 'pending';
  String _search = '';

  @override
  void dispose() {
    _referenceController.dispose();
    _titleController.dispose();
    _vendorController.dispose();
    _notesController.dispose();
    _purchaseOrderController.dispose();
    _goodsReceiptController.dispose();
    super.dispose();
  }

  VendorBillStatus _statusForSelection(String id) {
    switch (id) {
      case 'paid':
        return const VendorBillStatus(
          id: 'paid',
          label: 'Paid',
          color: 'green',
        );
      case 'draft':
        return const VendorBillStatus(
          id: 'draft',
          label: 'Draft',
          color: 'grey',
        );
      case 'pending':
      default:
        return const VendorBillStatus(
          id: 'pending',
          label: 'Pending',
          color: 'amber',
        );
    }
  }

  Future<void> _submitBill({VendorBill? existingBill}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(vendorBillsControllerProvider.notifier);
    final bill =
        (existingBill ??
                VendorBill(
                  id: '',
                  vendorId: '',
                  purchaseOrderId: '',
                  goodsReceiptId: '',
                  reference: '',
                  title: '',
                  notes: '',
                  billDate: DateTime.now(),
                  dueDate: DateTime.now().add(const Duration(days: 7)),
                  status: const VendorBillStatus(
                    id: 'pending',
                    label: 'Pending',
                    color: 'amber',
                  ),
                  lines: const [],
                ))
            .copyWith(
              id:
                  existingBill?.id ??
                  'VB-${DateTime.now().millisecondsSinceEpoch}',
              vendorId: _vendorController.text.trim(),
              purchaseOrderId: _purchaseOrderController.text.trim(),
              goodsReceiptId: _goodsReceiptController.text.trim(),
              reference: _referenceController.text.trim(),
              title: _titleController.text.trim(),
              notes: _notesController.text.trim(),
              status: _statusForSelection(_statusId),
              lines: const [
                VendorBillLine(
                  id: 'VBL-1',
                  description: 'Receipt line',
                  quantity: 1,
                  unitPrice: 0,
                ),
              ],
            );

    if (existingBill == null) {
      await controller.createVendorBill(bill);
    } else {
      await controller.updateVendorBill(bill);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showBillDialog({VendorBill? bill}) async {
    final l10n = AppLocalizations.of(context)!;

    if (bill != null) {
      _referenceController.text = bill.reference;
      _titleController.text = bill.title;
      _vendorController.text = bill.vendorId;
      _purchaseOrderController.text = bill.purchaseOrderId;
      _goodsReceiptController.text = bill.goodsReceiptId;
      _notesController.text = bill.notes;
      _statusId = bill.status.id;
    } else {
      _referenceController.clear();
      _titleController.clear();
      _vendorController.clear();
      _purchaseOrderController.clear();
      _goodsReceiptController.clear();
      _notesController.clear();
      _statusId = 'pending';
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            bill == null ? l10n.vendorBillAddTitle : l10n.vendorBillEditTitle,
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
                        labelText: l10n.vendorBillReference,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorBillTitle,
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
                        labelText: l10n.vendorBillVendor,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _purchaseOrderController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorBillPurchaseOrder,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _goodsReceiptController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorBillGoodsReceipt,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _statusId,
                      decoration: InputDecoration(
                        labelText: l10n.vendorBillStatus,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'draft', child: Text('Draft')),
                        DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        DropdownMenuItem(value: 'paid', child: Text('Paid')),
                      ],
                      onChanged: (value) =>
                          setState(() => _statusId = value ?? 'pending'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.vendorBillNotes,
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
              onPressed: () => _submitBill(existingBill: bill),
              child: Text(
                bill == null ? l10n.vendorBillCreate : l10n.vendorBillSave,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createFromGoodsReceipt(GoodsReceipt receipt) async {
    final controller = ref.read(vendorBillsControllerProvider.notifier);
    final bill = VendorBill(
      id: 'VB-${DateTime.now().millisecondsSinceEpoch}',
      vendorId: 'V-1001',
      purchaseOrderId: receipt.purchaseOrderId,
      goodsReceiptId: receipt.id,
      reference: 'VB-${DateTime.now().millisecondsSinceEpoch}',
      title: '${receipt.title} bill',
      notes: 'Created from ${receipt.reference}',
      billDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 14)),
      status: const VendorBillStatus(
        id: 'pending',
        label: 'Pending',
        color: 'amber',
      ),
      lines: receipt.lines
          .map(
            (line) => VendorBillLine(
              id: 'VBL-${DateTime.now().millisecondsSinceEpoch}',
              description: line.description,
              quantity: line.receivedQuantity,
              unitPrice: 0,
            ),
          )
          .toList(),
    );
    await controller.createVendorBill(bill);
    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showCreateFromReceiptDialog() async {
    final repository = ref.read(vendorBillsRepositoryProvider);
    final result = await repository.fetchGoodsReceipts();

    if (!mounted) return;
    if (!result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to load goods receipts')),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create from goods receipt'),
          content: SizedBox(
            width: 320,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: result.data?.length ?? 0,
              itemBuilder: (context, index) {
                final receipt = result.data![index];
                return ListTile(
                  title: Text(receipt.reference),
                  subtitle: Text(receipt.title),
                  onTap: () => _createFromGoodsReceipt(receipt),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final billsAsync = ref.watch(vendorBillsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.vendorBillsPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showCreateFromReceiptDialog(),
            icon: const Icon(Icons.assignment_returned),
            tooltip: l10n.vendorBillCreateFromReceipt,
          ),
          IconButton(
            onPressed: () => _showBillDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.vendorBillAddTitle,
          ),
        ],
      ),
      body: billsAsync.when(
        loading: () => const AppLoadingState(message: 'Loading vendor bills'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.vendorBillsLoadError} $error'),
        data: (bills) {
          final filtered = bills.where((bill) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                bill.reference.toLowerCase().contains(query) ||
                bill.title.toLowerCase().contains(query);
          }).toList();

          if (filtered.isEmpty) {
            return AppEmptyState(
              title: l10n.vendorBillsEmptyTitle,
              message: l10n.vendorBillsEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.vendorBillSearchHint,
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
                    final bill = filtered[index];
                    return Card(
                      child: ListTile(
                        title: Text('${bill.reference} • ${bill.title}'),
                        subtitle: Text('${bill.vendorId} • ${bill.notes}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(label: Text(bill.status.label)),
                            IconButton(
                              onPressed: () => context.push(
                                '/vendor-bills/${bill.id}',
                                extra: bill,
                              ),
                              icon: const Icon(Icons.visibility),
                              tooltip: l10n.vendorBillDetailTitle,
                            ),
                            IconButton(
                              onPressed: () => _showBillDialog(bill: bill),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.vendorBillEditTitle,
                            ),
                            IconButton(
                              onPressed: () async => ref
                                  .read(vendorBillsControllerProvider.notifier)
                                  .deleteVendorBill(bill.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.vendorBillDeleteTitle,
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
