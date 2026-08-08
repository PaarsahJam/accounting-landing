// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get appTitle => 'Հաշվապահություն';

  @override
  String get login => 'Մուտք';

  @override
  String get signup => 'Գրանցում';

  @override
  String get email => 'Էլ. փոստ';

  @override
  String get password => 'Գաղտնաբառ';

  @override
  String get requiredField => 'Այս դաշտը պարտադիր է';

  @override
  String get signupTodoMessage => 'Գրանցումը դեռ հասանելի չէ:';

  @override
  String pageNotFound(Object path) {
    return 'Էջը չի գտնվել՝ $path';
  }

  @override
  String get dashboard => 'Վահանակ';

  @override
  String get invoicePageTitle => 'Հաշիվ-ապրանքագրեր';

  @override
  String get invoiceAddTitle => 'Ավելացնել հաշիվ-ապրանքագիր';

  @override
  String get invoiceEditTitle => 'Խմբագրել հաշիվ-ապրանքագիր';

  @override
  String get invoiceCustomer => 'Հաճախորդի անուն';

  @override
  String get invoiceAmount => 'Գումար';

  @override
  String get invoiceStatus => 'Կարգավիճակ';

  @override
  String get invoiceDescription => 'Նկարագրություն';

  @override
  String get invoiceCancel => 'Չեղարկել';

  @override
  String get invoiceCreate => 'Ստեղծել';

  @override
  String get invoiceSave => 'Պահպանել';

  @override
  String get invoiceRequiredField => 'Այս դաշտը պարտադիր է';

  @override
  String get invoiceStatusPending => 'Սպասման մեջ';

  @override
  String get invoiceLoadError => 'Հաշիվ-ապրանքագրերի բեռնման սխալ.';

  @override
  String get invoiceEmptyTitle => 'Հաշիվ-ապրանքագրեր դեռ չկան';

  @override
  String get invoiceEmptyMessage => 'Դեռևս ոչ մի հաշիվ-ապրանքագիր գրանցված չէ:';

  @override
  String get invoiceEditAction => 'Խմբագրել';

  @override
  String get invoiceDeleteAction => 'Ջնջել';

  @override
  String get invoiceCurrencyUnit => '֏';

  @override
  String get refresh => 'Թարմացնել';

  @override
  String get dashboardOverview => 'Հաշվապահական գործունեության ակնարկ';

  @override
  String get dashboardSubtitle =>
      'Հիմնական ցուցանիշներ ընթացիկ ժամանակաշրջանի համար';

  @override
  String get dashboardRevenue => 'Եկամուտ';

  @override
  String get dashboardExpenses => 'Ծախսեր';

  @override
  String get dashboardOutstandingInvoices => 'Չմարված հաշիվ-ապրանքագրեր';

  @override
  String get dashboardCashFlow => 'Դրամական հոսք';

  @override
  String get dashboardLoadError => 'Վահանակի տվյալների բեռնման սխալ.';

  @override
  String get dashboardLoading => 'Վահանակը բեռնվում է';

  @override
  String get dashboardFinancialSubtitle =>
      'Ֆինանսական KPI՝ ամփոփված փորձնական տվյալներից';

  @override
  String get dashboardAccountsReceivable => 'Դեբիտորական պարտքեր';

  @override
  String get dashboardTotalOutstandingInvoices =>
      'Ընդհանուր չմարված հաշիվ-ապրանքագրեր';

  @override
  String get dashboardOverdueInvoices => 'Ժամկետանց հաշիվ-ապրանքագրեր';

  @override
  String get dashboardReceivedThisMonth => 'Այս ամիս ստացված գումար';

  @override
  String get dashboardAccountsPayable => 'Կրեդիտորական պարտքեր';

  @override
  String get dashboardOutstandingVendorBills =>
      'Չմարված մատակարարի հաշիվ-ապրանքագրեր';

  @override
  String get dashboardOverdueBills => 'Ժամկետանց հաշիվ-ապրանքագրեր';

  @override
  String get dashboardPaymentsMadeThisMonth => 'Այս ամիս կատարված վճարումներ';

  @override
  String get dashboardInventory => 'Պահեստ';

  @override
  String get dashboardProductCount => 'Ապրանքների քանակ';

  @override
  String get dashboardLowStockProducts => 'Ցածր պահեստով ապրանքներ';

  @override
  String get dashboardTotalStockQuantity => 'Պահեստի ընդհանուր քանակ';

  @override
  String get dashboardWarehouseCount => 'Պահեստների քանակ';

  @override
  String get dashboardCashPosition => 'Դրամական դիրք';

  @override
  String get dashboardCash => 'Կանխիկ';

  @override
  String get dashboardBank => 'Բանկ';

  @override
  String get dashboardTotalLiquidAssets => 'Ընդհանուր իրացվելի ակտիվներ';

  @override
  String get dashboardMonthlyRevenue => 'Ամսական եկամուտ';

  @override
  String get dashboardMonthlyExpenses => 'Ամսական ծախսեր';

  @override
  String get dashboardProfitOverview => 'Շահույթի ակնարկ';

  @override
  String get dashboardGrossProfit => 'Համախառն շահույթ';

  @override
  String get dashboardNetProfit => 'Զուտ շահույթ';

  @override
  String get dashboardRecentActivity => 'Վերջին գործունեություն';

  @override
  String get dashboardNoRecentActivity => 'Վերջին գործունեություն չկա';

  @override
  String get dashboardQuickActions => 'Արագ գործողություններ';

  @override
  String get dashboardCreateSalesInvoice => 'Ստեղծել վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get dashboardCreateVendorBill => 'Ստեղծել մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get dashboardReceiveCustomerPayment => 'Ստանալ հաճախորդի վճարում';

  @override
  String get dashboardRecordVendorPayment => 'Գրանցել մատակարարի վճարում';

  @override
  String get dashboardViewJournal => 'Դիտել մատյանը';

  @override
  String get dashboardActivityPurchaseOrder => 'Գնման պատվեր';

  @override
  String get dashboardActivityGoodsReceipt => 'Ապրանքների ստացում';

  @override
  String get dashboardActivityVendorBill => 'Մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get dashboardActivityVendorPayment => 'Մատակարարի վճարում';

  @override
  String get dashboardActivitySalesInvoice => 'Վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get dashboardActivityCustomerPayment => 'Հաճախորդի ստացում';

  @override
  String get dashboardActivityJournalEntry => 'Մատյանային գրանցում';

  @override
  String get expensesPageTitle => 'Ծախսեր';

  @override
  String get expensesLoadError => 'Ծախսերի բեռնման սխալ.';

  @override
  String get expensesEmptyTitle => 'Ծախսեր չկան';

  @override
  String get expensesEmptyMessage => 'Դեռևս ոչ մի ծախս գրանցված չէ:';

  @override
  String get reportsPageTitle => 'Հաշվետվություններ';

  @override
  String get reportsLoadError => 'Հաշվետվությունների բեռնման սխալ.';

  @override
  String get reportsEmptyTitle => 'Հաշվետվություններ չկան';

  @override
  String get reportsEmptyMessage => 'Դեռևս ոչ մի հաշվետվություն ստեղծված չէ:';

  @override
  String get financialReportsPageTitle => 'Ֆինանսական հաշվետվություններ';

  @override
  String get financialReportsLoadingMessage =>
      'Ֆինանսական հաշվետվությունները բեռնվում են';

  @override
  String get financialReportsNoReportsTitle => 'Հաշվետվություններ չկան';

  @override
  String get financialReportsNoReportsMessage =>
      'Ընտրված ժամանակաշրջանի համար տվյալներ չկան:';

  @override
  String get financialReportsTrialBalance => 'Փորձնական բալանս';

  @override
  String get financialReportsBalanceSheet => 'Հաշվեկշիռ';

  @override
  String get financialReportsCashFlow => 'Դրամական հոսք';

  @override
  String get financialReportsSearchAccount => 'Որոնել հաշիվ';

  @override
  String get financialReportsStartLabel => 'Սկսած';

  @override
  String get financialReportsEndLabel => 'Մինչև';

  @override
  String get financialReportsFilterAll => 'Բոլորը';

  @override
  String get financialReportsFilterDebit => 'Դեբետ';

  @override
  String get financialReportsFilterCredit => 'Կրեդիտ';

  @override
  String get financialReportsArAging => 'AR Aging';

  @override
  String get financialReportsApAging => 'AP Aging';

  @override
  String get financialReportsRevenue => 'Եկամուտ';

  @override
  String get financialReportsExpenses => 'Ծախսեր';

  @override
  String get financialReportsNetProfit => 'Զուտ շահույթ';

  @override
  String get financialReportsBalanced => 'Հավասարակշռված';

  @override
  String get financialReportsYes => 'Այո';

  @override
  String get financialReportsNo => 'Ոչ';

  @override
  String get financialReportsProfitAndLoss => 'Շահույթի և վնասի հաշվետվություն';

  @override
  String get financialReportsAccountCode => 'Հաշվի կոդ';

  @override
  String get financialReportsAccountName => 'Հաշվի անուն';

  @override
  String get financialReportsDebit => 'Դեբետ';

  @override
  String get financialReportsCredit => 'Կրեդիտ';

  @override
  String get financialReportsEndingBalance => 'Վերջնական մնացորդ';

  @override
  String get financialReportsAssets => 'Ակտիվներ';

  @override
  String get financialReportsLiabilities => 'Պարտավորություններ';

  @override
  String get financialReportsEquity => 'Սեփական կապիտալ';

  @override
  String get financialReportsCash => 'Կանխիկ';

  @override
  String get financialReportsBank => 'Բանկ';

  @override
  String get financialReportsReceivables => 'Դեբիտորական պարտքեր';

  @override
  String get financialReportsInventory => 'Պահեստ';

  @override
  String get financialReportsPayables => 'Կրեդիտորական պարտքեր';

  @override
  String get financialReportsCapital => 'Կապիտալ';

  @override
  String get financialReportsOperatingActivities =>
      'Գործառնական գործունեություն';

  @override
  String get reportPeriodLabel => 'Ժամանակաշրջան';

  @override
  String get reportSelectLabel => 'Ընտրել հաշվետվություն';

  @override
  String get supportedFiltersLabel => 'Աջակցվող զտիչներ';

  @override
  String get exportOptionsLabel => 'Արտահանման տարբերակներ';

  @override
  String get mockOnlyLabel => 'Միայն փորձնական';

  @override
  String get revenueSummaryLabel => 'Եկամուտ';

  @override
  String get expensesSummaryLabel => 'Ծախսեր';

  @override
  String get netIncomeSummaryLabel => 'Զուտ շահույթ';

  @override
  String get cashBalanceSummaryLabel => 'Կանխիկի մնացորդ';

  @override
  String get settingsPageTitle => 'Կարգավորումներ';

  @override
  String get settingsLoadError => 'Կարգավորումները հնարավոր չէ բեռնել';

  @override
  String get customersPageTitle => 'Հաճախորդներ';

  @override
  String get customersLoadError => 'Հաճախորդների բեռնման սխալ.';

  @override
  String get customersEmptyTitle => 'Հաճախորդներ չկան';

  @override
  String get customersEmptyMessage => 'Դեռևս ոչ մի հաճախորդ գրանցված չէ:';

  @override
  String get customerAddTitle => 'Ավելացնել հաճախորդ';

  @override
  String get customerEditTitle => 'Խմբագրել հաճախորդ';

  @override
  String get customerName => 'Անուն';

  @override
  String get customerCompany => 'Ընկերություն';

  @override
  String get customerEmail => 'Էլ. փոստ';

  @override
  String get customerPhone => 'Հեռախոս';

  @override
  String get customerBalance => 'Չմարված մնացորդ';

  @override
  String get customerStatus => 'Կարգավիճակ';

  @override
  String get customerNotes => 'Նշումներ';

  @override
  String get customerCreate => 'Ստեղծել';

  @override
  String get customerSave => 'Պահպանել';

  @override
  String get generalLedgerPageTitle => 'Գլխավոր մատյան';

  @override
  String get generalLedgerLoadError => 'Գլխավոր մատյանի բեռնման սխալ.';

  @override
  String get generalLedgerEmptyTitle => 'Գլխավոր մատյանի համար տվյալներ չկան';

  @override
  String get generalLedgerEmptyMessage =>
      'Գլխավոր մատյանի համար դեռևս տվյալներ չկան:';

  @override
  String get generalLedgerSearchHint => 'Որոնել հաշիվներ';

  @override
  String get generalLedgerActive => 'Ակտիվ';

  @override
  String get generalLedgerInactive => 'Ոչ ակտիվ';

  @override
  String get generalLedgerBalanced => 'Հավասարակշռված';

  @override
  String get generalLedgerUnbalanced => 'Անհավասարակշիռ';

  @override
  String get chartOfAccountsTitle => 'Հաշվային պլան';

  @override
  String get journalEntriesTitle => 'Մատյանային գրանցումներ';

  @override
  String get trialBalanceTitle => 'Փորձնական բալանս';

  @override
  String get ledgerAccountTypeLabel => 'Տիպ';

  @override
  String get ledgerOpeningBalanceLabel => 'Բացման մնացորդ';

  @override
  String get ledgerCurrentBalanceLabel => 'Ընթացիկ մնացորդ';

  @override
  String get ledgerActiveLabel => 'Ակտիվ';

  @override
  String get ledgerAccountAsset => 'Ակտիվ';

  @override
  String get ledgerAccountLiability => 'Պարտավորություն';

  @override
  String get ledgerAccountEquity => 'Սեփական կապիտալ';

  @override
  String get ledgerAccountRevenue => 'Եկամուտ';

  @override
  String get ledgerAccountExpense => 'Ծախս';

  @override
  String get journalEntryDetailTitle => 'Մատյանային գրանցում';

  @override
  String get journalEntryReferenceLabel => 'Հղում';

  @override
  String get journalEntryDateLabel => 'Ամսաթիվ';

  @override
  String get journalEntryMemoLabel => 'Նշում';

  @override
  String get journalEntryLinesLabel => 'Տողեր';

  @override
  String get journalEntryNoMemo => 'Առանց նշումների';

  @override
  String get journalEntryLineDefault => 'Մատյանի տող';

  @override
  String get journalEntryDebit => 'Դեբետ';

  @override
  String get journalEntryCredit => 'Կրեդիտ';

  @override
  String get accountDetailPageTitle => 'Հաշվի մանրամասներ';

  @override
  String get accountDetailLoadingMessage => 'Հաշվի մանրամասները բեռնվում են';

  @override
  String get accountDetailBalanceLabel => 'Ընթացիկ մնացորդ';

  @override
  String get accountDetailTransactionsTitle => 'Գործառնություններ';

  @override
  String get accountDetailNoTransactionsTitle => 'Գործառնություններ չկան';

  @override
  String get accountDetailNoTransactionsMessage =>
      'Այս հաշիվը դեռևս գործառնություններ չունի:';

  @override
  String get trialBalanceDebitLabel => 'Դեբետ';

  @override
  String get trialBalanceCreditLabel => 'Կրեդիտ';

  @override
  String get inventoryPageTitle => 'Պահեստ';

  @override
  String get inventoryLoadError => 'Պահեստի բեռնման սխալ.';

  @override
  String get inventoryEmptyTitle => 'Ապրանքներ չկան';

  @override
  String get inventoryEmptyMessage => 'Դեռևս ոչ մի ապրանք հասանելի չէ:';

  @override
  String get inventorySearchHint => 'Որոնել ապրանքներ';

  @override
  String get inventoryCategoryFilter => 'Կատեգորիայի զտիչ';

  @override
  String get inventoryAllCategories => 'Բոլոր կատեգորիաները';

  @override
  String get inventoryAddProduct => 'Ավելացնել ապրանք';

  @override
  String get inventoryEditProduct => 'Խմբագրել ապրանք';

  @override
  String get inventoryDeleteProduct => 'Ջնջել ապրանք';

  @override
  String get inventoryCreate => 'Ստեղծել';

  @override
  String get inventorySave => 'Պահպանել';

  @override
  String get inventorySku => 'SKU';

  @override
  String get inventoryName => 'Անուն';

  @override
  String get inventoryDescription => 'Նկարագրություն';

  @override
  String get inventoryCategory => 'Կատեգորիա';

  @override
  String get inventoryUnit => 'Միավոր';

  @override
  String get inventoryPrice => 'Գին';

  @override
  String get inventoryStockOnHand => 'Առկա պահեստ';

  @override
  String get inventoryActive => 'Ակտիվ';

  @override
  String get inventoryWarehousesTitle => 'Պահեստներ';

  @override
  String get inventoryWarehousesLoadError => 'Պահեստների բեռնման սխալ.';

  @override
  String get inventoryWarehousesEmptyTitle => 'Պահեստներ չկան';

  @override
  String get inventoryWarehousesEmptyMessage =>
      'Դեռևս ոչ մի պահեստ հասանելի չէ:';

  @override
  String get inventoryStockDetailLoadError =>
      'Պահեստի մանրամասների բեռնման սխալ.';

  @override
  String get inventoryStockDetailEmptyTitle => 'Պահեստի շարժումներ չկան';

  @override
  String get inventoryStockDetailEmptyMessage =>
      'Այս ապրանքը դեռևս պահեստային շարժումներ չունի:';

  @override
  String get inventoryStockDetailQuantity => 'Առկա պահեստ';

  @override
  String get inventoryStockDetailWarehouse => 'Պահեստ';

  @override
  String get inventoryStockDetailMovementHistory => 'Շարժումների պատմություն';

  @override
  String get inventoryStockDetailNoWarehouse => 'Պահեստ չի նշանակվել';

  @override
  String get purchaseOrdersPageTitle => 'Գնման պատվերներ';

  @override
  String get purchaseOrdersLoadError => 'Գնման պատվերների բեռնման սխալ.';

  @override
  String get purchaseOrdersEmptyTitle => 'Գնման պատվերներ չկան';

  @override
  String get purchaseOrdersEmptyMessage =>
      'Դեռևս ոչ մի գնման պատվեր գրանցված չէ:';

  @override
  String get purchaseOrderAddTitle => 'Ավելացնել գնման պատվեր';

  @override
  String get purchaseOrderEditTitle => 'Խմբագրել գնման պատվեր';

  @override
  String get purchaseOrderDeleteTitle => 'Ջնջել գնման պատվեր';

  @override
  String get purchaseOrderCreate => 'Ստեղծել';

  @override
  String get purchaseOrderSave => 'Պահպանել';

  @override
  String get purchaseOrderReference => 'Հղում';

  @override
  String get purchaseOrderTitle => 'Վերնագիր';

  @override
  String get purchaseOrderVendor => 'Մատակարար';

  @override
  String get purchaseOrderStatus => 'Կարգավիճակ';

  @override
  String get purchaseOrderNotes => 'Նշումներ';

  @override
  String get purchaseOrderLineDescription => 'Տողի նկարագրություն';

  @override
  String get purchaseOrderQuantity => 'Քանակ';

  @override
  String get purchaseOrderUnitPrice => 'Միավոր գին';

  @override
  String get purchaseOrderSearchHint => 'Որոնել գնման պատվերներ';

  @override
  String get vendorBillsPageTitle => 'Մատակարարի հաշիվ-ապրանքագրեր';

  @override
  String get vendorBillsLoadError =>
      'Մատակարարի հաշիվ-ապրանքագրերի բեռնման սխալ.';

  @override
  String get vendorBillsEmptyTitle => 'Մատակարարի հաշիվ-ապրանքագրեր չկան';

  @override
  String get vendorBillsEmptyMessage =>
      'Դեռևս ոչ մի մատակարարի հաշիվ-ապրանքագիր գրանցված չէ:';

  @override
  String get vendorBillAddTitle => 'Ավելացնել մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get vendorBillEditTitle => 'Խմբագրել մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get vendorBillDetailTitle => 'Մատակարարի հաշիվ-ապրանքագրի մանրամասներ';

  @override
  String get vendorBillDeleteTitle => 'Ջնջել մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get vendorBillCreate => 'Ստեղծել';

  @override
  String get vendorBillSave => 'Պահպանել';

  @override
  String get vendorBillReference => 'Հղում';

  @override
  String get vendorBillTitle => 'Վերնագիր';

  @override
  String get vendorBillVendor => 'Մատակարար';

  @override
  String get vendorBillPurchaseOrder => 'Գնման պատվեր';

  @override
  String get vendorBillGoodsReceipt => 'Ապրանքների ստացում';

  @override
  String get vendorBillStatus => 'Կարգավիճակ';

  @override
  String get vendorBillNotes => 'Նշումներ';

  @override
  String get vendorBillSearchHint => 'Որոնել մատակարարի հաշիվ-ապրանքագրեր';

  @override
  String get vendorBillCreateFromReceipt => 'Ստեղծել ստացման փաստաթղթից';

  @override
  String get vendorBillLinesLabel => 'Տողեր';

  @override
  String get salesInvoicesPageTitle => 'Վաճառքի հաշիվ-ապրանքագրեր';

  @override
  String get salesInvoicesLoadError =>
      'Վաճառքի հաշիվ-ապրանքագրերի բեռնման սխալ.';

  @override
  String get salesInvoicesEmptyTitle => 'Վաճառքի հաշիվ-ապրանքագրեր չկան';

  @override
  String get salesInvoicesEmptyMessage =>
      'Դեռևս ոչ մի վաճառքի հաշիվ-ապրանքագիր գրանցված չէ:';

  @override
  String get salesInvoiceAddTitle => 'Ավելացնել վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get salesInvoiceEditTitle => 'Խմբագրել վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get salesInvoiceDetailTitle => 'Վաճառքի հաշիվ-ապրանքագրի մանրամասներ';

  @override
  String get salesInvoiceDeleteTitle => 'Ջնջել վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get salesInvoiceCreate => 'Ստեղծել';

  @override
  String get salesInvoiceSave => 'Պահպանել';

  @override
  String get salesInvoiceReference => 'Հղում';

  @override
  String get salesInvoiceTitle => 'Վերնագիր';

  @override
  String get salesInvoiceCustomer => 'Հաճախորդ';

  @override
  String get salesInvoiceDueDate => 'Վճարման վերջնաժամկետ';

  @override
  String get salesInvoiceStatus => 'Կարգավիճակ';

  @override
  String get salesInvoiceNotes => 'Նշումներ';

  @override
  String get salesInvoiceLinesLabel => 'Տողեր';

  @override
  String get salesInvoiceAddLine => 'Ավելացնել տող';

  @override
  String get salesInvoiceSearchHint => 'Որոնել վաճառքի հաշիվ-ապրանքագրեր';

  @override
  String get salesInvoiceSubtotal => 'Ենթագումար';

  @override
  String get salesInvoiceTax => 'Հարկ';

  @override
  String get salesInvoiceTotal => 'Ընդամենը';

  @override
  String get customerPaymentsPageTitle => 'Հաճախորդի ստացումներ';

  @override
  String get customerPaymentsLoadError => 'Հաճախորդի ստացումների բեռնման սխալ.';

  @override
  String get customerPaymentsEmptyTitle => 'Հաճախորդի ստացումներ չկան';

  @override
  String get customerPaymentsEmptyMessage =>
      'Դեռևս ոչ մի հաճախորդի ստացում գրանցված չէ:';

  @override
  String get customerPaymentAddTitle => 'Ավելացնել հաճախորդի ստացում';

  @override
  String get customerPaymentEditTitle => 'Խմբագրել հաճախորդի ստացում';

  @override
  String get customerPaymentDetailTitle => 'Հաճախորդի ստացման մանրամասներ';

  @override
  String get customerPaymentDeleteTitle => 'Ջնջել հաճախորդի ստացում';

  @override
  String get customerPaymentCreate => 'Ստեղծել';

  @override
  String get customerPaymentSave => 'Պահպանել';

  @override
  String get customerPaymentReference => 'Հղում';

  @override
  String get customerPaymentCustomer => 'Հաճախորդ';

  @override
  String get customerPaymentAmount => 'Գումար';

  @override
  String get customerPaymentMethod => 'Մեթոդ';

  @override
  String get customerPaymentStatus => 'Կարգավիճակ';

  @override
  String get customerPaymentNotes => 'Նշումներ';

  @override
  String get customerPaymentSearchHint => 'Որոնել հաճախորդի ստացումներ';

  @override
  String get customerPaymentAllocationsLabel => 'Բաշխումներ';

  @override
  String get customerPaymentAllocationAmount => 'Բաշխված գումար';

  @override
  String get customerStatementsPageTitle => 'Հաճախորդի քաղվածքներ';

  @override
  String get customerStatementsLoadError =>
      'Հաճախորդի քաղվածքների բեռնման սխալ.';

  @override
  String get customerStatementsEmptyTitle => 'Հաճախորդի քաղվածքներ չկան';

  @override
  String get customerStatementsEmptyMessage =>
      'Դեռևս ոչ մի քաղվածք ստեղծված չէ:';

  @override
  String get customerStatementsSelectCustomer => 'Ընտրել հաճախորդ';

  @override
  String get customerStatementsDateRange => 'Ժամանակահատված';

  @override
  String get customerStatementsOpeningBalance => 'Բացման մնացորդ';

  @override
  String get customerStatementsRunningBalance => 'Ընթացիկ մնացորդ';

  @override
  String get customerStatementsOutstandingBalance => 'Չմարված մնացորդ';

  @override
  String get customerStatementsInvoiceHistory =>
      'Հաշիվ-ապրանքագրերի պատմություն';

  @override
  String get customerStatementsPaymentHistory => 'Վճարումների պատմություն';

  @override
  String get customerStatementsAgingTitle =>
      'Դեբիտորական պարտքերի վերլուծություն';

  @override
  String get customerStatementsNoInvoices => 'Հաշիվ-ապրանքագրեր չեն գտնվել';

  @override
  String get customerStatementsNoPayments => 'Վճարումներ չեն գտնվել';

  @override
  String get customerStatementsNoEntries =>
      'Ընտրված ժամանակահատվածում գրառումներ չկան';

  @override
  String get vendorPaymentsPageTitle => 'Մատակարարի վճարումներ';

  @override
  String get vendorPaymentsLoadError => 'Մատակարարի վճարումների բեռնման սխալ.';

  @override
  String get vendorPaymentsEmptyTitle => 'Մատակարարի վճարումներ չկան';

  @override
  String get vendorPaymentsEmptyMessage =>
      'Դեռևս ոչ մի մատակարարի վճարում գրանցված չէ:';

  @override
  String get vendorPaymentAddTitle => 'Ավելացնել մատակարարի վճարում';

  @override
  String get vendorPaymentEditTitle => 'Խմբագրել մատակարարի վճարում';

  @override
  String get vendorPaymentDetailTitle => 'Մատակարարի վճարման մանրամասներ';

  @override
  String get vendorPaymentDeleteTitle => 'Ջնջել մատակարարի վճարում';

  @override
  String get vendorPaymentCreate => 'Ստեղծել';

  @override
  String get vendorPaymentSave => 'Պահպանել';

  @override
  String get vendorPaymentReference => 'Հղում';

  @override
  String get vendorPaymentVendor => 'Մատակարար';

  @override
  String get vendorPaymentAmount => 'Գումար';

  @override
  String get vendorPaymentMethod => 'Մեթոդ';

  @override
  String get vendorPaymentStatus => 'Կարգավիճակ';

  @override
  String get vendorPaymentNotes => 'Նշումներ';

  @override
  String get vendorPaymentSearchHint => 'Որոնել մատակարարի վճարումներ';

  @override
  String get vendorPaymentAllocationsLabel => 'Բաշխումներ';

  @override
  String get vendorPaymentAllocationAmount => 'Բաշխված գումար';

  @override
  String get vendorStatementsPageTitle => 'Մատակարարի քաղվածքներ';

  @override
  String get vendorStatementsLoadError =>
      'Մատակարարի քաղվածքների բեռնման սխալ.';

  @override
  String get vendorStatementsEmptyTitle => 'Մատակարարի քաղվածքներ չկան';

  @override
  String get vendorStatementsEmptyMessage => 'Դեռևս ոչ մի քաղվածք ստեղծված չէ:';

  @override
  String get vendorStatementsSelectVendor => 'Ընտրել մատակարար';

  @override
  String get vendorStatementsDateRange => 'Ժամանակահատված';

  @override
  String get vendorStatementsOpeningBalance => 'Բացման մնացորդ';

  @override
  String get vendorStatementsRunningBalance => 'Ընթացիկ մնացորդ';

  @override
  String get vendorStatementsOutstandingBalance => 'Չմարված մնացորդ';

  @override
  String get vendorStatementsBillHistory => 'Հաշիվ-ապրանքագրերի պատմություն';

  @override
  String get vendorStatementsPaymentHistory => 'Վճարումների պատմություն';

  @override
  String get vendorStatementsAgingTitle =>
      'Կրեդիտորական պարտքերի վերլուծություն';

  @override
  String get vendorStatementsNoBills => 'Հաշիվ-ապրանքագրեր չեն գտնվել';

  @override
  String get vendorStatementsNoPayments => 'Վճարումներ չեն գտնվել';

  @override
  String get vendorStatementsNoEntries =>
      'Ընտրված ժամանակահատվածում գրառումներ չկան';

  @override
  String get journalPreviewPageTitle => 'Մատյանի նախադիտում';

  @override
  String get journalPreviewLoadError =>
      'Մատյանի նախադիտման բեռնումը չհաջողվեց:';

  @override
  String get journalPreviewEmptyTitle => 'Նախադիտում հասանելի չէ';

  @override
  String get journalPreviewEmptyMessage =>
      'Ընտրված փաստաթղթի համար մատյանի նախադիտում դեռևս չկա:';

  @override
  String get journalPreviewDocument => 'Փաստաթուղթ';

  @override
  String get journalPreviewPostingDate => 'Փակցման ամսաթիվ';

  @override
  String get journalPreviewNarration => 'Բացատրություն';

  @override
  String get journalPreviewLinesLabel => 'Փակցման տողեր';

  @override
  String get journalExplorerPageTitle => 'Մատյան';

  @override
  String get journalExplorerLoadError => 'Մատյանի բեռնումը չհաջողվեց:';

  @override
  String get journalExplorerEmptyTitle => 'Մատյանային գրանցում չի գտնվել';

  @override
  String get journalExplorerEmptyMessage =>
      'Ոչ մի մատյանային գրանցում չի համապատասխանում ընթացիկ զտիչներին:';

  @override
  String get journalExplorerSearchHint => 'Որոնել համարով կամ հղումով';

  @override
  String get journalExplorerSourceType => 'Աղբյուրի տիպ';

  @override
  String get journalExplorerAccountCode => 'Հաշվի կոդ';

  @override
  String get journalExplorerSortBy => 'Տեսակավորում';

  @override
  String get journalExplorerNewest => 'Ամենանորերը';

  @override
  String get journalExplorerOldest => 'Ամենահները';

  @override
  String get journalExplorerDateRange => 'Ժամանակահատված';

  @override
  String get journalExplorerPostingDate => 'Փակցման ամսաթիվ';

  @override
  String get journalExplorerNarration => 'Բացատրություն';

  @override
  String get journalExplorerPostingStatus => 'Փակցման կարգավիճակ';

  @override
  String get journalExplorerTotalDebit => 'Ընդհանուր դեբետ';

  @override
  String get journalExplorerTotalCredit => 'Ընդհանուր կրեդիտ';

  @override
  String get journalExplorerLinesLabel => 'Մատյանի տողեր';

  @override
  String get journalExplorerLoading => 'Փաստաթղթերը բեռնվում են';

  @override
  String get journalExplorerSourceAll => 'Բոլորը';

  @override
  String get journalExplorerSourcePurchaseOrder => 'Գնման պատվեր';

  @override
  String get journalExplorerSourceGoodsReceipt => 'Ապրանքների ստացում';

  @override
  String get journalExplorerSourceVendorBill => 'Մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get journalExplorerSourceVendorPayment => 'Մատակարարի վճարում';

  @override
  String get journalExplorerSourceSalesInvoice => 'Վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get journalExplorerSourceCustomerPayment => 'Հաճախորդի ստացում';

  @override
  String get journalExplorerViewSource => 'Դիտել աղբյուր փաստաթուղթը';

  @override
  String get vendorsPageTitle => 'Մատակարարներ';

  @override
  String get vendorsLoadError => 'Մատակարարների բեռնման սխալ.';

  @override
  String get vendorsEmptyTitle => 'Մատակարարներ չկան';

  @override
  String get vendorsEmptyMessage => 'Դեռևս ոչ մի մատակարար գրանցված չէ:';

  @override
  String get vendorAddTitle => 'Ավելացնել մատակարար';

  @override
  String get vendorEditTitle => 'Խմբագրել մատակարար';

  @override
  String get vendorCompanyName => 'Ընկերության անուն';

  @override
  String get vendorContactName => 'Կոնտակտային անուն';

  @override
  String get vendorEmail => 'Էլ. փոստ';

  @override
  String get vendorPhone => 'Հեռախոս';

  @override
  String get vendorAddress => 'Հասցե';

  @override
  String get vendorTaxIdentifier => 'Հարկային համար';

  @override
  String get vendorActiveStatus => 'Ակտիվ';

  @override
  String get vendorNotes => 'Նշումներ';

  @override
  String get vendorSearchHint => 'Որոնել մատակարարներ';

  @override
  String get vendorStatusLabel => 'Կարգավիճակ';

  @override
  String get vendorActive => 'Ակտիվ';

  @override
  String get vendorInactive => 'Ոչ ակտիվ';

  @override
  String get vendorCreate => 'Ստեղծել';

  @override
  String get vendorSave => 'Պահպանել';

  @override
  String get currencyUnit => '֏';

  @override
  String get bankReconciliationPageTitle => 'Բանկային համադրում';

  @override
  String get bankReconciliationLoadError =>
      'Համադրման տվյալները հնարավոր չէ բեռնել.';

  @override
  String get bankAccountSelector => 'Բանկային հաշիվ';

  @override
  String get bankReconciliationSummary => 'Համադրման ամփոփում';

  @override
  String get bankMatchedTransactions => 'Համադրված գործառնություններ';

  @override
  String get bankUnmatchedTransactions => 'Չհամադրված գործառնություններ';

  @override
  String get bankProgress => 'Առաջընթաց';

  @override
  String get bankNoTransactions => 'Գործառնություններ չեն գտնվել';

  @override
  String get bankNoTransactionsMessage =>
      'Այս հաշվի համար դեռևս գործառնություններ չկան:';

  @override
  String get bankFinalize => 'Ավարտել համադրումը';

  @override
  String get bankCompletionDialogTitle => 'Համադրումն ավարտված է';

  @override
  String get bankCompletionDialogMessage =>
      'Համադրման նիստը հաջողությամբ ավարտվեց:';

  @override
  String get bankDone => 'Հաստատել';

  @override
  String get fiscalYearsPageTitle => 'Ֆինանսական տարիներ';

  @override
  String get fiscalPeriodsPageTitle => 'Հաշվետու ժամանակաշրջաններ';

  @override
  String get yearEndClosingPageTitle => 'Տարվա վերջի փակում';

  @override
  String get createButton => 'Ստեղծել';

  @override
  String get draft => 'Սևագիր';

  @override
  String get pendingApproval => 'Սպասվում է հաստատման';

  @override
  String get approved => 'Հաստատված';

  @override
  String get posted => 'Փակցված';

  @override
  String get locked => 'Կողպված';

  @override
  String get cancelled => 'Չեղարկված';

  @override
  String get documentNumberLabel => 'Փաստաթղթի համար';

  @override
  String get documentStatusLabel => 'Կարգավիճակ';

  @override
  String get documentCreatedAtLabel => 'Ստեղծված';

  @override
  String get documentApprovedAtLabel => 'Հաստատված';

  @override
  String get documentPostedAtLabel => 'Փակցված';

  @override
  String get approvalTimelineTitle => 'Հաստատման փուլեր';

  @override
  String get documentTypeLabel => 'Տիպ';

  @override
  String get workflowInvalidTransition => 'Անթույլատրելի անցում';

  @override
  String get workflowTransitionToPendingApproval => 'Ուղարկել հաստատման';

  @override
  String get workflowTransitionToApproved => 'Հաստատել';

  @override
  String get workflowTransitionToPosted => 'Փակցել';

  @override
  String get workflowTransitionToLocked => 'Կողպել';

  @override
  String get workflowTransitionToCancelled => 'Չեղարկել';

  @override
  String get approvalWorkflowPageTitle => 'Փաստաթղթի աշխատանքային հոսք';

  @override
  String get approvalWorkflowLoadError => 'Փաստաթղթերի բեռնման սխալ.';

  @override
  String get approvalWorkflowEmptyTitle => 'Փաստաթղթեր չկան';

  @override
  String get approvalWorkflowEmptyMessage =>
      'Դեռևս ոչ մի փաստաթուղթ գրանցված չէ:';

  @override
  String get auditTrailPageTitle => 'Աուդիտի մատյան';

  @override
  String get auditTrailLoadError => 'Աուդիտի մատյանի բեռնման սխալ.';

  @override
  String get auditTrailEmptyTitle => 'Դեռևս ոչ մի գործունեություն գրանցված չէ';

  @override
  String get auditTrailEmptyMessage =>
      'Այս փաստաթղթի համար դեռևս ոչ մի գործունեություն գրանցված չէ:';

  @override
  String get auditTrailFilterAll => 'Բոլորը';

  @override
  String auditTrailPerformedBy(String user) {
    return 'Կատարել է $user';
  }

  @override
  String get auditActionCreated => 'Ստեղծված';

  @override
  String get auditActionEdited => 'Խմբագրված';

  @override
  String get auditActionDeleted => 'Ջնջված';

  @override
  String get auditActionSubmittedForApproval => 'Ուղարկվել է հաստատման';

  @override
  String get auditActionApproved => 'Հաստատված';

  @override
  String get auditActionRejected => 'Մերժված';

  @override
  String get auditActionPosted => 'Փակցված';

  @override
  String get auditActionLocked => 'Կողպված';

  @override
  String get auditActionCancelled => 'Չեղարկված';

  @override
  String get auditActionReopened => 'Վերաբացված';

  @override
  String get auditActionPaid => 'Վճարված';

  @override
  String get auditActionPartiallyPaid => 'Մասամբ վճարված';

  @override
  String get auditActionRefunded => 'Վերադարձված';

  @override
  String get auditActionPrinted => 'Տպված';

  @override
  String get auditActionExported => 'Արտահանված';

  @override
  String get auditActionStockAdjusted => 'Պահեստը ճշգրտվել է';

  @override
  String get auditActionStockTransferred => 'Պահեստը փոխանցվել է';

  @override
  String get auditActionStockCounted => 'Պահեստը հաշվառվել է';

  @override
  String get auditActionJournalGenerated => 'Մատյանային գրանցում ստեղծվել է';

  @override
  String get auditActionJournalReviewed => 'Մատյանային գրանցումը վերանայվել է';

  @override
  String get auditActionAddressChanged => 'Հասցեն փոխվել է';

  @override
  String get auditActionContactChanged => 'Կոնտակտային տվյալները փոխվել են';

  @override
  String get auditActionArchived => 'Արխիվացված';

  @override
  String get auditActionUnarchived => 'Արխիվից հանված';

  @override
  String get auditActionPeriodOpened => 'Հաշվետու ժամանակաշրջանը բացվել է';

  @override
  String get auditActionPeriodClosed => 'Հաշվետու ժամանակաշրջանը փակվել է';

  @override
  String get auditEntitySalesInvoice => 'Վաճառքի հաշիվ-ապրանքագիր';

  @override
  String get auditEntityVendorBill => 'Մատակարարի հաշիվ-ապրանքագիր';

  @override
  String get auditEntityPurchaseOrder => 'Գնման պատվեր';

  @override
  String get auditEntityGoodsReceipt => 'Ապրանքների ստացում';

  @override
  String get auditEntityVendorPayment => 'Մատակարարի վճարում';

  @override
  String get auditEntityCustomerPayment => 'Հաճախորդի ստացում';

  @override
  String get auditEntityCustomer => 'Հաճախորդ';

  @override
  String get auditEntityVendor => 'Մատակարար';

  @override
  String get auditEntityInventory => 'Պահեստ';

  @override
  String get auditEntityJournalEntry => 'Մատյանային գրանցում';

  @override
  String get auditEntityFiscalPeriod => 'Հաշվետու ժամանակաշրջան';

  @override
  String get auditEntityFinancialReport => 'Ֆինանսական հաշվետվություն';

  @override
  String get bankAccountsPageTitle => 'Բանկային հաշիվներ';

  @override
  String get bankAccountsLoadError => 'Բանկային հաշիվների բեռնման սխալ.';

  @override
  String get bankAccountsEmptyTitle => 'Բանկային հաշիվ չի գտնվել';

  @override
  String get bankAccountsEmptyMessage => 'Ոչ մի բանկային հաշիվ գրանցված չէ:';

  @override
  String get bankAccountsSearchHint => 'Որոնել հաշիվներ';

  @override
  String get bankAccountsBalanceLabel => 'Ընթացիկ մնացորդ';

  @override
  String get bankAccountsTypeChecking => 'Ընթացիկ';

  @override
  String get bankAccountsTypeSavings => 'Խնայողական';

  @override
  String get bankAccountsTypeCash => 'Կանխիկ';

  @override
  String get bankAccountsTypeCreditCard => 'Վարկային քարտ';

  @override
  String get bankAccountsStatusActive => 'Ակտիվ';

  @override
  String get bankAccountsStatusInactive => 'Ոչ ակտիվ';

  @override
  String get bankAccountsStatusFrozen => 'Սառեցված';

  @override
  String get bankTransactionsPageTitle => 'Գործառնություններ';

  @override
  String get bankTransactionsLoadError => 'Գործառնությունների բեռնման սխալ.';

  @override
  String get bankTransactionsEmptyTitle => 'Գործառնություն չի գտնվել';

  @override
  String get bankTransactionsEmptyMessage =>
      'Այս հաշվի համար ոչ մի գործառնություն գրանցված չէ:';

  @override
  String get bankTransactionsSearchHint => 'Որոնել գործառնություններ';

  @override
  String get bankTransactionsAllTypes => 'Բոլոր տիպերը';

  @override
  String get bankTransactionTypeDeposit => 'Մուտք';

  @override
  String get bankTransactionTypeWithdrawal => 'Ելք';

  @override
  String get bankTransactionTypeTransfer => 'Փոխանցում';

  @override
  String get bankTransactionTypeInterest => 'Տոկոս';

  @override
  String get bankTransactionTypeBankFee => 'Բանկային միջնորդավճար';

  @override
  String get bankTransactionTypeAdjustment => 'Ճշգրտում';

  @override
  String get bankTransactionRunningBalance => 'Ընթացիկ մնացորդ';

  @override
  String get bankTransactionDate => 'Ամսաթիվ';

  @override
  String get bankTransactionReference => 'Հղում';

  @override
  String get bankStatementsPageTitle => 'Բանկային քաղվածքներ';

  @override
  String get bankStatementsLoadError => 'Բանկային քաղվածքների բեռնման սխալ.';

  @override
  String get bankStatementsEmptyTitle => 'Բանկային քաղվածք չի գտնվել';

  @override
  String get bankStatementsEmptyMessage =>
      'Ոչ մի բանկային քաղվածք ներմուծված չէ:';

  @override
  String get bankStatementsOpeningBalance => 'Ժամանակաշրջանի սկզբի մնացորդ';

  @override
  String get bankStatementsClosingBalance => 'Ժամանակաշրջանի վերջի մնացորդ';

  @override
  String get bankStatementsStatusDraft => 'Սևագիր';

  @override
  String get bankStatementsStatusInProgress => 'Համադրման ընթացքում';

  @override
  String get bankStatementsStatusReconciled => 'Համադրված';

  @override
  String get bankStatementsStatusNeedsAttention => 'Ուշադրության կարիք ունի';

  @override
  String get bankReconciliationAutoMatch => 'Ավտոմատ համադրում';

  @override
  String get bankReconciliationMatch => 'Համադրել';

  @override
  String get bankReconciliationUnmatch => 'Չեղարկել համադրումը';

  @override
  String get bankReconciliationDifference => 'Տարբերություն';

  @override
  String get bankReconciliationBalanced => 'Հավասարակշռված';

  @override
  String get bankReconciliationFinalized =>
      'Բանկային քաղվածքը հաջողությամբ համադրվեց:';

  @override
  String get bankReconciliationNoTransactions => 'Գործառնություն չի գտնվել';

  @override
  String get stockLedgerPageTitle => 'Պահեստի մատյան';

  @override
  String get stockLedgerLoadError => 'Պահեստի մատյանի բեռնման սխալ.';

  @override
  String get stockLedgerEmptyTitle => 'Մատյանում գրառումներ չկան';

  @override
  String get stockLedgerEmptyMessage =>
      'Այս ապրանքի համար պահեստի մատյանի գրառումներ չեն գտնվել:';

  @override
  String get stockLedgerWarehouseFilter => 'Զտել ըստ պահեստի';

  @override
  String get stockLedgerAllWarehouses => 'Բոլոր պահեստները';

  @override
  String get stockLedgerBalance => 'Մնացորդ';

  @override
  String get stockLedgerTotalIn => 'Ընդհանուր մուտք';

  @override
  String get stockLedgerTotalOut => 'Ընդհանուր ելք';

  @override
  String get stockLedgerTotalValue => 'Ընդհանուր արժեք';

  @override
  String get stockAdjustmentPageTitle => 'Պահեստի ճշգրտում';

  @override
  String get stockAdjustmentCreateTitle => 'Նոր ճշգրտում';

  @override
  String get stockAdjustmentLoadError => 'Ճշգրտումների բեռնման սխալ.';

  @override
  String get stockAdjustmentEmptyTitle => 'Ճշգրտումներ չկան';

  @override
  String get stockAdjustmentEmptyMessage =>
      'Դեռևս ոչ մի պահեստի ճշգրտում գրանցված չէ:';

  @override
  String get stockAdjustmentProduct => 'Ապրանք';

  @override
  String get stockAdjustmentWarehouse => 'Պահեստ';

  @override
  String get stockAdjustmentQuantity => 'Քանակ';

  @override
  String get stockAdjustmentQuantityHint =>
      'Մուտքագրեք բացասական թիվ՝ պահեստը նվազեցնելու համար';

  @override
  String get stockAdjustmentReason => 'Պատճառ';

  @override
  String get stockAdjustmentInvalidQuantity => 'Մուտքագրեք վավեր թիվ';

  @override
  String get inventoryValuationPageTitle => 'Պահեստի գնահատում';

  @override
  String get inventoryValuationLoadError => 'Գնահատման բեռնման սխալ.';

  @override
  String get inventoryValuationEmptyTitle => 'Գնահատման տվյալներ չկան';

  @override
  String get inventoryValuationEmptyMessage =>
      'Պահեստի գնահատման տվյալներ հասանելի չեն:';

  @override
  String get inventoryValuationTotalValue => 'Ընդհանուր արժեք';

  @override
  String get inventoryValuationProducts => 'Ապրանքներ';

  @override
  String get inventoryValuationWarehouses => 'Պահեստներ';

  @override
  String get inventoryValuationDate => 'Հաշվարկի ամսաթիվ';

  @override
  String get inventoryValuationQty => 'Քանակ';

  @override
  String get inventoryValuationAvgCost => 'Միջին ինքնարժեք';

  @override
  String get stockTransferPageTitle => 'Պահեստի փոխանցում';

  @override
  String get stockTransferLoadError => 'Փոխանցումների բեռնման սխալ.';

  @override
  String get stockTransferEmptyTitle => 'Փոխանցումներ չկան';

  @override
  String get stockTransferEmptyMessage =>
      'Դեռևս ոչ մի պահեստի փոխանցում գրանցված չէ:';

  @override
  String get stockTransferCreateTitle => 'Նոր փոխանցում';

  @override
  String get stockTransferProduct => 'Ապրանք';

  @override
  String get stockTransferFrom => 'Աղբյուր պահեստ';

  @override
  String get stockTransferTo => 'Նպատակակետ պահեստ';

  @override
  String get stockTransferQuantity => 'Քանակ';

  @override
  String get stockTransferNotes => 'Նշումներ';

  @override
  String get stockTransferReference => 'Հղում';

  @override
  String get stockTransferDate => 'Փոխանցման ամսաթիվ';

  @override
  String get stockTransferStatus => 'Կարգավիճակ';

  @override
  String get stockTransferStatusPending => 'Սպասման մեջ';

  @override
  String get stockTransferStatusCompleted => 'Ավարտված';

  @override
  String get stockTransferStatusCancelled => 'Չեղարկված';

  @override
  String get stockTransferSameWarehouseError =>
      'Աղբյուր և նպատակակետ պահեստները պետք է տարբեր լինեն';

  @override
  String get stockTransferInvalidQuantity => 'Քանակը պետք է զրոյից մեծ լինի';

  @override
  String get stockTransferCreateError => 'Փոխանցման ստեղծման սխալ';

  @override
  String get stockTransferCompleteAction => 'Ավարտել';

  @override
  String get stockTransferCancelAction => 'Չեղարկել փոխանցումը';

  @override
  String get stockTransferInsufficientStock =>
      'Աղբյուր պահեստում բավարար քանակ չկա';

  @override
  String get attachmentsSectionTitle => 'Կցված ֆայլեր';

  @override
  String get attachmentAdd => 'Ավելացնել';

  @override
  String get attachmentAddTitle => 'Ավելացնել կցված ֆայլ';

  @override
  String get attachmentFilename => 'Ֆայլի անուն';

  @override
  String get attachmentNotes => 'Նշումներ';

  @override
  String get attachmentLoadError => 'Կցված ֆայլերի բեռնման սխալ.';

  @override
  String get attachmentEmptyTitle => 'Կցված ֆայլեր չկան';

  @override
  String get attachmentEmptyMessage =>
      'Դեռևս ոչ մի ֆայլ կցված չէ այս փաստաթղթին:';

  @override
  String get attachmentAddError => 'Կցված ֆայլ ավելացնելու սխալ';

  @override
  String get attachmentRenameTitle => 'Վերանվանել կցված ֆայլը';

  @override
  String get attachmentRenameAction => 'Վերանվանել';

  @override
  String get attachmentEditNotesTitle => 'Խմբագրել նշումները';

  @override
  String get attachmentEditNotesAction => 'Խմբագրել նշումները';

  @override
  String get attachmentRemoveTitle => 'Հեռացնել կցված ֆայլը';

  @override
  String get attachmentRemoveAction => 'Հեռացնել';

  @override
  String attachmentRemoveConfirm(String filename) {
    return 'Հեռացնե՞լ «$filename» այս փաստաթղթից:';
  }

  @override
  String get attachmentFileSize => 'Չափ';

  @override
  String get attachmentUploadedBy => 'Ներբեռնված է';

  @override
  String get attachmentUploadedAt => 'Ներբեռնման ամսաթիվ';

  @override
  String get commentsSectionTitle => 'Մեկնաբանություններ և նշումներ';

  @override
  String get commentAdd => 'Ավելացնել մեկնաբանություն';

  @override
  String get commentAddPlaceholder => 'Գրեք մեկնաբանություն կամ ներքին նշում…';

  @override
  String get commentLoadError => 'Մեկնաբանությունների բեռնման սխալ.';

  @override
  String get commentEmptyTitle => 'Դեռևս ոչ մի մեկնաբանություն չկա';

  @override
  String get commentEmptyMessage =>
      'Թողեք առաջին մեկնաբանությունը կամ ներքին նշումը:';

  @override
  String get commentAddError => 'Մեկնաբանություն ավելացնելու սխալ';

  @override
  String get commentEditTitle => 'Խմբագրել մեկնաբանությունը';

  @override
  String get commentEditAction => 'Պահպանել';

  @override
  String get commentDeleteTitle => 'Ջնջել մեկնաբանությունը';

  @override
  String get commentDeleteAction => 'Ջնջել';

  @override
  String commentDeleteConfirm(String author) {
    return 'Ջնջե՞լ $author -ի մեկնաբանությունը:';
  }

  @override
  String get commentEditedLabel => 'Խմբագրված';

  @override
  String commentPostedBy(String author) {
    return '$author';
  }

  @override
  String get searchHint => 'Որոնել փաստաթղթեր, անուններ, ապրանքի կոդեր…';

  @override
  String get searchClear => 'Մաքրել';

  @override
  String get searchErrorMessage => 'Որոնման սխալ.';

  @override
  String get searchEmptyTitle => 'Արդյունք չի գտնվել';

  @override
  String searchEmptyMessage(String query) {
    return '«$query» որոնման համար ոչինչ չի գտնվել';
  }

  @override
  String get searchRecentTitle => 'Վերջին որոնումներ';

  @override
  String get searchRecentEmpty => 'Վերջին որոնումներ չկան';

  @override
  String get searchRecentClear => 'Մաքրել բոլորը';

  @override
  String get searchGroupCustomers => 'Հաճախորդներ';

  @override
  String get searchGroupVendors => 'Մատակարարներ';

  @override
  String get searchGroupProducts => 'Ապրանքներ';

  @override
  String get searchGroupSalesInvoices => 'Վաճառքի հաշիվ-ապրանքագրեր';

  @override
  String get searchGroupVendorBills => 'Գնման հաշիվ-ապրանքագրեր';

  @override
  String get searchGroupPurchaseOrders => 'Գնման պատվերներ';

  @override
  String get searchGroupGoodsReceipts => 'Ապրանքների ստացումներ';

  @override
  String get searchGroupBankAccounts => 'Բանկային հաշիվներ';

  @override
  String get searchGroupJournalEntries => 'Մատյանային գրանցումներ';

  @override
  String get searchGroupFiscalPeriods => 'Հաշվետու ժամանակաշրջաններ';

  @override
  String get searchPageTitle => 'Համընդհանուր որոնում';

  @override
  String get language => 'Լեզու';

  @override
  String get themeModeLabel => 'Թեմա';

  @override
  String get themeModeSystem => 'Համակարգ';

  @override
  String get themeModeLight => 'Բաց';

  @override
  String get themeModeDark => 'Մուգ';

  @override
  String get confirmPassword => 'Կրկնեք գաղտնաբառը';

  @override
  String get passwordsDoNotMatch => 'Գաղտնաբառերը չեն համընկնում';

  @override
  String get createCompany => 'Ստեղծել ընկերություն';

  @override
  String get companyLegalName => 'Իրավաբանական անուն';

  @override
  String get companyTaxId => 'Հարկային համար';

  @override
  String get tagsPageTitle => 'Պիտակներ';

  @override
  String get tagsSectionTitle => 'Պիտակներ';

  @override
  String get tagName => 'Պիտակի անուն';

  @override
  String get tagDescription => 'Նկարագրություն (ոչ պարտադիր)';

  @override
  String get tagColor => 'Գույն';

  @override
  String get tagCreateTitle => 'Նոր պիտակ';

  @override
  String get tagEditTitle => 'Խմբագրել պիտակը';

  @override
  String get tagEditAction => 'Խմբագրել';

  @override
  String get tagDeleteTitle => 'Ջնջել պիտակը';

  @override
  String get tagDeleteAction => 'Ջնջել';

  @override
  String tagDeleteConfirm(String name) {
    return 'Ջնջե՞լ «$name» պիտակը: Այն կհեռացվի բոլոր փաստաթղթերից:';
  }

  @override
  String get tagAssignTitle => 'Ավելացնել պիտակ';

  @override
  String get tagAssign => 'Ավելացնել պիտակ';

  @override
  String get tagNoAvailable => 'Բոլոր պիտակներն արդեն տրվել են';

  @override
  String get tagLoadError => 'Պիտակների բեռնման սխալ.';

  @override
  String get tagEmptyTitle => 'Առանց պիտակների';

  @override
  String get tagEmptyMessage => 'Այս փաստաթղթին ոչ մի պիտակ չի տրվել:';

  @override
  String get tagEmptyPageMessage =>
      'Դեռևս ոչ մի պիտակ սահմանված չէ: Ստեղծեք մեկը:';

  @override
  String get userRolesPageTitle => 'Օգտատերեր և դերեր';

  @override
  String get userRolesTabUsers => 'Օգտատերեր';

  @override
  String get userRolesTabRoles => 'Դերեր';

  @override
  String get userRolesAssignTitle => 'Դերի տրամադրում';

  @override
  String get userRolesDeactivate => 'Ապաակտիվացնել';

  @override
  String get userRolesLoadError => 'Բեռնման սխալ.';

  @override
  String get userRolesEmptyTitle => 'Ոչինչ չի գտնվել';

  @override
  String get userRolesEmptyMessage => 'Օգտատեր կամ դեր չի գտնվել:';

  @override
  String get userRolesUnknownRole => 'Անհայտ';

  @override
  String get userRolesCurrentUser => 'Ընթացիկ օգտատեր';

  @override
  String get permissionViewCustomers => 'Դիտել հաճախորդներին';

  @override
  String get permissionEditCustomers => 'Խմբագրել հաճախորդներին';

  @override
  String get permissionDeleteCustomers => 'Ջնջել հաճախորդներին';

  @override
  String get permissionPostJournal => 'Փակցել մատյանը';

  @override
  String get permissionCloseFiscalPeriod => 'Փակել հաշվետու ժամանակաշրջանը';

  @override
  String get permissionViewFinancialReports =>
      'Դիտել ֆինանսական հաշվետվությունները';

  @override
  String get permissionManageUsers => 'Կառավարել օգտատերերին';

  @override
  String get permissionManageRoles => 'Կառավարել դերերը';

  @override
  String get currenciesPageTitle => 'Արժույթներ';

  @override
  String get currenciesTabCurrencies => 'Արժույթներ';

  @override
  String get currenciesTabRates => 'Փոխարժեքներ';

  @override
  String get currenciesLoadError => 'Արժույթների բեռնման սխալ.';

  @override
  String get currenciesEmptyTitle => 'Արժույթ սահմանված չէ';

  @override
  String get currenciesEmptyMessage => 'Ոչ մի արժույթ կազմաձևված չէ:';

  @override
  String get currencyBadgeBase => 'Բազային';

  @override
  String get currencyBadgeInactive => 'Ոչ ակտիվ';

  @override
  String get currencySetBaseTitle => 'Սահմանել բազային արժույթ';

  @override
  String currencySetBaseConfirm(String isoCode) {
    return 'Սահմանե՞լ $isoCode որպես բազային արժույթ:';
  }

  @override
  String get currencySetBaseAction => 'Սահմանել որպես բազային';

  @override
  String get currencyEditRateTitle => 'Խմբագրել փոխարժեքը';

  @override
  String currencyRateLabel(String from, String to) {
    return '$from դիմաց $to';
  }

  @override
  String get currencyRateValue => 'Փոխարժեք';

  @override
  String get currencyRateInvalid => 'Մուտքագրեք դրական թիվ';

  @override
  String get dashboardCurrencies => 'Արժույթներ';

  @override
  String get recurringTransactionsPageTitle => 'Պարբերական գործառնություններ';

  @override
  String get recurringTransactionCreateTitle => 'Նոր պարբերական գործառնություն';

  @override
  String get recurringTransactionEditTitle =>
      'Խմբագրել պարբերական գործառնությունը';

  @override
  String get recurringTransactionsLoadError =>
      'Պարբերական գործառնությունների բեռնման սխալ.';

  @override
  String get recurringTransactionsEmptyTitle =>
      'Պարբերական գործառնություններ չկան';

  @override
  String get recurringTransactionsEmptyMessage =>
      'Դեռևս ոչ մի պարբերական գործառնություն սահմանված չէ:';

  @override
  String get recurringTransactionBadgeActive => 'Ակտիվ';

  @override
  String get recurringTransactionBadgeInactive => 'Ոչ ակտիվ';

  @override
  String get recurringTransactionNextRun => 'Հաջորդ կատարում';

  @override
  String get recurringTransactionName => 'Անուն';

  @override
  String get recurringTransactionFrequency => 'Պարբերականություն';

  @override
  String get recurringTransactionSourceId => 'Աղբյուր փաստաթղթի ID';

  @override
  String get recurringTransactionSourceType => 'Աղբյուր փաստաթղթի տիպ';

  @override
  String get recurringTransactionNotes => 'Նշումներ';

  @override
  String get recurringTransactionActivate => 'Ակտիվացնել';

  @override
  String get recurringTransactionDeactivate => 'Ապաակտիվացնել';

  @override
  String get recurringTransactionExecuteNow => 'Կատարել հիմա';

  @override
  String recurringTransactionExecuted(String name) {
    return '$name կատարվել է (փորձնական)';
  }

  @override
  String get recurringFrequencyDaily => 'Օրական';

  @override
  String get recurringFrequencyWeekly => 'Շաբաթական';

  @override
  String get recurringFrequencyMonthly => 'Ամսական';

  @override
  String get recurringFrequencyQuarterly => 'Եռամսյակային';

  @override
  String get recurringFrequencyYearly => 'Տարեկան';

  @override
  String get dashboardRecurringTransactions => 'Պարբերական գործառնություններ';

  @override
  String get fixedAssetsPageTitle => 'Հիմնական միջոցներ';

  @override
  String get fixedAssetCreateTitle => 'Նոր հիմնական միջոց';

  @override
  String get fixedAssetEditTitle => 'Խմբագրել հիմնական միջոցը';

  @override
  String get fixedAssetsLoadError => 'Հիմնական միջոցների բեռնման սխալ.';

  @override
  String get fixedAssetsEmptyTitle => 'Հիմնական միջոցներ չկան';

  @override
  String get fixedAssetsEmptyMessage =>
      'Դեռևս ոչ մի հիմնական միջոց գրանցված չէ:';

  @override
  String get fixedAssetBadgeActive => 'Ակտիվ';

  @override
  String get fixedAssetBadgeDisposed => 'Օտարված';

  @override
  String get fixedAssetName => 'Միջոցի անուն';

  @override
  String get fixedAssetCategory => 'Կատեգորիա';

  @override
  String get fixedAssetPurchaseCost => 'Գնման ինքնարժեք';

  @override
  String get fixedAssetSalvageValue => 'Մնացորդային արժեք';

  @override
  String get fixedAssetUsefulLife => 'Օգտակար ծառայության ժամկետ (տարի)';

  @override
  String get fixedAssetDepreciationMethod => 'Մաշվածքի մեթոդ';

  @override
  String get fixedAssetMethodStraightLine => 'Գծային';

  @override
  String get fixedAssetMethodDecliningBalance => 'Նվազող մնացորդ';

  @override
  String get fixedAssetNotes => 'Նշումներ';

  @override
  String get fixedAssetBookValue => 'Հաշվապահական արժեք';

  @override
  String get fixedAssetAccumDepreciation => 'Կուտակված մաշվածք';

  @override
  String get fixedAssetDispose => 'Օտարել միջոցը';

  @override
  String get fixedAssetCalculateDepreciation => 'Կիրառել մաշվածք';

  @override
  String get fixedAssetViewSchedule => 'Դիտել մաշվածքի աղյուսակը';

  @override
  String get fixedAssetScheduleTitle => 'Մաշվածքի աղյուսակ';

  @override
  String get fixedAssetScheduleYear => 'Տարի';

  @override
  String get fixedAssetScheduleOpening => 'Բացման մնացորդ';

  @override
  String get fixedAssetScheduleCharge => 'Մաշվածք';

  @override
  String get fixedAssetScheduleAccum => 'Կուտակված';

  @override
  String get fixedAssetScheduleClosing => 'Փակման մնացորդ';

  @override
  String get fixedAssetInvalidNumber => 'Մուտքագրեք վավեր դրական թիվ';

  @override
  String get dashboardFixedAssets => 'Հիմնական միջոցներ';

  @override
  String get importExportPageTitle => 'Ներմուծում / Արտահանում';

  @override
  String get importExportSelectEntity => 'Ընտրել սուբյեկտի տիպ';

  @override
  String get importExportExportBtn => 'Արտահանել CSV';

  @override
  String get importExportImportBtn => 'Ներմուծել CSV';

  @override
  String get importExportRecentJobs => 'Վերջին գործողություններ';

  @override
  String get importExportLoadError => 'Գործողությունների բեռնման սխալ.';

  @override
  String get importExportEmptyTitle => 'Ոչ մի գործողություն չի կատարվել';

  @override
  String get importExportEmptyMessage =>
      'Կատարեք արտահանման կամ ներմուծման գործողություն՝ արդյունքները տեսնելու համար:';

  @override
  String get importExportRows => 'Տող';

  @override
  String get importExportDirectionExport => 'Արտահանում';

  @override
  String get importExportDirectionImport => 'Ներմուծում';

  @override
  String get importExportStatusSuccess => 'Հաջողված';

  @override
  String get importExportStatusFailed => 'Ձախողված';

  @override
  String get importExportPreviewBtn => 'CSV նախադիտում';

  @override
  String get importExportPreviewTitle => 'CSV նախադիտում';

  @override
  String get dashboardImportExport => 'Ներմուծում / Արտահանում';

  @override
  String get crmDashboard => 'CRM վահանակ';

  @override
  String get pipeline => 'Վաճառքի խողովակ';

  @override
  String get newOpportunity => 'Նոր հնարավորություն';

  @override
  String get noOpportunities => 'Դեռևս ոչ մի հնարավորություն գրանցված չէ';

  @override
  String get tasks => 'Առաջադրանքներ';

  @override
  String get newTask => 'Նոր առաջադրանք';

  @override
  String get noTasks => 'Դեռևս ոչ մի առաջադրանք գրանցված չէ';

  @override
  String get title => 'Վերնագիր';

  @override
  String get description => 'Նկարագրություն';

  @override
  String get dueDate => 'Վճարման վերջնաժամկետ';

  @override
  String get priority => 'Առաջնահերթություն';

  @override
  String get cancel => 'Չեղարկել';

  @override
  String get create => 'Ստեղծել';

  @override
  String get saveButton => 'Պահպանել';

  @override
  String get contactsPageTitle => 'Կոնտակտներ';

  @override
  String get contactsLoadError => 'Կոնտակտների բեռնման սխալ.';

  @override
  String get contactsEmptyTitle => 'Դեռևս ոչ մի կոնտակտ գրանցված չէ';

  @override
  String get contactsEmptyMessage => 'Դեռևս ոչ մի կոնտակտ ավելացված չէ:';

  @override
  String get contactCreateTitle => 'Ավելացնել կոնտակտ';

  @override
  String get contactEditTitle => 'Խմբագրել կոնտակտը';

  @override
  String get contactDeleteTitle => 'Ջնջել կոնտակտը';

  @override
  String get contactFirstName => 'Անուն';

  @override
  String get contactLastName => 'Ազգանուն';

  @override
  String get contactEmail => 'Էլ. փոստ';

  @override
  String get contactPhone => 'Հեռախոս';

  @override
  String get contactJobTitle => 'Պաշտոն';

  @override
  String get contactDepartment => 'Բաժին';

  @override
  String get contactPrimary => 'Հիմնական կոնտակտ';

  @override
  String get contactPrimaryLabel => 'Հիմնական';

  @override
  String get contactNotes => 'Նշումներ';

  @override
  String get interactionsSectionTitle => 'Փոխազդեցություններ';

  @override
  String get interactionAddTitle => 'Ավելացնել փոխազդեցություն';

  @override
  String get interactionType => 'Տիպ';

  @override
  String get interactionSubject => 'Թեմա';

  @override
  String get interactionDescription => 'Նկարագրություն';

  @override
  String get interactionAdd => 'Ավելացնել';

  @override
  String get interactionsLoadError => 'Փոխազդեցությունների բեռնման սխալ.';

  @override
  String get interactionsEmptyTitle =>
      'Դեռևս ոչ մի փոխազդեցություն գրանցված չէ';

  @override
  String get interactionsEmptyMessage =>
      'Այս կոնտակտի համար ոչ մի փոխազդեցություն գրանցված չէ:';

  @override
  String get docProcessingQueueTitle => 'Փաստաթղթերի մշակման հերթ';

  @override
  String get docProcessingQueueLoading => 'Հերթը բեռնվում է';

  @override
  String get docProcessingQueueLoadError => 'Հերթի բեռնման սխալ.';

  @override
  String get docProcessingQueueEmptyTitle => 'Հերթը դատարկ է';

  @override
  String get docProcessingQueueEmptyMessage =>
      'Ոչ մի փաստաթուղթ սպասման մեջ չէ:';

  @override
  String get docProcessingJobId => 'Աշխատանքի ID';

  @override
  String get docReviewPageTitle => 'Փաստաթղթի վերանայում';

  @override
  String get docReviewDocumentSection => 'Փաստաթուղթ';

  @override
  String get docReviewAttachment => 'Կցված ֆայլ';

  @override
  String get docReviewStatus => 'Կարգավիճակ';

  @override
  String get docReviewDocumentType => 'Փաստաթղթի տիպ';

  @override
  String get docReviewConfidence => 'Վստահություն';

  @override
  String get docReviewExtractedSection => 'Արդյունահանված տվյալներ';

  @override
  String get docReviewNoteSection => 'Վերանայման նշում';

  @override
  String get docReviewNoteHint => 'Ոչ պարտադիր նշում այս որոշման համար…';

  @override
  String get docReviewApproveAction => 'Հաստատել';

  @override
  String get docReviewRejectAction => 'Մերժել';

  @override
  String get docReviewRejectTitle => 'Մերժել փաստաթուղթը';

  @override
  String get docReviewRejectNoteLabel => 'Մերժման պատճառ';

  @override
  String get docReviewRejectConfirm => 'Մերժել';

  @override
  String get docReviewRejectedDefault => 'Մերժված է վերանայողի կողմից';

  @override
  String get docReviewDecisionSection => 'Վերանայման որոշում';

  @override
  String get docReviewDecisionOutcome => 'Արդյունք';

  @override
  String get docReviewDecisionBy => 'Վերանայվել է';

  @override
  String get docReviewDecisionNote => 'Նշում';

  @override
  String get docReviewJournalPreviewTitle => 'Մատյանային գրանցման նախադիտում';

  @override
  String get docReviewPostAndCreate => 'Փակցնել և ստեղծել';

  @override
  String get aiAssistantTitle => 'ԱԻ Օգնական';

  @override
  String get aiAssistantEmptyMessage =>
      'Հարցրեք ձեր բիզնեսի մասին — եկամուտ, դրամարկղ, հաշիվ-ապրանքագրեր, հաճախորդներ կամ խնդրեք գործողության առաջարկ։';

  @override
  String get aiAssistantHint => 'Հարցրեք ձեր բիզնեսի մասին…';

  @override
  String get aiAssistantSend => 'Ուղարկել';

  @override
  String get aiAssistantError => 'Ներեցեք, չկարողացա պատասխանել։ Փորձեք կրկին։';

  @override
  String get aiAssistantYou => 'Դուք';

  @override
  String get aiAssistantAssistant => 'Օգնական';

  @override
  String get aiAssistantThinking => 'Մտածում եմ…';

  @override
  String get aiAssistantConfirmTitle => 'Հաստատել ԱԻ գործողությունը';

  @override
  String aiAssistantConfirmBody(Object description) {
    return 'Այս առաջարկը պահանջում է ձեր հաստատումը և կգրանցվի աուդիտի մատյանում՝\n\n$description';
  }

  @override
  String get aiAssistantConfirmAction => 'Հաստատել և գրանցել';

  @override
  String get aiAssistantActionLogged =>
      'ԱԻ գործողությունը հաստատվել և գրանցվել է աուդիտի մատյանում։';

  @override
  String get aiAssistantActionFailed =>
      'ԱԻ գործողությունը հնարավոր չեղավ կատարել։';

  @override
  String get guidanceTourNext => 'Հաջորդը';

  @override
  String get guidanceTourSkip => 'Բաց թողնել';

  @override
  String get guidanceTourDone => 'Ավարտել';

  @override
  String guidanceTourStepCount(Object current, Object total) {
    return 'Քայլ $current՝ $total-ից';
  }

  @override
  String get guidanceWelcomeTitle => 'Բարի գալուստ ձեր վահանակ';

  @override
  String get guidanceWelcomeBody =>
      'Սա ձեր ֆինանսական հրամանատարական կենտրոնն է։ Այն ամենը, ինչ գրանցում եք՝ հաշիվ-ապրանքագրեր, վճարումներ և պաշարներ, ցուցադրվում է այստեղ։';

  @override
  String get guidanceQuickActionsTitle => 'Արագ գործողություններ';

  @override
  String get guidanceQuickActionsBody =>
      'Անմիջապես անցեք սովորական գործողություններին՝ վաճառքի հաշիվ-ապրանքագիր ստեղծելը, վճարում գրանցելը կամ մատյանը դիտելը։';

  @override
  String get guidanceMetricsTitle => 'Հիմնական ցուցիչներ';

  @override
  String get guidanceMetricsBody =>
      'Հետևեք դեբիտորական և կրեդիտորական պարտքերին, պաշարներին ու կանխիկ միջոցներին մի հայացքով։';

  @override
  String get guidancePerformanceTitle => 'Կատարողականը';

  @override
  String get guidancePerformanceBody =>
      'Դիագրամներն ու շահույթի ամփոփումը ցույց են տալիս ձեր եկամուտը, ծախսերը և շահութաբերությունը ժամանակի ընթացքում։';

  @override
  String get guidanceNavigationTitle => 'Հիմնական նավիգացիա';

  @override
  String get guidanceNavigationBody =>
      'Այս վահանակից ուսումնասիրեք Վաճառք, Գնում, Բանկային և Հաշվետվություններ բաժինները։';

  @override
  String get guidanceBankingTitle => 'Բանկային';

  @override
  String get guidanceBankingBody =>
      'Կառավարեք բանկային հաշիվները և համադրեք քաղվածքները այստեղից։';

  @override
  String get guidanceReportsTitle => 'Հաշվետվություններ';

  @override
  String get guidanceReportsBody =>
      'Այստեղից բացեք ֆինանսական հաշվետվությունները, գլխավոր մատյանը և մատյան որոնողը։';

  @override
  String get guidanceSearchTitle => 'Գլոբալ որոնում';

  @override
  String get guidanceSearchBody => 'Որոնեք ամբողջ հավելվածում այստեղից։';

  @override
  String get guidanceLanguageTitle => 'Լեզու և թեմա';

  @override
  String get guidanceLanguageBody =>
      'Անցեք ֆարսի, անգլերենի կամ հայերենի միջև, և փոխեք բաց/մուգ թեման։';

  @override
  String get guidanceNotificationsTitle => 'Ծանուցումներ';

  @override
  String get guidanceNotificationsBody =>
      'Ծանուցումները ձեզ տեղյակ են պահում ժամկետանց և հաստատման սպասող հարցերի մասին։';

  @override
  String get guidanceReadyTitle => 'Ամեն ինչ պատրաստ է';

  @override
  String get guidanceReadyBody =>
      'Երբ օգնության կարիք ունենաք, բացեք մենյուն և ընտրեք AI Assistant-ը. այն կարող է պատասխանել ձեր բիզնեսի մասին հարցերին։ Այժմ պատրաստ եք սկսել։';

  @override
  String get conceptHelpWhatDoesThisMean => 'Ի՞նչ է սա նշանակում';

  @override
  String get conceptHelpGotIt => 'Հասկացա';

  @override
  String get conceptInvoiceTitle => 'Հաշիվ-ապրանքագիր';

  @override
  String get conceptInvoiceBody =>
      'Հաշիվ-ապրանքագիրը հաշիվ է, որը ուղարկում եք հաճախորդին մատուցած ապրանքների կամ ծառայությունների համար։ Այն ցույց է տալիս, թե ինչքան է նա պարտք և երբ է վճարման ժամկետը։';

  @override
  String get conceptReceivableTitle => 'Դեբիտորական պարտքեր';

  @override
  String get conceptReceivableBody =>
      'Դեբիտորական պարտքերը այն գումարն է, որը հաճախորդները դեռ պարտք են արդեն ուղարկված հաշիվ-ապրանքագրերի համար։ Այն ցույց է տալիս, թե ինչ գումարներ են մուտք լինելու և օգնում է հետևել ժամկետանց վճարումներին։';

  @override
  String get conceptProfitTitle => 'Շահույթ';

  @override
  String get conceptProfitBody =>
      'Շահույթը մնում է այն բանից հետո, երբ ծախսերը հանում եք եկամուտից։ Համախառն շահույթը որոշ ծախսերից առաջ է, իսկ զուտ շահույթը ձեր վերջնական արդյունքն է։';

  @override
  String get conceptPaymentTitle => 'Վճարում';

  @override
  String get conceptPaymentBody =>
      'Վճարումը հաճախորդից ստացված (կամ մատակարարին ուղարկված) գումար է՝ հաշիվ-ապրանքագիրը կամ հաշիվը փակելու համար։ Այստեղ գրանցելը պահում է ձեր մնացորդները ճշգրիտ։';

  @override
  String get conceptBankReconciliationTitle => 'Բանկային համադրում';

  @override
  String get conceptBankReconciliationBody =>
      'Բանկային համադրումը ձեր գրանցված գործարքների համեմատումն է իրական բանկային քաղվածքի հետ՝ հայտնաբերելու բաց թողած կամ չհամընկնող գործարքները և հաստատելու մնացորդների ճշգրտությունը։';

  @override
  String get workflowCopilotTitle => 'Աշխատանքային ուղեցույց';

  @override
  String get workflowCopilotSubtitle =>
      'Ուղղորդվող առաջադրանքներ, որոնք քայլ առ քայլ անցկացնում են հաշվապահական սովորական գործողություններով։';

  @override
  String get workflowStartTask => 'Սկսել';

  @override
  String get workflowResumeTask => 'Շարունակել';

  @override
  String get workflowCompletedTaskLabel => 'Ավարտված';

  @override
  String workflowStepsProgress(Object current, Object total) {
    return '$current՝ $total-ից քայլ';
  }

  @override
  String get workflowWhyThisMatters => 'Ինչու է այս քայլը կարևոր';

  @override
  String workflowStepCount(Object current, Object total) {
    return 'Քայլ $current՝ $total-ից';
  }

  @override
  String get workflowCancel => 'Չեղարկել';

  @override
  String get workflowResumeLater => 'Շարունակել ավելի ուշ';

  @override
  String get workflowNext => 'Հաջորդը';

  @override
  String get workflowFinish => 'Ավարտել';

  @override
  String get workflowCreateInvoiceTaskTitle =>
      'Ստեղծեք ձեր առաջին հաշիվ-ապրանքագիրը';

  @override
  String get workflowCreateInvoiceTaskDescription =>
      'Վաճառքը վերածեք պաշտոնական հաշիվ-ապրանքագրի և հետևեք դրա վերածմանը դեբիտորական պարտքի։';

  @override
  String get workflowCreateInvoiceStep1Title => 'Բացեք վաճառքի մոդուլը';

  @override
  String get workflowCreateInvoiceStep1Body =>
      'Այստեղ գրանցում եք, թե հաճախորդները ինչքան են պարտք։ Հաշիվ-ապրանքագիրը վճարման պաշտոնական հարցումն է, որը ստեղծում է այն դեբիտորական պարտքը, որին հետևում է հավելվածը։';

  @override
  String get workflowCreateInvoiceStep2Title => 'Սկսեք նոր հաշիվ-ապրանքագիր';

  @override
  String get workflowCreateInvoiceStep2Body =>
      '«Նոր հաշիվ-ապրանքագիր» կոճակը բացում է ձևաթուղթ, որտեղ մուտքագրում եք հաճախորդին և գումարը։ Մանրամասները հետո կարող եք խմբագրել. սկսեք անհրաժեշտ տվյալներից։';

  @override
  String get workflowCreateInvoiceStep3Title => 'Հաստատեք դեբիտորական պարտքը';

  @override
  String get workflowCreateInvoiceStep3Body =>
      'Վահանակում դեբիտորական պարտքերի ցուցիչն այժմ ներառում է ձեր հաշիվ-ապրանքագիրը։ Դա այն գումարն է, որին ձեր բիզնեսը ակնկալում է ստանալ։';

  @override
  String get workflowRecordPaymentTaskTitle => 'Գրանցեք հաճախորդի վճարումը';

  @override
  String get workflowRecordPaymentTaskDescription =>
      'Գրանցեք ստացված գումարը, որպեսզի մնացորդները ճշգրիտ մնան։';

  @override
  String get workflowRecordPaymentStep1Title => 'Բացեք հաճախորդի վճարումները';

  @override
  String get workflowRecordPaymentStep1Body =>
      'Վճարումները նվազեցնում են հաճախորդների պարտքը։ Այստեղ գրանցելը թույլ չի տալիս, որ ձեր դեբիտորական պարտքերն իրականությունից մեծ երևան։';

  @override
  String get workflowRecordPaymentStep2Title => 'Գրանցեք վճարումը';

  @override
  String get workflowRecordPaymentStep2Body =>
      'Գրանցման կոճակով գումարը կապեք ճիշտ հաճախորդի և հաշիվ-ապրանքագրի հետ։ Հավելվածն ինքնաբերաբար թարմացնում է մնացորդը։';

  @override
  String get workflowRecordPaymentStep3Title => 'Տեսեք թարմացված մնացորդը';

  @override
  String get workflowRecordPaymentStep3Body =>
      'Ձեր դեբիտորական պարտքերի գումարը վահանակում նվազում է վճարված չափով՝ իրական պատկերն այն մասին, թե ինչքան դեռ պարտք են։';

  @override
  String get workflowReviewReceivablesTaskTitle =>
      'Ստուգեք, թե ովքեր են ձեզ պարտք';

  @override
  String get workflowReviewReceivablesTaskDescription =>
      'Հասկացեք ձեր դեբիտորական պարտքերը և որոշեք, թե որ հաճախորդների հետ շփվել։';

  @override
  String get workflowReviewReceivablesStep1Title =>
      'Բացեք ձեր ֆինանսական հաշվետվությունները';

  @override
  String get workflowReviewReceivablesStep1Body =>
      'Հաշվետվությունները միավորում են ձեր բիզնեսի թվերը մեկ տեղում։ Վաճառքի և դեբիտորական տվյալները ցույց են տալիս, թե ով և ինչքան է ձեզ պարտք։';

  @override
  String get workflowReviewReceivablesStep2Title =>
      'Ստուգեք դեբիտորական ամփոփումը';

  @override
  String get workflowReviewReceivablesStep2Body =>
      'Դեբիտորական պարտքերի ցուցիչը վահանակում ամփոփում է ընդհանուր մնացորդն ու ժամկետանց գումարները, որպեսզի իմանաք, թե որտեղից սկսել։';
}
