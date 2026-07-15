import 'package:accounting_app/features/customer_payments/data/customer_payments_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomerPaymentsRepository', () {
    late MockCustomerPaymentsRepository repository;

    setUp(() {
      repository = MockCustomerPaymentsRepository();
    });

    test('fetches customer payments from the mock store', () async {
      final result = await repository.fetchCustomerPayments();

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
    });

    test('exposes payment methods and invoices for allocation', () async {
      expect(repository.methods, isNotEmpty);

      final invoicesResult = await repository.fetchSalesInvoices();
      expect(invoicesResult.isSuccess, isTrue);
      expect(invoicesResult.data, isNotEmpty);
    });

    test('creates and deletes a payment', () async {
      final payment = repository.samplePayment();
      final created = await repository.createCustomerPayment(payment);
      expect(created.isSuccess, isTrue);

      final deleted = await repository.deleteCustomerPayment(payment.id);
      expect(deleted.isSuccess, isTrue);
    });
  });
}
