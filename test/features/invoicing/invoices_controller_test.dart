import 'package:accounting_app/features/invoicing/data/invoice_repository.dart';
import 'package:accounting_app/features/invoicing/data/invoice_repository_provider.dart';
import 'package:accounting_app/features/invoicing/domain/invoices_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InvoicesController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          invoiceRepositoryProvider.overrideWithValue(MockInvoiceRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads invoices successfully', () async {
      final controller = container.read(invoicesControllerProvider.notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.id, isNotEmpty);
    });
  });
}
