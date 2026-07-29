import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/customer_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/customer.dart';
import 'customer_repository.dart';

/// Tenant-scoped Drift implementation of [CustomerRepository].
///
/// The active company id is resolved lazily per call via [companyId] so a
/// company switch is picked up without rebuilding the database connection.
/// When no company is active the repository fails closed with a
/// [TenantContextFailure] instead of reading or mutating data across tenants.
class DriftCustomerRepository implements CustomerRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final CustomerDao _dao;

  DriftCustomerRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = CustomerDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllCustomers(companyId);
      return AppResult.success(entries.map(_toDomain).toList());
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> createCustomer(Customer customer) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertCustomer(_toCompanion(customer, companyId));
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Customer>> updateCustomer(Customer customer) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateCustomer(_toCompanion(customer, companyId), companyId);
      return AppResult.success(customer);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteCustomer(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteCustomer(id, companyId);
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

  CustomersTableCompanion _toCompanion(Customer customer, String companyId) {
    return CustomersTableCompanion.insert(
      id: customer.id,
      companyId: companyId,
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
