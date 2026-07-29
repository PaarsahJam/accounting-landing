import 'package:drift/drift.dart';

import 'app_database.dart';

class PurchaseOrderDao extends DatabaseAccessor<AppDatabase> {
  PurchaseOrderDao(super.db);

  $PurchaseOrderTableTable get _orders => db.purchaseOrderTable;
  $PurchaseOrderLineTableTable get _lines => db.purchaseOrderLineTable;

  Future<List<PurchaseOrderTableData>> getAllOrders(String companyId) =>
      (select(_orders)..where((t) => t.companyId.equals(companyId))).get();

  Future<PurchaseOrderTableData?> getOrderById(String id, String companyId) =>
      (select(_orders)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<List<PurchaseOrderLineTableData>> getLinesByOrderId(
    String orderId,
    String companyId,
  ) =>
      (select(_lines)
            ..where(
              (t) => t.purchaseOrderId.equals(orderId) &
                  t.companyId.equals(companyId),
            ))
          .get();

  Future<int> insertOrder(PurchaseOrderTableCompanion order) =>
      into(_orders).insert(order);

  Future<int> insertLine(PurchaseOrderLineTableCompanion line) =>
      into(_lines).insert(line);

  Future<int> updateOrder(
    PurchaseOrderTableCompanion order,
    String companyId,
  ) {
    final id = order.id.value;
    return (update(_orders)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(order);
  }

  Future<int> deleteOrder(String id, String companyId) =>
      (delete(_orders)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  Future<int> deleteLinesByOrderId(String orderId, String companyId) =>
      (delete(_lines)
            ..where(
              (t) => t.purchaseOrderId.equals(orderId) &
                  t.companyId.equals(companyId),
            ))
          .go();
}
