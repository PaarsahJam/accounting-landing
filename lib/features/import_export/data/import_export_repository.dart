// lib/features/import_export/data/import_export_repository.dart

import '../../../core/errors/app_result.dart';
import '../../../features/audit_trail/data/audit_trail_repository.dart';
import '../../../features/audit_trail/domain/audit_action.dart';
import '../../../features/audit_trail/domain/audit_entry.dart';
import '../../../features/audit_trail/domain/audit_entity_type.dart';
import '../domain/import_export_job.dart';

abstract class ImportExportRepository {
  /// Export the given entity type to CSV; returns a job record with csvPreview.
  Future<AppResult<ImportExportJob>> exportCsv(ExportEntityType entityType);

  /// Simulate importing a CSV for the given entity type.
  Future<AppResult<ImportExportJob>> importCsv(ExportEntityType entityType);

  /// Return all past jobs, newest first.
  Future<AppResult<List<ImportExportJob>>> listJobs();
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock CSV templates per entity type
// ─────────────────────────────────────────────────────────────────────────────

const _mockCsvData = <ExportEntityType, String>{
  ExportEntityType.customers: '''id,name,company,email,phone,balance
CUST-001,Alice Johnson,Acme Corp,alice@acme.com,+1-555-0001,5000.00
CUST-002,Bob Smith,Beta Ltd,bob@beta.com,+1-555-0002,2300.50
CUST-003,Carol White,Gamma Inc,carol@gamma.com,+1-555-0003,0.00''',

  ExportEntityType.vendors: '''id,company,contact,email,phone,taxId
VND-001,Office Supplies Co,Dave Lee,dave@osc.com,+1-555-1001,TX-001
VND-002,Tech Hardware Ltd,Eve Green,eve@thl.com,+1-555-1002,TX-002''',

  ExportEntityType.products: '''sku,name,category,unit,price,stockOnHand
PRD-001,Printer Paper A4,Stationery,Ream,12.50,200
PRD-002,Laptop Stand,Equipment,Piece,45.00,15
PRD-003,USB-C Hub,Electronics,Piece,29.99,40''',

  ExportEntityType.salesInvoices: '''id,reference,customer,date,total,status
SI-2026-000001,INV-001,Acme Corp,2026-01-10,1500.00,Posted
SI-2026-000002,INV-002,Beta Ltd,2026-01-15,750.00,Draft''',

  ExportEntityType.vendorBills: '''id,reference,vendor,date,total,status
VB-2026-000001,BILL-001,Office Supplies Co,2026-01-08,350.00,Posted
VB-2026-000002,BILL-002,Tech Hardware Ltd,2026-01-12,890.00,Draft''',

  ExportEntityType.inventory: '''warehouse,sku,productName,qty,avgCost,totalValue
WH-001,PRD-001,Printer Paper A4,200,10.00,2000.00
WH-001,PRD-002,Laptop Stand,15,30.00,450.00
WH-002,PRD-003,USB-C Hub,40,20.00,800.00''',

  ExportEntityType.journalEntries: '''id,date,narration,accountCode,debit,credit
JV-2026-000001,2026-01-10,Sales Invoice SI-001,1100,1500.00,0.00
JV-2026-000001,2026-01-10,Sales Invoice SI-001,4000,0.00,1500.00''',

  ExportEntityType.fixedAssets: '''id,code,name,category,purchaseDate,cost,bookValue,method
FA-001,FA-001,Office Computer,Equipment,2022-06-01,1500.00,940.00,Straight Line
FA-002,FA-002,Office Furniture,Furniture,2021-03-15,3000.00,2160.00,Straight Line
FA-003,FA-003,Company Vehicle,Vehicle,2023-01-10,25000.00,20000.00,Declining Balance''',
};

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockImportExportRepository implements ImportExportRepository {
  MockImportExportRepository({AuditTrailRepository? auditRepository})
      : _audit = auditRepository ?? MockAuditTrailRepository();

  final AuditTrailRepository _audit;
  final List<ImportExportJob> _jobs = [];
  int _idCounter = 1;

  String _nextId(String prefix) => '$prefix-${_idCounter++}';

  int _countRows(String csv) {
    // Header row + data rows; subtract 1 for the header
    final lines = csv.trim().split('\n');
    return lines.length > 1 ? lines.length - 1 : 0;
  }

  @override
  Future<AppResult<ImportExportJob>> exportCsv(
    ExportEntityType entityType,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    final csv = _mockCsvData[entityType] ?? 'id,name\n(no data)';
    final rowCount = _countRows(csv);

    final job = ImportExportJob(
      id: _nextId('EXP'),
      entityType: entityType,
      direction: JobDirection.export,
      status: JobStatus.success,
      performedAt: DateTime.now(),
      rowCount: rowCount,
      message: 'Exported $rowCount rows',
      csvPreview: csv,
    );
    _jobs.insert(0, job);

    await _audit.addEntry(AuditEntry(
      id: 'AUD-EXP-${job.id}',
      entityType: AuditEntityType.financialReport,
      entityId: job.id,
      entityLabel: '${entityType.label} CSV export',
      action: AuditAction.exported,
      performedAt: job.performedAt,
      performedBy: 'system',
      note: 'Exported ${entityType.label}: $rowCount rows',
    ));

    return AppResult.success(job);
  }

  @override
  Future<AppResult<ImportExportJob>> importCsv(
    ExportEntityType entityType,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final csv = _mockCsvData[entityType] ?? 'id,name\n(no data)';
    final rowCount = _countRows(csv);

    final job = ImportExportJob(
      id: _nextId('IMP'),
      entityType: entityType,
      direction: JobDirection.import,
      status: JobStatus.success,
      performedAt: DateTime.now(),
      rowCount: rowCount,
      message: 'Imported $rowCount rows (mock)',
    );
    _jobs.insert(0, job);

    await _audit.addEntry(AuditEntry(
      id: 'AUD-IMP-${job.id}',
      entityType: AuditEntityType.financialReport,
      entityId: job.id,
      entityLabel: '${entityType.label} CSV import',
      action: AuditAction.created,
      performedAt: job.performedAt,
      performedBy: 'system',
      note: 'Imported ${entityType.label}: $rowCount rows (mock)',
    ));

    return AppResult.success(job);
  }

  @override
  Future<AppResult<List<ImportExportJob>>> listJobs() async {
    await Future<void>.delayed(const Duration(milliseconds: 60));
    return AppResult.success(List.unmodifiable(_jobs));
  }
}
