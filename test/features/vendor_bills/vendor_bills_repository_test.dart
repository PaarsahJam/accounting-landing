import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockVendorBillsRepository', () {
    late MockVendorBillsRepository repository;

    setUp(() {
      repository = MockVendorBillsRepository();
    });

    test('fetches vendor bills', () async {
      final result = await repository.fetchVendorBills();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });
  });
}
