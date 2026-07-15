import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/product.dart';
import '../domain/stock_movement.dart';
import '../domain/warehouse_controller.dart';

class ProductStockDetailPage extends ConsumerStatefulWidget {
  const ProductStockDetailPage({required this.product, super.key});

  final Product product;

  @override
  ConsumerState<ProductStockDetailPage> createState() =>
      _ProductStockDetailPageState();
}

class _ProductStockDetailPageState
    extends ConsumerState<ProductStockDetailPage> {
  late Future<List<StockMovement>> _movementsFuture;

  @override
  void initState() {
    super.initState();
    _movementsFuture = ref
        .read(warehouseControllerProvider.notifier)
        .fetchMovements(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final warehousesAsync = ref.watch(warehouseControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: warehousesAsync.when(
        loading: () => const AppLoadingState(message: 'Loading stock detail'),
        error: (error, stackTrace) => AppErrorState(
          message: '${l10n.inventoryStockDetailLoadError} $error',
        ),
        data: (warehouses) {
          final warehouse = warehouses.isNotEmpty ? warehouses.first : null;

          return FutureBuilder<List<StockMovement>>(
            future: _movementsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AppLoadingState(message: 'Loading movements');
              }
              if (snapshot.hasError) {
                return AppErrorState(
                  message:
                      '${l10n.inventoryStockDetailLoadError} ${snapshot.error}',
                );
              }
              final movements = snapshot.data ?? const <StockMovement>[];
              if (movements.isEmpty) {
                return AppEmptyState(
                  title: l10n.inventoryStockDetailEmptyTitle,
                  message: l10n.inventoryStockDetailEmptyMessage,
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.inventoryStockDetailQuantity,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(widget.product.stockOnHand.toString()),
                          const SizedBox(height: 16),
                          Text(
                            l10n.inventoryStockDetailWarehouse,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            warehouse?.name ??
                                l10n.inventoryStockDetailNoWarehouse,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.inventoryStockDetailMovementHistory,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...movements.map(
                    (movement) => Card(
                      child: ListTile(
                        title: Text('${movement.type} • ${movement.quantity}'),
                        subtitle: Text(movement.description),
                        trailing: Text(
                          '${movement.occurredAt.day}/${movement.occurredAt.month}/${movement.occurredAt.year}',
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
