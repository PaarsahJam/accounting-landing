import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository_provider.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoices_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SalesInvoicesController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          salesInvoicesRepositoryProvider.overrideWithValue(
            MockSalesInvoicesRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads sales invoices successfully', () async {
      final controller = container.read(
        salesInvoicesControllerProvider.notifier,
      );
      final invoices = await controller.future;

      expect(invoices, isNotEmpty);
    });
  });
}
