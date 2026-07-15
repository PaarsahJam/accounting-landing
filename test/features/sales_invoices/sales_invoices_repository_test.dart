import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockSalesInvoicesRepository', () {
    late MockSalesInvoicesRepository repository;

    setUp(() {
      repository = MockSalesInvoicesRepository();
    });

    test('fetches sales invoices', () async {
      final result = await repository.fetchSalesInvoices();
      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });
  });
}
