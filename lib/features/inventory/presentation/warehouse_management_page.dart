import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/warehouse_controller.dart';

class WarehouseManagementPage extends ConsumerWidget {
  const WarehouseManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn('en');
    final warehousesAsync = ref.watch(warehouseControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.inventoryWarehousesTitle)),
      body: warehousesAsync.when(
        loading: () => const AppLoadingState(message: 'Loading warehouses'),
        error: (error, stackTrace) => AppErrorState(
          message: '${l10n.inventoryWarehousesLoadError} $error',
        ),
        data: (warehouses) {
          if (warehouses.isEmpty) {
            return AppEmptyState(
              title: l10n.inventoryWarehousesEmptyTitle,
              message: l10n.inventoryWarehousesEmptyMessage,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: warehouses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final warehouse = warehouses[index];
              return Card(
                child: ListTile(
                  title: Text(warehouse.name),
                  subtitle: Text('${warehouse.code} • ${warehouse.location}'),
                  trailing: Icon(
                    warehouse.active
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: warehouse.active ? Colors.green : Colors.grey,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
