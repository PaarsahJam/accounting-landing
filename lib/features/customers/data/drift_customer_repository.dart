import '../../../core/database/app_database.dart';
import '../../../core/database/customer_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/customer.dart';
import 'customer_repository.dart';

class DriftCustomerRepository implements CustomerRepository {
  final AppDatabase _database;
  late final CustomerDao _dao;

  DriftCustomerRepository({AppDatabase? database})
      : _database = database ?? AppDatabase() {
    _dao = CustomerDao(_database);
  }

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    try {
      final entries = await _dao.getAllCustomers();
      return AppResult.success(entries.map(_toDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    try {
      final companion = _toCompanion(customer);
      await _dao.insertCustomer(companion);
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    try {
      final companion = _toCompanion(customer);
      await _dao.updateCustomer(companion);
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    try {
      await _dao.deleteCustomer(id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  Customer _toDomain(CustomersTableData entry) {
    return Customer(
      id: entry.id,
      name: entry.name,
      company: entry.company,
      email: entry.email,
      phone: entry.phone,
      outstandingBalance: entry.outstandingBalance,
      status: entry.status,
      notes: entry.notes,
    );
  }

  CustomersTableCompanion _toCompanion(Customer customer) {
    return CustomersTableCompanion.insert(
      id: customer.id,
      name: customer.name,
      company: customer.company,
      email: customer.email,
      phone: customer.phone,
      outstandingBalance: customer.outstandingBalance,
      status: customer.status,
      notes: customer.notes,
    );
  }
}
