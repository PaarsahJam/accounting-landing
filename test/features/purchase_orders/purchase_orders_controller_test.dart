import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository_provider.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_orders_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PurchaseOrdersController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          purchaseOrdersRepositoryProvider.overrideWithValue(
            MockPurchaseOrdersRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads purchase orders successfully', () async {
      final controller = container.read(
        purchaseOrdersControllerProvider.notifier,
      );
      final orders = await controller.future;

      expect(orders, isNotEmpty);
    });
  });
}
