import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/stock_adjustment.dart';
import '../domain/stock_adjustment_controller.dart';
import '../domain/warehouse_controller.dart';
import '../domain/inventory_controller.dart';

class StockAdjustmentPage extends ConsumerStatefulWidget {
  const StockAdjustmentPage({super.key});

  @override
  ConsumerState<StockAdjustmentPage> createState() =>
      _StockAdjustmentPageState();
}

class _StockAdjustmentPageState extends ConsumerState<StockAdjustmentPage> {
  final _formKey = GlobalKey<FormState>();
  String _productId = 'P-1001';
  String _warehouseId = 'WH-001';
  final _quantityController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitAdjustment() async {
    if (!_formKey.currentState!.validate()) return;

    final quantity = double.tryParse(_quantityController.text.trim()) ?? 0;
    final records = await ref
        .read(warehouseControllerProvider.notifier)
        .fetchStockRecords(_productId);
    final rec = records.where((r) => r.warehouseId == _warehouseId).firstOrNull;

    final adjustment = StockAdjustment(
      id: 'ADJ-${DateTime.now().millisecondsSinceEpoch}',
      productId: _productId,
      warehouseId: _warehouseId,
      adjustmentDate: DateTime.now(),
      quantityBefore: rec?.quantity ?? 0,
      quantityAdjusted: quantity,
      reason: _reasonController.text.trim(),
      reference: 'ADJ-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      createdBy: 'current_user',
    );

    await ref
        .read(stockAdjustmentControllerProvider.notifier)
        .createAdjustment(adjustment);

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _showAdjustmentDialog() async {
    final l10n = AppLocalizations.of(context)!;
    _quantityController.clear();
    _reasonController.clear();

    final products = await ref.read(inventoryControllerProvider.future);
    final warehouses = await ref.read(warehouseControllerProvider.future);

    if (!mounted) return;
    setState(() {
      _productId = products.isNotEmpty ? products.first.id : 'P-1001';
      _warehouseId = warehouses.isNotEmpty ? warehouses.first.id : 'WH-001';
    });

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.stockAdjustmentCreateTitle),
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
                        labelText: l10n.stockAdjustmentProduct,
                      ),
                      items: products
                          .map(
                            (p) => DropdownMenuItem(
                              value: p.id,
                              child: Text(p.name),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _productId = v ?? _productId),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _warehouseId,
                      decoration: InputDecoration(
                        labelText: l10n.stockAdjustmentWarehouse,
                      ),
                      items: warehouses
                          .map(
                            (w) => DropdownMenuItem(
                              value: w.id,
                              child: Text(w.name),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _warehouseId = v ?? _warehouseId),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: l10n.stockAdjustmentQuantity,
                        helperText: l10n.stockAdjustmentQuantityHint,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.requiredField;
                        }
                        if (double.tryParse(v.trim()) == null) {
                          return l10n.stockAdjustmentInvalidQuantity;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        labelText: l10n.stockAdjustmentReason,
                      ),
                      maxLines: 2,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? l10n.requiredField
                          : null,
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
              onPressed: _submitAdjustment,
              child: Text(l10n.createButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final adjustmentsAsync = ref.watch(stockAdjustmentControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stockAdjustmentPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: l10n.stockAdjustmentCreateTitle,
            onPressed: _showAdjustmentDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () =>
                ref.read(stockAdjustmentControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: adjustmentsAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.stockAdjustmentLoadError} $error'),
        data: (adjustments) {
          if (adjustments.isEmpty) {
            return AppEmptyState(
              title: l10n.stockAdjustmentEmptyTitle,
              message: l10n.stockAdjustmentEmptyMessage,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: adjustments.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final adj = adjustments[index];
              return _AdjustmentCard(adjustment: adj, l10n: l10n);
            },
          );
        },
      ),
    );
  }
}

class _AdjustmentCard extends StatelessWidget {
  const _AdjustmentCard({required this.adjustment, required this.l10n});

  final StockAdjustment adjustment;
  final AppLocalizations l10n;

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = adjustment.quantityAdjusted >= 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (isPositive ? Colors.green : Colors.red).withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isPositive ? Icons.add : Icons.remove,
                color: isPositive ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adjustment.reference,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    adjustment.reason,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${_formatDate(adjustment.adjustmentDate)} · ${adjustment.createdBy}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isPositive ? '+' : ''}${adjustment.quantityAdjusted.toStringAsFixed(0)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  '${adjustment.quantityBefore.toStringAsFixed(0)} → ${adjustment.quantityAfter.toStringAsFixed(0)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
