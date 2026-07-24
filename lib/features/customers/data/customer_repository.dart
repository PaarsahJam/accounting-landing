import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/customer.dart';

abstract class CustomerRepository {
  Future<AppResult<List<Customer>>> fetchCustomers();
  Future<AppResult<Customer>> createCustomer(Customer customer);
  Future<AppResult<Customer>> updateCustomer(Customer customer);
  Future<AppResult<void>> deleteCustomer(String id);
}

class MockCustomerRepository implements CustomerRepository {
  final List<Customer> _customers = [
    const Customer(
      id: 'CUST-1001',
      name: 'Ava Rahimi',
      company: 'Northstar Co.',
      email: 'ava@northstar.co',
      phone: '+98 912 000 0001',
      outstandingBalance: 2450000,
      status: 'Active',
      notes: 'Preferred for monthly invoicing',
    ),
    const Customer(
      id: 'CUST-1002',
      name: 'Ben Carter',
      company: 'Maple Leaf Trading',
      email: 'ben@mapleleaf.com',
      phone: '+1 416 555 0102',
      outstandingBalance: 875000,
      status: 'Active',
      notes: '',
    ),
    const Customer(
      id: 'CUST-1003',
      name: 'Clara Wanjiku',
      company: 'Savannah Imports',
      email: 'clara@savannah.co.ke',
      phone: '+254 712 345 678',
      outstandingBalance: 3200000,
      status: 'Active',
      notes: 'Quarterly review required',
    ),
  ];

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_customers));
  }

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _customers.add(customer);
    return AppResult.success(customer);
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _customers.indexWhere((item) => item.id == customer.id);
    if (index >= 0) {
      _customers[index] = customer;
      return AppResult.success(customer);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Customer not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _customers.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _customers.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Customer not found'),
    );
  }
}
