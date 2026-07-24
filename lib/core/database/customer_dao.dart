import 'package:drift/drift.dart';

import 'app_database.dart';

class CustomerDao extends DatabaseAccessor<AppDatabase> {
  CustomerDao(super.db);

  $CustomersTableTable get _customers => db.customersTable;

  Future<List<CustomersTableData>> getAllCustomers() => select(_customers).get();

  Future<CustomersTableData?> getCustomerById(String id) =>
      (select(_customers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertCustomer(CustomersTableCompanion customer) =>
      into(_customers).insert(customer);

  Future<bool> updateCustomer(CustomersTableCompanion customer) =>
      update(_customers).replace(customer);

  Future<int> deleteCustomer(String id) =>
      (delete(_customers)..where((t) => t.id.equals(id))).go();
}
