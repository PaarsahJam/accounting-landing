import 'package:accounting_app/features/vendor_statements/data/vendor_statements_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VendorStatementsRepository', () {
    test('loads vendor statements successfully', () async {
      final repository = MockVendorStatementsRepository();

      final result = await repository.fetchVendorStatements();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.first.vendorName, isNotEmpty);
    });
  });
}
