import 'package:drift/drift.dart';

import 'app_database.dart';

class SalesInvoiceDao extends DatabaseAccessor<AppDatabase> {
  SalesInvoiceDao(super.db);

  $SalesInvoiceTableTable get _invoices => db.salesInvoiceTable;
  $SalesInvoiceLineTableTable get _lines => db.salesInvoiceLineTable;

  Future<List<SalesInvoiceTableData>> getAllInvoices(String companyId) =>
      (select(_invoices)..where((t) => t.companyId.equals(companyId))).get();

  Future<SalesInvoiceTableData?> getInvoiceById(
    String id,
    String companyId,
  ) =>
      (select(_invoices)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<List<SalesInvoiceLineTableData>> getLinesByInvoiceId(
    String invoiceId,
    String companyId,
  ) =>
      (select(_lines)
            ..where(
              (t) => t.invoiceId.equals(invoiceId) & t.companyId.equals(companyId),
            ))
          .get();

  Future<int> insertInvoice(SalesInvoiceTableCompanion invoice) =>
      into(_invoices).insert(invoice);

  Future<int> insertLine(SalesInvoiceLineTableCompanion line) =>
      into(_lines).insert(line);

  Future<int> updateInvoice(
    SalesInvoiceTableCompanion invoice,
    String companyId,
  ) {
    final id = invoice.id.value;
    return (update(_invoices)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(invoice);
  }

  Future<int> deleteInvoice(String id, String companyId) =>
      (delete(_invoices)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  Future<int> deleteLinesByInvoiceId(String invoiceId, String companyId) =>
      (delete(_lines)
            ..where(
              (t) => t.invoiceId.equals(invoiceId) & t.companyId.equals(companyId),
            ))
          .go();
}
