import 'package:accounting_app/features/general_ledger/data/general_ledger_repository.dart';
import 'package:accounting_app/features/general_ledger/domain/account_detail_view_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockGeneralLedgerRepository', () {
    late MockGeneralLedgerRepository repository;

    setUp(() {
      repository = MockGeneralLedgerRepository();
    });

    test('fetches account detail data for a known account', () async {
      final result = await repository.fetchAccountDetail('1');

      expect(result.isSuccess, isTrue);
      final data = result.data as AccountDetailViewData;
      expect(data.account.id, '1');
      expect(data.transactions, isNotEmpty);
    });
  });
}
