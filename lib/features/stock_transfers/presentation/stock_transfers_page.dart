import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../inventory/domain/inventory_controller.dart';
import '../../inventory/domain/warehouse_controller.dart';
import '../domain/create_transfer_request.dart';
import '../domain/stock_transfer_record.dart';
import '../domain/stock_transfer_status.dart';
import '../domain/stock_transfers_controller.dart';

class StockTransfersPage extends ConsumerStatefulWidget {
  const StockTransfersPage({super.key});

  @override
  ConsumerState<StockTransfersPage> createState() => _StockTransfersPageState();
}

class _StockTransfersPageState extends ConsumerState<StockTransfersPage> {
  final _formKey = GlobalKey<FormState>();
  String? _productId;
  String? _fromWarehouseId;
  String? _toWarehouseId;
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _showCreateDialog() async {
    final l10n = AppLocalizations.of(context)!;
    _quantityController.clear();
    _notesController.clear();

    final products = await ref.read(inventoryControllerProvider.future);
    final warehouses = await ref.read(warehouseControllerProvider.future);

    if (products.isEmpty || warehouses.isEmpty) return;
    if (!mounted) return;

    setState(() {
      _productId ??= products.first.id;
      _fromWarehouseId ??= warehouses.first.id;
      _toWarehouseId ??= warehouses.length > 1
          ? warehouses[1].id
          : warehouses.first.id;
    });

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(l10n.stockTransferCreateTitle),
              content: SizedBox(
                width: 420,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<String>(
                          initialValue: _productId,
                          decoration: InputDecoration(
                            labelText: l10n.stockTransferProduct,
                          ),
                          items: products
                              .map(
                                (p) => DropdownMenuItem(
                                  value: p.id,
                                  child: Text(p.name),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _productId = v);
                              setDialogState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: _fromWarehouseId,
                          decoration: InputDecoration(
                            labelText: l10n.stockTransferFrom,
                          ),
                          items: warehouses
                              .map(
                                (w) => DropdownMenuItem(
                                  value: w.id,
                                  child: Text(w.name),
                                ),
                              )
                              .toList(),
                          validator: (v) {
                            if (v == null) return l10n.requiredField;
                            if (v == _toWarehouseId) {
                              return l10n.stockTransferSameWarehouseError;
                            }
                            return null;
                          },
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _fromWarehouseId = v);
                              setDialogState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: _toWarehouseId,
                          decoration: InputDecoration(
                            labelText: l10n.stockTransferTo,
                          ),
                          items: warehouses
                              .map(
                                (w) => DropdownMenuItem(
                                  value: w.id,
                                  child: Text(w.name),
                                ),
                              )
                              .toList(),
                          validator: (v) {
                            if (v == null) return l10n.requiredField;
                            if (v == _fromWarehouseId) {
                              return l10n.stockTransferSameWarehouseError;
                            }
                            return null;
                          },
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _toWarehouseId = v);
                              setDialogState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _quantityController,
                          decoration: InputDecoration(
                            labelText: l10n.stockTransferQuantity,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return l10n.requiredField;
                            }
                            final qty = double.tryParse(v.trim());
                            if (qty == null || qty <= 0) {
                              return l10n.stockTransferInvalidQuantity;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesController,
                          decoration: InputDecoration(
                            labelText: l10n.stockTransferNotes,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(l10n.invoiceCancel),
                ),
                FilledButton(
                  onPressed: () => _submitTransfer(dialogContext, l10n),
                  child: Text(l10n.createButton),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _submitTransfer(
    BuildContext dialogContext,
    AppLocalizations l10n,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    final qty = double.tryParse(_quantityController.text.trim()) ?? 0;
    final request = CreateTransferRequest(
      productId: _productId!,
      fromWarehouseId: _fromWarehouseId!,
      toWarehouseId: _toWarehouseId!,
      quantity: qty,
      transferDate: DateTime.now(),
      notes: _notesController.text.trim(),
      createdBy: 'current_user',
    );

    final result = await ref
        .read(stockTransfersControllerProvider.notifier)
        .createTransfer(request);

    if (!dialogContext.mounted) return;

    if (result == null || !result.isSuccess) {
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(
          content: Text(
            result?.error?.message ?? l10n.stockTransferCreateError,
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } else {
      Navigator.of(dialogContext).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final transfersAsync = ref.watch(stockTransfersControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stockTransferPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () =>
                ref.read(stockTransfersControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        tooltip: l10n.stockTransferCreateTitle,
        child: const Icon(Icons.add),
      ),
      body: transfersAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.stockTransferLoadError} $error'),
        data: (transfers) {
          if (transfers.isEmpty) {
            return AppEmptyState(
              title: l10n.stockTransferEmptyTitle,
              message: l10n.stockTransferEmptyMessage,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: transfers.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return _TransferCard(
                transfer: transfers[index],
                l10n: l10n,
                formatDate: _formatDate,
              );
            },
          );
        },
      ),
    );
  }
}

class _TransferCard extends StatelessWidget {
  const _TransferCard({
    required this.transfer,
    required this.l10n,
    required this.formatDate,
  });

  final StockTransferRecord transfer;
  final AppLocalizations l10n;
  final String Function(DateTime) formatDate;

  Color _statusColor(StockTransferStatus status) {
    switch (status) {
      case StockTransferStatus.completed:
        return Colors.green;
      case StockTransferStatus.pending:
        return Colors.orange;
      case StockTransferStatus.cancelled:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _statusColor(transfer.status);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    transfer.reference,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    transfer.status.label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              transfer.productName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.warehouse_outlined,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${transfer.fromWarehouseName} → ${transfer.toWarehouseName}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${l10n.stockTransferQuantity}: ${transfer.quantity.toStringAsFixed(0)}',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  formatDate(transfer.transferDate),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (transfer.notes.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                transfer.notes,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
