import 'package:drift/drift.dart';

import 'app_database.dart';

/// Tenant-scoped data access for vendors. See [CustomerDao] for the scoping
/// contract: every query is filtered by [companyId] and the repository fails
/// closed when no company is active.
class VendorDao extends DatabaseAccessor<AppDatabase> {
  VendorDao(super.db);

  $VendorsTableTable get _vendors => db.vendorsTable;

  Future<List<VendorsTableData>> getAllVendors(String companyId) =>
      (select(_vendors)..where((t) => t.companyId.equals(companyId))).get();

  Future<VendorsTableData?> getVendorById(String id, String companyId) =>
      (select(_vendors)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertVendor(VendorsTableCompanion vendor) =>
      into(_vendors).insert(vendor);

  /// Updates only when id AND companyId both match, preventing cross-tenant
  /// overwrites via a foreign id.
  Future<int> updateVendor(VendorsTableCompanion vendor, String companyId) {
    final id = vendor.id.value;
    return (update(_vendors)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(vendor);
  }

  Future<int> deleteVendor(String id, String companyId) =>
      (delete(_vendors)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();
}
