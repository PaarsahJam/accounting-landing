import 'package:drift/drift.dart';

import 'app_database.dart';

class VendorBillDao extends DatabaseAccessor<AppDatabase> {
  VendorBillDao(super.db);

  $VendorBillTableTable get _bills => db.vendorBillTable;
  $VendorBillLineTableTable get _lines => db.vendorBillLineTable;

  Future<List<VendorBillTableData>> getAllBills(String companyId) =>
      (select(_bills)..where((t) => t.companyId.equals(companyId))).get();

  Future<VendorBillTableData?> getBillById(String id, String companyId) =>
      (select(_bills)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<List<VendorBillLineTableData>> getLinesByBillId(
    String billId,
    String companyId,
  ) =>
      (select(_lines)
            ..where(
              (t) => t.billId.equals(billId) & t.companyId.equals(companyId),
            ))
          .get();

  Future<int> insertBill(VendorBillTableCompanion bill) =>
      into(_bills).insert(bill);

  Future<int> insertLine(VendorBillLineTableCompanion line) =>
      into(_lines).insert(line);

  Future<int> updateBill(VendorBillTableCompanion bill, String companyId) {
    final id = bill.id.value;
    return (update(_bills)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(bill);
  }

  Future<int> deleteBill(String id, String companyId) =>
      (delete(_bills)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  Future<int> deleteLinesByBillId(String billId, String companyId) =>
      (delete(_lines)
            ..where(
              (t) => t.billId.equals(billId) & t.companyId.equals(companyId),
            ))
          .go();
}
