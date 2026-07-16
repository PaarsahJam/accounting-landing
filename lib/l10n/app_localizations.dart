import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fa'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fa, this message translates to:
  /// **'حسابداری'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In fa, this message translates to:
  /// **'ورود'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In fa, this message translates to:
  /// **'ثبت نام'**
  String get signup;

  /// No description provided for @email.
  ///
  /// In fa, this message translates to:
  /// **'ایمیل'**
  String get email;

  /// No description provided for @password.
  ///
  /// In fa, this message translates to:
  /// **'رمز عبور'**
  String get password;

  /// No description provided for @requiredField.
  ///
  /// In fa, this message translates to:
  /// **'این فیلد الزامی است'**
  String get requiredField;

  /// No description provided for @signupTodoMessage.
  ///
  /// In fa, this message translates to:
  /// **'ثبت‌نام در حال حاضر در دسترس نیست.'**
  String get signupTodoMessage;

  /// No description provided for @pageNotFound.
  ///
  /// In fa, this message translates to:
  /// **'صفحه‌ای با این مسیر یافت نشد: {path}'**
  String pageNotFound(Object path);

  /// No description provided for @dashboard.
  ///
  /// In fa, this message translates to:
  /// **'داشبورد'**
  String get dashboard;

  /// No description provided for @invoicePageTitle.
  ///
  /// In fa, this message translates to:
  /// **'فاکتورها'**
  String get invoicePageTitle;

  /// No description provided for @invoiceAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن فاکتور'**
  String get invoiceAddTitle;

  /// No description provided for @invoiceEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش فاکتور'**
  String get invoiceEditTitle;

  /// No description provided for @invoiceCustomer.
  ///
  /// In fa, this message translates to:
  /// **'نام مشتری'**
  String get invoiceCustomer;

  /// No description provided for @invoiceAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ'**
  String get invoiceAmount;

  /// No description provided for @invoiceStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get invoiceStatus;

  /// No description provided for @invoiceDescription.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات'**
  String get invoiceDescription;

  /// No description provided for @invoiceCancel.
  ///
  /// In fa, this message translates to:
  /// **'انصراف'**
  String get invoiceCancel;

  /// No description provided for @invoiceCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get invoiceCreate;

  /// No description provided for @invoiceSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get invoiceSave;

  /// No description provided for @invoiceRequiredField.
  ///
  /// In fa, this message translates to:
  /// **'این فیلد الزامی است'**
  String get invoiceRequiredField;

  /// No description provided for @invoiceStatusPending.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار'**
  String get invoiceStatusPending;

  /// No description provided for @invoiceLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری فاکتورها:'**
  String get invoiceLoadError;

  /// No description provided for @invoiceEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'هنوز فاکتوری ثبت نشده است'**
  String get invoiceEmptyTitle;

  /// No description provided for @invoiceEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هیچ فاکتوری ثبت نشده است.'**
  String get invoiceEmptyMessage;

  /// No description provided for @invoiceEditAction.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش'**
  String get invoiceEditAction;

  /// No description provided for @invoiceDeleteAction.
  ///
  /// In fa, this message translates to:
  /// **'حذف'**
  String get invoiceDeleteAction;

  /// No description provided for @invoiceCurrencyUnit.
  ///
  /// In fa, this message translates to:
  /// **'ریال'**
  String get invoiceCurrencyUnit;

  /// No description provided for @refresh.
  ///
  /// In fa, this message translates to:
  /// **'تازه‌سازی'**
  String get refresh;

  /// No description provided for @dashboardOverview.
  ///
  /// In fa, this message translates to:
  /// **'نمای کلی فعالیت‌های حسابداری'**
  String get dashboardOverview;

  /// No description provided for @dashboardSubtitle.
  ///
  /// In fa, this message translates to:
  /// **'شاخص‌های کلیدی برای دوره جاری'**
  String get dashboardSubtitle;

  /// No description provided for @dashboardRevenue.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get dashboardRevenue;

  /// No description provided for @dashboardExpenses.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌ها'**
  String get dashboardExpenses;

  /// No description provided for @dashboardOutstandingInvoices.
  ///
  /// In fa, this message translates to:
  /// **'فاکتورهای معوق'**
  String get dashboardOutstandingInvoices;

  /// No description provided for @dashboardCashFlow.
  ///
  /// In fa, this message translates to:
  /// **'جریان نقد'**
  String get dashboardCashFlow;

  /// No description provided for @dashboardLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری داده‌های داشبورد:'**
  String get dashboardLoadError;

  /// No description provided for @dashboardLoading.
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری داشبورد'**
  String get dashboardLoading;

  /// No description provided for @dashboardFinancialSubtitle.
  ///
  /// In fa, this message translates to:
  /// **'شاخص‌های مالی تجمیع‌شده از داده‌های آزمایشی'**
  String get dashboardFinancialSubtitle;

  /// No description provided for @dashboardAccountsReceivable.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌های دریافتنی'**
  String get dashboardAccountsReceivable;

  /// No description provided for @dashboardTotalOutstandingInvoices.
  ///
  /// In fa, this message translates to:
  /// **'کل فاکتورهای معوق'**
  String get dashboardTotalOutstandingInvoices;

  /// No description provided for @dashboardOverdueInvoices.
  ///
  /// In fa, this message translates to:
  /// **'فاکتورهای سررسید گذشته'**
  String get dashboardOverdueInvoices;

  /// No description provided for @dashboardReceivedThisMonth.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ دریافتی این ماه'**
  String get dashboardReceivedThisMonth;

  /// No description provided for @dashboardAccountsPayable.
  ///
  /// In fa, this message translates to:
  /// **'حساب‌های پرداختنی'**
  String get dashboardAccountsPayable;

  /// No description provided for @dashboardOutstandingVendorBills.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب‌های معوق تأمین‌کننده'**
  String get dashboardOutstandingVendorBills;

  /// No description provided for @dashboardOverdueBills.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب‌های سررسید گذشته'**
  String get dashboardOverdueBills;

  /// No description provided for @dashboardPaymentsMadeThisMonth.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت‌های انجام‌شده این ماه'**
  String get dashboardPaymentsMadeThisMonth;

  /// No description provided for @dashboardInventory.
  ///
  /// In fa, this message translates to:
  /// **'موجودی'**
  String get dashboardInventory;

  /// No description provided for @dashboardProductCount.
  ///
  /// In fa, this message translates to:
  /// **'تعداد محصولات'**
  String get dashboardProductCount;

  /// No description provided for @dashboardLowStockProducts.
  ///
  /// In fa, this message translates to:
  /// **'محصولات با موجودی کم'**
  String get dashboardLowStockProducts;

  /// No description provided for @dashboardTotalStockQuantity.
  ///
  /// In fa, this message translates to:
  /// **'کل موجودی انبار'**
  String get dashboardTotalStockQuantity;

  /// No description provided for @dashboardWarehouseCount.
  ///
  /// In fa, this message translates to:
  /// **'تعداد انبارها'**
  String get dashboardWarehouseCount;

  /// No description provided for @dashboardCashPosition.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت نقدینگی'**
  String get dashboardCashPosition;

  /// No description provided for @dashboardCash.
  ///
  /// In fa, this message translates to:
  /// **'نقد'**
  String get dashboardCash;

  /// No description provided for @dashboardBank.
  ///
  /// In fa, this message translates to:
  /// **'بانک'**
  String get dashboardBank;

  /// No description provided for @dashboardTotalLiquidAssets.
  ///
  /// In fa, this message translates to:
  /// **'کل دارایی‌های نقد'**
  String get dashboardTotalLiquidAssets;

  /// No description provided for @dashboardMonthlyRevenue.
  ///
  /// In fa, this message translates to:
  /// **'درآمد ماهانه'**
  String get dashboardMonthlyRevenue;

  /// No description provided for @dashboardMonthlyExpenses.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌های ماهانه'**
  String get dashboardMonthlyExpenses;

  /// No description provided for @dashboardProfitOverview.
  ///
  /// In fa, this message translates to:
  /// **'نمای کلی سود'**
  String get dashboardProfitOverview;

  /// No description provided for @dashboardGrossProfit.
  ///
  /// In fa, this message translates to:
  /// **'سود ناخالص'**
  String get dashboardGrossProfit;

  /// No description provided for @dashboardNetProfit.
  ///
  /// In fa, this message translates to:
  /// **'سود خالص'**
  String get dashboardNetProfit;

  /// No description provided for @dashboardRecentActivity.
  ///
  /// In fa, this message translates to:
  /// **'فعالیت‌های اخیر'**
  String get dashboardRecentActivity;

  /// No description provided for @dashboardNoRecentActivity.
  ///
  /// In fa, this message translates to:
  /// **'فعالیت اخیری وجود ندارد'**
  String get dashboardNoRecentActivity;

  /// No description provided for @dashboardQuickActions.
  ///
  /// In fa, this message translates to:
  /// **'اقدامات سریع'**
  String get dashboardQuickActions;

  /// No description provided for @dashboardCreateSalesInvoice.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد فاکتور فروش'**
  String get dashboardCreateSalesInvoice;

  /// No description provided for @dashboardCreateVendorBill.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد صورتحساب تأمین‌کننده'**
  String get dashboardCreateVendorBill;

  /// No description provided for @dashboardReceiveCustomerPayment.
  ///
  /// In fa, this message translates to:
  /// **'دریافت پرداخت مشتری'**
  String get dashboardReceiveCustomerPayment;

  /// No description provided for @dashboardRecordVendorPayment.
  ///
  /// In fa, this message translates to:
  /// **'ثبت پرداخت تأمین‌کننده'**
  String get dashboardRecordVendorPayment;

  /// No description provided for @dashboardViewJournal.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده دفتر روزنامه'**
  String get dashboardViewJournal;

  /// No description provided for @dashboardActivityPurchaseOrder.
  ///
  /// In fa, this message translates to:
  /// **'سفارش خرید'**
  String get dashboardActivityPurchaseOrder;

  /// No description provided for @dashboardActivityGoodsReceipt.
  ///
  /// In fa, this message translates to:
  /// **'رسید کالا'**
  String get dashboardActivityGoodsReceipt;

  /// No description provided for @dashboardActivityVendorBill.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب تأمین‌کننده'**
  String get dashboardActivityVendorBill;

  /// No description provided for @dashboardActivityVendorPayment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت تأمین‌کننده'**
  String get dashboardActivityVendorPayment;

  /// No description provided for @dashboardActivitySalesInvoice.
  ///
  /// In fa, this message translates to:
  /// **'فاکتور فروش'**
  String get dashboardActivitySalesInvoice;

  /// No description provided for @dashboardActivityCustomerPayment.
  ///
  /// In fa, this message translates to:
  /// **'دریافت مشتری'**
  String get dashboardActivityCustomerPayment;

  /// No description provided for @dashboardActivityJournalEntry.
  ///
  /// In fa, this message translates to:
  /// **'سند حسابداری'**
  String get dashboardActivityJournalEntry;

  /// No description provided for @expensesPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌ها'**
  String get expensesPageTitle;

  /// No description provided for @expensesLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری هزینه‌ها:'**
  String get expensesLoadError;

  /// No description provided for @expensesEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌ای موجود نیست'**
  String get expensesEmptyTitle;

  /// No description provided for @expensesEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز هزینه‌ای ثبت نشده است.'**
  String get expensesEmptyMessage;

  /// No description provided for @reportsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'گزارش‌ها'**
  String get reportsPageTitle;

  /// No description provided for @reportsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری گزارش‌ها:'**
  String get reportsLoadError;

  /// No description provided for @reportsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'گزارشی موجود نیست'**
  String get reportsEmptyTitle;

  /// No description provided for @reportsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز گزارشی ایجاد نشده است.'**
  String get reportsEmptyMessage;

  /// No description provided for @financialReportsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'گزارش‌های مالی'**
  String get financialReportsPageTitle;

  /// No description provided for @financialReportsLoadingMessage.
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری گزارش‌های مالی'**
  String get financialReportsLoadingMessage;

  /// No description provided for @financialReportsNoReportsTitle.
  ///
  /// In fa, this message translates to:
  /// **'گزارشی موجود نیست'**
  String get financialReportsNoReportsTitle;

  /// No description provided for @financialReportsNoReportsMessage.
  ///
  /// In fa, this message translates to:
  /// **'برای دوره انتخاب‌شده داده‌ای در دسترس نیست.'**
  String get financialReportsNoReportsMessage;

  /// No description provided for @financialReportsTrialBalance.
  ///
  /// In fa, this message translates to:
  /// **'تراز آزمایشی'**
  String get financialReportsTrialBalance;

  /// No description provided for @financialReportsBalanceSheet.
  ///
  /// In fa, this message translates to:
  /// **'ترازنامه'**
  String get financialReportsBalanceSheet;

  /// No description provided for @financialReportsCashFlow.
  ///
  /// In fa, this message translates to:
  /// **'جریان نقد'**
  String get financialReportsCashFlow;

  /// No description provided for @financialReportsSearchAccount.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی حساب'**
  String get financialReportsSearchAccount;

  /// No description provided for @financialReportsStartLabel.
  ///
  /// In fa, this message translates to:
  /// **'از'**
  String get financialReportsStartLabel;

  /// No description provided for @financialReportsEndLabel.
  ///
  /// In fa, this message translates to:
  /// **'تا'**
  String get financialReportsEndLabel;

  /// No description provided for @financialReportsFilterAll.
  ///
  /// In fa, this message translates to:
  /// **'همه'**
  String get financialReportsFilterAll;

  /// No description provided for @financialReportsFilterDebit.
  ///
  /// In fa, this message translates to:
  /// **'بدهکار'**
  String get financialReportsFilterDebit;

  /// No description provided for @financialReportsFilterCredit.
  ///
  /// In fa, this message translates to:
  /// **'بستانکار'**
  String get financialReportsFilterCredit;

  /// No description provided for @financialReportsArAging.
  ///
  /// In fa, this message translates to:
  /// **'AR Aging'**
  String get financialReportsArAging;

  /// No description provided for @financialReportsApAging.
  ///
  /// In fa, this message translates to:
  /// **'AP Aging'**
  String get financialReportsApAging;

  /// No description provided for @financialReportsRevenue.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get financialReportsRevenue;

  /// No description provided for @financialReportsExpenses.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌ها'**
  String get financialReportsExpenses;

  /// No description provided for @financialReportsNetProfit.
  ///
  /// In fa, this message translates to:
  /// **'سود خالص'**
  String get financialReportsNetProfit;

  /// No description provided for @financialReportsBalanced.
  ///
  /// In fa, this message translates to:
  /// **'تراز'**
  String get financialReportsBalanced;

  /// No description provided for @financialReportsYes.
  ///
  /// In fa, this message translates to:
  /// **'بله'**
  String get financialReportsYes;

  /// No description provided for @financialReportsNo.
  ///
  /// In fa, this message translates to:
  /// **'خیر'**
  String get financialReportsNo;

  /// No description provided for @financialReportsProfitAndLoss.
  ///
  /// In fa, this message translates to:
  /// **'صورت سود و زیان'**
  String get financialReportsProfitAndLoss;

  /// No description provided for @financialReportsAccountCode.
  ///
  /// In fa, this message translates to:
  /// **'کد حساب'**
  String get financialReportsAccountCode;

  /// No description provided for @financialReportsAccountName.
  ///
  /// In fa, this message translates to:
  /// **'نام حساب'**
  String get financialReportsAccountName;

  /// No description provided for @financialReportsDebit.
  ///
  /// In fa, this message translates to:
  /// **'بدهکار'**
  String get financialReportsDebit;

  /// No description provided for @financialReportsCredit.
  ///
  /// In fa, this message translates to:
  /// **'بستانکار'**
  String get financialReportsCredit;

  /// No description provided for @financialReportsEndingBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده نهایی'**
  String get financialReportsEndingBalance;

  /// No description provided for @financialReportsAssets.
  ///
  /// In fa, this message translates to:
  /// **'دارایی‌ها'**
  String get financialReportsAssets;

  /// No description provided for @financialReportsLiabilities.
  ///
  /// In fa, this message translates to:
  /// **'بدهی‌ها'**
  String get financialReportsLiabilities;

  /// No description provided for @financialReportsEquity.
  ///
  /// In fa, this message translates to:
  /// **'حقوق صاحبان سهام'**
  String get financialReportsEquity;

  /// No description provided for @financialReportsCash.
  ///
  /// In fa, this message translates to:
  /// **'نقد'**
  String get financialReportsCash;

  /// No description provided for @financialReportsBank.
  ///
  /// In fa, this message translates to:
  /// **'بانک'**
  String get financialReportsBank;

  /// No description provided for @financialReportsReceivables.
  ///
  /// In fa, this message translates to:
  /// **'دریافتنی‌ها'**
  String get financialReportsReceivables;

  /// No description provided for @financialReportsInventory.
  ///
  /// In fa, this message translates to:
  /// **'موجودی'**
  String get financialReportsInventory;

  /// No description provided for @financialReportsPayables.
  ///
  /// In fa, this message translates to:
  /// **'پرداختنی‌ها'**
  String get financialReportsPayables;

  /// No description provided for @financialReportsCapital.
  ///
  /// In fa, this message translates to:
  /// **'سرمایه'**
  String get financialReportsCapital;

  /// No description provided for @financialReportsOperatingActivities.
  ///
  /// In fa, this message translates to:
  /// **'فعالیت‌های عملیاتی'**
  String get financialReportsOperatingActivities;

  /// No description provided for @reportPeriodLabel.
  ///
  /// In fa, this message translates to:
  /// **'دوره'**
  String get reportPeriodLabel;

  /// No description provided for @reportSelectLabel.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب گزارش'**
  String get reportSelectLabel;

  /// No description provided for @supportedFiltersLabel.
  ///
  /// In fa, this message translates to:
  /// **'فیلترهای پشتیبانی‌شده'**
  String get supportedFiltersLabel;

  /// No description provided for @exportOptionsLabel.
  ///
  /// In fa, this message translates to:
  /// **'گزینه‌های خروجی'**
  String get exportOptionsLabel;

  /// No description provided for @mockOnlyLabel.
  ///
  /// In fa, this message translates to:
  /// **'فقط شبیه‌سازی'**
  String get mockOnlyLabel;

  /// No description provided for @revenueSummaryLabel.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get revenueSummaryLabel;

  /// No description provided for @expensesSummaryLabel.
  ///
  /// In fa, this message translates to:
  /// **'هزینه‌ها'**
  String get expensesSummaryLabel;

  /// No description provided for @netIncomeSummaryLabel.
  ///
  /// In fa, this message translates to:
  /// **'سود خالص'**
  String get netIncomeSummaryLabel;

  /// No description provided for @cashBalanceSummaryLabel.
  ///
  /// In fa, this message translates to:
  /// **'مانده نقد'**
  String get cashBalanceSummaryLabel;

  /// No description provided for @settingsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'تنظیمات'**
  String get settingsPageTitle;

  /// No description provided for @settingsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'امکان بارگذاری تنظیمات وجود ندارد'**
  String get settingsLoadError;

  /// No description provided for @customersPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'مشتریان'**
  String get customersPageTitle;

  /// No description provided for @customersLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری مشتریان:'**
  String get customersLoadError;

  /// No description provided for @customersEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'مشتری‌ای موجود نیست'**
  String get customersEmptyTitle;

  /// No description provided for @customersEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز مشتری‌ای ثبت نشده است.'**
  String get customersEmptyMessage;

  /// No description provided for @customerAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن مشتری'**
  String get customerAddTitle;

  /// No description provided for @customerEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش مشتری'**
  String get customerEditTitle;

  /// No description provided for @customerName.
  ///
  /// In fa, this message translates to:
  /// **'نام'**
  String get customerName;

  /// No description provided for @customerCompany.
  ///
  /// In fa, this message translates to:
  /// **'شرکت'**
  String get customerCompany;

  /// No description provided for @customerEmail.
  ///
  /// In fa, this message translates to:
  /// **'ایمیل'**
  String get customerEmail;

  /// No description provided for @customerPhone.
  ///
  /// In fa, this message translates to:
  /// **'تلفن'**
  String get customerPhone;

  /// No description provided for @customerBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده معوق'**
  String get customerBalance;

  /// No description provided for @customerStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get customerStatus;

  /// No description provided for @customerNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get customerNotes;

  /// No description provided for @customerCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get customerCreate;

  /// No description provided for @customerSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get customerSave;

  /// No description provided for @generalLedgerPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'دفتر کل'**
  String get generalLedgerPageTitle;

  /// No description provided for @generalLedgerLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری دفتر کل:'**
  String get generalLedgerLoadError;

  /// No description provided for @generalLedgerEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'داده‌ای برای دفتر کل موجود نیست'**
  String get generalLedgerEmptyTitle;

  /// No description provided for @generalLedgerEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز داده‌ای برای دفتر کل در دسترس نیست.'**
  String get generalLedgerEmptyMessage;

  /// No description provided for @generalLedgerSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی حساب‌ها'**
  String get generalLedgerSearchHint;

  /// No description provided for @generalLedgerActive.
  ///
  /// In fa, this message translates to:
  /// **'فعال'**
  String get generalLedgerActive;

  /// No description provided for @generalLedgerInactive.
  ///
  /// In fa, this message translates to:
  /// **'غیرفعال'**
  String get generalLedgerInactive;

  /// No description provided for @generalLedgerBalanced.
  ///
  /// In fa, this message translates to:
  /// **'تراز'**
  String get generalLedgerBalanced;

  /// No description provided for @generalLedgerUnbalanced.
  ///
  /// In fa, this message translates to:
  /// **'نامتوازن'**
  String get generalLedgerUnbalanced;

  /// No description provided for @chartOfAccountsTitle.
  ///
  /// In fa, this message translates to:
  /// **'طرح حساب‌ها'**
  String get chartOfAccountsTitle;

  /// No description provided for @journalEntriesTitle.
  ///
  /// In fa, this message translates to:
  /// **'سندهای حسابداری'**
  String get journalEntriesTitle;

  /// No description provided for @trialBalanceTitle.
  ///
  /// In fa, this message translates to:
  /// **'تراز آزمایشی'**
  String get trialBalanceTitle;

  /// No description provided for @ledgerAccountTypeLabel.
  ///
  /// In fa, this message translates to:
  /// **'نوع'**
  String get ledgerAccountTypeLabel;

  /// No description provided for @ledgerOpeningBalanceLabel.
  ///
  /// In fa, this message translates to:
  /// **'مانده افتتاحیه'**
  String get ledgerOpeningBalanceLabel;

  /// No description provided for @ledgerCurrentBalanceLabel.
  ///
  /// In fa, this message translates to:
  /// **'مانده فعلی'**
  String get ledgerCurrentBalanceLabel;

  /// No description provided for @ledgerActiveLabel.
  ///
  /// In fa, this message translates to:
  /// **'فعال'**
  String get ledgerActiveLabel;

  /// No description provided for @ledgerAccountAsset.
  ///
  /// In fa, this message translates to:
  /// **'دارایی'**
  String get ledgerAccountAsset;

  /// No description provided for @ledgerAccountLiability.
  ///
  /// In fa, this message translates to:
  /// **'بدهی'**
  String get ledgerAccountLiability;

  /// No description provided for @ledgerAccountEquity.
  ///
  /// In fa, this message translates to:
  /// **'حقوق صاحبان سهام'**
  String get ledgerAccountEquity;

  /// No description provided for @ledgerAccountRevenue.
  ///
  /// In fa, this message translates to:
  /// **'درآمد'**
  String get ledgerAccountRevenue;

  /// No description provided for @ledgerAccountExpense.
  ///
  /// In fa, this message translates to:
  /// **'هزینه'**
  String get ledgerAccountExpense;

  /// No description provided for @journalEntryDetailTitle.
  ///
  /// In fa, this message translates to:
  /// **'سند حسابداری'**
  String get journalEntryDetailTitle;

  /// No description provided for @journalEntryReferenceLabel.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get journalEntryReferenceLabel;

  /// No description provided for @journalEntryDateLabel.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ'**
  String get journalEntryDateLabel;

  /// No description provided for @journalEntryMemoLabel.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get journalEntryMemoLabel;

  /// No description provided for @journalEntryLinesLabel.
  ///
  /// In fa, this message translates to:
  /// **'ردیف‌ها'**
  String get journalEntryLinesLabel;

  /// No description provided for @journalEntryNoMemo.
  ///
  /// In fa, this message translates to:
  /// **'بدون یادداشت'**
  String get journalEntryNoMemo;

  /// No description provided for @journalEntryLineDefault.
  ///
  /// In fa, this message translates to:
  /// **'ردیف سند'**
  String get journalEntryLineDefault;

  /// No description provided for @journalEntryDebit.
  ///
  /// In fa, this message translates to:
  /// **'بدهکار'**
  String get journalEntryDebit;

  /// No description provided for @journalEntryCredit.
  ///
  /// In fa, this message translates to:
  /// **'بستانکار'**
  String get journalEntryCredit;

  /// No description provided for @accountDetailPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات حساب'**
  String get accountDetailPageTitle;

  /// No description provided for @accountDetailLoadingMessage.
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری جزئیات حساب'**
  String get accountDetailLoadingMessage;

  /// No description provided for @accountDetailBalanceLabel.
  ///
  /// In fa, this message translates to:
  /// **'مانده فعلی'**
  String get accountDetailBalanceLabel;

  /// No description provided for @accountDetailTransactionsTitle.
  ///
  /// In fa, this message translates to:
  /// **'معاملات'**
  String get accountDetailTransactionsTitle;

  /// No description provided for @accountDetailNoTransactionsTitle.
  ///
  /// In fa, this message translates to:
  /// **'معامله‌ای وجود ندارد'**
  String get accountDetailNoTransactionsTitle;

  /// No description provided for @accountDetailNoTransactionsMessage.
  ///
  /// In fa, this message translates to:
  /// **'این حساب هنوز معامله‌ای ندارد.'**
  String get accountDetailNoTransactionsMessage;

  /// No description provided for @trialBalanceDebitLabel.
  ///
  /// In fa, this message translates to:
  /// **'بدهکار'**
  String get trialBalanceDebitLabel;

  /// No description provided for @trialBalanceCreditLabel.
  ///
  /// In fa, this message translates to:
  /// **'بستانکار'**
  String get trialBalanceCreditLabel;

  /// No description provided for @inventoryPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'موجودی'**
  String get inventoryPageTitle;

  /// No description provided for @inventoryLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری موجودی:'**
  String get inventoryLoadError;

  /// No description provided for @inventoryEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'محصولی موجود نیست'**
  String get inventoryEmptyTitle;

  /// No description provided for @inventoryEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز محصولی در دسترس نیست.'**
  String get inventoryEmptyMessage;

  /// No description provided for @inventorySearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی محصولات'**
  String get inventorySearchHint;

  /// No description provided for @inventoryCategoryFilter.
  ///
  /// In fa, this message translates to:
  /// **'فیلتر دسته‌بندی'**
  String get inventoryCategoryFilter;

  /// No description provided for @inventoryAllCategories.
  ///
  /// In fa, this message translates to:
  /// **'همه دسته‌بندی‌ها'**
  String get inventoryAllCategories;

  /// No description provided for @inventoryAddProduct.
  ///
  /// In fa, this message translates to:
  /// **'افزودن محصول'**
  String get inventoryAddProduct;

  /// No description provided for @inventoryEditProduct.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش محصول'**
  String get inventoryEditProduct;

  /// No description provided for @inventoryDeleteProduct.
  ///
  /// In fa, this message translates to:
  /// **'حذف محصول'**
  String get inventoryDeleteProduct;

  /// No description provided for @inventoryCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get inventoryCreate;

  /// No description provided for @inventorySave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get inventorySave;

  /// No description provided for @inventorySku.
  ///
  /// In fa, this message translates to:
  /// **'SKU'**
  String get inventorySku;

  /// No description provided for @inventoryName.
  ///
  /// In fa, this message translates to:
  /// **'نام'**
  String get inventoryName;

  /// No description provided for @inventoryDescription.
  ///
  /// In fa, this message translates to:
  /// **'توضیحات'**
  String get inventoryDescription;

  /// No description provided for @inventoryCategory.
  ///
  /// In fa, this message translates to:
  /// **'دسته‌بندی'**
  String get inventoryCategory;

  /// No description provided for @inventoryUnit.
  ///
  /// In fa, this message translates to:
  /// **'واحد'**
  String get inventoryUnit;

  /// No description provided for @inventoryPrice.
  ///
  /// In fa, this message translates to:
  /// **'قیمت'**
  String get inventoryPrice;

  /// No description provided for @inventoryStockOnHand.
  ///
  /// In fa, this message translates to:
  /// **'موجودی فعلی'**
  String get inventoryStockOnHand;

  /// No description provided for @inventoryActive.
  ///
  /// In fa, this message translates to:
  /// **'فعال'**
  String get inventoryActive;

  /// No description provided for @inventoryWarehousesTitle.
  ///
  /// In fa, this message translates to:
  /// **'انبارها'**
  String get inventoryWarehousesTitle;

  /// No description provided for @inventoryWarehousesLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری انبارها:'**
  String get inventoryWarehousesLoadError;

  /// No description provided for @inventoryWarehousesEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'انباری موجود نیست'**
  String get inventoryWarehousesEmptyTitle;

  /// No description provided for @inventoryWarehousesEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز انباری در دسترس نیست.'**
  String get inventoryWarehousesEmptyMessage;

  /// No description provided for @inventoryStockDetailLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری جزئیات موجودی:'**
  String get inventoryStockDetailLoadError;

  /// No description provided for @inventoryStockDetailEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'حرکت موجودی وجود ندارد'**
  String get inventoryStockDetailEmptyTitle;

  /// No description provided for @inventoryStockDetailEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'این محصول هنوز حرکت موجودی ندارد.'**
  String get inventoryStockDetailEmptyMessage;

  /// No description provided for @inventoryStockDetailQuantity.
  ///
  /// In fa, this message translates to:
  /// **'موجودی فعلی'**
  String get inventoryStockDetailQuantity;

  /// No description provided for @inventoryStockDetailWarehouse.
  ///
  /// In fa, this message translates to:
  /// **'انبار'**
  String get inventoryStockDetailWarehouse;

  /// No description provided for @inventoryStockDetailMovementHistory.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه حرکت‌ها'**
  String get inventoryStockDetailMovementHistory;

  /// No description provided for @inventoryStockDetailNoWarehouse.
  ///
  /// In fa, this message translates to:
  /// **'انباری اختصاص داده نشده است'**
  String get inventoryStockDetailNoWarehouse;

  /// No description provided for @purchaseOrdersPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'سفارش‌های خرید'**
  String get purchaseOrdersPageTitle;

  /// No description provided for @purchaseOrdersLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری سفارش‌های خرید:'**
  String get purchaseOrdersLoadError;

  /// No description provided for @purchaseOrdersEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'سفارش خریدی موجود نیست'**
  String get purchaseOrdersEmptyTitle;

  /// No description provided for @purchaseOrdersEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز سفارش خرید ثبت نشده است.'**
  String get purchaseOrdersEmptyMessage;

  /// No description provided for @purchaseOrderAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن سفارش خرید'**
  String get purchaseOrderAddTitle;

  /// No description provided for @purchaseOrderEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش سفارش خرید'**
  String get purchaseOrderEditTitle;

  /// No description provided for @purchaseOrderDeleteTitle.
  ///
  /// In fa, this message translates to:
  /// **'حذف سفارش خرید'**
  String get purchaseOrderDeleteTitle;

  /// No description provided for @purchaseOrderCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get purchaseOrderCreate;

  /// No description provided for @purchaseOrderSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get purchaseOrderSave;

  /// No description provided for @purchaseOrderReference.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get purchaseOrderReference;

  /// No description provided for @purchaseOrderTitle.
  ///
  /// In fa, this message translates to:
  /// **'عنوان'**
  String get purchaseOrderTitle;

  /// No description provided for @purchaseOrderVendor.
  ///
  /// In fa, this message translates to:
  /// **'تأمین‌کننده'**
  String get purchaseOrderVendor;

  /// No description provided for @purchaseOrderStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get purchaseOrderStatus;

  /// No description provided for @purchaseOrderNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get purchaseOrderNotes;

  /// No description provided for @purchaseOrderLineDescription.
  ///
  /// In fa, this message translates to:
  /// **'توضیح ردیف'**
  String get purchaseOrderLineDescription;

  /// No description provided for @purchaseOrderQuantity.
  ///
  /// In fa, this message translates to:
  /// **'تعداد'**
  String get purchaseOrderQuantity;

  /// No description provided for @purchaseOrderUnitPrice.
  ///
  /// In fa, this message translates to:
  /// **'قیمت واحد'**
  String get purchaseOrderUnitPrice;

  /// No description provided for @purchaseOrderSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی سفارش‌های خرید'**
  String get purchaseOrderSearchHint;

  /// No description provided for @vendorBillsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب‌های تأمین‌کننده'**
  String get vendorBillsPageTitle;

  /// No description provided for @vendorBillsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری صورتحساب‌های تأمین‌کننده:'**
  String get vendorBillsLoadError;

  /// No description provided for @vendorBillsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب تأمین‌کننده‌ای موجود نیست'**
  String get vendorBillsEmptyTitle;

  /// No description provided for @vendorBillsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز صورتحساب تأمین‌کننده‌ای ثبت نشده است.'**
  String get vendorBillsEmptyMessage;

  /// No description provided for @vendorBillAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن صورتحساب تأمین‌کننده'**
  String get vendorBillAddTitle;

  /// No description provided for @vendorBillEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش صورتحساب تأمین‌کننده'**
  String get vendorBillEditTitle;

  /// No description provided for @vendorBillDetailTitle.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات صورتحساب تأمین‌کننده'**
  String get vendorBillDetailTitle;

  /// No description provided for @vendorBillDeleteTitle.
  ///
  /// In fa, this message translates to:
  /// **'حذف صورتحساب تأمین‌کننده'**
  String get vendorBillDeleteTitle;

  /// No description provided for @vendorBillCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get vendorBillCreate;

  /// No description provided for @vendorBillSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get vendorBillSave;

  /// No description provided for @vendorBillReference.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get vendorBillReference;

  /// No description provided for @vendorBillTitle.
  ///
  /// In fa, this message translates to:
  /// **'عنوان'**
  String get vendorBillTitle;

  /// No description provided for @vendorBillVendor.
  ///
  /// In fa, this message translates to:
  /// **'تأمین‌کننده'**
  String get vendorBillVendor;

  /// No description provided for @vendorBillPurchaseOrder.
  ///
  /// In fa, this message translates to:
  /// **'سفارش خرید'**
  String get vendorBillPurchaseOrder;

  /// No description provided for @vendorBillGoodsReceipt.
  ///
  /// In fa, this message translates to:
  /// **'رسید کالا'**
  String get vendorBillGoodsReceipt;

  /// No description provided for @vendorBillStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get vendorBillStatus;

  /// No description provided for @vendorBillNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get vendorBillNotes;

  /// No description provided for @vendorBillSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی صورتحساب‌های تأمین‌کننده'**
  String get vendorBillSearchHint;

  /// No description provided for @vendorBillCreateFromReceipt.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد از رسید کالا'**
  String get vendorBillCreateFromReceipt;

  /// No description provided for @vendorBillLinesLabel.
  ///
  /// In fa, this message translates to:
  /// **'ردیف‌ها'**
  String get vendorBillLinesLabel;

  /// No description provided for @salesInvoicesPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'فاکتورهای فروش'**
  String get salesInvoicesPageTitle;

  /// No description provided for @salesInvoicesLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری فاکتورهای فروش:'**
  String get salesInvoicesLoadError;

  /// No description provided for @salesInvoicesEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'فاکتور فروش موجود نیست'**
  String get salesInvoicesEmptyTitle;

  /// No description provided for @salesInvoicesEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز فاکتور فروش ثبت نشده است.'**
  String get salesInvoicesEmptyMessage;

  /// No description provided for @salesInvoiceAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن فاکتور فروش'**
  String get salesInvoiceAddTitle;

  /// No description provided for @salesInvoiceEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش فاکتور فروش'**
  String get salesInvoiceEditTitle;

  /// No description provided for @salesInvoiceDetailTitle.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات فاکتور فروش'**
  String get salesInvoiceDetailTitle;

  /// No description provided for @salesInvoiceDeleteTitle.
  ///
  /// In fa, this message translates to:
  /// **'حذف فاکتور فروش'**
  String get salesInvoiceDeleteTitle;

  /// No description provided for @salesInvoiceCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get salesInvoiceCreate;

  /// No description provided for @salesInvoiceSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get salesInvoiceSave;

  /// No description provided for @salesInvoiceReference.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get salesInvoiceReference;

  /// No description provided for @salesInvoiceTitle.
  ///
  /// In fa, this message translates to:
  /// **'عنوان'**
  String get salesInvoiceTitle;

  /// No description provided for @salesInvoiceCustomer.
  ///
  /// In fa, this message translates to:
  /// **'مشتری'**
  String get salesInvoiceCustomer;

  /// No description provided for @salesInvoiceDueDate.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ سررسید'**
  String get salesInvoiceDueDate;

  /// No description provided for @salesInvoiceStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get salesInvoiceStatus;

  /// No description provided for @salesInvoiceNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت‌ها'**
  String get salesInvoiceNotes;

  /// No description provided for @salesInvoiceLinesLabel.
  ///
  /// In fa, this message translates to:
  /// **'سطرها'**
  String get salesInvoiceLinesLabel;

  /// No description provided for @salesInvoiceAddLine.
  ///
  /// In fa, this message translates to:
  /// **'افزودن سطر'**
  String get salesInvoiceAddLine;

  /// No description provided for @salesInvoiceSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی فاکتورهای فروش'**
  String get salesInvoiceSearchHint;

  /// No description provided for @salesInvoiceSubtotal.
  ///
  /// In fa, this message translates to:
  /// **'جمع جزء'**
  String get salesInvoiceSubtotal;

  /// No description provided for @salesInvoiceTax.
  ///
  /// In fa, this message translates to:
  /// **'مالیات'**
  String get salesInvoiceTax;

  /// No description provided for @salesInvoiceTotal.
  ///
  /// In fa, this message translates to:
  /// **'جمع کل'**
  String get salesInvoiceTotal;

  /// No description provided for @customerPaymentsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'دریافت‌های مشتری'**
  String get customerPaymentsPageTitle;

  /// No description provided for @customerPaymentsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری دریافت‌های مشتری:'**
  String get customerPaymentsLoadError;

  /// No description provided for @customerPaymentsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'دریافت مشتری موجود نیست'**
  String get customerPaymentsEmptyTitle;

  /// No description provided for @customerPaymentsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز دریافت مشتری ثبت نشده است.'**
  String get customerPaymentsEmptyMessage;

  /// No description provided for @customerPaymentAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن دریافت مشتری'**
  String get customerPaymentAddTitle;

  /// No description provided for @customerPaymentEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش دریافت مشتری'**
  String get customerPaymentEditTitle;

  /// No description provided for @customerPaymentDetailTitle.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات دریافت مشتری'**
  String get customerPaymentDetailTitle;

  /// No description provided for @customerPaymentDeleteTitle.
  ///
  /// In fa, this message translates to:
  /// **'حذف دریافت مشتری'**
  String get customerPaymentDeleteTitle;

  /// No description provided for @customerPaymentCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get customerPaymentCreate;

  /// No description provided for @customerPaymentSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get customerPaymentSave;

  /// No description provided for @customerPaymentReference.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get customerPaymentReference;

  /// No description provided for @customerPaymentCustomer.
  ///
  /// In fa, this message translates to:
  /// **'مشتری'**
  String get customerPaymentCustomer;

  /// No description provided for @customerPaymentAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ'**
  String get customerPaymentAmount;

  /// No description provided for @customerPaymentMethod.
  ///
  /// In fa, this message translates to:
  /// **'روش'**
  String get customerPaymentMethod;

  /// No description provided for @customerPaymentStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get customerPaymentStatus;

  /// No description provided for @customerPaymentNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get customerPaymentNotes;

  /// No description provided for @customerPaymentSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی دریافت‌های مشتری'**
  String get customerPaymentSearchHint;

  /// No description provided for @customerPaymentAllocationsLabel.
  ///
  /// In fa, this message translates to:
  /// **'تخصیص‌ها'**
  String get customerPaymentAllocationsLabel;

  /// No description provided for @customerPaymentAllocationAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تخصیص‌یافته'**
  String get customerPaymentAllocationAmount;

  /// No description provided for @customerStatementsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورت‌حساب‌های مشتری'**
  String get customerStatementsPageTitle;

  /// No description provided for @customerStatementsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری صورت‌حساب‌های مشتری:'**
  String get customerStatementsLoadError;

  /// No description provided for @customerStatementsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورت‌حساب مشتری‌ای موجود نیست'**
  String get customerStatementsEmptyTitle;

  /// No description provided for @customerStatementsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز صورت‌حسابی ایجاد نشده است.'**
  String get customerStatementsEmptyMessage;

  /// No description provided for @customerStatementsSelectCustomer.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب مشتری'**
  String get customerStatementsSelectCustomer;

  /// No description provided for @customerStatementsDateRange.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی'**
  String get customerStatementsDateRange;

  /// No description provided for @customerStatementsOpeningBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده افتتاحیه'**
  String get customerStatementsOpeningBalance;

  /// No description provided for @customerStatementsRunningBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده جاری'**
  String get customerStatementsRunningBalance;

  /// No description provided for @customerStatementsOutstandingBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده معوق'**
  String get customerStatementsOutstandingBalance;

  /// No description provided for @customerStatementsInvoiceHistory.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه فاکتورها'**
  String get customerStatementsInvoiceHistory;

  /// No description provided for @customerStatementsPaymentHistory.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه پرداخت‌ها'**
  String get customerStatementsPaymentHistory;

  /// No description provided for @customerStatementsAgingTitle.
  ///
  /// In fa, this message translates to:
  /// **'سنی‌سازی مطالبات'**
  String get customerStatementsAgingTitle;

  /// No description provided for @customerStatementsNoInvoices.
  ///
  /// In fa, this message translates to:
  /// **'فاکتوری یافت نشد'**
  String get customerStatementsNoInvoices;

  /// No description provided for @customerStatementsNoPayments.
  ///
  /// In fa, this message translates to:
  /// **'پرداختی یافت نشد'**
  String get customerStatementsNoPayments;

  /// No description provided for @customerStatementsNoEntries.
  ///
  /// In fa, this message translates to:
  /// **'ورودی‌ای در بازه انتخابی وجود ندارد'**
  String get customerStatementsNoEntries;

  /// No description provided for @vendorPaymentsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت‌های تأمین‌کننده'**
  String get vendorPaymentsPageTitle;

  /// No description provided for @vendorPaymentsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری پرداخت‌های تأمین‌کننده:'**
  String get vendorPaymentsLoadError;

  /// No description provided for @vendorPaymentsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت تأمین‌کننده‌ای موجود نیست'**
  String get vendorPaymentsEmptyTitle;

  /// No description provided for @vendorPaymentsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز پرداخت تأمین‌کننده‌ای ثبت نشده است.'**
  String get vendorPaymentsEmptyMessage;

  /// No description provided for @vendorPaymentAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن پرداخت تأمین‌کننده'**
  String get vendorPaymentAddTitle;

  /// No description provided for @vendorPaymentEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش پرداخت تأمین‌کننده'**
  String get vendorPaymentEditTitle;

  /// No description provided for @vendorPaymentDetailTitle.
  ///
  /// In fa, this message translates to:
  /// **'جزئیات پرداخت تأمین‌کننده'**
  String get vendorPaymentDetailTitle;

  /// No description provided for @vendorPaymentDeleteTitle.
  ///
  /// In fa, this message translates to:
  /// **'حذف پرداخت تأمین‌کننده'**
  String get vendorPaymentDeleteTitle;

  /// No description provided for @vendorPaymentCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get vendorPaymentCreate;

  /// No description provided for @vendorPaymentSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get vendorPaymentSave;

  /// No description provided for @vendorPaymentReference.
  ///
  /// In fa, this message translates to:
  /// **'مرجع'**
  String get vendorPaymentReference;

  /// No description provided for @vendorPaymentVendor.
  ///
  /// In fa, this message translates to:
  /// **'تأمین‌کننده'**
  String get vendorPaymentVendor;

  /// No description provided for @vendorPaymentAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ'**
  String get vendorPaymentAmount;

  /// No description provided for @vendorPaymentMethod.
  ///
  /// In fa, this message translates to:
  /// **'روش'**
  String get vendorPaymentMethod;

  /// No description provided for @vendorPaymentStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get vendorPaymentStatus;

  /// No description provided for @vendorPaymentNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get vendorPaymentNotes;

  /// No description provided for @vendorPaymentSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی پرداخت‌های تأمین‌کننده'**
  String get vendorPaymentSearchHint;

  /// No description provided for @vendorPaymentAllocationsLabel.
  ///
  /// In fa, this message translates to:
  /// **'تخصیص‌ها'**
  String get vendorPaymentAllocationsLabel;

  /// No description provided for @vendorPaymentAllocationAmount.
  ///
  /// In fa, this message translates to:
  /// **'مبلغ تخصیص‌یافته'**
  String get vendorPaymentAllocationAmount;

  /// No description provided for @vendorStatementsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورت‌حساب‌های تأمین‌کننده'**
  String get vendorStatementsPageTitle;

  /// No description provided for @vendorStatementsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری صورت‌حساب‌های تأمین‌کننده:'**
  String get vendorStatementsLoadError;

  /// No description provided for @vendorStatementsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'صورت‌حساب تأمین‌کننده‌ای موجود نیست'**
  String get vendorStatementsEmptyTitle;

  /// No description provided for @vendorStatementsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز صورت‌حسابی ایجاد نشده است.'**
  String get vendorStatementsEmptyMessage;

  /// No description provided for @vendorStatementsSelectVendor.
  ///
  /// In fa, this message translates to:
  /// **'انتخاب تأمین‌کننده'**
  String get vendorStatementsSelectVendor;

  /// No description provided for @vendorStatementsDateRange.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی'**
  String get vendorStatementsDateRange;

  /// No description provided for @vendorStatementsOpeningBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده افتتاحیه'**
  String get vendorStatementsOpeningBalance;

  /// No description provided for @vendorStatementsRunningBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده جاری'**
  String get vendorStatementsRunningBalance;

  /// No description provided for @vendorStatementsOutstandingBalance.
  ///
  /// In fa, this message translates to:
  /// **'مانده معوق'**
  String get vendorStatementsOutstandingBalance;

  /// No description provided for @vendorStatementsBillHistory.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه صورتحساب‌ها'**
  String get vendorStatementsBillHistory;

  /// No description provided for @vendorStatementsPaymentHistory.
  ///
  /// In fa, this message translates to:
  /// **'تاریخچه پرداخت‌ها'**
  String get vendorStatementsPaymentHistory;

  /// No description provided for @vendorStatementsAgingTitle.
  ///
  /// In fa, this message translates to:
  /// **'سنی‌سازی بدهی‌ها'**
  String get vendorStatementsAgingTitle;

  /// No description provided for @vendorStatementsNoBills.
  ///
  /// In fa, this message translates to:
  /// **'صورتحسابی یافت نشد'**
  String get vendorStatementsNoBills;

  /// No description provided for @vendorStatementsNoPayments.
  ///
  /// In fa, this message translates to:
  /// **'پرداختی یافت نشد'**
  String get vendorStatementsNoPayments;

  /// No description provided for @vendorStatementsNoEntries.
  ///
  /// In fa, this message translates to:
  /// **'ورودی‌ای در بازه انتخابی وجود ندارد'**
  String get vendorStatementsNoEntries;

  /// No description provided for @journalPreviewPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌نمایش دفتر روزنامه'**
  String get journalPreviewPageTitle;

  /// No description provided for @journalPreviewLoadError.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری پیش‌نمایش دفتر روزنامه انجام نشد.'**
  String get journalPreviewLoadError;

  /// No description provided for @journalPreviewEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌نمایشی در دسترس نیست'**
  String get journalPreviewEmptyTitle;

  /// No description provided for @journalPreviewEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'برای سند انتخاب‌شده هنوز پیش‌نمایش دفتر روزنامه وجود ندارد.'**
  String get journalPreviewEmptyMessage;

  /// No description provided for @journalPreviewDocument.
  ///
  /// In fa, this message translates to:
  /// **'سند'**
  String get journalPreviewDocument;

  /// No description provided for @journalPreviewPostingDate.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ ثبت'**
  String get journalPreviewPostingDate;

  /// No description provided for @journalPreviewNarration.
  ///
  /// In fa, this message translates to:
  /// **'شرح'**
  String get journalPreviewNarration;

  /// No description provided for @journalPreviewLinesLabel.
  ///
  /// In fa, this message translates to:
  /// **'سطرهای ثبت'**
  String get journalPreviewLinesLabel;

  /// No description provided for @journalExplorerPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'دفتر کل'**
  String get journalExplorerPageTitle;

  /// No description provided for @journalExplorerLoadError.
  ///
  /// In fa, this message translates to:
  /// **'بارگذاری دفتر کل انجام نشد.'**
  String get journalExplorerLoadError;

  /// No description provided for @journalExplorerEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'سند حسابداری یافت نشد'**
  String get journalExplorerEmptyTitle;

  /// No description provided for @journalExplorerEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هیچ سند حسابداری با فیلترهای فعلی مطابقت ندارد.'**
  String get journalExplorerEmptyMessage;

  /// No description provided for @journalExplorerSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی شماره یا مرجع'**
  String get journalExplorerSearchHint;

  /// No description provided for @journalExplorerSourceType.
  ///
  /// In fa, this message translates to:
  /// **'نوع منبع'**
  String get journalExplorerSourceType;

  /// No description provided for @journalExplorerAccountCode.
  ///
  /// In fa, this message translates to:
  /// **'کد حساب'**
  String get journalExplorerAccountCode;

  /// No description provided for @journalExplorerSortBy.
  ///
  /// In fa, this message translates to:
  /// **'مرتب‌سازی'**
  String get journalExplorerSortBy;

  /// No description provided for @journalExplorerNewest.
  ///
  /// In fa, this message translates to:
  /// **'جدیدترین'**
  String get journalExplorerNewest;

  /// No description provided for @journalExplorerOldest.
  ///
  /// In fa, this message translates to:
  /// **'قدیمی‌ترین'**
  String get journalExplorerOldest;

  /// No description provided for @journalExplorerDateRange.
  ///
  /// In fa, this message translates to:
  /// **'بازه زمانی'**
  String get journalExplorerDateRange;

  /// No description provided for @journalExplorerPostingDate.
  ///
  /// In fa, this message translates to:
  /// **'تاریخ ثبت'**
  String get journalExplorerPostingDate;

  /// No description provided for @journalExplorerNarration.
  ///
  /// In fa, this message translates to:
  /// **'شرح'**
  String get journalExplorerNarration;

  /// No description provided for @journalExplorerPostingStatus.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت ثبت'**
  String get journalExplorerPostingStatus;

  /// No description provided for @journalExplorerTotalDebit.
  ///
  /// In fa, this message translates to:
  /// **'جمع بدهکار'**
  String get journalExplorerTotalDebit;

  /// No description provided for @journalExplorerTotalCredit.
  ///
  /// In fa, this message translates to:
  /// **'جمع بستانکار'**
  String get journalExplorerTotalCredit;

  /// No description provided for @journalExplorerLinesLabel.
  ///
  /// In fa, this message translates to:
  /// **'سطرهای دفتر'**
  String get journalExplorerLinesLabel;

  /// No description provided for @journalExplorerLoading.
  ///
  /// In fa, this message translates to:
  /// **'در حال بارگذاری اسناد'**
  String get journalExplorerLoading;

  /// No description provided for @journalExplorerSourceAll.
  ///
  /// In fa, this message translates to:
  /// **'همه'**
  String get journalExplorerSourceAll;

  /// No description provided for @journalExplorerSourcePurchaseOrder.
  ///
  /// In fa, this message translates to:
  /// **'سفارش خرید'**
  String get journalExplorerSourcePurchaseOrder;

  /// No description provided for @journalExplorerSourceGoodsReceipt.
  ///
  /// In fa, this message translates to:
  /// **'رسید کالا'**
  String get journalExplorerSourceGoodsReceipt;

  /// No description provided for @journalExplorerSourceVendorBill.
  ///
  /// In fa, this message translates to:
  /// **'صورتحساب تأمین‌کننده'**
  String get journalExplorerSourceVendorBill;

  /// No description provided for @journalExplorerSourceVendorPayment.
  ///
  /// In fa, this message translates to:
  /// **'پرداخت تأمین‌کننده'**
  String get journalExplorerSourceVendorPayment;

  /// No description provided for @journalExplorerSourceSalesInvoice.
  ///
  /// In fa, this message translates to:
  /// **'فاکتور فروش'**
  String get journalExplorerSourceSalesInvoice;

  /// No description provided for @journalExplorerSourceCustomerPayment.
  ///
  /// In fa, this message translates to:
  /// **'دریافت مشتری'**
  String get journalExplorerSourceCustomerPayment;

  /// No description provided for @journalExplorerViewSource.
  ///
  /// In fa, this message translates to:
  /// **'مشاهده سند مبدأ'**
  String get journalExplorerViewSource;

  /// No description provided for @vendorsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'تأمین‌کنندگان'**
  String get vendorsPageTitle;

  /// No description provided for @vendorsLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری تأمین‌کنندگان:'**
  String get vendorsLoadError;

  /// No description provided for @vendorsEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'تأمین‌کننده‌ای موجود نیست'**
  String get vendorsEmptyTitle;

  /// No description provided for @vendorsEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز تأمین‌کننده‌ای ثبت نشده است.'**
  String get vendorsEmptyMessage;

  /// No description provided for @vendorAddTitle.
  ///
  /// In fa, this message translates to:
  /// **'افزودن تأمین‌کننده'**
  String get vendorAddTitle;

  /// No description provided for @vendorEditTitle.
  ///
  /// In fa, this message translates to:
  /// **'ویرایش تأمین‌کننده'**
  String get vendorEditTitle;

  /// No description provided for @vendorCompanyName.
  ///
  /// In fa, this message translates to:
  /// **'نام شرکت'**
  String get vendorCompanyName;

  /// No description provided for @vendorContactName.
  ///
  /// In fa, this message translates to:
  /// **'نام تماس'**
  String get vendorContactName;

  /// No description provided for @vendorEmail.
  ///
  /// In fa, this message translates to:
  /// **'ایمیل'**
  String get vendorEmail;

  /// No description provided for @vendorPhone.
  ///
  /// In fa, this message translates to:
  /// **'تلفن'**
  String get vendorPhone;

  /// No description provided for @vendorAddress.
  ///
  /// In fa, this message translates to:
  /// **'آدرس'**
  String get vendorAddress;

  /// No description provided for @vendorTaxIdentifier.
  ///
  /// In fa, this message translates to:
  /// **'شناسه مالیاتی'**
  String get vendorTaxIdentifier;

  /// No description provided for @vendorActiveStatus.
  ///
  /// In fa, this message translates to:
  /// **'فعال'**
  String get vendorActiveStatus;

  /// No description provided for @vendorNotes.
  ///
  /// In fa, this message translates to:
  /// **'یادداشت'**
  String get vendorNotes;

  /// No description provided for @vendorSearchHint.
  ///
  /// In fa, this message translates to:
  /// **'جست‌وجوی تأمین‌کننده‌ها'**
  String get vendorSearchHint;

  /// No description provided for @vendorStatusLabel.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get vendorStatusLabel;

  /// No description provided for @vendorActive.
  ///
  /// In fa, this message translates to:
  /// **'فعال'**
  String get vendorActive;

  /// No description provided for @vendorInactive.
  ///
  /// In fa, this message translates to:
  /// **'غیرفعال'**
  String get vendorInactive;

  /// No description provided for @vendorCreate.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد'**
  String get vendorCreate;

  /// No description provided for @vendorSave.
  ///
  /// In fa, this message translates to:
  /// **'ذخیره'**
  String get vendorSave;

  /// No description provided for @currencyUnit.
  ///
  /// In fa, this message translates to:
  /// **'ریال'**
  String get currencyUnit;

  /// No description provided for @bankReconciliationPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'تطبیق بانک'**
  String get bankReconciliationPageTitle;

  /// No description provided for @bankReconciliationLoadError.
  ///
  /// In fa, this message translates to:
  /// **'امکان بارگذاری داده‌های تطبیق وجود ندارد:'**
  String get bankReconciliationLoadError;

  /// No description provided for @bankAccountSelector.
  ///
  /// In fa, this message translates to:
  /// **'حساب بانک'**
  String get bankAccountSelector;

  /// No description provided for @bankReconciliationSummary.
  ///
  /// In fa, this message translates to:
  /// **'خلاصه تطبیق'**
  String get bankReconciliationSummary;

  /// No description provided for @bankMatchedTransactions.
  ///
  /// In fa, this message translates to:
  /// **'معاملات منطبق'**
  String get bankMatchedTransactions;

  /// No description provided for @bankUnmatchedTransactions.
  ///
  /// In fa, this message translates to:
  /// **'معاملات نامنطبق'**
  String get bankUnmatchedTransactions;

  /// No description provided for @bankProgress.
  ///
  /// In fa, this message translates to:
  /// **'پیشرفت'**
  String get bankProgress;

  /// No description provided for @bankNoTransactions.
  ///
  /// In fa, this message translates to:
  /// **'معامله‌ای یافت نشد'**
  String get bankNoTransactions;

  /// No description provided for @bankNoTransactionsMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز معامله‌ای برای این حساب در دسترس نیست.'**
  String get bankNoTransactionsMessage;

  /// No description provided for @bankFinalize.
  ///
  /// In fa, this message translates to:
  /// **'اتمام تطبیق'**
  String get bankFinalize;

  /// No description provided for @bankCompletionDialogTitle.
  ///
  /// In fa, this message translates to:
  /// **'تطبیق تکمیل شد'**
  String get bankCompletionDialogTitle;

  /// No description provided for @bankCompletionDialogMessage.
  ///
  /// In fa, this message translates to:
  /// **'جلسه تطبیق با موفقیت تکمیل شد.'**
  String get bankCompletionDialogMessage;

  /// No description provided for @bankDone.
  ///
  /// In fa, this message translates to:
  /// **'تأیید'**
  String get bankDone;

  /// No description provided for @fiscalYearsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'دوره‌های مالی'**
  String get fiscalYearsPageTitle;

  /// No description provided for @fiscalPeriodsPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'دوره‌های فاصله‌گذاری'**
  String get fiscalPeriodsPageTitle;

  /// No description provided for @yearEndClosingPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'بستن سال‌نهايی'**
  String get yearEndClosingPageTitle;

  /// No description provided for @createButton.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد کردن'**
  String get createButton;

  /// No description provided for @draft.
  ///
  /// In fa, this message translates to:
  /// **'پیش‌نویس'**
  String get draft;

  /// No description provided for @pendingApproval.
  ///
  /// In fa, this message translates to:
  /// **'در انتظار تایید'**
  String get pendingApproval;

  /// No description provided for @approved.
  ///
  /// In fa, this message translates to:
  /// **'تایید شده'**
  String get approved;

  /// No description provided for @posted.
  ///
  /// In fa, this message translates to:
  /// **'ثبت شده'**
  String get posted;

  /// No description provided for @locked.
  ///
  /// In fa, this message translates to:
  /// **'قفل شده'**
  String get locked;

  /// No description provided for @cancelled.
  ///
  /// In fa, this message translates to:
  /// **'لغو شده'**
  String get cancelled;

  /// No description provided for @documentNumberLabel.
  ///
  /// In fa, this message translates to:
  /// **'شماره سند'**
  String get documentNumberLabel;

  /// No description provided for @documentStatusLabel.
  ///
  /// In fa, this message translates to:
  /// **'وضعیت'**
  String get documentStatusLabel;

  /// No description provided for @documentCreatedAtLabel.
  ///
  /// In fa, this message translates to:
  /// **'ایجاد شده'**
  String get documentCreatedAtLabel;

  /// No description provided for @documentApprovedAtLabel.
  ///
  /// In fa, this message translates to:
  /// **'تایید شده'**
  String get documentApprovedAtLabel;

  /// No description provided for @documentPostedAtLabel.
  ///
  /// In fa, this message translates to:
  /// **'ثبت شده'**
  String get documentPostedAtLabel;

  /// No description provided for @approvalTimelineTitle.
  ///
  /// In fa, this message translates to:
  /// **'مراحل تأیید'**
  String get approvalTimelineTitle;

  /// No description provided for @documentTypeLabel.
  ///
  /// In fa, this message translates to:
  /// **'نوع'**
  String get documentTypeLabel;

  /// No description provided for @workflowInvalidTransition.
  ///
  /// In fa, this message translates to:
  /// **'انتقال غیرمجاز'**
  String get workflowInvalidTransition;

  /// No description provided for @workflowTransitionToPendingApproval.
  ///
  /// In fa, this message translates to:
  /// **'ارسال برای تأیید'**
  String get workflowTransitionToPendingApproval;

  /// No description provided for @workflowTransitionToApproved.
  ///
  /// In fa, this message translates to:
  /// **'تأیید'**
  String get workflowTransitionToApproved;

  /// No description provided for @workflowTransitionToPosted.
  ///
  /// In fa, this message translates to:
  /// **'ثبت'**
  String get workflowTransitionToPosted;

  /// No description provided for @workflowTransitionToLocked.
  ///
  /// In fa, this message translates to:
  /// **'قفل'**
  String get workflowTransitionToLocked;

  /// No description provided for @workflowTransitionToCancelled.
  ///
  /// In fa, this message translates to:
  /// **'لغو'**
  String get workflowTransitionToCancelled;

  /// No description provided for @approvalWorkflowPageTitle.
  ///
  /// In fa, this message translates to:
  /// **'گردش کار سند'**
  String get approvalWorkflowPageTitle;

  /// No description provided for @approvalWorkflowLoadError.
  ///
  /// In fa, this message translates to:
  /// **'خطا در بارگذاری اسناد:'**
  String get approvalWorkflowLoadError;

  /// No description provided for @approvalWorkflowEmptyTitle.
  ///
  /// In fa, this message translates to:
  /// **'سندی موجود نیست'**
  String get approvalWorkflowEmptyTitle;

  /// No description provided for @approvalWorkflowEmptyMessage.
  ///
  /// In fa, this message translates to:
  /// **'هنوز سندی ثبت نشده است.'**
  String get approvalWorkflowEmptyMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
