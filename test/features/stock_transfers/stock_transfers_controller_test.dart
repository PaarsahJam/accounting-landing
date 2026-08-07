import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/stock_transfers/data/stock_transfer_repository.dart';
import 'package:accounting_app/features/stock_transfers/data/stock_transfer_repository_provider.dart';
import 'package:accounting_app/features/stock_transfers/domain/create_transfer_request.dart';
import 'package:accounting_app/features/stock_transfers/domain/stock_transfers_controller.dart';
import 'package:accounting_app/features/user_roles/domain/user_roles_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() {
  return ProviderContainer(
    overrides: [
      inventoryRepositoryProvider.overrideWithValue(MockInventoryRepository()),
      auditTrailRepositoryProvider.overrideWithValue(
        MockAuditTrailRepository(),
      ),
      stockTransferRepositoryProvider.overrideWithValue(
        MockStockTransferRepository(
          inventoryRepository: MockInventoryRepository(),
          auditTrailRepository: MockAuditTrailRepository(),
        ),
      ),
    ],
  );
}

/// Loads the signed-in user and built-in roles so the controller-level
/// permission check in [StockTransfersController.createTransfer] passes.
Future<void> loadAuthContext(ProviderContainer container) async {
  container.listen(currentUserControllerProvider, (_, _) {});
  container.listen(rolesControllerProvider, (_, _) {});
  await container.read(currentUserControllerProvider.future);
  await container.read(rolesControllerProvider.future);
}

void main() {
  group('StockTransfersController', () {
    late ProviderContainer container;

    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('builds and returns seeded transfers', () async {
      container.listen(stockTransfersControllerProvider, (_, _) {});
      final notifier = container.read(
        stockTransfersControllerProvider.notifier,
      );
      final transfers = await notifier.future;

      expect(transfers, isNotEmpty);
    });

    test('createTransfer prepends to state on success', () async {
      container.listen(stockTransfersControllerProvider, (_, _) {});
      await loadAuthContext(container);
      final notifier = container.read(
        stockTransfersControllerProvider.notifier,
      );
      final initial = await notifier.future;
      final before = initial.length;

      final result = await notifier.createTransfer(
        CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-002',
          quantity: 1,
          transferDate: DateTime(2026, 6, 1),
          notes: 'Controller test',
          createdBy: 'test',
        ),
      );

      expect(result, isNotNull);
      expect(result!.isSuccess, isTrue);

      final after = container.read(stockTransfersControllerProvider).value!;
      expect(after.length, equals(before + 1));
      expect(after.first.productId, equals('P-1001'));
    });

    test('createTransfer returns failure for same-warehouse request', () async {
      container.listen(stockTransfersControllerProvider, (_, _) {});
      final notifier = container.read(
        stockTransfersControllerProvider.notifier,
      );
      await notifier.future;

      final result = await notifier.createTransfer(
        CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-001',
          quantity: 1,
          transferDate: DateTime(2026, 6, 1),
          notes: '',
          createdBy: 'test',
        ),
      );

      expect(result, isNotNull);
      expect(result!.isSuccess, isFalse);
    });

    test('createTransfer returns failure for zero quantity', () async {
      container.listen(stockTransfersControllerProvider, (_, _) {});
      final notifier = container.read(
        stockTransfersControllerProvider.notifier,
      );
      await notifier.future;

      final result = await notifier.createTransfer(
        CreateTransferRequest(
          productId: 'P-1001',
          fromWarehouseId: 'WH-001',
          toWarehouseId: 'WH-002',
          quantity: 0,
          transferDate: DateTime(2026, 6, 1),
          notes: '',
          createdBy: 'test',
        ),
      );

      expect(result, isNotNull);
      expect(result!.isSuccess, isFalse);
    });

    test('refresh reloads transfers', () async {
      container.listen(stockTransfersControllerProvider, (_, _) {});
      final notifier = container.read(
        stockTransfersControllerProvider.notifier,
      );
      await notifier.future;

      await notifier.refresh();

      final state = container.read(stockTransfersControllerProvider).value;
      expect(state, isNotNull);
      expect(state!, isNotEmpty);
    });
  });
}
