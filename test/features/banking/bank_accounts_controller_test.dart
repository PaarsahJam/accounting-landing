import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/banking/data/banking_repository_provider.dart';
import 'package:accounting_app/features/banking/domain/bank_accounts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BankAccountsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          bankingRepositoryProvider.overrideWithValue(MockBankingRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads bank accounts successfully', () async {
      final controller = container.read(
        bankAccountsControllerProvider.notifier,
      );
      final accounts = await controller.future;
      expect(accounts, isNotEmpty);
    });

    test('state is AsyncData after load', () async {
      // Keep a listener to prevent auto-disposal
      container.listen(bankAccountsControllerProvider, (_, _) {});
      final controller = container.read(
        bankAccountsControllerProvider.notifier,
      );
      await controller.future;
      expect(
        container.read(bankAccountsControllerProvider),
        isA<AsyncData<dynamic>>(),
      );
    });

    test('refresh reloads accounts', () async {
      // Keep a listener to prevent auto-disposal during async refresh
      container.listen(bankAccountsControllerProvider, (_, _) {});
      final controller = container.read(
        bankAccountsControllerProvider.notifier,
      );
      await controller.future;
      await controller.refresh();
      final accounts = container.read(bankAccountsControllerProvider).value;
      expect(accounts, isNotEmpty);
    });
  });
}
