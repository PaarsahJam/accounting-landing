import 'package:drift/drift.dart';

import 'app_database.dart';

class VendorDao extends DatabaseAccessor<AppDatabase> {
  VendorDao(super.db);

  $VendorsTableTable get _vendors => db.vendorsTable;

  Future<List<VendorsTableData>> getAllVendors() => select(_vendors).get();

  Future<VendorsTableData?> getVendorById(String id) =>
      (select(_vendors)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertVendor(VendorsTableCompanion vendor) =>
      into(_vendors).insert(vendor);

  Future<bool> updateVendor(VendorsTableCompanion vendor) =>
      update(_vendors).replace(vendor);

  Future<int> deleteVendor(String id) =>
      (delete(_vendors)..where((t) => t.id.equals(id))).go();
}