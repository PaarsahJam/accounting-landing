import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/customers/data/customer_repository_provider.dart';
import 'package:accounting_app/features/customers/domain/customers_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomersController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          customerRepositoryProvider.overrideWithValue(
            MockCustomerRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads customers successfully', () async {
      final controller = container.read(customersControllerProvider.notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.name, isNotEmpty);
    });
  });
}
