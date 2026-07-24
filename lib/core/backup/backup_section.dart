/// Known section identifiers for backup/restore.
abstract class BackupSections {
  static const String settings = 'settings';
  static const String companies = 'companies';
  static const String attachmentMetadata = 'attachment_metadata';
  static const String auditTrail = 'audit_trail';
  static const String userPreferences = 'user_preferences';
  static const String fiscalPeriods = 'fiscal_periods';
  static const String chartOfAccounts = 'chart_of_accounts';
  static const String generalLedger = 'general_ledger';
  static const String customers = 'customers';
  static const String vendors = 'vendors';
  static const String products = 'products';
  static const String purchaseOrders = 'purchase_orders';
  static const String salesInvoices = 'sales_invoices';
  static const String vendorBills = 'vendor_bills';
  static const String customerPayments = 'customer_payments';
  static const String vendorPayments = 'vendor_payments';
  static const String bankAccounts = 'bank_accounts';
  static const String bankTransactions = 'bank_transactions';
  static const String bankStatements = 'bank_statements';
  static const String journalEntries = 'journal_entries';
  static const String currencies = 'currencies';
  static const String recurringTransactions = 'recurring_transactions';
  static const String fixedAssets = 'fixed_assets';
  static const String tags = 'tags';
  static const String userRoles = 'user_roles';

  /// Core metadata always included.
  static const List<String> coreSections = [
    settings,
    companies,
    userPreferences,
  ];

  /// Operational data sections.
  static const List<String> dataSections = [
    attachmentMetadata,
    auditTrail,
    customers,
    vendors,
    products,
    purchaseOrders,
    salesInvoices,
    vendorBills,
    customerPayments,
    vendorPayments,
    bankAccounts,
    bankTransactions,
    bankStatements,
    journalEntries,
    fiscalPeriods,
    chartOfAccounts,
    generalLedger,
    currencies,
    recurringTransactions,
    fixedAssets,
    tags,
    userRoles,
  ];
}
