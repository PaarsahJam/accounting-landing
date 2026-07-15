import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository.dart';
import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository_provider.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payments_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VendorPaymentsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          vendorPaymentsRepositoryProvider.overrideWithValue(
            MockVendorPaymentsRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads vendor payments successfully', () async {
      final controller = container.read(
        vendorPaymentsControllerProvider.notifier,
      );
      final payments = await controller.future;

      expect(payments, isNotEmpty);
    });
  });
}
