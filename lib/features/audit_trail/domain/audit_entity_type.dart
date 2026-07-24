// lib/features/audit_trail/domain/audit_entity_type.dart

/// The module / entity type that an audit entry belongs to.
enum AuditEntityType {
  salesInvoice,
  vendorBill,
  purchaseOrder,
  goodsReceipt,
  vendorPayment,
  customerPayment,
  customer,
  vendor,
  inventory,
  journalEntry,
  fiscalPeriod,
  financialReport,
  contact,
  crmTask,
  lead,
  opportunity;

  /// Human-readable label for display.
  String get label {
    switch (this) {
      case AuditEntityType.salesInvoice:
        return 'Sales Invoice';
      case AuditEntityType.vendorBill:
        return 'Vendor Bill';
      case AuditEntityType.purchaseOrder:
        return 'Purchase Order';
      case AuditEntityType.goodsReceipt:
        return 'Goods Receipt';
      case AuditEntityType.vendorPayment:
        return 'Vendor Payment';
      case AuditEntityType.customerPayment:
        return 'Customer Payment';
      case AuditEntityType.customer:
        return 'Customer';
      case AuditEntityType.vendor:
        return 'Vendor';
      case AuditEntityType.inventory:
        return 'Inventory';
      case AuditEntityType.journalEntry:
        return 'Journal Entry';
      case AuditEntityType.fiscalPeriod:
        return 'Fiscal Period';
      case AuditEntityType.financialReport:
        return 'Financial Report';
      case AuditEntityType.contact:
        return 'Contact';
      case AuditEntityType.crmTask:
        return 'CRM Task';
      case AuditEntityType.lead:
        return 'Lead';
      case AuditEntityType.opportunity:
        return 'Opportunity';
    }
  }
}
