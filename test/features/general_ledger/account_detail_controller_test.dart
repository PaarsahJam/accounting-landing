import 'package:accounting_app/features/general_ledger/data/general_ledger_repository.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository_provider.dart';
import 'package:accounting_app/features/general_ledger/domain/account_detail_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountDetailController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          generalLedgerRepositoryProvider.overrideWithValue(
            MockGeneralLedgerRepository(),
          ),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads account detail data for a ledger account', () async {
      final controller = container.read(
        accountDetailControllerProvider('1').notifier,
      );
      final result = await controller.future;

      expect(result.account.id, '1');
      expect(result.transactions, isNotEmpty);
      expect(result.currentBalance, isNot(0));
    });
  });
}
