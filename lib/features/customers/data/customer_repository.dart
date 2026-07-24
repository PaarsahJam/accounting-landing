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
      version: 1,
    ),
    const Customer(
      id: 'CUST-1002',
      name: 'Sina Nouri',
      company: 'Bright Labs',
      email: 'sina@brightlabs.ir',
      phone: '+98 913 000 0002',
      outstandingBalance: 860000,
      status: 'Pending',
      notes: 'Settlement expected next week',
      version: 1,
    ),
  ];

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return AppResult.success(List<Customer>.from(_customers));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _customers.add(customer);
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _customers.indexWhere((item) => item.id == customer.id);
      if (index >= 0) {
        _customers[index] = customer;
      } else {
        _customers.add(customer);
      }
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _customers.removeWhere((item) => item.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
