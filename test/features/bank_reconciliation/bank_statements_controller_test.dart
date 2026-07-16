import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository.dart';
import 'package:accounting_app/features/bank_reconciliation/data/bank_statement_repository_provider.dart';
import 'package:accounting_app/features/bank_reconciliation/domain/bank_statements_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BankStatementsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          bankStatementRepositoryProvider.overrideWithValue(
            MockBankStatementRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads statements successfully', () async {
      final controller = container.read(
        bankStatementsControllerProvider.notifier,
      );
      final statements = await controller.future;
      expect(statements, isNotEmpty);
    });

    test('state is AsyncData after load', () async {
      container.listen(bankStatementsControllerProvider, (_, _) {});
      final controller = container.read(
        bankStatementsControllerProvider.notifier,
      );
      await controller.future;
      expect(
        container.read(bankStatementsControllerProvider),
        isA<AsyncData<dynamic>>(),
      );
    });

    test('refresh reloads statements', () async {
      container.listen(bankStatementsControllerProvider, (_, _) {});
      final controller = container.read(
        bankStatementsControllerProvider.notifier,
      );
      await controller.future;
      await controller.refresh();
      final statements = container.read(bankStatementsControllerProvider).value;
      expect(statements, isNotEmpty);
    });
  });
}
