import 'package:accounting_app/features/vendor_payments/data/vendor_payments_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockVendorPaymentsRepository', () {
    late MockVendorPaymentsRepository repository;

    setUp(() {
      repository = MockVendorPaymentsRepository();
    });

    test('fetches vendor payments', () async {
      final result = await repository.fetchVendorPayments();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('fetches vendor bills for allocation', () async {
      final result = await repository.fetchVendorBills();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });
  });
}
