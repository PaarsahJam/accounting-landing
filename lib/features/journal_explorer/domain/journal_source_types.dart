import '../../../l10n/app_localizations.dart';
import 'journal_source_type.dart';

export 'journal_source_type.dart' show journalSourceTypeAll;

const journalSourceTypes = <JournalSourceType>[
  JournalSourceType(id: 'purchase_order', label: 'Purchase Order'),
  JournalSourceType(id: 'goods_receipt', label: 'Goods Receipt'),
  JournalSourceType(id: 'vendor_bill', label: 'Vendor Bill'),
  JournalSourceType(id: 'vendor_payment', label: 'Vendor Payment'),
  JournalSourceType(id: 'sales_invoice', label: 'Sales Invoice'),
  JournalSourceType(id: 'customer_payment', label: 'Customer Payment'),
];

String journalSourceTypeLabel(String id, AppLocalizations l10n) {
  switch (id) {
    case 'purchase_order':
      return l10n.journalExplorerSourcePurchaseOrder;
    case 'goods_receipt':
      return l10n.journalExplorerSourceGoodsReceipt;
    case 'vendor_bill':
      return l10n.journalExplorerSourceVendorBill;
    case 'vendor_payment':
      return l10n.journalExplorerSourceVendorPayment;
    case 'sales_invoice':
      return l10n.journalExplorerSourceSalesInvoice;
    case 'customer_payment':
      return l10n.journalExplorerSourceCustomerPayment;
    default:
      return id;
  }
}
