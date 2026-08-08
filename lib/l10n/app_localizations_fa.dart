// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'حسابداری';

  @override
  String get login => 'ورود';

  @override
  String get signup => 'ثبت نام';

  @override
  String get email => 'ایمیل';

  @override
  String get password => 'رمز عبور';

  @override
  String get requiredField => 'این فیلد الزامی است';

  @override
  String get signupTodoMessage => 'ثبت‌نام در حال حاضر در دسترس نیست.';

  @override
  String pageNotFound(Object path) {
    return 'صفحه‌ای با این مسیر یافت نشد: $path';
  }

  @override
  String get dashboard => 'داشبورد';

  @override
  String get invoicePageTitle => 'فاکتورها';

  @override
  String get invoiceAddTitle => 'افزودن فاکتور';

  @override
  String get invoiceEditTitle => 'ویرایش فاکتور';

  @override
  String get invoiceCustomer => 'نام مشتری';

  @override
  String get invoiceAmount => 'مبلغ';

  @override
  String get invoiceStatus => 'وضعیت';

  @override
  String get invoiceDescription => 'توضیحات';

  @override
  String get invoiceCancel => 'انصراف';

  @override
  String get invoiceCreate => 'ایجاد';

  @override
  String get invoiceSave => 'ذخیره';

  @override
  String get invoiceRequiredField => 'این فیلد الزامی است';

  @override
  String get invoiceStatusPending => 'در انتظار';

  @override
  String get invoiceLoadError => 'خطا در بارگذاری فاکتورها:';

  @override
  String get invoiceEmptyTitle => 'هنوز فاکتوری ثبت نشده است';

  @override
  String get invoiceEmptyMessage => 'هیچ فاکتوری ثبت نشده است.';

  @override
  String get invoiceEditAction => 'ویرایش';

  @override
  String get invoiceDeleteAction => 'حذف';

  @override
  String get invoiceCurrencyUnit => 'ریال';

  @override
  String get refresh => 'تازه‌سازی';

  @override
  String get dashboardOverview => 'نمای کلی فعالیت‌های حسابداری';

  @override
  String get dashboardSubtitle => 'شاخص‌های کلیدی برای دوره جاری';

  @override
  String get dashboardRevenue => 'درآمد';

  @override
  String get dashboardExpenses => 'هزینه‌ها';

  @override
  String get dashboardOutstandingInvoices => 'فاکتورهای معوق';

  @override
  String get dashboardCashFlow => 'جریان نقد';

  @override
  String get dashboardLoadError => 'خطا در بارگذاری داده‌های داشبورد:';

  @override
  String get dashboardLoading => 'در حال بارگذاری داشبورد';

  @override
  String get dashboardFinancialSubtitle =>
      'شاخص‌های مالی تجمیع‌شده از داده‌های آزمایشی';

  @override
  String get dashboardAccountsReceivable => 'حساب‌های دریافتنی';

  @override
  String get dashboardTotalOutstandingInvoices => 'کل فاکتورهای معوق';

  @override
  String get dashboardOverdueInvoices => 'فاکتورهای سررسید گذشته';

  @override
  String get dashboardReceivedThisMonth => 'مبلغ دریافتی این ماه';

  @override
  String get dashboardAccountsPayable => 'حساب‌های پرداختنی';

  @override
  String get dashboardOutstandingVendorBills => 'صورتحساب‌های معوق تأمین‌کننده';

  @override
  String get dashboardOverdueBills => 'صورتحساب‌های سررسید گذشته';

  @override
  String get dashboardPaymentsMadeThisMonth => 'پرداخت‌های انجام‌شده این ماه';

  @override
  String get dashboardInventory => 'موجودی';

  @override
  String get dashboardProductCount => 'تعداد محصولات';

  @override
  String get dashboardLowStockProducts => 'محصولات با موجودی کم';

  @override
  String get dashboardTotalStockQuantity => 'کل موجودی انبار';

  @override
  String get dashboardWarehouseCount => 'تعداد انبارها';

  @override
  String get dashboardCashPosition => 'وضعیت نقدینگی';

  @override
  String get dashboardCash => 'نقد';

  @override
  String get dashboardBank => 'بانک';

  @override
  String get dashboardTotalLiquidAssets => 'کل دارایی‌های نقد';

  @override
  String get dashboardMonthlyRevenue => 'درآمد ماهانه';

  @override
  String get dashboardMonthlyExpenses => 'هزینه‌های ماهانه';

  @override
  String get dashboardProfitOverview => 'نمای کلی سود';

  @override
  String get dashboardGrossProfit => 'سود ناخالص';

  @override
  String get dashboardNetProfit => 'سود خالص';

  @override
  String get dashboardRecentActivity => 'فعالیت‌های اخیر';

  @override
  String get dashboardNoRecentActivity => 'فعالیت اخیری وجود ندارد';

  @override
  String get dashboardQuickActions => 'اقدامات سریع';

  @override
  String get dashboardCreateSalesInvoice => 'ایجاد فاکتور فروش';

  @override
  String get dashboardCreateVendorBill => 'ایجاد صورتحساب تأمین‌کننده';

  @override
  String get dashboardReceiveCustomerPayment => 'دریافت پرداخت مشتری';

  @override
  String get dashboardRecordVendorPayment => 'ثبت پرداخت تأمین‌کننده';

  @override
  String get dashboardViewJournal => 'مشاهده دفتر روزنامه';

  @override
  String get dashboardActivityPurchaseOrder => 'سفارش خرید';

  @override
  String get dashboardActivityGoodsReceipt => 'رسید کالا';

  @override
  String get dashboardActivityVendorBill => 'صورتحساب تأمین‌کننده';

  @override
  String get dashboardActivityVendorPayment => 'پرداخت تأمین‌کننده';

  @override
  String get dashboardActivitySalesInvoice => 'فاکتور فروش';

  @override
  String get dashboardActivityCustomerPayment => 'دریافت مشتری';

  @override
  String get dashboardActivityJournalEntry => 'سند حسابداری';

  @override
  String get expensesPageTitle => 'هزینه‌ها';

  @override
  String get expensesLoadError => 'خطا در بارگذاری هزینه‌ها:';

  @override
  String get expensesEmptyTitle => 'هزینه‌ای موجود نیست';

  @override
  String get expensesEmptyMessage => 'هنوز هزینه‌ای ثبت نشده است.';

  @override
  String get reportsPageTitle => 'گزارش‌ها';

  @override
  String get reportsLoadError => 'خطا در بارگذاری گزارش‌ها:';

  @override
  String get reportsEmptyTitle => 'گزارشی موجود نیست';

  @override
  String get reportsEmptyMessage => 'هنوز گزارشی ایجاد نشده است.';

  @override
  String get financialReportsPageTitle => 'گزارش‌های مالی';

  @override
  String get financialReportsLoadingMessage => 'در حال بارگذاری گزارش‌های مالی';

  @override
  String get financialReportsNoReportsTitle => 'گزارشی موجود نیست';

  @override
  String get financialReportsNoReportsMessage =>
      'برای دوره انتخاب‌شده داده‌ای در دسترس نیست.';

  @override
  String get financialReportsTrialBalance => 'تراز آزمایشی';

  @override
  String get financialReportsBalanceSheet => 'ترازنامه';

  @override
  String get financialReportsCashFlow => 'جریان نقد';

  @override
  String get financialReportsSearchAccount => 'جست‌وجوی حساب';

  @override
  String get financialReportsStartLabel => 'از';

  @override
  String get financialReportsEndLabel => 'تا';

  @override
  String get financialReportsFilterAll => 'همه';

  @override
  String get financialReportsFilterDebit => 'بدهکار';

  @override
  String get financialReportsFilterCredit => 'بستانکار';

  @override
  String get financialReportsArAging => 'AR Aging';

  @override
  String get financialReportsApAging => 'AP Aging';

  @override
  String get financialReportsRevenue => 'درآمد';

  @override
  String get financialReportsExpenses => 'هزینه‌ها';

  @override
  String get financialReportsNetProfit => 'سود خالص';

  @override
  String get financialReportsBalanced => 'تراز';

  @override
  String get financialReportsYes => 'بله';

  @override
  String get financialReportsNo => 'خیر';

  @override
  String get financialReportsProfitAndLoss => 'صورت سود و زیان';

  @override
  String get financialReportsAccountCode => 'کد حساب';

  @override
  String get financialReportsAccountName => 'نام حساب';

  @override
  String get financialReportsDebit => 'بدهکار';

  @override
  String get financialReportsCredit => 'بستانکار';

  @override
  String get financialReportsEndingBalance => 'مانده نهایی';

  @override
  String get financialReportsAssets => 'دارایی‌ها';

  @override
  String get financialReportsLiabilities => 'بدهی‌ها';

  @override
  String get financialReportsEquity => 'حقوق صاحبان سهام';

  @override
  String get financialReportsCash => 'نقد';

  @override
  String get financialReportsBank => 'بانک';

  @override
  String get financialReportsReceivables => 'دریافتنی‌ها';

  @override
  String get financialReportsInventory => 'موجودی';

  @override
  String get financialReportsPayables => 'پرداختنی‌ها';

  @override
  String get financialReportsCapital => 'سرمایه';

  @override
  String get financialReportsOperatingActivities => 'فعالیت‌های عملیاتی';

  @override
  String get reportPeriodLabel => 'دوره';

  @override
  String get reportSelectLabel => 'انتخاب گزارش';

  @override
  String get supportedFiltersLabel => 'فیلترهای پشتیبانی‌شده';

  @override
  String get exportOptionsLabel => 'گزینه‌های خروجی';

  @override
  String get mockOnlyLabel => 'فقط شبیه‌سازی';

  @override
  String get revenueSummaryLabel => 'درآمد';

  @override
  String get expensesSummaryLabel => 'هزینه‌ها';

  @override
  String get netIncomeSummaryLabel => 'سود خالص';

  @override
  String get cashBalanceSummaryLabel => 'مانده نقد';

  @override
  String get settingsPageTitle => 'تنظیمات';

  @override
  String get settingsLoadError => 'امکان بارگذاری تنظیمات وجود ندارد';

  @override
  String get customersPageTitle => 'مشتریان';

  @override
  String get customersLoadError => 'خطا در بارگذاری مشتریان:';

  @override
  String get customersEmptyTitle => 'مشتری‌ای موجود نیست';

  @override
  String get customersEmptyMessage => 'هنوز مشتری‌ای ثبت نشده است.';

  @override
  String get customerAddTitle => 'افزودن مشتری';

  @override
  String get customerEditTitle => 'ویرایش مشتری';

  @override
  String get customerName => 'نام';

  @override
  String get customerCompany => 'شرکت';

  @override
  String get customerEmail => 'ایمیل';

  @override
  String get customerPhone => 'تلفن';

  @override
  String get customerBalance => 'مانده معوق';

  @override
  String get customerStatus => 'وضعیت';

  @override
  String get customerNotes => 'یادداشت';

  @override
  String get customerCreate => 'ایجاد';

  @override
  String get customerSave => 'ذخیره';

  @override
  String get generalLedgerPageTitle => 'دفتر کل';

  @override
  String get generalLedgerLoadError => 'خطا در بارگذاری دفتر کل:';

  @override
  String get generalLedgerEmptyTitle => 'داده‌ای برای دفتر کل موجود نیست';

  @override
  String get generalLedgerEmptyMessage =>
      'هنوز داده‌ای برای دفتر کل در دسترس نیست.';

  @override
  String get generalLedgerSearchHint => 'جست‌وجوی حساب‌ها';

  @override
  String get generalLedgerActive => 'فعال';

  @override
  String get generalLedgerInactive => 'غیرفعال';

  @override
  String get generalLedgerBalanced => 'تراز';

  @override
  String get generalLedgerUnbalanced => 'نامتوازن';

  @override
  String get chartOfAccountsTitle => 'طرح حساب‌ها';

  @override
  String get journalEntriesTitle => 'سندهای حسابداری';

  @override
  String get trialBalanceTitle => 'تراز آزمایشی';

  @override
  String get ledgerAccountTypeLabel => 'نوع';

  @override
  String get ledgerOpeningBalanceLabel => 'مانده افتتاحیه';

  @override
  String get ledgerCurrentBalanceLabel => 'مانده فعلی';

  @override
  String get ledgerActiveLabel => 'فعال';

  @override
  String get ledgerAccountAsset => 'دارایی';

  @override
  String get ledgerAccountLiability => 'بدهی';

  @override
  String get ledgerAccountEquity => 'حقوق صاحبان سهام';

  @override
  String get ledgerAccountRevenue => 'درآمد';

  @override
  String get ledgerAccountExpense => 'هزینه';

  @override
  String get journalEntryDetailTitle => 'سند حسابداری';

  @override
  String get journalEntryReferenceLabel => 'مرجع';

  @override
  String get journalEntryDateLabel => 'تاریخ';

  @override
  String get journalEntryMemoLabel => 'یادداشت';

  @override
  String get journalEntryLinesLabel => 'ردیف‌ها';

  @override
  String get journalEntryNoMemo => 'بدون یادداشت';

  @override
  String get journalEntryLineDefault => 'ردیف سند';

  @override
  String get journalEntryDebit => 'بدهکار';

  @override
  String get journalEntryCredit => 'بستانکار';

  @override
  String get accountDetailPageTitle => 'جزئیات حساب';

  @override
  String get accountDetailLoadingMessage => 'در حال بارگذاری جزئیات حساب';

  @override
  String get accountDetailBalanceLabel => 'مانده فعلی';

  @override
  String get accountDetailTransactionsTitle => 'معاملات';

  @override
  String get accountDetailNoTransactionsTitle => 'معامله‌ای وجود ندارد';

  @override
  String get accountDetailNoTransactionsMessage =>
      'این حساب هنوز معامله‌ای ندارد.';

  @override
  String get trialBalanceDebitLabel => 'بدهکار';

  @override
  String get trialBalanceCreditLabel => 'بستانکار';

  @override
  String get inventoryPageTitle => 'موجودی';

  @override
  String get inventoryLoadError => 'خطا در بارگذاری موجودی:';

  @override
  String get inventoryEmptyTitle => 'محصولی موجود نیست';

  @override
  String get inventoryEmptyMessage => 'هنوز محصولی در دسترس نیست.';

  @override
  String get inventorySearchHint => 'جست‌وجوی محصولات';

  @override
  String get inventoryCategoryFilter => 'فیلتر دسته‌بندی';

  @override
  String get inventoryAllCategories => 'همه دسته‌بندی‌ها';

  @override
  String get inventoryAddProduct => 'افزودن محصول';

  @override
  String get inventoryEditProduct => 'ویرایش محصول';

  @override
  String get inventoryDeleteProduct => 'حذف محصول';

  @override
  String get inventoryCreate => 'ایجاد';

  @override
  String get inventorySave => 'ذخیره';

  @override
  String get inventorySku => 'SKU';

  @override
  String get inventoryName => 'نام';

  @override
  String get inventoryDescription => 'توضیحات';

  @override
  String get inventoryCategory => 'دسته‌بندی';

  @override
  String get inventoryUnit => 'واحد';

  @override
  String get inventoryPrice => 'قیمت';

  @override
  String get inventoryStockOnHand => 'موجودی فعلی';

  @override
  String get inventoryActive => 'فعال';

  @override
  String get inventoryWarehousesTitle => 'انبارها';

  @override
  String get inventoryWarehousesLoadError => 'خطا در بارگذاری انبارها:';

  @override
  String get inventoryWarehousesEmptyTitle => 'انباری موجود نیست';

  @override
  String get inventoryWarehousesEmptyMessage => 'هنوز انباری در دسترس نیست.';

  @override
  String get inventoryStockDetailLoadError => 'خطا در بارگذاری جزئیات موجودی:';

  @override
  String get inventoryStockDetailEmptyTitle => 'حرکت موجودی وجود ندارد';

  @override
  String get inventoryStockDetailEmptyMessage =>
      'این محصول هنوز حرکت موجودی ندارد.';

  @override
  String get inventoryStockDetailQuantity => 'موجودی فعلی';

  @override
  String get inventoryStockDetailWarehouse => 'انبار';

  @override
  String get inventoryStockDetailMovementHistory => 'تاریخچه حرکت‌ها';

  @override
  String get inventoryStockDetailNoWarehouse => 'انباری اختصاص داده نشده است';

  @override
  String get purchaseOrdersPageTitle => 'سفارش‌های خرید';

  @override
  String get purchaseOrdersLoadError => 'خطا در بارگذاری سفارش‌های خرید:';

  @override
  String get purchaseOrdersEmptyTitle => 'سفارش خریدی موجود نیست';

  @override
  String get purchaseOrdersEmptyMessage => 'هنوز سفارش خرید ثبت نشده است.';

  @override
  String get purchaseOrderAddTitle => 'افزودن سفارش خرید';

  @override
  String get purchaseOrderEditTitle => 'ویرایش سفارش خرید';

  @override
  String get purchaseOrderDeleteTitle => 'حذف سفارش خرید';

  @override
  String get purchaseOrderCreate => 'ایجاد';

  @override
  String get purchaseOrderSave => 'ذخیره';

  @override
  String get purchaseOrderReference => 'مرجع';

  @override
  String get purchaseOrderTitle => 'عنوان';

  @override
  String get purchaseOrderVendor => 'تأمین‌کننده';

  @override
  String get purchaseOrderStatus => 'وضعیت';

  @override
  String get purchaseOrderNotes => 'یادداشت';

  @override
  String get purchaseOrderLineDescription => 'توضیح ردیف';

  @override
  String get purchaseOrderQuantity => 'تعداد';

  @override
  String get purchaseOrderUnitPrice => 'قیمت واحد';

  @override
  String get purchaseOrderSearchHint => 'جست‌وجوی سفارش‌های خرید';

  @override
  String get vendorBillsPageTitle => 'صورتحساب‌های تأمین‌کننده';

  @override
  String get vendorBillsLoadError =>
      'خطا در بارگذاری صورتحساب‌های تأمین‌کننده:';

  @override
  String get vendorBillsEmptyTitle => 'صورتحساب تأمین‌کننده‌ای موجود نیست';

  @override
  String get vendorBillsEmptyMessage =>
      'هنوز صورتحساب تأمین‌کننده‌ای ثبت نشده است.';

  @override
  String get vendorBillAddTitle => 'افزودن صورتحساب تأمین‌کننده';

  @override
  String get vendorBillEditTitle => 'ویرایش صورتحساب تأمین‌کننده';

  @override
  String get vendorBillDetailTitle => 'جزئیات صورتحساب تأمین‌کننده';

  @override
  String get vendorBillDeleteTitle => 'حذف صورتحساب تأمین‌کننده';

  @override
  String get vendorBillCreate => 'ایجاد';

  @override
  String get vendorBillSave => 'ذخیره';

  @override
  String get vendorBillReference => 'مرجع';

  @override
  String get vendorBillTitle => 'عنوان';

  @override
  String get vendorBillVendor => 'تأمین‌کننده';

  @override
  String get vendorBillPurchaseOrder => 'سفارش خرید';

  @override
  String get vendorBillGoodsReceipt => 'رسید کالا';

  @override
  String get vendorBillStatus => 'وضعیت';

  @override
  String get vendorBillNotes => 'یادداشت';

  @override
  String get vendorBillSearchHint => 'جست‌وجوی صورتحساب‌های تأمین‌کننده';

  @override
  String get vendorBillCreateFromReceipt => 'ایجاد از رسید کالا';

  @override
  String get vendorBillLinesLabel => 'ردیف‌ها';

  @override
  String get salesInvoicesPageTitle => 'فاکتورهای فروش';

  @override
  String get salesInvoicesLoadError => 'خطا در بارگذاری فاکتورهای فروش:';

  @override
  String get salesInvoicesEmptyTitle => 'فاکتور فروش موجود نیست';

  @override
  String get salesInvoicesEmptyMessage => 'هنوز فاکتور فروش ثبت نشده است.';

  @override
  String get salesInvoiceAddTitle => 'افزودن فاکتور فروش';

  @override
  String get salesInvoiceEditTitle => 'ویرایش فاکتور فروش';

  @override
  String get salesInvoiceDetailTitle => 'جزئیات فاکتور فروش';

  @override
  String get salesInvoiceDeleteTitle => 'حذف فاکتور فروش';

  @override
  String get salesInvoiceCreate => 'ایجاد';

  @override
  String get salesInvoiceSave => 'ذخیره';

  @override
  String get salesInvoiceReference => 'مرجع';

  @override
  String get salesInvoiceTitle => 'عنوان';

  @override
  String get salesInvoiceCustomer => 'مشتری';

  @override
  String get salesInvoiceDueDate => 'تاریخ سررسید';

  @override
  String get salesInvoiceStatus => 'وضعیت';

  @override
  String get salesInvoiceNotes => 'یادداشت‌ها';

  @override
  String get salesInvoiceLinesLabel => 'سطرها';

  @override
  String get salesInvoiceAddLine => 'افزودن سطر';

  @override
  String get salesInvoiceSearchHint => 'جست‌وجوی فاکتورهای فروش';

  @override
  String get salesInvoiceSubtotal => 'جمع جزء';

  @override
  String get salesInvoiceTax => 'مالیات';

  @override
  String get salesInvoiceTotal => 'جمع کل';

  @override
  String get customerPaymentsPageTitle => 'دریافت‌های مشتری';

  @override
  String get customerPaymentsLoadError => 'خطا در بارگذاری دریافت‌های مشتری:';

  @override
  String get customerPaymentsEmptyTitle => 'دریافت مشتری موجود نیست';

  @override
  String get customerPaymentsEmptyMessage => 'هنوز دریافت مشتری ثبت نشده است.';

  @override
  String get customerPaymentAddTitle => 'افزودن دریافت مشتری';

  @override
  String get customerPaymentEditTitle => 'ویرایش دریافت مشتری';

  @override
  String get customerPaymentDetailTitle => 'جزئیات دریافت مشتری';

  @override
  String get customerPaymentDeleteTitle => 'حذف دریافت مشتری';

  @override
  String get customerPaymentCreate => 'ایجاد';

  @override
  String get customerPaymentSave => 'ذخیره';

  @override
  String get customerPaymentReference => 'مرجع';

  @override
  String get customerPaymentCustomer => 'مشتری';

  @override
  String get customerPaymentAmount => 'مبلغ';

  @override
  String get customerPaymentMethod => 'روش';

  @override
  String get customerPaymentStatus => 'وضعیت';

  @override
  String get customerPaymentNotes => 'یادداشت';

  @override
  String get customerPaymentSearchHint => 'جست‌وجوی دریافت‌های مشتری';

  @override
  String get customerPaymentAllocationsLabel => 'تخصیص‌ها';

  @override
  String get customerPaymentAllocationAmount => 'مبلغ تخصیص‌یافته';

  @override
  String get customerStatementsPageTitle => 'صورت‌حساب‌های مشتری';

  @override
  String get customerStatementsLoadError =>
      'خطا در بارگذاری صورت‌حساب‌های مشتری:';

  @override
  String get customerStatementsEmptyTitle => 'صورت‌حساب مشتری‌ای موجود نیست';

  @override
  String get customerStatementsEmptyMessage =>
      'هنوز صورت‌حسابی ایجاد نشده است.';

  @override
  String get customerStatementsSelectCustomer => 'انتخاب مشتری';

  @override
  String get customerStatementsDateRange => 'بازه زمانی';

  @override
  String get customerStatementsOpeningBalance => 'مانده افتتاحیه';

  @override
  String get customerStatementsRunningBalance => 'مانده جاری';

  @override
  String get customerStatementsOutstandingBalance => 'مانده معوق';

  @override
  String get customerStatementsInvoiceHistory => 'تاریخچه فاکتورها';

  @override
  String get customerStatementsPaymentHistory => 'تاریخچه پرداخت‌ها';

  @override
  String get customerStatementsAgingTitle => 'سنی‌سازی مطالبات';

  @override
  String get customerStatementsNoInvoices => 'فاکتوری یافت نشد';

  @override
  String get customerStatementsNoPayments => 'پرداختی یافت نشد';

  @override
  String get customerStatementsNoEntries =>
      'ورودی‌ای در بازه انتخابی وجود ندارد';

  @override
  String get vendorPaymentsPageTitle => 'پرداخت‌های تأمین‌کننده';

  @override
  String get vendorPaymentsLoadError =>
      'خطا در بارگذاری پرداخت‌های تأمین‌کننده:';

  @override
  String get vendorPaymentsEmptyTitle => 'پرداخت تأمین‌کننده‌ای موجود نیست';

  @override
  String get vendorPaymentsEmptyMessage =>
      'هنوز پرداخت تأمین‌کننده‌ای ثبت نشده است.';

  @override
  String get vendorPaymentAddTitle => 'افزودن پرداخت تأمین‌کننده';

  @override
  String get vendorPaymentEditTitle => 'ویرایش پرداخت تأمین‌کننده';

  @override
  String get vendorPaymentDetailTitle => 'جزئیات پرداخت تأمین‌کننده';

  @override
  String get vendorPaymentDeleteTitle => 'حذف پرداخت تأمین‌کننده';

  @override
  String get vendorPaymentCreate => 'ایجاد';

  @override
  String get vendorPaymentSave => 'ذخیره';

  @override
  String get vendorPaymentReference => 'مرجع';

  @override
  String get vendorPaymentVendor => 'تأمین‌کننده';

  @override
  String get vendorPaymentAmount => 'مبلغ';

  @override
  String get vendorPaymentMethod => 'روش';

  @override
  String get vendorPaymentStatus => 'وضعیت';

  @override
  String get vendorPaymentNotes => 'یادداشت';

  @override
  String get vendorPaymentSearchHint => 'جست‌وجوی پرداخت‌های تأمین‌کننده';

  @override
  String get vendorPaymentAllocationsLabel => 'تخصیص‌ها';

  @override
  String get vendorPaymentAllocationAmount => 'مبلغ تخصیص‌یافته';

  @override
  String get vendorStatementsPageTitle => 'صورت‌حساب‌های تأمین‌کننده';

  @override
  String get vendorStatementsLoadError =>
      'خطا در بارگذاری صورت‌حساب‌های تأمین‌کننده:';

  @override
  String get vendorStatementsEmptyTitle =>
      'صورت‌حساب تأمین‌کننده‌ای موجود نیست';

  @override
  String get vendorStatementsEmptyMessage => 'هنوز صورت‌حسابی ایجاد نشده است.';

  @override
  String get vendorStatementsSelectVendor => 'انتخاب تأمین‌کننده';

  @override
  String get vendorStatementsDateRange => 'بازه زمانی';

  @override
  String get vendorStatementsOpeningBalance => 'مانده افتتاحیه';

  @override
  String get vendorStatementsRunningBalance => 'مانده جاری';

  @override
  String get vendorStatementsOutstandingBalance => 'مانده معوق';

  @override
  String get vendorStatementsBillHistory => 'تاریخچه صورتحساب‌ها';

  @override
  String get vendorStatementsPaymentHistory => 'تاریخچه پرداخت‌ها';

  @override
  String get vendorStatementsAgingTitle => 'سنی‌سازی بدهی‌ها';

  @override
  String get vendorStatementsNoBills => 'صورتحسابی یافت نشد';

  @override
  String get vendorStatementsNoPayments => 'پرداختی یافت نشد';

  @override
  String get vendorStatementsNoEntries => 'ورودی‌ای در بازه انتخابی وجود ندارد';

  @override
  String get journalPreviewPageTitle => 'پیش‌نمایش دفتر روزنامه';

  @override
  String get journalPreviewLoadError =>
      'بارگذاری پیش‌نمایش دفتر روزنامه انجام نشد.';

  @override
  String get journalPreviewEmptyTitle => 'پیش‌نمایشی در دسترس نیست';

  @override
  String get journalPreviewEmptyMessage =>
      'برای سند انتخاب‌شده هنوز پیش‌نمایش دفتر روزنامه وجود ندارد.';

  @override
  String get journalPreviewDocument => 'سند';

  @override
  String get journalPreviewPostingDate => 'تاریخ ثبت';

  @override
  String get journalPreviewNarration => 'شرح';

  @override
  String get journalPreviewLinesLabel => 'سطرهای ثبت';

  @override
  String get journalExplorerPageTitle => 'دفتر کل';

  @override
  String get journalExplorerLoadError => 'بارگذاری دفتر کل انجام نشد.';

  @override
  String get journalExplorerEmptyTitle => 'سند حسابداری یافت نشد';

  @override
  String get journalExplorerEmptyMessage =>
      'هیچ سند حسابداری با فیلترهای فعلی مطابقت ندارد.';

  @override
  String get journalExplorerSearchHint => 'جست‌وجوی شماره یا مرجع';

  @override
  String get journalExplorerSourceType => 'نوع منبع';

  @override
  String get journalExplorerAccountCode => 'کد حساب';

  @override
  String get journalExplorerSortBy => 'مرتب‌سازی';

  @override
  String get journalExplorerNewest => 'جدیدترین';

  @override
  String get journalExplorerOldest => 'قدیمی‌ترین';

  @override
  String get journalExplorerDateRange => 'بازه زمانی';

  @override
  String get journalExplorerPostingDate => 'تاریخ ثبت';

  @override
  String get journalExplorerNarration => 'شرح';

  @override
  String get journalExplorerPostingStatus => 'وضعیت ثبت';

  @override
  String get journalExplorerTotalDebit => 'جمع بدهکار';

  @override
  String get journalExplorerTotalCredit => 'جمع بستانکار';

  @override
  String get journalExplorerLinesLabel => 'سطرهای دفتر';

  @override
  String get journalExplorerLoading => 'در حال بارگذاری اسناد';

  @override
  String get journalExplorerSourceAll => 'همه';

  @override
  String get journalExplorerSourcePurchaseOrder => 'سفارش خرید';

  @override
  String get journalExplorerSourceGoodsReceipt => 'رسید کالا';

  @override
  String get journalExplorerSourceVendorBill => 'صورتحساب تأمین‌کننده';

  @override
  String get journalExplorerSourceVendorPayment => 'پرداخت تأمین‌کننده';

  @override
  String get journalExplorerSourceSalesInvoice => 'فاکتور فروش';

  @override
  String get journalExplorerSourceCustomerPayment => 'دریافت مشتری';

  @override
  String get journalExplorerViewSource => 'مشاهده سند مبدأ';

  @override
  String get vendorsPageTitle => 'تأمین‌کنندگان';

  @override
  String get vendorsLoadError => 'خطا در بارگذاری تأمین‌کنندگان:';

  @override
  String get vendorsEmptyTitle => 'تأمین‌کننده‌ای موجود نیست';

  @override
  String get vendorsEmptyMessage => 'هنوز تأمین‌کننده‌ای ثبت نشده است.';

  @override
  String get vendorAddTitle => 'افزودن تأمین‌کننده';

  @override
  String get vendorEditTitle => 'ویرایش تأمین‌کننده';

  @override
  String get vendorCompanyName => 'نام شرکت';

  @override
  String get vendorContactName => 'نام تماس';

  @override
  String get vendorEmail => 'ایمیل';

  @override
  String get vendorPhone => 'تلفن';

  @override
  String get vendorAddress => 'آدرس';

  @override
  String get vendorTaxIdentifier => 'شناسه مالیاتی';

  @override
  String get vendorActiveStatus => 'فعال';

  @override
  String get vendorNotes => 'یادداشت';

  @override
  String get vendorSearchHint => 'جست‌وجوی تأمین‌کننده‌ها';

  @override
  String get vendorStatusLabel => 'وضعیت';

  @override
  String get vendorActive => 'فعال';

  @override
  String get vendorInactive => 'غیرفعال';

  @override
  String get vendorCreate => 'ایجاد';

  @override
  String get vendorSave => 'ذخیره';

  @override
  String get currencyUnit => 'ریال';

  @override
  String get bankReconciliationPageTitle => 'تطبیق بانک';

  @override
  String get bankReconciliationLoadError =>
      'امکان بارگذاری داده‌های تطبیق وجود ندارد:';

  @override
  String get bankAccountSelector => 'حساب بانک';

  @override
  String get bankReconciliationSummary => 'خلاصه تطبیق';

  @override
  String get bankMatchedTransactions => 'معاملات منطبق';

  @override
  String get bankUnmatchedTransactions => 'معاملات نامنطبق';

  @override
  String get bankProgress => 'پیشرفت';

  @override
  String get bankNoTransactions => 'معامله‌ای یافت نشد';

  @override
  String get bankNoTransactionsMessage =>
      'هنوز معامله‌ای برای این حساب در دسترس نیست.';

  @override
  String get bankFinalize => 'اتمام تطبیق';

  @override
  String get bankCompletionDialogTitle => 'تطبیق تکمیل شد';

  @override
  String get bankCompletionDialogMessage => 'جلسه تطبیق با موفقیت تکمیل شد.';

  @override
  String get bankDone => 'تأیید';

  @override
  String get fiscalYearsPageTitle => 'دوره‌های مالی';

  @override
  String get fiscalPeriodsPageTitle => 'دوره‌های فاصله‌گذاری';

  @override
  String get yearEndClosingPageTitle => 'بستن سال‌نهايی';

  @override
  String get createButton => 'ایجاد کردن';

  @override
  String get draft => 'پیش‌نویس';

  @override
  String get pendingApproval => 'در انتظار تایید';

  @override
  String get approved => 'تایید شده';

  @override
  String get posted => 'ثبت شده';

  @override
  String get locked => 'قفل شده';

  @override
  String get cancelled => 'لغو شده';

  @override
  String get documentNumberLabel => 'شماره سند';

  @override
  String get documentStatusLabel => 'وضعیت';

  @override
  String get documentCreatedAtLabel => 'ایجاد شده';

  @override
  String get documentApprovedAtLabel => 'تایید شده';

  @override
  String get documentPostedAtLabel => 'ثبت شده';

  @override
  String get approvalTimelineTitle => 'مراحل تأیید';

  @override
  String get documentTypeLabel => 'نوع';

  @override
  String get workflowInvalidTransition => 'انتقال غیرمجاز';

  @override
  String get workflowTransitionToPendingApproval => 'ارسال برای تأیید';

  @override
  String get workflowTransitionToApproved => 'تأیید';

  @override
  String get workflowTransitionToPosted => 'ثبت';

  @override
  String get workflowTransitionToLocked => 'قفل';

  @override
  String get workflowTransitionToCancelled => 'لغو';

  @override
  String get approvalWorkflowPageTitle => 'گردش کار سند';

  @override
  String get approvalWorkflowLoadError => 'خطا در بارگذاری اسناد:';

  @override
  String get approvalWorkflowEmptyTitle => 'سندی موجود نیست';

  @override
  String get approvalWorkflowEmptyMessage => 'هنوز سندی ثبت نشده است.';

  @override
  String get auditTrailPageTitle => 'گزارش حسابرسی';

  @override
  String get auditTrailLoadError => 'خطا در بارگذاری گزارش حسابرسی:';

  @override
  String get auditTrailEmptyTitle => 'هنوز فعالیتی ثبت نشده است';

  @override
  String get auditTrailEmptyMessage =>
      'برای این سند هنوز فعالیتی ثبت نشده است.';

  @override
  String get auditTrailFilterAll => 'همه';

  @override
  String auditTrailPerformedBy(String user) {
    return 'توسط $user';
  }

  @override
  String get auditActionCreated => 'ایجاد شد';

  @override
  String get auditActionEdited => 'ویرایش شد';

  @override
  String get auditActionDeleted => 'حذف شد';

  @override
  String get auditActionSubmittedForApproval => 'برای تأیید ارسال شد';

  @override
  String get auditActionApproved => 'تأیید شد';

  @override
  String get auditActionRejected => 'رد شد';

  @override
  String get auditActionPosted => 'ثبت شد';

  @override
  String get auditActionLocked => 'قفل شد';

  @override
  String get auditActionCancelled => 'لغو شد';

  @override
  String get auditActionReopened => 'بازگشایی شد';

  @override
  String get auditActionPaid => 'پرداخت شد';

  @override
  String get auditActionPartiallyPaid => 'پرداخت جزئی شد';

  @override
  String get auditActionRefunded => 'بازگشت داده شد';

  @override
  String get auditActionPrinted => 'چاپ شد';

  @override
  String get auditActionExported => 'خروجی گرفته شد';

  @override
  String get auditActionStockAdjusted => 'موجودی تنظیم شد';

  @override
  String get auditActionStockTransferred => 'موجودی منتقل شد';

  @override
  String get auditActionStockCounted => 'موجودی شمارش شد';

  @override
  String get auditActionJournalGenerated => 'سند حسابداری تولید شد';

  @override
  String get auditActionJournalReviewed => 'سند حسابداری بررسی شد';

  @override
  String get auditActionAddressChanged => 'آدرس تغییر کرد';

  @override
  String get auditActionContactChanged => 'اطلاعات تماس تغییر کرد';

  @override
  String get auditActionArchived => 'بایگانی شد';

  @override
  String get auditActionUnarchived => 'از بایگانی خارج شد';

  @override
  String get auditActionPeriodOpened => 'دوره مالی باز شد';

  @override
  String get auditActionPeriodClosed => 'دوره مالی بسته شد';

  @override
  String get auditEntitySalesInvoice => 'فاکتور فروش';

  @override
  String get auditEntityVendorBill => 'صورتحساب تأمین‌کننده';

  @override
  String get auditEntityPurchaseOrder => 'سفارش خرید';

  @override
  String get auditEntityGoodsReceipt => 'رسید کالا';

  @override
  String get auditEntityVendorPayment => 'پرداخت تأمین‌کننده';

  @override
  String get auditEntityCustomerPayment => 'دریافت مشتری';

  @override
  String get auditEntityCustomer => 'مشتری';

  @override
  String get auditEntityVendor => 'تأمین‌کننده';

  @override
  String get auditEntityInventory => 'موجودی';

  @override
  String get auditEntityJournalEntry => 'سند حسابداری';

  @override
  String get auditEntityFiscalPeriod => 'دوره مالی';

  @override
  String get auditEntityFinancialReport => 'گزارش مالی';

  @override
  String get bankAccountsPageTitle => 'حساب‌های بانکی';

  @override
  String get bankAccountsLoadError => 'خطا در بارگذاری حساب‌های بانکی:';

  @override
  String get bankAccountsEmptyTitle => 'حساب بانکی یافت نشد';

  @override
  String get bankAccountsEmptyMessage => 'هیچ حساب بانکی ثبت نشده است.';

  @override
  String get bankAccountsSearchHint => 'جستجو در حساب‌ها';

  @override
  String get bankAccountsBalanceLabel => 'موجودی فعلی';

  @override
  String get bankAccountsTypeChecking => 'جاری';

  @override
  String get bankAccountsTypeSavings => 'پس‌انداز';

  @override
  String get bankAccountsTypeCash => 'نقد';

  @override
  String get bankAccountsTypeCreditCard => 'کارت اعتباری';

  @override
  String get bankAccountsStatusActive => 'فعال';

  @override
  String get bankAccountsStatusInactive => 'غیرفعال';

  @override
  String get bankAccountsStatusFrozen => 'مسدود';

  @override
  String get bankTransactionsPageTitle => 'تراکنش‌ها';

  @override
  String get bankTransactionsLoadError => 'خطا در بارگذاری تراکنش‌ها:';

  @override
  String get bankTransactionsEmptyTitle => 'تراکنشی یافت نشد';

  @override
  String get bankTransactionsEmptyMessage =>
      'هیچ تراکنشی برای این حساب ثبت نشده است.';

  @override
  String get bankTransactionsSearchHint => 'جستجو در تراکنش‌ها';

  @override
  String get bankTransactionsAllTypes => 'همه انواع';

  @override
  String get bankTransactionTypeDeposit => 'واریز';

  @override
  String get bankTransactionTypeWithdrawal => 'برداشت';

  @override
  String get bankTransactionTypeTransfer => 'انتقال';

  @override
  String get bankTransactionTypeInterest => 'سود';

  @override
  String get bankTransactionTypeBankFee => 'کارمزد بانکی';

  @override
  String get bankTransactionTypeAdjustment => 'تعدیل';

  @override
  String get bankTransactionRunningBalance => 'موجودی جاری';

  @override
  String get bankTransactionDate => 'تاریخ';

  @override
  String get bankTransactionReference => 'مرجع';

  @override
  String get bankStatementsPageTitle => 'صورت‌های بانکی';

  @override
  String get bankStatementsLoadError => 'خطا در بارگذاری صورت‌های بانکی:';

  @override
  String get bankStatementsEmptyTitle => 'صورت بانکی یافت نشد';

  @override
  String get bankStatementsEmptyMessage => 'هیچ صورت بانکی وارد نشده است.';

  @override
  String get bankStatementsOpeningBalance => 'موجودی ابتدای دوره';

  @override
  String get bankStatementsClosingBalance => 'موجودی پایان دوره';

  @override
  String get bankStatementsStatusDraft => 'پیش‌نویس';

  @override
  String get bankStatementsStatusInProgress => 'در حال تطابق';

  @override
  String get bankStatementsStatusReconciled => 'تطابق یافت';

  @override
  String get bankStatementsStatusNeedsAttention => 'نیاز به بررسی';

  @override
  String get bankReconciliationAutoMatch => 'تطابق خودکار';

  @override
  String get bankReconciliationMatch => 'تطابق';

  @override
  String get bankReconciliationUnmatch => 'لغو تطابق';

  @override
  String get bankReconciliationDifference => 'اختلاف';

  @override
  String get bankReconciliationBalanced => 'متعادل';

  @override
  String get bankReconciliationFinalized => 'صورت بانکی با موفقیت تطابق یافت.';

  @override
  String get bankReconciliationNoTransactions => 'تراکنشی یافت نشد';

  @override
  String get stockLedgerPageTitle => 'دفتر موجودی';

  @override
  String get stockLedgerLoadError => 'خطا در بارگذاری دفتر موجودی:';

  @override
  String get stockLedgerEmptyTitle => 'ورودی‌ای در دفتر وجود ندارد';

  @override
  String get stockLedgerEmptyMessage =>
      'هیچ ورودی دفتر موجودی برای این محصول یافت نشد.';

  @override
  String get stockLedgerWarehouseFilter => 'فیلتر بر اساس انبار';

  @override
  String get stockLedgerAllWarehouses => 'همه انبارها';

  @override
  String get stockLedgerBalance => 'موجودی';

  @override
  String get stockLedgerTotalIn => 'جمع ورودی';

  @override
  String get stockLedgerTotalOut => 'جمع خروجی';

  @override
  String get stockLedgerTotalValue => 'ارزش کل';

  @override
  String get stockAdjustmentPageTitle => 'تعدیل موجودی';

  @override
  String get stockAdjustmentCreateTitle => 'تعدیل جدید';

  @override
  String get stockAdjustmentLoadError => 'خطا در بارگذاری تعدیل‌ها:';

  @override
  String get stockAdjustmentEmptyTitle => 'تعدیلی وجود ندارد';

  @override
  String get stockAdjustmentEmptyMessage =>
      'هنوز هیچ تعدیل موجودی ثبت نشده است.';

  @override
  String get stockAdjustmentProduct => 'محصول';

  @override
  String get stockAdjustmentWarehouse => 'انبار';

  @override
  String get stockAdjustmentQuantity => 'تعداد';

  @override
  String get stockAdjustmentQuantityHint =>
      'برای کاهش موجودی عدد منفی وارد کنید';

  @override
  String get stockAdjustmentReason => 'دلیل';

  @override
  String get stockAdjustmentInvalidQuantity => 'عدد معتبر وارد کنید';

  @override
  String get inventoryValuationPageTitle => 'ارزیابی موجودی';

  @override
  String get inventoryValuationLoadError => 'خطا در بارگذاری ارزیابی:';

  @override
  String get inventoryValuationEmptyTitle => 'داده ارزیابی‌ای وجود ندارد';

  @override
  String get inventoryValuationEmptyMessage =>
      'اطلاعات ارزیابی موجودی در دسترس نیست.';

  @override
  String get inventoryValuationTotalValue => 'ارزش کل';

  @override
  String get inventoryValuationProducts => 'محصولات';

  @override
  String get inventoryValuationWarehouses => 'انبارها';

  @override
  String get inventoryValuationDate => 'تاریخ محاسبه';

  @override
  String get inventoryValuationQty => 'تعداد';

  @override
  String get inventoryValuationAvgCost => 'میانگین بهای تمام‌شده';

  @override
  String get stockTransferPageTitle => 'انتقال موجودی';

  @override
  String get stockTransferLoadError => 'خطا در بارگذاری انتقال‌ها:';

  @override
  String get stockTransferEmptyTitle => 'انتقالی وجود ندارد';

  @override
  String get stockTransferEmptyMessage =>
      'هنوز هیچ انتقال موجودی ثبت نشده است.';

  @override
  String get stockTransferCreateTitle => 'انتقال جدید';

  @override
  String get stockTransferProduct => 'محصول';

  @override
  String get stockTransferFrom => 'انبار مبدأ';

  @override
  String get stockTransferTo => 'انبار مقصد';

  @override
  String get stockTransferQuantity => 'تعداد';

  @override
  String get stockTransferNotes => 'یادداشت';

  @override
  String get stockTransferReference => 'مرجع';

  @override
  String get stockTransferDate => 'تاریخ انتقال';

  @override
  String get stockTransferStatus => 'وضعیت';

  @override
  String get stockTransferStatusPending => 'در انتظار';

  @override
  String get stockTransferStatusCompleted => 'تکمیل شده';

  @override
  String get stockTransferStatusCancelled => 'لغو شده';

  @override
  String get stockTransferSameWarehouseError =>
      'انبار مبدأ و مقصد باید متفاوت باشند';

  @override
  String get stockTransferInvalidQuantity => 'تعداد باید بیشتر از صفر باشد';

  @override
  String get stockTransferCreateError => 'خطا در ایجاد انتقال';

  @override
  String get stockTransferCompleteAction => 'تکمیل';

  @override
  String get stockTransferCancelAction => 'لغو انتقال';

  @override
  String get stockTransferInsufficientStock => 'موجودی انبار مبدأ کافی نیست';

  @override
  String get attachmentsSectionTitle => 'پیوست‌ها';

  @override
  String get attachmentAdd => 'افزودن';

  @override
  String get attachmentAddTitle => 'افزودن پیوست';

  @override
  String get attachmentFilename => 'نام فایل';

  @override
  String get attachmentNotes => 'یادداشت';

  @override
  String get attachmentLoadError => 'خطا در بارگذاری پیوست‌ها:';

  @override
  String get attachmentEmptyTitle => 'پیوستی وجود ندارد';

  @override
  String get attachmentEmptyMessage =>
      'هنوز هیچ فایلی به این سند ضمیمه نشده است.';

  @override
  String get attachmentAddError => 'خطا در افزودن پیوست';

  @override
  String get attachmentRenameTitle => 'تغییر نام پیوست';

  @override
  String get attachmentRenameAction => 'تغییر نام';

  @override
  String get attachmentEditNotesTitle => 'ویرایش یادداشت';

  @override
  String get attachmentEditNotesAction => 'ویرایش یادداشت';

  @override
  String get attachmentRemoveTitle => 'حذف پیوست';

  @override
  String get attachmentRemoveAction => 'حذف';

  @override
  String attachmentRemoveConfirm(String filename) {
    return 'حذف \"$filename\" از این سند؟';
  }

  @override
  String get attachmentFileSize => 'حجم';

  @override
  String get attachmentUploadedBy => 'بارگذاری توسط';

  @override
  String get attachmentUploadedAt => 'تاریخ بارگذاری';

  @override
  String get commentsSectionTitle => 'نظرات و یادداشت‌ها';

  @override
  String get commentAdd => 'افزودن نظر';

  @override
  String get commentAddPlaceholder => 'یک نظر یا یادداشت داخلی بنویسید…';

  @override
  String get commentLoadError => 'خطا در بارگذاری نظرات:';

  @override
  String get commentEmptyTitle => 'هنوز نظری ثبت نشده';

  @override
  String get commentEmptyMessage => 'اولین نظر یا یادداشت داخلی را بگذارید.';

  @override
  String get commentAddError => 'خطا در افزودن نظر';

  @override
  String get commentEditTitle => 'ویرایش نظر';

  @override
  String get commentEditAction => 'ذخیره';

  @override
  String get commentDeleteTitle => 'حذف نظر';

  @override
  String get commentDeleteAction => 'حذف';

  @override
  String commentDeleteConfirm(String author) {
    return 'نظر $author حذف شود؟';
  }

  @override
  String get commentEditedLabel => 'ویرایش‌شده';

  @override
  String commentPostedBy(String author) {
    return '$author';
  }

  @override
  String get searchHint => 'جستجوی اسناد، نام‌ها، کد محصول…';

  @override
  String get searchClear => 'پاک کردن';

  @override
  String get searchErrorMessage => 'خطا در جستجو:';

  @override
  String get searchEmptyTitle => 'نتیجه‌ای یافت نشد';

  @override
  String searchEmptyMessage(String query) {
    return 'هیچ موردی برای \"$query\" یافت نشد';
  }

  @override
  String get searchRecentTitle => 'جستجوهای اخیر';

  @override
  String get searchRecentEmpty => 'جستجوی اخیری وجود ندارد';

  @override
  String get searchRecentClear => 'پاک کردن همه';

  @override
  String get searchGroupCustomers => 'مشتریان';

  @override
  String get searchGroupVendors => 'تأمین‌کنندگان';

  @override
  String get searchGroupProducts => 'محصولات';

  @override
  String get searchGroupSalesInvoices => 'فاکتورهای فروش';

  @override
  String get searchGroupVendorBills => 'صورت‌حساب‌های خرید';

  @override
  String get searchGroupPurchaseOrders => 'سفارش‌های خرید';

  @override
  String get searchGroupGoodsReceipts => 'رسیدهای کالا';

  @override
  String get searchGroupBankAccounts => 'حساب‌های بانکی';

  @override
  String get searchGroupJournalEntries => 'ثبت‌های دفتر';

  @override
  String get searchGroupFiscalPeriods => 'دوره‌های مالی';

  @override
  String get searchPageTitle => 'جستجوی سراسری';

  @override
  String get language => 'زبان';

  @override
  String get themeModeLabel => 'پوسته';

  @override
  String get themeModeSystem => 'سیستم';

  @override
  String get themeModeLight => 'روشن';

  @override
  String get themeModeDark => 'تاریک';

  @override
  String get confirmPassword => 'تکرار رمز عبور';

  @override
  String get passwordsDoNotMatch => 'رمز عبور همخوانی ندارد';

  @override
  String get createCompany => 'ایجاد شرکت';

  @override
  String get companyLegalName => 'نام حقوقی';

  @override
  String get companyTaxId => 'شناسه مالیاتی';

  @override
  String get tagsPageTitle => 'برچسب‌ها';

  @override
  String get tagsSectionTitle => 'برچسب‌ها';

  @override
  String get tagName => 'نام برچسب';

  @override
  String get tagDescription => 'توضیحات (اختیاری)';

  @override
  String get tagColor => 'رنگ';

  @override
  String get tagCreateTitle => 'برچسب جدید';

  @override
  String get tagEditTitle => 'ویرایش برچسب';

  @override
  String get tagEditAction => 'ویرایش';

  @override
  String get tagDeleteTitle => 'حذف برچسب';

  @override
  String get tagDeleteAction => 'حذف';

  @override
  String tagDeleteConfirm(String name) {
    return 'برچسب \"$name\" حذف شود؟ از همه اسناد حذف خواهد شد.';
  }

  @override
  String get tagAssignTitle => 'افزودن برچسب';

  @override
  String get tagAssign => 'افزودن برچسب';

  @override
  String get tagNoAvailable => 'همه برچسب‌ها قبلاً تخصیص داده شده‌اند';

  @override
  String get tagLoadError => 'خطا در بارگذاری برچسب‌ها:';

  @override
  String get tagEmptyTitle => 'بدون برچسب';

  @override
  String get tagEmptyMessage => 'هیچ برچسبی به این سند تخصیص داده نشده است.';

  @override
  String get tagEmptyPageMessage => 'هنوز برچسبی تعریف نشده. یکی بسازید.';

  @override
  String get userRolesPageTitle => 'کاربران و نقش‌ها';

  @override
  String get userRolesTabUsers => 'کاربران';

  @override
  String get userRolesTabRoles => 'نقش‌ها';

  @override
  String get userRolesAssignTitle => 'تخصیص نقش';

  @override
  String get userRolesDeactivate => 'غیرفعال‌سازی';

  @override
  String get userRolesLoadError => 'خطا در بارگذاری:';

  @override
  String get userRolesEmptyTitle => 'موردی یافت نشد';

  @override
  String get userRolesEmptyMessage => 'کاربر یا نقشی یافت نشد.';

  @override
  String get userRolesUnknownRole => 'نامشخص';

  @override
  String get userRolesCurrentUser => 'کاربر جاری';

  @override
  String get permissionViewCustomers => 'مشاهده مشتریان';

  @override
  String get permissionEditCustomers => 'ویرایش مشتریان';

  @override
  String get permissionDeleteCustomers => 'حذف مشتریان';

  @override
  String get permissionPostJournal => 'ثبت سند';

  @override
  String get permissionCloseFiscalPeriod => 'بستن دوره مالی';

  @override
  String get permissionViewFinancialReports => 'مشاهده گزارش‌های مالی';

  @override
  String get permissionManageUsers => 'مدیریت کاربران';

  @override
  String get permissionManageRoles => 'مدیریت نقش‌ها';

  @override
  String get currenciesPageTitle => 'ارزها';

  @override
  String get currenciesTabCurrencies => 'ارزها';

  @override
  String get currenciesTabRates => 'نرخ ارز';

  @override
  String get currenciesLoadError => 'خطا در بارگذاری ارزها:';

  @override
  String get currenciesEmptyTitle => 'ارزی تعریف نشده';

  @override
  String get currenciesEmptyMessage => 'هیچ ارزی پیکربندی نشده است.';

  @override
  String get currencyBadgeBase => 'پایه';

  @override
  String get currencyBadgeInactive => 'غیرفعال';

  @override
  String get currencySetBaseTitle => 'تعیین ارز پایه';

  @override
  String currencySetBaseConfirm(String isoCode) {
    return 'آیا $isoCode را به عنوان ارز پایه تعیین می‌کنید؟';
  }

  @override
  String get currencySetBaseAction => 'تعیین به عنوان پایه';

  @override
  String get currencyEditRateTitle => 'ویرایش نرخ ارز';

  @override
  String currencyRateLabel(String from, String to) {
    return '$from به ازای $to';
  }

  @override
  String get currencyRateValue => 'نرخ';

  @override
  String get currencyRateInvalid => 'یک عدد مثبت وارد کنید';

  @override
  String get dashboardCurrencies => 'ارزها';

  @override
  String get recurringTransactionsPageTitle => 'تراکنش‌های دوره‌ای';

  @override
  String get recurringTransactionCreateTitle => 'تراکنش دوره‌ای جدید';

  @override
  String get recurringTransactionEditTitle => 'ویرایش تراکنش دوره‌ای';

  @override
  String get recurringTransactionsLoadError =>
      'خطا در بارگذاری تراکنش‌های دوره‌ای:';

  @override
  String get recurringTransactionsEmptyTitle => 'تراکنش دوره‌ای‌ای وجود ندارد';

  @override
  String get recurringTransactionsEmptyMessage =>
      'هنوز هیچ تراکنش دوره‌ای تعریف نشده است.';

  @override
  String get recurringTransactionBadgeActive => 'فعال';

  @override
  String get recurringTransactionBadgeInactive => 'غیرفعال';

  @override
  String get recurringTransactionNextRun => 'اجرای بعدی';

  @override
  String get recurringTransactionName => 'نام';

  @override
  String get recurringTransactionFrequency => 'تکرار';

  @override
  String get recurringTransactionSourceId => 'شناسه سند مبدأ';

  @override
  String get recurringTransactionSourceType => 'نوع سند مبدأ';

  @override
  String get recurringTransactionNotes => 'یادداشت';

  @override
  String get recurringTransactionActivate => 'فعال‌سازی';

  @override
  String get recurringTransactionDeactivate => 'غیرفعال‌سازی';

  @override
  String get recurringTransactionExecuteNow => 'اجرای فوری';

  @override
  String recurringTransactionExecuted(String name) {
    return '$name اجرا شد (شبیه‌سازی)';
  }

  @override
  String get recurringFrequencyDaily => 'روزانه';

  @override
  String get recurringFrequencyWeekly => 'هفتگی';

  @override
  String get recurringFrequencyMonthly => 'ماهانه';

  @override
  String get recurringFrequencyQuarterly => 'فصلی';

  @override
  String get recurringFrequencyYearly => 'سالانه';

  @override
  String get dashboardRecurringTransactions => 'تراکنش‌های دوره‌ای';

  @override
  String get fixedAssetsPageTitle => 'دارایی‌های ثابت';

  @override
  String get fixedAssetCreateTitle => 'دارایی ثابت جدید';

  @override
  String get fixedAssetEditTitle => 'ویرایش دارایی ثابت';

  @override
  String get fixedAssetsLoadError => 'خطا در بارگذاری دارایی‌های ثابت:';

  @override
  String get fixedAssetsEmptyTitle => 'دارایی ثابتی وجود ندارد';

  @override
  String get fixedAssetsEmptyMessage => 'هنوز هیچ دارایی ثابتی ثبت نشده است.';

  @override
  String get fixedAssetBadgeActive => 'فعال';

  @override
  String get fixedAssetBadgeDisposed => 'اسقاط';

  @override
  String get fixedAssetName => 'نام دارایی';

  @override
  String get fixedAssetCategory => 'دسته‌بندی';

  @override
  String get fixedAssetPurchaseCost => 'بهای تمام‌شده';

  @override
  String get fixedAssetSalvageValue => 'ارزش اسقاط';

  @override
  String get fixedAssetUsefulLife => 'عمر مفید (سال)';

  @override
  String get fixedAssetDepreciationMethod => 'روش استهلاک';

  @override
  String get fixedAssetMethodStraightLine => 'خط مستقیم';

  @override
  String get fixedAssetMethodDecliningBalance => 'نزولی';

  @override
  String get fixedAssetNotes => 'یادداشت';

  @override
  String get fixedAssetBookValue => 'ارزش دفتری';

  @override
  String get fixedAssetAccumDepreciation => 'استهلاک انباشته';

  @override
  String get fixedAssetDispose => 'اسقاط دارایی';

  @override
  String get fixedAssetCalculateDepreciation => 'اعمال استهلاک';

  @override
  String get fixedAssetViewSchedule => 'مشاهده جدول استهلاک';

  @override
  String get fixedAssetScheduleTitle => 'جدول استهلاک';

  @override
  String get fixedAssetScheduleYear => 'سال';

  @override
  String get fixedAssetScheduleOpening => 'افتتاحیه';

  @override
  String get fixedAssetScheduleCharge => 'هزینه';

  @override
  String get fixedAssetScheduleAccum => 'انباشته';

  @override
  String get fixedAssetScheduleClosing => 'اختتامیه';

  @override
  String get fixedAssetInvalidNumber => 'یک عدد مثبت معتبر وارد کنید';

  @override
  String get dashboardFixedAssets => 'دارایی‌های ثابت';

  @override
  String get importExportPageTitle => 'واردات / صادرات';

  @override
  String get importExportSelectEntity => 'انتخاب نوع موجودیت';

  @override
  String get importExportExportBtn => 'صادرات CSV';

  @override
  String get importExportImportBtn => 'واردات CSV';

  @override
  String get importExportRecentJobs => 'عملیات اخیر';

  @override
  String get importExportLoadError => 'خطا در بارگذاری عملیات:';

  @override
  String get importExportEmptyTitle => 'هیچ عملیاتی انجام نشده';

  @override
  String get importExportEmptyMessage =>
      'برای مشاهده نتایج، یک عملیات صادرات یا واردات انجام دهید.';

  @override
  String get importExportRows => 'سطر';

  @override
  String get importExportDirectionExport => 'صادرات';

  @override
  String get importExportDirectionImport => 'واردات';

  @override
  String get importExportStatusSuccess => 'موفق';

  @override
  String get importExportStatusFailed => 'ناموفق';

  @override
  String get importExportPreviewBtn => 'پیش‌نمایش CSV';

  @override
  String get importExportPreviewTitle => 'پیش‌نمایش CSV';

  @override
  String get dashboardImportExport => 'واردات / صادرات';

  @override
  String get crmDashboard => 'داشبورد CRM';

  @override
  String get pipeline => 'خط فروش';

  @override
  String get newOpportunity => 'فرصت جدید';

  @override
  String get noOpportunities => 'هنوز فرصتی ثبت نشده';

  @override
  String get tasks => 'وظایف';

  @override
  String get newTask => 'وظیفه جدید';

  @override
  String get noTasks => 'هنوز وظیفهای ثبت نشده';

  @override
  String get title => 'عنوان';

  @override
  String get description => 'توضیحات';

  @override
  String get dueDate => 'تاریخ سررسید';

  @override
  String get priority => 'اولویت';

  @override
  String get cancel => 'انصراف';

  @override
  String get create => 'ایجاد';

  @override
  String get saveButton => 'ذخیره';

  @override
  String get contactsPageTitle => 'مخاطبان';

  @override
  String get contactsLoadError => 'خطا در بارگذاری مخاطبان:';

  @override
  String get contactsEmptyTitle => 'هنوز مخاطبی ثبت نشده';

  @override
  String get contactsEmptyMessage => 'هنوز هیچ مخاطبی اضافه نشده است.';

  @override
  String get contactCreateTitle => 'افزودن مخاطب';

  @override
  String get contactEditTitle => 'ویرایش مخاطب';

  @override
  String get contactDeleteTitle => 'حذف مخاطب';

  @override
  String get contactFirstName => 'نام';

  @override
  String get contactLastName => 'نام خانوادگی';

  @override
  String get contactEmail => 'ایمیل';

  @override
  String get contactPhone => 'تلفن';

  @override
  String get contactJobTitle => 'عنوان شغلی';

  @override
  String get contactDepartment => 'بخش';

  @override
  String get contactPrimary => 'مخاطب اصلی';

  @override
  String get contactPrimaryLabel => 'اصلی';

  @override
  String get contactNotes => 'یادداشت';

  @override
  String get interactionsSectionTitle => 'تعاملات';

  @override
  String get interactionAddTitle => 'افزودن تعامل';

  @override
  String get interactionType => 'نوع';

  @override
  String get interactionSubject => 'موضوع';

  @override
  String get interactionDescription => 'توضیحات';

  @override
  String get interactionAdd => 'افزودن';

  @override
  String get interactionsLoadError => 'خطا در بارگذاری تعاملات:';

  @override
  String get interactionsEmptyTitle => 'هنوز تعاملی ثبت نشده';

  @override
  String get interactionsEmptyMessage =>
      'هیچ تعاملی برای این مخاطب ثبت نشده است.';

  @override
  String get docProcessingQueueTitle => 'صف پردازش اسناد';

  @override
  String get docProcessingQueueLoading => 'در حال بارگذاری صف';

  @override
  String get docProcessingQueueLoadError => 'خطا در بارگذاری صف:';

  @override
  String get docProcessingQueueEmptyTitle => 'صف خالی است';

  @override
  String get docProcessingQueueEmptyMessage => 'هیچ سندی در انتظار بررسی نیست.';

  @override
  String get docProcessingJobId => 'شناسه کار';

  @override
  String get docReviewPageTitle => 'بررسی سند';

  @override
  String get docReviewDocumentSection => 'سند';

  @override
  String get docReviewAttachment => 'پیوست';

  @override
  String get docReviewStatus => 'وضعیت';

  @override
  String get docReviewDocumentType => 'نوع سند';

  @override
  String get docReviewConfidence => 'اطمینان';

  @override
  String get docReviewExtractedSection => 'داده استخراجشده';

  @override
  String get docReviewNoteSection => 'یادداشت بررسی';

  @override
  String get docReviewNoteHint => 'یادداشت اختیاری برای این تصمیم…';

  @override
  String get docReviewApproveAction => 'تأیید';

  @override
  String get docReviewRejectAction => 'رد';

  @override
  String get docReviewRejectTitle => 'رد سند';

  @override
  String get docReviewRejectNoteLabel => 'دلیل رد';

  @override
  String get docReviewRejectConfirm => 'رد';

  @override
  String get docReviewRejectedDefault => 'توسط بررسیکننده رد شد';

  @override
  String get docReviewDecisionSection => 'تصمیم بررسی';

  @override
  String get docReviewDecisionOutcome => 'نتیجه';

  @override
  String get docReviewDecisionBy => 'بررسیشده توسط';

  @override
  String get docReviewDecisionNote => 'یادداشت';

  @override
  String get docReviewJournalPreviewTitle => 'پیشنمایش سند حسابداری';

  @override
  String get docReviewPostAndCreate => 'ثبت و ایجاد';

  @override
  String get aiAssistantTitle => 'دستیار هوشمند';

  @override
  String get aiAssistantEmptyMessage =>
      'درباره کسب‌وکارتان بپرسید — درآمد، نقدینگی، فاکتورها، مشتریان، یا بخواهید یک اقدام پیشنهاد دهم.';

  @override
  String get aiAssistantHint => 'هر سوالی درباره کسب‌وکارتان بپرسید…';

  @override
  String get aiAssistantSend => 'ارسال';

  @override
  String get aiAssistantError =>
      'متأسفم، نتوانستم پاسخ دهم. لطفاً دوباره تلاش کنید.';

  @override
  String get aiAssistantYou => 'شما';

  @override
  String get aiAssistantAssistant => 'دستیار';

  @override
  String get aiAssistantThinking => 'در حال فکر کردن…';

  @override
  String get aiAssistantConfirmTitle => 'تأیید اقدام هوشمند';

  @override
  String aiAssistantConfirmBody(Object description) {
    return 'این پیشنهاد نیاز به تأیید شما دارد و در گزارش حسابرسی ثبت می‌شود:\n\n$description';
  }

  @override
  String get aiAssistantConfirmAction => 'تأیید و ثبت';

  @override
  String get aiAssistantActionLogged =>
      'اقدام هوشمند تأیید و در گزارش حسابرسی ثبت شد.';

  @override
  String get aiAssistantActionFailed => 'اقدام هوشمند قابل اجرا نبود.';

  @override
  String get guidanceTourNext => 'بعدی';

  @override
  String get guidanceTourSkip => 'رد شدن';

  @override
  String get guidanceTourDone => 'تمام';

  @override
  String guidanceTourStepCount(Object current, Object total) {
    return '$current از $total';
  }

  @override
  String get guidanceWelcomeTitle => 'به داشبورد خوش آمدید';

  @override
  String get guidanceWelcomeBody =>
      'این مرکز فرماندهی مالی شماست. هر آنچه ثبت کنید — فاکتور، قبض، پرداخت و موجودی — اینجا نمایش داده می‌شود.';

  @override
  String get guidanceQuickActionsTitle => 'دسترسی سریع';

  @override
  String get guidanceQuickActionsBody =>
      'با این دکمه‌ها مستقیم به کارهای رایج بروید؛ مثل صدور فاکتور فروش، ثبت پرداخت یا مشاهده دفتر روزنامه.';

  @override
  String get guidanceMetricsTitle => 'شاخص‌های کلیدی';

  @override
  String get guidanceMetricsBody =>
      'حساب‌های دریافتنی، حساب‌های پرداختنی، موجودی انبار و وجه نقد را در یک نگاه ببینید.';

  @override
  String get guidancePerformanceTitle => 'عملکرد';

  @override
  String get guidancePerformanceBody =>
      'نمودارها و خلاصه سود، درآمد، هزینه و سودآوری شما را در طول زمان نشان می‌دهند.';

  @override
  String get guidanceNavigationTitle => 'ناوبری اصلی';

  @override
  String get guidanceNavigationBody =>
      'از این نوار برای رفتن به بخش‌های فروش، خرید، بانکداری و گزارش‌ها استفاده کنید.';

  @override
  String get guidanceBankingTitle => 'بانکداری';

  @override
  String get guidanceBankingBody =>
      'حساب‌های بانکی را مدیریت و صورت‌های بانکی را از اینجا تطبیق دهید.';

  @override
  String get guidanceReportsTitle => 'گزارش‌ها';

  @override
  String get guidanceReportsBody =>
      'گزارش‌های مالی، دفتر کل و جست‌وجوی اسناد را از اینجا باز کنید.';

  @override
  String get guidanceSearchTitle => 'جست‌وجوی سراسری';

  @override
  String get guidanceSearchBody => 'از اینجا در کل برنامه جست‌وجو کنید.';

  @override
  String get guidanceLanguageTitle => 'زبان و ظاهر';

  @override
  String get guidanceLanguageBody =>
      'بین فارسی، English و Հայերեն جابه‌جا شوید و حالت روشن/تاریک را تغییر دهید.';

  @override
  String get guidanceNotificationsTitle => 'اعلان‌ها';

  @override
  String get guidanceNotificationsBody =>
      'اعلان‌ها شما را از اقلام معوق و تأییدیه‌ها به‌روز نگه می‌دارند.';

  @override
  String get guidanceReadyTitle => 'همه‌چیز آماده است';

  @override
  String get guidanceReadyBody =>
      'هر وقت به کمک نیاز داشتید، منوی برنامه را باز و گزینه دستیار هوشمند (AI Assistant) را انتخاب کنید؛ درباره کسب‌وکارتان پاسخ می‌دهد. حالا آماده شروع هستید!';
}
