// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Accounting';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get requiredField => 'This field is required';

  @override
  String get signupTodoMessage => 'Sign up is not available yet.';

  @override
  String pageNotFound(Object path) {
    return 'Page not found: $path';
  }

  @override
  String get dashboard => 'Dashboard';

  @override
  String get invoicePageTitle => 'Invoices';

  @override
  String get invoiceAddTitle => 'Add invoice';

  @override
  String get invoiceEditTitle => 'Edit invoice';

  @override
  String get invoiceCustomer => 'Customer name';

  @override
  String get invoiceAmount => 'Amount';

  @override
  String get invoiceStatus => 'Status';

  @override
  String get invoiceDescription => 'Description';

  @override
  String get invoiceCancel => 'Cancel';

  @override
  String get invoiceCreate => 'Create';

  @override
  String get invoiceSave => 'Save';

  @override
  String get invoiceRequiredField => 'This field is required';

  @override
  String get invoiceStatusPending => 'Pending';

  @override
  String get invoiceLoadError => 'Error loading invoices:';

  @override
  String get invoiceEmptyTitle => 'No invoices yet';

  @override
  String get invoiceEmptyMessage => 'No invoices have been registered yet.';

  @override
  String get invoiceEditAction => 'Edit';

  @override
  String get invoiceDeleteAction => 'Delete';

  @override
  String get invoiceCurrencyUnit => 'IRR';

  @override
  String get refresh => 'Refresh';

  @override
  String get dashboardOverview => 'Accounting activity overview';

  @override
  String get dashboardSubtitle => 'Key metrics for the current period';

  @override
  String get dashboardRevenue => 'Revenue';

  @override
  String get dashboardExpenses => 'Expenses';

  @override
  String get dashboardOutstandingInvoices => 'Outstanding invoices';

  @override
  String get dashboardCashFlow => 'Cash flow';

  @override
  String get dashboardLoadError => 'Error loading dashboard data:';

  @override
  String get dashboardLoading => 'Loading dashboard';

  @override
  String get dashboardFinancialSubtitle =>
      'Financial KPIs aggregated from live mock data';

  @override
  String get dashboardAccountsReceivable => 'Accounts Receivable';

  @override
  String get dashboardTotalOutstandingInvoices => 'Total outstanding invoices';

  @override
  String get dashboardOverdueInvoices => 'Overdue invoices';

  @override
  String get dashboardReceivedThisMonth => 'Amount received this month';

  @override
  String get dashboardAccountsPayable => 'Accounts Payable';

  @override
  String get dashboardOutstandingVendorBills => 'Outstanding vendor bills';

  @override
  String get dashboardOverdueBills => 'Overdue bills';

  @override
  String get dashboardPaymentsMadeThisMonth => 'Payments made this month';

  @override
  String get dashboardInventory => 'Inventory';

  @override
  String get dashboardProductCount => 'Number of products';

  @override
  String get dashboardLowStockProducts => 'Low stock products';

  @override
  String get dashboardTotalStockQuantity => 'Total stock quantity';

  @override
  String get dashboardWarehouseCount => 'Warehouse count';

  @override
  String get dashboardCashPosition => 'Cash Position';

  @override
  String get dashboardCash => 'Cash';

  @override
  String get dashboardBank => 'Bank';

  @override
  String get dashboardTotalLiquidAssets => 'Total liquid assets';

  @override
  String get dashboardMonthlyRevenue => 'Monthly Revenue';

  @override
  String get dashboardMonthlyExpenses => 'Monthly Expenses';

  @override
  String get dashboardProfitOverview => 'Profit Overview';

  @override
  String get dashboardGrossProfit => 'Gross Profit';

  @override
  String get dashboardNetProfit => 'Net Profit';

  @override
  String get dashboardRecentActivity => 'Recent Activity';

  @override
  String get dashboardNoRecentActivity => 'No recent activity';

  @override
  String get dashboardQuickActions => 'Quick Actions';

  @override
  String get dashboardCreateSalesInvoice => 'Create Sales Invoice';

  @override
  String get dashboardCreateVendorBill => 'Create Vendor Bill';

  @override
  String get dashboardReceiveCustomerPayment => 'Receive Customer Payment';

  @override
  String get dashboardRecordVendorPayment => 'Record Vendor Payment';

  @override
  String get dashboardViewJournal => 'View Journal';

  @override
  String get dashboardActivityPurchaseOrder => 'Purchase Order';

  @override
  String get dashboardActivityGoodsReceipt => 'Goods Receipt';

  @override
  String get dashboardActivityVendorBill => 'Vendor Bill';

  @override
  String get dashboardActivityVendorPayment => 'Vendor Payment';

  @override
  String get dashboardActivitySalesInvoice => 'Sales Invoice';

  @override
  String get dashboardActivityCustomerPayment => 'Customer Payment';

  @override
  String get dashboardActivityJournalEntry => 'Journal Entry';

  @override
  String get expensesPageTitle => 'Expenses';

  @override
  String get expensesLoadError => 'Error loading expenses:';

  @override
  String get expensesEmptyTitle => 'No expenses available';

  @override
  String get expensesEmptyMessage => 'No expenses have been registered yet.';

  @override
  String get reportsPageTitle => 'Reports';

  @override
  String get reportsLoadError => 'Error loading reports:';

  @override
  String get reportsEmptyTitle => 'No reports available';

  @override
  String get reportsEmptyMessage => 'No reports have been generated yet.';

  @override
  String get financialReportsPageTitle => 'Financial Reports';

  @override
  String get financialReportsLoadingMessage => 'Loading financial reports';

  @override
  String get financialReportsNoReportsTitle => 'No reports available';

  @override
  String get financialReportsNoReportsMessage =>
      'No data is available for the selected period.';

  @override
  String get financialReportsTrialBalance => 'Trial Balance';

  @override
  String get financialReportsBalanceSheet => 'Balance Sheet';

  @override
  String get financialReportsCashFlow => 'Cash Flow';

  @override
  String get financialReportsSearchAccount => 'Search account';

  @override
  String get financialReportsStartLabel => 'Start';

  @override
  String get financialReportsEndLabel => 'End';

  @override
  String get financialReportsFilterAll => 'All';

  @override
  String get financialReportsFilterDebit => 'Debit';

  @override
  String get financialReportsFilterCredit => 'Credit';

  @override
  String get financialReportsArAging => 'AR Aging';

  @override
  String get financialReportsApAging => 'AP Aging';

  @override
  String get financialReportsRevenue => 'Revenue';

  @override
  String get financialReportsExpenses => 'Expenses';

  @override
  String get financialReportsNetProfit => 'Net Profit';

  @override
  String get financialReportsBalanced => 'Balanced';

  @override
  String get financialReportsYes => 'Yes';

  @override
  String get financialReportsNo => 'No';

  @override
  String get financialReportsProfitAndLoss => 'Profit & Loss';

  @override
  String get financialReportsAccountCode => 'Account Code';

  @override
  String get financialReportsAccountName => 'Account Name';

  @override
  String get financialReportsDebit => 'Debit';

  @override
  String get financialReportsCredit => 'Credit';

  @override
  String get financialReportsEndingBalance => 'Ending Balance';

  @override
  String get financialReportsAssets => 'Assets';

  @override
  String get financialReportsLiabilities => 'Liabilities';

  @override
  String get financialReportsEquity => 'Equity';

  @override
  String get financialReportsCash => 'Cash';

  @override
  String get financialReportsBank => 'Bank';

  @override
  String get financialReportsReceivables => 'Receivables';

  @override
  String get financialReportsInventory => 'Inventory';

  @override
  String get financialReportsPayables => 'Payables';

  @override
  String get financialReportsCapital => 'Capital';

  @override
  String get financialReportsOperatingActivities => 'Operating activities';

  @override
  String get reportPeriodLabel => 'Period';

  @override
  String get reportSelectLabel => 'Choose a report';

  @override
  String get supportedFiltersLabel => 'Supported filters';

  @override
  String get exportOptionsLabel => 'Export options';

  @override
  String get mockOnlyLabel => 'Mock only';

  @override
  String get revenueSummaryLabel => 'Revenue';

  @override
  String get expensesSummaryLabel => 'Expenses';

  @override
  String get netIncomeSummaryLabel => 'Net income';

  @override
  String get cashBalanceSummaryLabel => 'Cash balance';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsLoadError => 'Unable to load settings';

  @override
  String get customersPageTitle => 'Customers';

  @override
  String get customersLoadError => 'Error loading customers:';

  @override
  String get customersEmptyTitle => 'No customers available';

  @override
  String get customersEmptyMessage => 'No customers have been registered yet.';

  @override
  String get customerAddTitle => 'Add customer';

  @override
  String get customerEditTitle => 'Edit customer';

  @override
  String get customerName => 'Name';

  @override
  String get customerCompany => 'Company';

  @override
  String get customerEmail => 'Email';

  @override
  String get customerPhone => 'Phone';

  @override
  String get customerBalance => 'Outstanding balance';

  @override
  String get customerStatus => 'Status';

  @override
  String get customerNotes => 'Notes';

  @override
  String get customerCreate => 'Create';

  @override
  String get customerSave => 'Save';

  @override
  String get generalLedgerPageTitle => 'General Ledger';

  @override
  String get generalLedgerLoadError => 'Error loading general ledger:';

  @override
  String get generalLedgerEmptyTitle => 'No ledger data available';

  @override
  String get generalLedgerEmptyMessage => 'No ledger data is available yet.';

  @override
  String get generalLedgerSearchHint => 'Search accounts';

  @override
  String get generalLedgerActive => 'Active';

  @override
  String get generalLedgerInactive => 'Inactive';

  @override
  String get generalLedgerBalanced => 'Balanced';

  @override
  String get generalLedgerUnbalanced => 'Unbalanced';

  @override
  String get chartOfAccountsTitle => 'Chart of Accounts';

  @override
  String get journalEntriesTitle => 'Journal Entries';

  @override
  String get trialBalanceTitle => 'Trial Balance';

  @override
  String get ledgerAccountTypeLabel => 'Type';

  @override
  String get ledgerOpeningBalanceLabel => 'Opening balance';

  @override
  String get ledgerCurrentBalanceLabel => 'Current balance';

  @override
  String get ledgerActiveLabel => 'Active';

  @override
  String get ledgerAccountAsset => 'Asset';

  @override
  String get ledgerAccountLiability => 'Liability';

  @override
  String get ledgerAccountEquity => 'Equity';

  @override
  String get ledgerAccountRevenue => 'Revenue';

  @override
  String get ledgerAccountExpense => 'Expense';

  @override
  String get journalEntryDetailTitle => 'Journal entry';

  @override
  String get journalEntryReferenceLabel => 'Reference';

  @override
  String get journalEntryDateLabel => 'Date';

  @override
  String get journalEntryMemoLabel => 'Memo';

  @override
  String get journalEntryLinesLabel => 'Lines';

  @override
  String get journalEntryNoMemo => 'No memo';

  @override
  String get journalEntryLineDefault => 'Entry line';

  @override
  String get journalEntryDebit => 'Debit';

  @override
  String get journalEntryCredit => 'Credit';

  @override
  String get accountDetailPageTitle => 'Account Detail';

  @override
  String get accountDetailLoadingMessage => 'Loading account detail';

  @override
  String get accountDetailBalanceLabel => 'Current balance';

  @override
  String get accountDetailTransactionsTitle => 'Transactions';

  @override
  String get accountDetailNoTransactionsTitle => 'No transactions';

  @override
  String get accountDetailNoTransactionsMessage =>
      'This account has no transactions yet.';

  @override
  String get trialBalanceDebitLabel => 'Debit';

  @override
  String get trialBalanceCreditLabel => 'Credit';

  @override
  String get inventoryPageTitle => 'Inventory';

  @override
  String get inventoryLoadError => 'Error loading inventory:';

  @override
  String get inventoryEmptyTitle => 'No products available';

  @override
  String get inventoryEmptyMessage => 'No products are available yet.';

  @override
  String get inventorySearchHint => 'Search products';

  @override
  String get inventoryCategoryFilter => 'Category filter';

  @override
  String get inventoryAllCategories => 'All categories';

  @override
  String get inventoryAddProduct => 'Add product';

  @override
  String get inventoryEditProduct => 'Edit product';

  @override
  String get inventoryDeleteProduct => 'Delete product';

  @override
  String get inventoryCreate => 'Create';

  @override
  String get inventorySave => 'Save';

  @override
  String get inventorySku => 'SKU';

  @override
  String get inventoryName => 'Name';

  @override
  String get inventoryDescription => 'Description';

  @override
  String get inventoryCategory => 'Category';

  @override
  String get inventoryUnit => 'Unit';

  @override
  String get inventoryPrice => 'Price';

  @override
  String get inventoryStockOnHand => 'Stock on hand';

  @override
  String get inventoryActive => 'Active';

  @override
  String get inventoryWarehousesTitle => 'Warehouses';

  @override
  String get inventoryWarehousesLoadError => 'Error loading warehouses:';

  @override
  String get inventoryWarehousesEmptyTitle => 'No warehouses available';

  @override
  String get inventoryWarehousesEmptyMessage =>
      'No warehouses are available yet.';

  @override
  String get inventoryStockDetailLoadError => 'Error loading stock detail:';

  @override
  String get inventoryStockDetailEmptyTitle => 'No stock movements';

  @override
  String get inventoryStockDetailEmptyMessage =>
      'This product has no stock movements yet.';

  @override
  String get inventoryStockDetailQuantity => 'Current quantity';

  @override
  String get inventoryStockDetailWarehouse => 'Warehouse';

  @override
  String get inventoryStockDetailMovementHistory => 'Movement history';

  @override
  String get inventoryStockDetailNoWarehouse => 'No warehouse assigned';

  @override
  String get purchaseOrdersPageTitle => 'Purchase Orders';

  @override
  String get purchaseOrdersLoadError => 'Error loading purchase orders:';

  @override
  String get purchaseOrdersEmptyTitle => 'No purchase orders available';

  @override
  String get purchaseOrdersEmptyMessage =>
      'No purchase orders have been registered yet.';

  @override
  String get purchaseOrderAddTitle => 'Add purchase order';

  @override
  String get purchaseOrderEditTitle => 'Edit purchase order';

  @override
  String get purchaseOrderDeleteTitle => 'Delete purchase order';

  @override
  String get purchaseOrderCreate => 'Create';

  @override
  String get purchaseOrderSave => 'Save';

  @override
  String get purchaseOrderReference => 'Reference';

  @override
  String get purchaseOrderTitle => 'Title';

  @override
  String get purchaseOrderVendor => 'Vendor';

  @override
  String get purchaseOrderStatus => 'Status';

  @override
  String get purchaseOrderNotes => 'Notes';

  @override
  String get purchaseOrderLineDescription => 'Line description';

  @override
  String get purchaseOrderQuantity => 'Quantity';

  @override
  String get purchaseOrderUnitPrice => 'Unit price';

  @override
  String get purchaseOrderSearchHint => 'Search purchase orders';

  @override
  String get vendorBillsPageTitle => 'Vendor Bills';

  @override
  String get vendorBillsLoadError => 'Error loading vendor bills:';

  @override
  String get vendorBillsEmptyTitle => 'No vendor bills available';

  @override
  String get vendorBillsEmptyMessage =>
      'No vendor bills have been registered yet.';

  @override
  String get vendorBillAddTitle => 'Add vendor bill';

  @override
  String get vendorBillEditTitle => 'Edit vendor bill';

  @override
  String get vendorBillDetailTitle => 'Vendor bill detail';

  @override
  String get vendorBillDeleteTitle => 'Delete vendor bill';

  @override
  String get vendorBillCreate => 'Create';

  @override
  String get vendorBillSave => 'Save';

  @override
  String get vendorBillReference => 'Reference';

  @override
  String get vendorBillTitle => 'Title';

  @override
  String get vendorBillVendor => 'Vendor';

  @override
  String get vendorBillPurchaseOrder => 'Purchase order';

  @override
  String get vendorBillGoodsReceipt => 'Goods receipt';

  @override
  String get vendorBillStatus => 'Status';

  @override
  String get vendorBillNotes => 'Notes';

  @override
  String get vendorBillSearchHint => 'Search vendor bills';

  @override
  String get vendorBillCreateFromReceipt => 'Create from goods receipt';

  @override
  String get vendorBillLinesLabel => 'Lines';

  @override
  String get salesInvoicesPageTitle => 'Sales Invoices';

  @override
  String get salesInvoicesLoadError => 'Error loading sales invoices:';

  @override
  String get salesInvoicesEmptyTitle => 'No sales invoices available';

  @override
  String get salesInvoicesEmptyMessage =>
      'No sales invoices have been registered yet.';

  @override
  String get salesInvoiceAddTitle => 'Add sales invoice';

  @override
  String get salesInvoiceEditTitle => 'Edit sales invoice';

  @override
  String get salesInvoiceDetailTitle => 'Sales invoice detail';

  @override
  String get salesInvoiceDeleteTitle => 'Delete sales invoice';

  @override
  String get salesInvoiceCreate => 'Create';

  @override
  String get salesInvoiceSave => 'Save';

  @override
  String get salesInvoiceReference => 'Reference';

  @override
  String get salesInvoiceTitle => 'Title';

  @override
  String get salesInvoiceCustomer => 'Customer';

  @override
  String get salesInvoiceDueDate => 'Due date';

  @override
  String get salesInvoiceStatus => 'Status';

  @override
  String get salesInvoiceNotes => 'Notes';

  @override
  String get salesInvoiceLinesLabel => 'Lines';

  @override
  String get salesInvoiceAddLine => 'Add line';

  @override
  String get salesInvoiceSearchHint => 'Search sales invoices';

  @override
  String get salesInvoiceSubtotal => 'Subtotal';

  @override
  String get salesInvoiceTax => 'Tax';

  @override
  String get salesInvoiceTotal => 'Total';

  @override
  String get customerPaymentsPageTitle => 'Customer Payments';

  @override
  String get customerPaymentsLoadError => 'Error loading customer payments:';

  @override
  String get customerPaymentsEmptyTitle => 'No customer payments available';

  @override
  String get customerPaymentsEmptyMessage =>
      'No customer payments have been registered yet.';

  @override
  String get customerPaymentAddTitle => 'Add customer payment';

  @override
  String get customerPaymentEditTitle => 'Edit customer payment';

  @override
  String get customerPaymentDetailTitle => 'Customer payment detail';

  @override
  String get customerPaymentDeleteTitle => 'Delete customer payment';

  @override
  String get customerPaymentCreate => 'Create';

  @override
  String get customerPaymentSave => 'Save';

  @override
  String get customerPaymentReference => 'Reference';

  @override
  String get customerPaymentCustomer => 'Customer';

  @override
  String get customerPaymentAmount => 'Amount';

  @override
  String get customerPaymentMethod => 'Method';

  @override
  String get customerPaymentStatus => 'Status';

  @override
  String get customerPaymentNotes => 'Notes';

  @override
  String get customerPaymentSearchHint => 'Search customer payments';

  @override
  String get customerPaymentAllocationsLabel => 'Allocations';

  @override
  String get customerPaymentAllocationAmount => 'Allocated amount';

  @override
  String get customerStatementsPageTitle => 'Customer Statements';

  @override
  String get customerStatementsLoadError =>
      'Error loading customer statements:';

  @override
  String get customerStatementsEmptyTitle => 'No customer statements available';

  @override
  String get customerStatementsEmptyMessage =>
      'No statements have been generated yet.';

  @override
  String get customerStatementsSelectCustomer => 'Select customer';

  @override
  String get customerStatementsDateRange => 'Date range';

  @override
  String get customerStatementsOpeningBalance => 'Opening balance';

  @override
  String get customerStatementsRunningBalance => 'Running balance';

  @override
  String get customerStatementsOutstandingBalance => 'Outstanding balance';

  @override
  String get customerStatementsInvoiceHistory => 'Invoice history';

  @override
  String get customerStatementsPaymentHistory => 'Payment history';

  @override
  String get customerStatementsAgingTitle => 'Accounts receivable aging';

  @override
  String get customerStatementsNoInvoices => 'No invoices found';

  @override
  String get customerStatementsNoPayments => 'No payments found';

  @override
  String get customerStatementsNoEntries => 'No entries in the selected range';

  @override
  String get vendorPaymentsPageTitle => 'Vendor Payments';

  @override
  String get vendorPaymentsLoadError => 'Error loading vendor payments:';

  @override
  String get vendorPaymentsEmptyTitle => 'No vendor payments available';

  @override
  String get vendorPaymentsEmptyMessage =>
      'No vendor payments have been registered yet.';

  @override
  String get vendorPaymentAddTitle => 'Add vendor payment';

  @override
  String get vendorPaymentEditTitle => 'Edit vendor payment';

  @override
  String get vendorPaymentDetailTitle => 'Vendor payment detail';

  @override
  String get vendorPaymentDeleteTitle => 'Delete vendor payment';

  @override
  String get vendorPaymentCreate => 'Create';

  @override
  String get vendorPaymentSave => 'Save';

  @override
  String get vendorPaymentReference => 'Reference';

  @override
  String get vendorPaymentVendor => 'Vendor';

  @override
  String get vendorPaymentAmount => 'Amount';

  @override
  String get vendorPaymentMethod => 'Method';

  @override
  String get vendorPaymentStatus => 'Status';

  @override
  String get vendorPaymentNotes => 'Notes';

  @override
  String get vendorPaymentSearchHint => 'Search vendor payments';

  @override
  String get vendorPaymentAllocationsLabel => 'Allocations';

  @override
  String get vendorPaymentAllocationAmount => 'Allocated amount';

  @override
  String get vendorStatementsPageTitle => 'Vendor Statements';

  @override
  String get vendorStatementsLoadError => 'Error loading vendor statements:';

  @override
  String get vendorStatementsEmptyTitle => 'No vendor statements available';

  @override
  String get vendorStatementsEmptyMessage =>
      'No statements have been generated yet.';

  @override
  String get vendorStatementsSelectVendor => 'Select vendor';

  @override
  String get vendorStatementsDateRange => 'Date range';

  @override
  String get vendorStatementsOpeningBalance => 'Opening balance';

  @override
  String get vendorStatementsRunningBalance => 'Running balance';

  @override
  String get vendorStatementsOutstandingBalance => 'Outstanding balance';

  @override
  String get vendorStatementsBillHistory => 'Bill history';

  @override
  String get vendorStatementsPaymentHistory => 'Payment history';

  @override
  String get vendorStatementsAgingTitle => 'Accounts payable aging';

  @override
  String get vendorStatementsNoBills => 'No bills found';

  @override
  String get vendorStatementsNoPayments => 'No payments found';

  @override
  String get vendorStatementsNoEntries => 'No entries in the selected range';

  @override
  String get journalPreviewPageTitle => 'Journal Preview';

  @override
  String get journalPreviewLoadError => 'Unable to load the journal preview.';

  @override
  String get journalPreviewEmptyTitle => 'No preview available';

  @override
  String get journalPreviewEmptyMessage =>
      'The selected document does not have a journal preview yet.';

  @override
  String get journalPreviewDocument => 'Document';

  @override
  String get journalPreviewPostingDate => 'Posting date';

  @override
  String get journalPreviewNarration => 'Narration';

  @override
  String get journalPreviewLinesLabel => 'Posting lines';

  @override
  String get journalExplorerPageTitle => 'General Journal';

  @override
  String get journalExplorerLoadError => 'Unable to load the general journal.';

  @override
  String get journalExplorerEmptyTitle => 'No journal entries found';

  @override
  String get journalExplorerEmptyMessage =>
      'No journal entries match the current filters.';

  @override
  String get journalExplorerSearchHint => 'Search journal or reference';

  @override
  String get journalExplorerSourceType => 'Source type';

  @override
  String get journalExplorerAccountCode => 'Account code';

  @override
  String get journalExplorerSortBy => 'Sort by';

  @override
  String get journalExplorerNewest => 'Newest';

  @override
  String get journalExplorerOldest => 'Oldest';

  @override
  String get journalExplorerDateRange => 'Date range';

  @override
  String get journalExplorerPostingDate => 'Posting date';

  @override
  String get journalExplorerNarration => 'Narration';

  @override
  String get journalExplorerPostingStatus => 'Posting status';

  @override
  String get journalExplorerTotalDebit => 'Total debit';

  @override
  String get journalExplorerTotalCredit => 'Total credit';

  @override
  String get journalExplorerLinesLabel => 'Journal lines';

  @override
  String get journalExplorerLoading => 'Loading journals';

  @override
  String get journalExplorerSourceAll => 'All';

  @override
  String get journalExplorerSourcePurchaseOrder => 'Purchase Order';

  @override
  String get journalExplorerSourceGoodsReceipt => 'Goods Receipt';

  @override
  String get journalExplorerSourceVendorBill => 'Vendor Bill';

  @override
  String get journalExplorerSourceVendorPayment => 'Vendor Payment';

  @override
  String get journalExplorerSourceSalesInvoice => 'Sales Invoice';

  @override
  String get journalExplorerSourceCustomerPayment => 'Customer Payment';

  @override
  String get journalExplorerViewSource => 'View source document';

  @override
  String get vendorsPageTitle => 'Vendors';

  @override
  String get vendorsLoadError => 'Error loading vendors:';

  @override
  String get vendorsEmptyTitle => 'No vendors available';

  @override
  String get vendorsEmptyMessage => 'No vendors have been registered yet.';

  @override
  String get vendorAddTitle => 'Add vendor';

  @override
  String get vendorEditTitle => 'Edit vendor';

  @override
  String get vendorCompanyName => 'Company name';

  @override
  String get vendorContactName => 'Contact name';

  @override
  String get vendorEmail => 'Email';

  @override
  String get vendorPhone => 'Phone';

  @override
  String get vendorAddress => 'Address';

  @override
  String get vendorTaxIdentifier => 'Tax identifier';

  @override
  String get vendorActiveStatus => 'Active';

  @override
  String get vendorNotes => 'Notes';

  @override
  String get vendorSearchHint => 'Search vendors';

  @override
  String get vendorStatusLabel => 'Status';

  @override
  String get vendorActive => 'Active';

  @override
  String get vendorInactive => 'Inactive';

  @override
  String get vendorCreate => 'Create';

  @override
  String get vendorSave => 'Save';

  @override
  String get currencyUnit => 'IRR';

  @override
  String get bankReconciliationPageTitle => 'Bank Reconciliation';

  @override
  String get bankReconciliationLoadError =>
      'Unable to load reconciliation data:';

  @override
  String get bankAccountSelector => 'Bank account';

  @override
  String get bankReconciliationSummary => 'Reconciliation summary';

  @override
  String get bankMatchedTransactions => 'Matched transactions';

  @override
  String get bankUnmatchedTransactions => 'Unmatched transactions';

  @override
  String get bankProgress => 'Progress';

  @override
  String get bankNoTransactions => 'No transactions found';

  @override
  String get bankNoTransactionsMessage =>
      'No transactions are available for this account yet.';

  @override
  String get bankFinalize => 'Finalize reconciliation';

  @override
  String get bankCompletionDialogTitle => 'Reconciliation complete';

  @override
  String get bankCompletionDialogMessage =>
      'The reconciliation session has been completed.';

  @override
  String get bankDone => 'Done';

  @override
  String get fiscalYearsPageTitle => 'Fiscal Years';

  @override
  String get fiscalPeriodsPageTitle => 'Fiscal Periods';

  @override
  String get yearEndClosingPageTitle => 'Year-End Closing';

  @override
  String get createButton => 'Create';

  @override
  String get draft => 'Draft';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String get approved => 'Approved';

  @override
  String get posted => 'Posted';

  @override
  String get locked => 'Locked';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get documentNumberLabel => 'Document Number';

  @override
  String get documentStatusLabel => 'Status';

  @override
  String get documentCreatedAtLabel => 'Created';

  @override
  String get documentApprovedAtLabel => 'Approved';

  @override
  String get documentPostedAtLabel => 'Posted';

  @override
  String get approvalTimelineTitle => 'Approval Timeline';

  @override
  String get documentTypeLabel => 'Type';

  @override
  String get workflowInvalidTransition => 'Invalid transition';

  @override
  String get workflowTransitionToPendingApproval => 'Submit for Approval';

  @override
  String get workflowTransitionToApproved => 'Approve';

  @override
  String get workflowTransitionToPosted => 'Post';

  @override
  String get workflowTransitionToLocked => 'Lock';

  @override
  String get workflowTransitionToCancelled => 'Cancel';

  @override
  String get approvalWorkflowPageTitle => 'Document Workflow';

  @override
  String get approvalWorkflowLoadError => 'Error loading documents:';

  @override
  String get approvalWorkflowEmptyTitle => 'No documents available';

  @override
  String get approvalWorkflowEmptyMessage =>
      'No documents have been registered yet.';

  @override
  String get auditTrailPageTitle => 'Audit Trail';

  @override
  String get auditTrailLoadError => 'Error loading audit trail:';

  @override
  String get auditTrailEmptyTitle => 'No activity recorded yet';

  @override
  String get auditTrailEmptyMessage =>
      'No activity has been recorded for this document yet.';

  @override
  String get auditTrailFilterAll => 'All';

  @override
  String auditTrailPerformedBy(String user) {
    return 'by $user';
  }

  @override
  String get auditActionCreated => 'Created';

  @override
  String get auditActionEdited => 'Edited';

  @override
  String get auditActionDeleted => 'Deleted';

  @override
  String get auditActionSubmittedForApproval => 'Submitted for Approval';

  @override
  String get auditActionApproved => 'Approved';

  @override
  String get auditActionRejected => 'Rejected';

  @override
  String get auditActionPosted => 'Posted';

  @override
  String get auditActionLocked => 'Locked';

  @override
  String get auditActionCancelled => 'Cancelled';

  @override
  String get auditActionReopened => 'Reopened';

  @override
  String get auditActionPaid => 'Paid';

  @override
  String get auditActionPartiallyPaid => 'Partially Paid';

  @override
  String get auditActionRefunded => 'Refunded';

  @override
  String get auditActionPrinted => 'Printed';

  @override
  String get auditActionExported => 'Exported';

  @override
  String get auditActionStockAdjusted => 'Stock Adjusted';

  @override
  String get auditActionStockTransferred => 'Stock Transferred';

  @override
  String get auditActionStockCounted => 'Stock Counted';

  @override
  String get auditActionJournalGenerated => 'Journal Generated';

  @override
  String get auditActionJournalReviewed => 'Journal Reviewed';

  @override
  String get auditActionAddressChanged => 'Address Changed';

  @override
  String get auditActionContactChanged => 'Contact Changed';

  @override
  String get auditActionArchived => 'Archived';

  @override
  String get auditActionUnarchived => 'Unarchived';

  @override
  String get auditActionPeriodOpened => 'Period Opened';

  @override
  String get auditActionPeriodClosed => 'Period Closed';

  @override
  String get auditEntitySalesInvoice => 'Sales Invoice';

  @override
  String get auditEntityVendorBill => 'Vendor Bill';

  @override
  String get auditEntityPurchaseOrder => 'Purchase Order';

  @override
  String get auditEntityGoodsReceipt => 'Goods Receipt';

  @override
  String get auditEntityVendorPayment => 'Vendor Payment';

  @override
  String get auditEntityCustomerPayment => 'Customer Payment';

  @override
  String get auditEntityCustomer => 'Customer';

  @override
  String get auditEntityVendor => 'Vendor';

  @override
  String get auditEntityInventory => 'Inventory';

  @override
  String get auditEntityJournalEntry => 'Journal Entry';

  @override
  String get auditEntityFiscalPeriod => 'Fiscal Period';

  @override
  String get auditEntityFinancialReport => 'Financial Report';

  @override
  String get bankAccountsPageTitle => 'Bank Accounts';

  @override
  String get bankAccountsLoadError => 'Error loading bank accounts:';

  @override
  String get bankAccountsEmptyTitle => 'No bank accounts found';

  @override
  String get bankAccountsEmptyMessage =>
      'No bank accounts have been registered yet.';

  @override
  String get bankAccountsSearchHint => 'Search accounts';

  @override
  String get bankAccountsBalanceLabel => 'Current Balance';

  @override
  String get bankAccountsTypeChecking => 'Checking';

  @override
  String get bankAccountsTypeSavings => 'Savings';

  @override
  String get bankAccountsTypeCash => 'Cash';

  @override
  String get bankAccountsTypeCreditCard => 'Credit Card';

  @override
  String get bankAccountsStatusActive => 'Active';

  @override
  String get bankAccountsStatusInactive => 'Inactive';

  @override
  String get bankAccountsStatusFrozen => 'Frozen';

  @override
  String get bankTransactionsPageTitle => 'Transactions';

  @override
  String get bankTransactionsLoadError => 'Error loading transactions:';

  @override
  String get bankTransactionsEmptyTitle => 'No transactions found';

  @override
  String get bankTransactionsEmptyMessage =>
      'No transactions are available for this account yet.';

  @override
  String get bankTransactionsSearchHint => 'Search transactions';

  @override
  String get bankTransactionsAllTypes => 'All types';

  @override
  String get bankTransactionTypeDeposit => 'Deposit';

  @override
  String get bankTransactionTypeWithdrawal => 'Withdrawal';

  @override
  String get bankTransactionTypeTransfer => 'Transfer';

  @override
  String get bankTransactionTypeInterest => 'Interest';

  @override
  String get bankTransactionTypeBankFee => 'Bank Fee';

  @override
  String get bankTransactionTypeAdjustment => 'Adjustment';

  @override
  String get bankTransactionRunningBalance => 'Running balance';

  @override
  String get bankTransactionDate => 'Date';

  @override
  String get bankTransactionReference => 'Reference';

  @override
  String get bankStatementsPageTitle => 'Bank Statements';

  @override
  String get bankStatementsLoadError => 'Error loading bank statements:';

  @override
  String get bankStatementsEmptyTitle => 'No bank statements found';

  @override
  String get bankStatementsEmptyMessage =>
      'No bank statements have been imported yet.';

  @override
  String get bankStatementsOpeningBalance => 'Opening Balance';

  @override
  String get bankStatementsClosingBalance => 'Closing Balance';

  @override
  String get bankStatementsStatusDraft => 'Draft';

  @override
  String get bankStatementsStatusInProgress => 'In Progress';

  @override
  String get bankStatementsStatusReconciled => 'Reconciled';

  @override
  String get bankStatementsStatusNeedsAttention => 'Needs Attention';

  @override
  String get bankReconciliationAutoMatch => 'Auto-Match';

  @override
  String get bankReconciliationMatch => 'Match';

  @override
  String get bankReconciliationUnmatch => 'Unmatch';

  @override
  String get bankReconciliationDifference => 'Difference';

  @override
  String get bankReconciliationBalanced => 'Balanced';

  @override
  String get bankReconciliationFinalized =>
      'Statement reconciled successfully.';

  @override
  String get bankReconciliationNoTransactions => 'No transactions';

  @override
  String get stockLedgerPageTitle => 'Stock Ledger';

  @override
  String get stockLedgerLoadError => 'Error loading stock ledger:';

  @override
  String get stockLedgerEmptyTitle => 'No ledger entries';

  @override
  String get stockLedgerEmptyMessage =>
      'No stock ledger entries found for this product.';

  @override
  String get stockLedgerWarehouseFilter => 'Filter by warehouse';

  @override
  String get stockLedgerAllWarehouses => 'All warehouses';

  @override
  String get stockLedgerBalance => 'Balance';

  @override
  String get stockLedgerTotalIn => 'Total In';

  @override
  String get stockLedgerTotalOut => 'Total Out';

  @override
  String get stockLedgerTotalValue => 'Total Value';

  @override
  String get stockAdjustmentPageTitle => 'Stock Adjustments';

  @override
  String get stockAdjustmentCreateTitle => 'New Adjustment';

  @override
  String get stockAdjustmentLoadError => 'Error loading adjustments:';

  @override
  String get stockAdjustmentEmptyTitle => 'No adjustments';

  @override
  String get stockAdjustmentEmptyMessage =>
      'No stock adjustments have been recorded yet.';

  @override
  String get stockAdjustmentProduct => 'Product';

  @override
  String get stockAdjustmentWarehouse => 'Warehouse';

  @override
  String get stockAdjustmentQuantity => 'Quantity';

  @override
  String get stockAdjustmentQuantityHint =>
      'Use negative value to decrease stock';

  @override
  String get stockAdjustmentReason => 'Reason';

  @override
  String get stockAdjustmentInvalidQuantity => 'Enter a valid number';

  @override
  String get inventoryValuationPageTitle => 'Inventory Valuation';

  @override
  String get inventoryValuationLoadError => 'Error loading valuation:';

  @override
  String get inventoryValuationEmptyTitle => 'No valuation data';

  @override
  String get inventoryValuationEmptyMessage =>
      'No inventory valuation data is available.';

  @override
  String get inventoryValuationTotalValue => 'Total Value';

  @override
  String get inventoryValuationProducts => 'Products';

  @override
  String get inventoryValuationWarehouses => 'Warehouses';

  @override
  String get inventoryValuationDate => 'As of Date';

  @override
  String get inventoryValuationQty => 'Qty';

  @override
  String get inventoryValuationAvgCost => 'Avg Cost';

  @override
  String get stockTransferPageTitle => 'Stock Transfers';

  @override
  String get stockTransferLoadError => 'Error loading transfers:';

  @override
  String get stockTransferEmptyTitle => 'No transfers';

  @override
  String get stockTransferEmptyMessage =>
      'No stock transfers have been recorded yet.';
}
