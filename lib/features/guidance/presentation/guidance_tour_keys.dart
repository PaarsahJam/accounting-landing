import 'package:flutter/widgets.dart';

/// Global keys for the widgets the guidance tour points at.
///
/// Keys are static so the tour can reference them across pages; only one
/// nav surface (rail vs. bottom bar) is ever mounted at a time, so the
/// shared nav keys never collide.
class GuidanceTourKeys {
  GuidanceTourKeys._();

  static final dashboardHeader = GlobalKey();
  static final quickActionSalesInvoice = GlobalKey();
  static final metricAccountsReceivable = GlobalKey();
  static final profitOverview = GlobalKey();

  static final salesInvoicesHeader = GlobalKey();
  static final invoicesHeader = GlobalKey();
  static final customerPaymentsHeader = GlobalKey();
  static final vendorPaymentsHeader = GlobalKey();
  static final bankReconciliationHeader = GlobalKey();

  static final navSales = GlobalKey();
  static final navBanking = GlobalKey();
  static final navReports = GlobalKey();

  static final searchButton = GlobalKey();
  static final languageButton = GlobalKey();
  static final notificationsBell = GlobalKey();

  /// Maps a nav route to its tour target key (or null for untargeted routes).
  static GlobalKey? forRoute(String route) {
    switch (route) {
      case '/sales-invoices':
        return navSales;
      case '/bank-accounts':
        return navBanking;
      case '/reports':
        return navReports;
      default:
        return null;
    }
  }
}
