import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice_status.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_method.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_status.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill_status.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill_line.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_method.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_status.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order_line.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order_status.dart';
import 'package:accounting_app/features/inventory/domain/product.dart';
import 'package:accounting_app/features/expenses/domain/expense.dart';

import '../domain/analytics_filter.dart';
import '../services/metric_calculator.dart';

abstract class AnalyticsRepository {
  Future<MetricSourceData> fetchSourceData({AnalyticsFilter filter = AnalyticsFilter.none});
}

class MockAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<MetricSourceData> fetchSourceData({AnalyticsFilter filter = AnalyticsFilter.none}) async {
    return MetricSourceData(
      invoices: _sampleInvoices,
      vendorBills: _sampleBills,
      customerPayments: _sampleCustomerPayments,
      vendorPayments: _sampleVendorPayments,
      purchaseOrders: _sampleOrders,
      products: _sampleProducts,
      expenses: _sampleExpenses,
    );
  }
}

final _pendingStatus = SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue');
final _paidStatus = SalesInvoiceStatus(id: 'paid', label: 'Paid', color: 'green');
final _overdueStatus = SalesInvoiceStatus(id: 'overdue', label: 'Overdue', color: 'red');

final _sampleInvoices = [
  SalesInvoice(
    id: 'si-1', customerId: 'c1', customerName: 'ACME Corp', reference: 'INV-001',
    title: 'Consulting Q1', notes: '', invoiceDate: DateTime(2026, 1, 15), dueDate: DateTime(2026, 2, 14),
    status: _pendingStatus, lines: [], subtotal: 5000, tax: 500, total: 5500,
  ),
  SalesInvoice(
    id: 'si-2', customerId: 'c2', customerName: 'Beta Inc', reference: 'INV-002',
    title: 'Software License', notes: '', invoiceDate: DateTime(2026, 2, 1), dueDate: DateTime(2026, 3, 1),
    status: _pendingStatus, lines: [], subtotal: 12000, tax: 1200, total: 13200,
  ),
  SalesInvoice(
    id: 'si-3', customerId: 'c1', customerName: 'ACME Corp', reference: 'INV-003',
    title: 'Support Renewal', notes: '', invoiceDate: DateTime(2026, 2, 20), dueDate: DateTime(2026, 3, 20),
    status: _paidStatus, lines: [], subtotal: 3000, tax: 300, total: 3300,
  ),
  SalesInvoice(
    id: 'si-4', customerId: 'c3', customerName: 'Gamma LLC', reference: 'INV-004',
    title: 'Hardware Sale', notes: '', invoiceDate: DateTime(2025, 12, 1), dueDate: DateTime(2025, 12, 31),
    status: _overdueStatus, lines: [], subtotal: 8000, tax: 800, total: 8800,
  ),
  SalesInvoice(
    id: 'si-5', customerId: 'c2', customerName: 'Beta Inc', reference: 'INV-005',
    title: 'Consulting Q2', notes: '', invoiceDate: DateTime(2026, 3, 10), dueDate: DateTime(2026, 4, 9),
    status: _pendingStatus, lines: [], subtotal: 7000, tax: 700, total: 7700,
  ),
];

final _sampleBills = [
  VendorBill(
    id: 'vb-1', vendorId: 'v1', purchaseOrderId: 'po-1', goodsReceiptId: 'gr-1',
    reference: 'BILL-001', title: 'Office Supplies', notes: '',
    billDate: DateTime(2026, 1, 20), dueDate: DateTime(2026, 2, 19),
    status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
    lines: [
      VendorBillLine(id: 'l1', description: 'Paper', quantity: 10, unitPrice: 25),
      VendorBillLine(id: 'l2', description: 'Toner', quantity: 5, unitPrice: 80),
    ],
  ),
  VendorBill(
    id: 'vb-2', vendorId: 'v2', purchaseOrderId: 'po-2', goodsReceiptId: 'gr-2',
    reference: 'BILL-002', title: 'Cloud Hosting', notes: '',
    billDate: DateTime(2026, 2, 5), dueDate: DateTime(2026, 3, 5),
    status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
    lines: [
      VendorBillLine(id: 'l3', description: 'AWS Monthly', quantity: 1, unitPrice: 1200),
    ],
  ),
  VendorBill(
    id: 'vb-3', vendorId: 'v1', purchaseOrderId: 'po-3', goodsReceiptId: 'gr-3',
    reference: 'BILL-003', title: 'IT Equipment', notes: '',
    billDate: DateTime(2026, 3, 1), dueDate: DateTime(2026, 3, 31),
    status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
    lines: [
      VendorBillLine(id: 'l4', description: 'Monitor', quantity: 3, unitPrice: 350),
    ],
  ),
];

final _sampleCustomerPayments = [
  CustomerPayment(
    id: 'cp-1', customerId: 'c1', customerName: 'ACME Corp',
    reference: 'RCPT-001', notes: '', paymentDate: DateTime(2026, 1, 25),
    receivedAt: DateTime(2026, 1, 25), amount: 5500,
    method: CustomerPaymentMethod(id: 'chk', label: 'Check', icon: 'check'),
    status: CustomerPaymentStatus(id: 'cleared', label: 'Cleared', color: 'green'),
    allocations: [],
  ),
  CustomerPayment(
    id: 'cp-2', customerId: 'c2', customerName: 'Beta Inc',
    reference: 'RCPT-002', notes: '', paymentDate: DateTime(2026, 2, 28),
    receivedAt: DateTime(2026, 2, 28), amount: 13200,
    method: CustomerPaymentMethod(id: 'wire', label: 'Wire', icon: 'account_balance'),
    status: CustomerPaymentStatus(id: 'cleared', label: 'Cleared', color: 'green'),
    allocations: [],
  ),
];

final _sampleVendorPayments = [
  VendorPayment(
    id: 'vp-1', vendorId: 'v1', vendorName: 'OfficeMax',
    reference: 'PMT-001', notes: '', paymentDate: DateTime(2026, 2, 10),
    createdAt: DateTime(2026, 2, 8), amount: 650,
    method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'bank'),
    status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
    allocations: [],
  ),
  VendorPayment(
    id: 'vp-2', vendorId: 'v2', vendorName: 'AWS Inc',
    reference: 'PMT-002', notes: '', paymentDate: DateTime(2026, 3, 5),
    createdAt: DateTime(2026, 3, 3), amount: 1200,
    method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'bank'),
    status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
    allocations: [],
  ),
];

final _sampleOrders = [
  PurchaseOrder(
    id: 'po-1', vendorId: 'v1', reference: 'PO-001', title: 'Office Supplies Order',
    notes: '', orderDate: DateTime(2026, 1, 10), expectedDate: DateTime(2026, 1, 30),
    status: PurchaseOrderStatus(id: 'received', label: 'Received', color: 'green'),
    lines: [
      PurchaseOrderLine(id: 'pol-1', description: 'Paper', quantity: 10, unitPrice: 25),
    ],
  ),
];

final _sampleProducts = [
  const Product(id: 'p1', sku: 'SKU-001', name: 'Widget A', description: 'Standard widget', categoryId: 'cat-1', unitId: 'u1', price: 50, stockOnHand: 100, active: true),
  const Product(id: 'p2', sku: 'SKU-002', name: 'Widget B', description: 'Premium widget', categoryId: 'cat-1', unitId: 'u1', price: 80, stockOnHand: 30, active: true),
  const Product(id: 'p3', sku: 'SKU-003', name: 'Service Hour', description: 'Consulting hour', categoryId: 'cat-2', unitId: 'u2', price: 150, stockOnHand: 0, active: true),
];

final _sampleExpenses = [
  Expense(
    id: 'exp-1', merchant: 'WeWork', amount: 2000, categoryId: 'rent',
    paymentMethodId: 'ach', occurredAt: DateTime(2026, 1, 5), description: 'Office rent Jan',
    attachmentIds: [], status: ExpenseStatus.approved,
    businessId: 'b1', createdAt: DateTime(2026, 1, 5), updatedAt: DateTime(2026, 1, 5),
    createdBy: 'admin', updatedBy: 'admin', isDeleted: false,
  ),
  Expense(
    id: 'exp-2', merchant: 'Telco', amount: 500, categoryId: 'utilities',
    paymentMethodId: 'ach', occurredAt: DateTime(2026, 2, 3), description: 'Internet Feb',
    attachmentIds: [], status: ExpenseStatus.approved,
    businessId: 'b1', createdAt: DateTime(2026, 2, 3), updatedAt: DateTime(2026, 2, 3),
    createdBy: 'admin', updatedBy: 'admin', isDeleted: false,
  ),
];
