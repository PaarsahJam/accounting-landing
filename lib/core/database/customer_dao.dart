import 'package:drift/drift.dart';

import 'app_database.dart';

/// Tenant-scoped data access for customers.
///
/// Every query is filtered by [companyId]; reads only return rows for the
/// active company, and updates/deletes only affect rows owned by it. The
/// repository layer stamps [CustomersTableCompanion.companyId] on inserts and
/// is responsible for refusing the call when no company is active (fail
/// closed) — the DAO assumes it is handed a valid, non-empty [companyId].
class CustomerDao extends DatabaseAccessor<AppDatabase> {
  CustomerDao(super.db);

  $CustomersTableTable get _customers => db.customersTable;

  Future<List<CustomersTableData>> getAllCustomers(String companyId) =>
      (select(_customers)..where((t) => t.companyId.equals(companyId))).get();

  Future<CustomersTableData?> getCustomerById(String id, String companyId) =>
      (select(_customers)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertCustomer(CustomersTableCompanion customer) =>
      into(_customers).insert(customer);

  /// Updates only when id AND companyId both match, so a caller can never
  /// overwrite another tenant's record by supplying a foreign id.
  Future<int> updateCustomer(
    CustomersTableCompanion customer,
    String companyId,
  ) {
    final id = customer.id.value;
    return (update(_customers)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(customer);
  }

  Future<int> deleteCustomer(String id, String companyId) =>
      (delete(_customers)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();
}
