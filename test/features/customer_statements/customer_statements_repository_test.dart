import 'package:accounting_app/features/customer_statements/data/customer_statements_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerStatementsRepository', () {
    test('loads customer statements successfully', () async {
      final repository = MockCustomerStatementsRepository();

      final result = await repository.fetchCustomerStatements();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.first.customerName, isNotEmpty);
    });
  });
}
