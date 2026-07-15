import 'package:accounting_app/features/customer_statements/data/customer_statements_repository.dart';
import 'package:accounting_app/features/customer_statements/data/customer_statements_repository_provider.dart';
import 'package:accounting_app/features/customer_statements/domain/customer_statements_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerStatementsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          customerStatementsRepositoryProvider.overrideWithValue(
            MockCustomerStatementsRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads customer statements successfully', () async {
      final controller = container.read(
        customerStatementsControllerProvider.notifier,
      );
      final statements = await controller.future;

      expect(statements, isNotEmpty);
      expect(statements.first.customerName, isNotEmpty);
    });
  });
}
