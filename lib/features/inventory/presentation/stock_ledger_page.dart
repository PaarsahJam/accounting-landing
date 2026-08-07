import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/product.dart';
import '../domain/stock_ledger_controller.dart';
import '../domain/stock_ledger_entry.dart';
import '../domain/stock_movement_type.dart';
import '../domain/warehouse_controller.dart';

class StockLedgerPage extends ConsumerStatefulWidget {
  const StockLedgerPage({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<StockLedgerPage> createState() => _StockLedgerPageState();
}

class _StockLedgerPageState extends ConsumerState<StockLedgerPage> {
  String? _warehouseFilter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ledgerAsync = ref.watch(
      stockLedgerControllerProvider(widget.product.id),
    );
    final warehousesAsync = ref.watch(warehouseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.stockLedgerPageTitle} — ${widget.product.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () => ref
                .read(stockLedgerControllerProvider(widget.product.id).notifier)
                .refresh(),
          ),
        ],
      ),
      body: ledgerAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) =>
            AppErrorState(message: '${l10n.stockLedgerLoadError} $error'),
        data: (ledgerState) {
          // Warehouse filter bar
          final filteredEntries = _warehouseFilter == null
              ? ledgerState.entries
              : ledgerState.entries
                    .where((e) => e.warehouseId == _warehouseFilter)
                    .toList();

          return Column(
            children: [
              _LedgerSummaryBar(ledgerState: ledgerState, l10n: l10n),
              // Warehouse filter
              warehousesAsync.maybeWhen(
                data: (warehouses) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DropdownButtonFormField<String?>(
                    initialValue: _warehouseFilter,
                    decoration: InputDecoration(
                      labelText: l10n.stockLedgerWarehouseFilter,
                      isDense: true,
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: Text(l10n.stockLedgerAllWarehouses),
                      ),
                      ...warehouses.map(
                        (w) =>
                            DropdownMenuItem(value: w.id, child: Text(w.name)),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _warehouseFilter = value);
                      ref
                          .read(
                            stockLedgerControllerProvider(
                              widget.product.id,
                            ).notifier,
                          )
                          .setWarehouseFilter(value);
                    },
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
              Expanded(
                child: filteredEntries.isEmpty
                    ? AppEmptyState(
                        title: l10n.stockLedgerEmptyTitle,
                        message: l10n.stockLedgerEmptyMessage,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: filteredEntries.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final entry = filteredEntries[index];
                          return _LedgerEntryTile(entry: entry);
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

class _LedgerSummaryBar extends StatelessWidget {
  const _LedgerSummaryBar({required this.ledgerState, required this.l10n});

  final StockLedgerState ledgerState;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primaryContainer.withAlpha(60),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _SummaryCell(
            label: l10n.stockLedgerBalance,
            value: ledgerState.currentBalance.toStringAsFixed(2),
          ),
          _SummaryCell(
            label: l10n.stockLedgerTotalIn,
            value: '+${ledgerState.totalInbound.toStringAsFixed(2)}',
            color: Colors.green,
          ),
          _SummaryCell(
            label: l10n.stockLedgerTotalOut,
            value: '-${ledgerState.totalOutbound.toStringAsFixed(2)}',
            color: Colors.red,
          ),
          _SummaryCell(
            label: l10n.stockLedgerTotalValue,
            value: ledgerState.totalValue.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}

class _SummaryCell extends StatelessWidget {
  const _SummaryCell({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _LedgerEntryTile extends StatelessWidget {
  const _LedgerEntryTile({required this.entry});

  final StockLedgerEntry entry;

  Color _typeColor(StockMovementType type) {
    switch (type) {
      case StockMovementType.receipt:
      case StockMovementType.opening:
      case StockMovementType.returnFromCustomer:
        return Colors.green;
      case StockMovementType.issue:
      case StockMovementType.writeOff:
      case StockMovementType.returnToVendor:
        return Colors.red;
      case StockMovementType.transfer:
        return Colors.blue;
      case StockMovementType.adjustment:
        return Colors.orange;
    }
  }

  String _formatDate(BuildContext context, DateTime date) =>
      AppFormatters.formatIsoDate(
        date,
        locale: Localizations.localeOf(context).languageCode,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositive = entry.quantity > 0;
    final typeColor = _typeColor(entry.movementType);

    return ListTile(
      dense: true,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: typeColor.withAlpha(30),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          isPositive ? Icons.add : Icons.remove,
          color: typeColor,
          size: 16,
        ),
      ),
      title: Text(entry.description, style: theme.textTheme.bodySmall),
      subtitle: Text(
        '${entry.movementType.label} · ${_formatDate(context, entry.date)} · Ref: ${entry.reference}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${isPositive ? '+' : ''}${entry.quantity.toStringAsFixed(0)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: typeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Bal: ${entry.runningBalance.toStringAsFixed(0)}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
