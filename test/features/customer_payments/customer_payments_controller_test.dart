import 'package:accounting_app/features/customer_payments/data/customer_payments_repository.dart';
import 'package:accounting_app/features/customer_payments/data/customer_payments_repository_provider.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payments_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerPaymentsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          customerPaymentsRepositoryProvider.overrideWithValue(
            MockCustomerPaymentsRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads customer payments successfully', () async {
      final controller = container.read(
        customerPaymentsControllerProvider.notifier,
      );
      final payments = await controller.future;

      expect(payments, isNotEmpty);
    });
  });
}
