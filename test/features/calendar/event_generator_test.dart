import 'package:accounting_app/features/calendar/domain/event_priority.dart';
import 'package:accounting_app/features/calendar/domain/event_status.dart';
import 'package:accounting_app/features/calendar/domain/event_type.dart';
import 'package:accounting_app/features/calendar/services/event_generator.dart';
import 'package:accounting_app/features/crm/domain/lead_opportunity.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_method.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_status.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order_status.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice_status.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill_status.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_method.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const generator = EventGenerator();

  final invoice = SalesInvoice(
    id: 'inv-1',
    customerId: 'cust-1',
    customerName: 'ACME Corp',
    reference: 'INV-001',
    title: 'Consulting Services',
    notes: '',
    invoiceDate: _jan15,
    dueDate: _feb14,
    status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
    lines: [],
    subtotal: 1000,
    tax: 100,
    total: 1100,
  );

  final bill = VendorBill(
    id: 'bill-1',
    vendorId: 'vend-1',
    purchaseOrderId: 'po-1',
    goodsReceiptId: 'gr-1',
    reference: 'BILL-001',
    title: 'Office Supplies',
    notes: '',
    billDate: _jan10,
    dueDate: _feb09,
    status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
    lines: [],
  );

  final customerPayment = CustomerPayment(
    id: 'cp-1',
    customerId: 'cust-1',
    customerName: 'ACME Corp',
    reference: 'PAY-001',
    notes: '',
    paymentDate: _feb01,
    receivedAt: _feb01,
    amount: 500,
    method: CustomerPaymentMethod(id: 'chk', label: 'Check', icon: 'check'),
    status: CustomerPaymentStatus(id: 'cleared', label: 'Cleared', color: 'green'),
    allocations: [],
  );

  final vendorPayment = VendorPayment(
    id: 'vp-1',
    vendorId: 'vend-1',
    vendorName: 'OfficeMax',
    reference: 'PMT-001',
    notes: '',
    paymentDate: _feb05,
    createdAt: _feb03,
    amount: 250,
    method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'bank'),
    status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
    allocations: [],
  );

  final po = PurchaseOrder(
    id: 'po-1',
    vendorId: 'vend-1',
    reference: 'PO-2026-001',
    title: 'Laptop Order',
    notes: '',
    orderDate: _jan05,
    expectedDate: _feb28,
    status: PurchaseOrderStatus(id: 'approved', label: 'Approved', color: 'green'),
    lines: [],
  );

  final lead = LeadOpportunity(
    id: 'lead-1',
    customerId: 'cust-2',
    title: 'Big Corp Deal',
    description: 'Enterprise license',
    stage: PipelineStage.negotiation,
    estimatedValue: 50000,
    probability: 0.6,
    expectedCloseDate: _mar01,
    owner: 'Alice',
    createdAt: _jan01,
  );

  group('fromSalesInvoice', () {
    test('creates due-date event with correct fields', () {
      final event = generator.fromSalesInvoice(invoice);
      expect(event.id, 'si-inv-1');
      expect(event.title, 'Invoice INV-001 due');
      expect(event.description, contains('Consulting Services'));
      expect(event.description, contains('ACME Corp'));
      expect(event.description, contains('\$1100.00'));
      expect(event.eventType, EventType.dueDate);
      expect(event.startAt, _feb14);
      expect(event.allDay, isTrue);
      expect(event.status, EventStatus.pending);
      expect(event.relatedEntityType, 'salesInvoice');
      expect(event.relatedEntityId, 'inv-1');
      expect(event.relatedEntityLabel, 'INV-001 — ACME Corp');
    });

    test('detects overdue and sets high priority', () {
      final pastDueInvoice = SalesInvoice(
        id: 'inv-2',
        customerId: 'cust-1',
        customerName: 'Old Corp',
        reference: 'INV-002',
        title: 'Past Due',
        notes: '',
        invoiceDate: _pastYear,
        dueDate: _pastDate,
        status: SalesInvoiceStatus(id: 'overdue', label: 'Overdue', color: 'red'),
        lines: [],
        subtotal: 500,
        tax: 50,
        total: 550,
      );
      final event = generator.fromSalesInvoice(pastDueInvoice);
      expect(event.priority, EventPriority.high);
    });

    test('sets medium priority for future dates', () {
      final futureInvoice = SalesInvoice(
        id: 'inv-3',
        customerId: 'cust-1',
        customerName: 'Future Corp',
        reference: 'INV-003',
        title: 'Future Due',
        notes: '',
        invoiceDate: _today,
        dueDate: DateTime(2027, 1, 15),
        status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
        lines: [],
        subtotal: 300,
        tax: 30,
        total: 330,
      );
      final event = generator.fromSalesInvoice(futureInvoice);
      expect(event.priority, EventPriority.medium);
    });
  });

  group('fromVendorBill', () {
    test('creates due-date event', () {
      final event = generator.fromVendorBill(bill);
      expect(event.id, 'vb-bill-1');
      expect(event.title, 'Vendor Bill BILL-001 due');
      expect(event.description, 'Office Supplies');
      expect(event.eventType, EventType.dueDate);
      expect(event.startAt, _feb09);
      expect(event.allDay, isTrue);
      expect(event.priority, EventPriority.medium);
      expect(event.relatedEntityType, 'vendorBill');
      expect(event.relatedEntityId, 'bill-1');
      expect(event.relatedEntityLabel, 'BILL-001');
    });
  });

  group('fromCustomerPayment', () {
    test('creates payment event', () {
      final event = generator.fromCustomerPayment(customerPayment);
      expect(event.id, 'cp-cp-1');
      expect(event.title, 'Payment received from ACME Corp');
      expect(event.description, 'PAY-001 — \$500.00');
      expect(event.eventType, EventType.payment);
      expect(event.startAt, _feb01);
      expect(event.status, EventStatus.completed);
      expect(event.relatedEntityType, 'customerPayment');
      expect(event.relatedEntityId, 'cp-1');
      expect(event.relatedEntityLabel, 'PAY-001');
    });
  });

  group('fromVendorPayment', () {
    test('creates payment event', () {
      final event = generator.fromVendorPayment(vendorPayment);
      expect(event.id, 'vp-vp-1');
      expect(event.title, 'Payment sent to OfficeMax');
      expect(event.description, 'PMT-001 — \$250.00');
      expect(event.eventType, EventType.payment);
      expect(event.startAt, _feb05);
      expect(event.status, EventStatus.completed);
      expect(event.relatedEntityType, 'vendorPayment');
      expect(event.relatedEntityId, 'vp-1');
    });
  });

  group('fromPurchaseOrder', () {
    test('creates due-date event for expected date', () {
      final event = generator.fromPurchaseOrder(po);
      expect(event.id, 'po-po-1');
      expect(event.title, 'PO PO-2026-001 expected');
      expect(event.description, 'Laptop Order');
      expect(event.eventType, EventType.dueDate);
      expect(event.startAt, _feb28);
      expect(event.allDay, isTrue);
      expect(event.status, EventStatus.pending);
      expect(event.relatedEntityType, 'purchaseOrder');
      expect(event.relatedEntityId, 'po-1');
      expect(event.relatedEntityLabel, 'PO-2026-001');
    });
  });

  group('fromLeadOpportunity', () {
    test('creates follow-up event', () {
      final event = generator.fromLeadOpportunity(lead);
      expect(event.id, 'lead-lead-1');
      expect(event.title, 'Expected close: Big Corp Deal');
      expect(event.description, '\$50000 — Negotiation');
      expect(event.eventType, EventType.followUp);
      expect(event.startAt, _mar01);
      expect(event.allDay, isTrue);
      expect(event.priority, EventPriority.medium);
      expect(event.relatedEntityType, 'lead');
      expect(event.relatedEntityId, 'lead-1');
      expect(event.relatedEntityLabel, 'Big Corp Deal');
    });
  });
}

final _today = DateTime(2026, 7, 23);
final _jan01 = DateTime(2026, 1, 1);
final _jan05 = DateTime(2026, 1, 5);
final _jan10 = DateTime(2026, 1, 10);
final _jan15 = DateTime(2026, 1, 15);
final _feb01 = DateTime(2026, 2, 1);
final _feb03 = DateTime(2026, 2, 3);
final _feb05 = DateTime(2026, 2, 5);
final _feb09 = DateTime(2026, 2, 9);
final _feb14 = DateTime(2026, 2, 14);
final _feb28 = DateTime(2026, 2, 28);
final _mar01 = DateTime(2026, 3, 1);
final _pastDate = DateTime(2025, 6, 1);
final _pastYear = DateTime(2025, 5, 15);
