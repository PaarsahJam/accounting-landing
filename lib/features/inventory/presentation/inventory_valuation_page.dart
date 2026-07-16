import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/inventory_valuation.dart';
import '../domain/inventory_valuation_controller.dart';

class InventoryValuationPage extends ConsumerWidget {
  const InventoryValuationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final valuationAsync = ref.watch(inventoryValuationControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inventoryValuationPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refresh,
            onPressed: () => ref
                .read(inventoryValuationControllerProvider.notifier)
                .refresh(),
          ),
        ],
      ),
      body: valuationAsync.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(
          message: '${l10n.inventoryValuationLoadError} $error',
        ),
        data: (state) {
          if (state.valuations.isEmpty) {
            return AppEmptyState(
              title: l10n.inventoryValuationEmptyTitle,
              message: l10n.inventoryValuationEmptyMessage,
            );
          }

          return Column(
            children: [
              _ValuationSummaryBar(state: state, l10n: l10n),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.valuations.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final val = state.valuations[index];
                    return _ValuationCard(valuation: val, l10n: l10n);
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

class _ValuationSummaryBar extends StatelessWidget {
  const _ValuationSummaryBar({required this.state, required this.l10n});

  final ValuationState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primaryContainer.withAlpha(60),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _Cell(
              label: l10n.inventoryValuationTotalValue,
              value: state.grandTotalValue.toStringAsFixed(2),
              highlight: true,
            ),
          ),
          Expanded(
            child: _Cell(
              label: l10n.inventoryValuationProducts,
              value: state.totalProducts.toString(),
            ),
          ),
          Expanded(
            child: _Cell(
              label: l10n.inventoryValuationWarehouses,
              value: state.totalWarehouses.toString(),
            ),
          ),
          Expanded(
            child: _Cell(
              label: l10n.inventoryValuationDate,
              value:
                  '${state.valuationDate.year}-${state.valuationDate.month.toString().padLeft(2, '0')}-${state.valuationDate.day.toString().padLeft(2, '0')}',
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
            color: highlight ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}

class _ValuationCard extends StatelessWidget {
  const _ValuationCard({required this.valuation, required this.l10n});

  final InventoryValuation valuation;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valuation.productName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${valuation.sku} · ${valuation.warehouseName}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  valuation.totalValue.toStringAsFixed(2),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _DetailChip(
                  label: l10n.inventoryValuationQty,
                  value: valuation.quantityOnHand.toStringAsFixed(0),
                ),
                const SizedBox(width: 8),
                _DetailChip(
                  label: l10n.inventoryValuationAvgCost,
                  value: valuation.averageUnitCost.toStringAsFixed(2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('$label: $value', style: theme.textTheme.labelSmall),
    );
  }
}
