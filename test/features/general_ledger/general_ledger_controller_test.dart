import 'package:accounting_app/features/general_ledger/data/general_ledger_repository.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository_provider.dart';
import 'package:accounting_app/features/general_ledger/domain/general_ledger_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneralLedgerController', () {
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

    test('loads ledger view data successfully', () async {
      final controller = container.read(
        generalLedgerControllerProvider.notifier,
      );
      final result = await controller.future;

      expect(result.accounts, isNotEmpty);
      expect(result.entries, isNotEmpty);
      expect(result.trialBalance, isNotEmpty);
    });
  });
}
