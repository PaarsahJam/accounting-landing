// lib/features/import_export/domain/import_export_job.dart

/// The type of entity being exported or imported.
enum ExportEntityType {
  customers,
  vendors,
  products,
  salesInvoices,
  vendorBills,
  inventory,
  journalEntries,
  fixedAssets;

  String get label {
    switch (this) {
      case ExportEntityType.customers:
        return 'Customers';
      case ExportEntityType.vendors:
        return 'Vendors';
      case ExportEntityType.products:
        return 'Products';
      case ExportEntityType.salesInvoices:
        return 'Sales Invoices';
      case ExportEntityType.vendorBills:
        return 'Vendor Bills';
      case ExportEntityType.inventory:
        return 'Inventory';
      case ExportEntityType.journalEntries:
        return 'Journal Entries';
      case ExportEntityType.fixedAssets:
        return 'Fixed Assets';
    }
  }

  String get csvFilename => '${label.toLowerCase().replaceAll(' ', '_')}.csv';
}

/// Whether this is an import or export operation.
enum JobDirection { export, import }

/// Status of a completed job.
enum JobStatus { success, failure }

/// An immutable record of one import or export operation.
class ImportExportJob {
  const ImportExportJob({
    required this.id,
    required this.entityType,
    required this.direction,
    required this.status,
    required this.performedAt,
    this.rowCount = 0,
    this.message,
    this.csvPreview,
  });

  final String id;
  final ExportEntityType entityType;
  final JobDirection direction;
  final JobStatus status;
  final DateTime performedAt;

  /// Number of rows exported / imported.
  final int rowCount;

  /// Human-readable result message.
  final String? message;

  /// First few lines of the CSV (export only, for preview).
  final String? csvPreview;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImportExportJob &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'ImportExportJob($id, ${entityType.label}, $direction, $status)';
}
