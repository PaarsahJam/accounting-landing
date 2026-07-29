import '../../../core/company/company_id_resolver.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/sales_invoice_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../customers/domain/customer.dart';
import '../domain/sales_invoice.dart';
import '../domain/sales_invoice_line.dart';
import '../domain/sales_invoice_status.dart';
import 'sales_invoices_repository.dart';

/// Tenant-scoped Drift implementation of [SalesInvoicesRepository].
class DriftSalesInvoicesRepository implements SalesInvoicesRepository {
  final AppDatabase _database;
  final CompanyIdResolver _companyId;
  late final SalesInvoiceDao _dao;

  DriftSalesInvoicesRepository({
    AppDatabase? database,
    CompanyIdResolver? companyId,
  })  : _database = database ?? AppDatabase(),
        _companyId = companyId ?? (() => null) {
    _dao = SalesInvoiceDao(_database);
  }

  AppResult<T> _noTenant<T>() =>
      AppResult<T>.failure(const TenantContextFailure());

  @override
  Future<AppResult<List<SalesInvoice>>> fetchSalesInvoices() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await _dao.getAllInvoices(companyId);
      final result = <SalesInvoice>[];
      for (final entry in entries) {
        final lines = await _dao.getLinesByInvoiceId(entry.id, companyId);
        result.add(_toDomain(entry, lines));
      }
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<SalesInvoice>> createSalesInvoice(
    SalesInvoice invoice,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.insertInvoice(_toCompanion(invoice, companyId));
      for (final line in invoice.lines) {
        await _dao.insertLine(_toLineCompanion(line, invoice.id, companyId));
      }
      return AppResult.success(invoice);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<SalesInvoice>> updateSalesInvoice(
    SalesInvoice invoice,
  ) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.updateInvoice(_toCompanion(invoice, companyId), companyId);
      await _dao.deleteLinesByInvoiceId(invoice.id, companyId);
      for (final line in invoice.lines) {
        await _dao.insertLine(_toLineCompanion(line, invoice.id, companyId));
      }
      return AppResult.success(invoice);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteSalesInvoice(String id) async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      await _dao.deleteLinesByInvoiceId(id, companyId);
      await _dao.deleteInvoice(id, companyId);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<Customer>>> fetchCustomers() async {
    final companyId = normalizeCompanyId(_companyId());
    if (companyId == null) return _noTenant();
    try {
      final entries = await (_database.select(_database.customersTable)
            ..where((t) => t.companyId.equals(companyId)))
          .get();
      return AppResult.success(
        entries
            .map((e) => Customer(
                  id: e.id,
                  name: e.name,
                  company: e.company,
                  email: e.email,
                  phone: e.phone,
                  outstandingBalance: e.outstandingBalance,
                  status: e.status,
                  notes: e.notes,
                ))
            .toList(),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<void> close() => _database.close();

  SalesInvoice _toDomain(
    SalesInvoiceTableData entry,
    List<SalesInvoiceLineTableData> lineEntries,
  ) {
    return SalesInvoice(
      id: entry.id,
      customerId: entry.customerId,
      customerName: entry.customerName,
      reference: entry.reference,
      title: entry.title,
      notes: entry.notes,
      invoiceDate: entry.invoiceDate,
      dueDate: entry.dueDate,
      status: SalesInvoiceStatus(
        id: entry.statusId,
        label: entry.statusLabel,
        color: entry.statusColor,
      ),
      lines: lineEntries
          .map((l) => SalesInvoiceLine(
                id: l.id,
                description: l.description,
                quantity: l.quantity,
                unitPrice: l.unitPrice,
              ))
          .toList(),
      subtotal: entry.subtotal,
      tax: entry.tax,
      total: entry.total,
    );
  }

  SalesInvoiceTableCompanion _toCompanion(
    SalesInvoice invoice,
    String companyId,
  ) {
    return SalesInvoiceTableCompanion.insert(
      id: invoice.id,
      companyId: companyId,
      customerId: invoice.customerId,
      customerName: invoice.customerName,
      reference: invoice.reference,
      title: invoice.title,
      notes: invoice.notes,
      invoiceDate: invoice.invoiceDate,
      dueDate: invoice.dueDate,
      statusId: invoice.status.id,
      statusLabel: invoice.status.label,
      statusColor: invoice.status.color,
      subtotal: invoice.subtotal,
      tax: invoice.tax,
      total: invoice.total,
    );
  }

  SalesInvoiceLineTableCompanion _toLineCompanion(
    SalesInvoiceLine line,
    String invoiceId,
    String companyId,
  ) {
    return SalesInvoiceLineTableCompanion.insert(
      id: line.id,
      companyId: companyId,
      invoiceId: invoiceId,
      description: line.description,
      quantity: line.quantity,
      unitPrice: line.unitPrice,
    );
  }
}
