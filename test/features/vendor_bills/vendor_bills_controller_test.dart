import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository_provider.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bills_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VendorBillsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          vendorBillsRepositoryProvider.overrideWithValue(
            MockVendorBillsRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads vendor bills successfully', () async {
      final controller = container.read(vendorBillsControllerProvider.notifier);
      final bills = await controller.future;

      expect(bills, isNotEmpty);
    });
  });
}
