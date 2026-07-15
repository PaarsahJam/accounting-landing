import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/goods_receipt.dart';
import '../domain/goods_receipt_line.dart';
import '../domain/goods_receipt_status.dart';
import '../domain/purchase_order.dart';
import '../domain/purchase_order_line.dart';
import '../domain/purchase_order_status.dart';
import '../domain/purchase_orders_controller.dart';

class PurchaseOrdersPage extends ConsumerStatefulWidget {
  const PurchaseOrdersPage({super.key});

  @override
  ConsumerState<PurchaseOrdersPage> createState() => _PurchaseOrdersPageState();
}

class _PurchaseOrdersPageState extends ConsumerState<PurchaseOrdersPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _vendorController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _search = '';
  String _statusId = 'draft';

  @override
  void dispose() {
    _referenceController.dispose();
    _titleController.dispose();
    _vendorController.dispose();
    _notesController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  PurchaseOrderStatus _statusForSelection(String id) {
    switch (id) {
      case 'approved':
        return const PurchaseOrderStatus(
          id: 'approved',
          label: 'Approved',
          color: 'green',
        );
      case 'ordered':
        return const PurchaseOrderStatus(
          id: 'ordered',
          label: 'Ordered',
          color: 'blue',
        );
      case 'draft':
      default:
        return const PurchaseOrderStatus(
          id: 'draft',
          label: 'Draft',
          color: 'grey',
        );
    }
  }

  Future<void> _submitOrder({PurchaseOrder? existingOrder}) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(purchaseOrdersControllerProvider.notifier);
    final order =
        (existingOrder ??
                PurchaseOrder(
                  id: '',
                  vendorId: '',
                  reference: '',
                  title: '',
                  notes: '',
                  orderDate: DateTime.now(),
                  expectedDate: DateTime.now().add(const Duration(days: 7)),
                  status: const PurchaseOrderStatus(
                    id: 'draft',
                    label: 'Draft',
                    color: 'grey',
                  ),
                  lines: const [],
                ))
            .copyWith(
              id:
                  existingOrder?.id ??
                  'PO-${DateTime.now().millisecondsSinceEpoch}',
              vendorId: _vendorController.text.trim(),
              reference: _referenceController.text.trim(),
              title: _titleController.text.trim(),
              notes: _notesController.text.trim(),
              orderDate: existingOrder?.orderDate ?? DateTime.now(),
              expectedDate:
                  existingOrder?.expectedDate ??
                  DateTime.now().add(const Duration(days: 7)),
              status: _statusForSelection(_statusId),
              lines: [
                PurchaseOrderLine(
                  id: 'POL-${DateTime.now().millisecondsSinceEpoch}',
                  description: _descriptionController.text.trim(),
                  quantity:
                      double.tryParse(_quantityController.text.trim()) ?? 0,
                  unitPrice:
                      double.tryParse(_unitPriceController.text.trim()) ?? 0,
                ),
              ],
            );

    if (existingOrder == null) {
      await controller.createPurchaseOrder(order);
    } else {
      await controller.updatePurchaseOrder(order);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    await controller.refresh();
  }

  Future<void> _showReceiptsSheet(PurchaseOrder order) async {
    final l10n = AppLocalizations.of(context)!;
    final receipt = GoodsReceipt(
      id: 'GR-${DateTime.now().millisecondsSinceEpoch}',
      purchaseOrderId: order.id,
      reference: 'GR-${DateTime.now().millisecondsSinceEpoch}',
      title: '${order.title} receipt',
      receivedAt: DateTime.now(),
      status: const GoodsReceiptStatus(
        id: 'partial',
        label: 'Partial',
        color: 'amber',
      ),
      lines: [
        GoodsReceiptLine(
          purchaseOrderLineId: order.lines.first.id,
          description: order.lines.first.description,
          orderedQuantity: order.lines.first.quantity,
          receivedQuantity: order.lines.first.quantity,
        ),
      ],
    );

    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.purchaseOrderAddTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text('${l10n.purchaseOrderReference}: ${receipt.reference}'),
              const SizedBox(height: 8),
              Text('${l10n.purchaseOrderTitle}: ${receipt.title}'),
              const SizedBox(height: 16),
              Row(
                children: [
                  FilledButton(
                    onPressed: () async {
                      await ref
                          .read(purchaseOrdersControllerProvider.notifier)
                          .refresh();
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Receipts'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      context.push(
                        '/journal-preview/goods_receipt/${receipt.id}',
                      );
                    },
                    child: const Text('Preview'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showOrderDialog({PurchaseOrder? order}) async {
    final l10n = AppLocalizations.of(context)!;

    if (order != null) {
      _referenceController.text = order.reference;
      _titleController.text = order.title;
      _vendorController.text = order.vendorId;
      _notesController.text = order.notes;
      _descriptionController.text = order.lines.first.description;
      _quantityController.text = order.lines.first.quantity.toString();
      _unitPriceController.text = order.lines.first.unitPrice.toString();
      _statusId = order.status.id;
    } else {
      _referenceController.clear();
      _titleController.clear();
      _vendorController.clear();
      _notesController.clear();
      _descriptionController.clear();
      _quantityController.clear();
      _unitPriceController.clear();
      _statusId = 'draft';
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            order == null
                ? l10n.purchaseOrderAddTitle
                : l10n.purchaseOrderEditTitle,
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
                        labelText: l10n.purchaseOrderReference,
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
                        labelText: l10n.purchaseOrderTitle,
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
                        labelText: l10n.purchaseOrderVendor,
                      ),
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: l10n.purchaseOrderLineDescription,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              labelText: l10n.purchaseOrderQuantity,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _unitPriceController,
                            decoration: InputDecoration(
                              labelText: l10n.purchaseOrderUnitPrice,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _statusId,
                      decoration: InputDecoration(
                        labelText: l10n.purchaseOrderStatus,
                      ),
                      items: const [
                        DropdownMenuItem(value: 'draft', child: Text('Draft')),
                        DropdownMenuItem(
                          value: 'approved',
                          child: Text('Approved'),
                        ),
                        DropdownMenuItem(
                          value: 'ordered',
                          child: Text('Ordered'),
                        ),
                      ],
                      onChanged: (value) =>
                          setState(() => _statusId = value ?? 'draft'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: l10n.purchaseOrderNotes,
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
              onPressed: () => _submitOrder(existingOrder: order),
              child: Text(
                order == null
                    ? l10n.purchaseOrderCreate
                    : l10n.purchaseOrderSave,
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
    final ordersAsync = ref.watch(purchaseOrdersControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.purchaseOrdersPageTitle),
        actions: [
          IconButton(
            onPressed: () => _showOrderDialog(),
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.purchaseOrderAddTitle,
          ),
        ],
      ),
      body: ordersAsync.when(
        loading: () =>
            const AppLoadingState(message: 'Loading purchase orders'),
        error: (error, stackTrace) =>
            AppErrorState(message: '${l10n.purchaseOrdersLoadError} $error'),
        data: (orders) {
          final filteredOrders = orders.where((order) {
            final query = _search.toLowerCase();
            return query.isEmpty ||
                order.reference.toLowerCase().contains(query) ||
                order.title.toLowerCase().contains(query);
          }).toList();

          if (filteredOrders.isEmpty) {
            return AppEmptyState(
              title: l10n.purchaseOrdersEmptyTitle,
              message: l10n.purchaseOrdersEmptyMessage,
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.purchaseOrderSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) => setState(() => _search = value),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Card(
                      child: ListTile(
                        title: Text('${order.reference} • ${order.title}'),
                        subtitle: Text('${order.vendorId} • ${order.notes}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Chip(label: Text(order.status.label)),
                            TextButton.icon(
                              onPressed: () => _showReceiptsSheet(order),
                              icon: const Icon(Icons.receipt_long),
                              label: const Text('Receipts'),
                            ),
                            IconButton(
                              onPressed: () => context.push(
                                '/journal-preview/purchase_order/${order.id}',
                              ),
                              icon: const Icon(Icons.preview_outlined),
                              tooltip: 'Journal Preview',
                            ),
                            IconButton(
                              onPressed: () => _showOrderDialog(order: order),
                              icon: const Icon(Icons.edit),
                              tooltip: l10n.purchaseOrderEditTitle,
                            ),
                            IconButton(
                              onPressed: () async => ref
                                  .read(
                                    purchaseOrdersControllerProvider.notifier,
                                  )
                                  .deletePurchaseOrder(order.id),
                              icon: const Icon(Icons.delete),
                              tooltip: l10n.purchaseOrderDeleteTitle,
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
