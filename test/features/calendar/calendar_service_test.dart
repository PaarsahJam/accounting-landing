import 'package:accounting_app/features/calendar/data/calendar_repository.dart';
import 'package:accounting_app/features/calendar/services/calendar_service.dart';
import 'package:accounting_app/features/calendar/services/event_generator.dart';
import 'package:accounting_app/features/calendar/domain/calendar_event.dart';
import 'package:accounting_app/features/calendar/domain/calendar_filter.dart';
import 'package:accounting_app/features/calendar/domain/event_type.dart';
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
  late MockCalendarRepository repo;
  late CalendarService service;

  setUp(() {
    repo = MockCalendarRepository();
    service = CalendarService(
      repository: repo,
      generator: const EventGenerator(),
    );
  });

  group('fetchEvents', () {
    test('returns empty when no events seeded', () async {
      final result = await service.fetchEvents();
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('delegates filter to repository', () async {
      const filter = CalendarFilter(eventTypes: [EventType.dueDate]);
      final result = await service.fetchEvents(filter: filter);
      expect(result.isSuccess, isTrue);
    });
  });

  group('generateAndSeed', () {
    test('no entities produces no events', () {
      service.generateAndSeed(
        invoices: [],
        bills: [],
        customerPayments: [],
        vendorPayments: [],
        purchaseOrders: [],
        leads: [],
      );
    });

    test('generates correct number of events from provided entities', () async {
      final invoice = _makeInvoice('inv-1', _feb14);
      final bill = _makeBill('bill-1', _feb09);
      final cp = _makeCustomerPayment('cp-1', _feb01);
      final vp = _makeVendorPayment('vp-1', _feb05);
      final po = _makePo('po-1', _mar01);
      final lead = _makeLead('lead-1', _mar15);

      service.generateAndSeed(
        invoices: [invoice],
        bills: [bill],
        customerPayments: [cp],
        vendorPayments: [vp],
        purchaseOrders: [po],
        leads: [lead],
      );

      final result = await service.fetchEvents();
      expect(result.data!.length, 6);

      final ids = result.data!.map((e) => e.id).toSet();
      expect(ids, contains('si-inv-1'));
      expect(ids, contains('vb-bill-1'));
      expect(ids, contains('cp-cp-1'));
      expect(ids, contains('vp-vp-1'));
      expect(ids, contains('po-po-1'));
      expect(ids, contains('lead-lead-1'));
    });
  });

  group('createEvent', () {
    test('persists new event', () async {
      final event = _makeEvent('new-1', 'Test event');
      final result = await service.createEvent(event);
      expect(result.isSuccess, isTrue);
      expect(result.data!.id, 'new-1');

      final fetchResult = await service.fetchEvents();
      expect(fetchResult.data!.any((e) => e.id == 'new-1'), isTrue);
    });
  });

  group('updateEvent', () {
    test('updates existing event', () async {
      final event = _makeEvent('upd-1', 'Original');
      await service.createEvent(event);

      final updated = _makeEvent('upd-1', 'Updated');
      final result = await service.updateEvent(updated);
      expect(result.isSuccess, isTrue);
      expect(result.data!.title, 'Updated');
    });

    test('returns failure for non-existent event', () async {
      final event = _makeEvent('nope', 'Nowhere');
      final result = await service.updateEvent(event);
      expect(result.isSuccess, isFalse);
    });
  });

  group('deleteEvent', () {
    test('removes event from repository', () async {
      final event = _makeEvent('del-1', 'To delete');
      await service.createEvent(event);
      await service.deleteEvent('del-1');

      final result = await service.fetchEvents();
      expect(result.data!.any((e) => e.id == 'del-1'), isFalse);
    });
  });
}

CalendarEvent _makeEvent(String id, String title) => CalendarEvent(
      id: id,
      title: title,
      eventType: EventType.task,
      startAt: DateTime(2026, 7, 23),
    );

SalesInvoice _makeInvoice(String id, DateTime dueDate) => SalesInvoice(
      id: id,
      customerId: 'c1',
      customerName: 'C1',
      reference: 'INV-$id',
      title: 'Invoice $id',
      notes: '',
      invoiceDate: DateTime(2026, 7, 23),
      dueDate: dueDate,
      status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
      lines: [],
      subtotal: 100,
      tax: 10,
      total: 110,
    );

VendorBill _makeBill(String id, DateTime dueDate) => VendorBill(
      id: id,
      vendorId: 'v1',
      purchaseOrderId: 'po-1',
      goodsReceiptId: 'gr-1',
      reference: 'BILL-$id',
      title: 'Bill $id',
      notes: '',
      billDate: DateTime(2026, 7, 23),
      dueDate: dueDate,
      status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
      lines: [],
    );

CustomerPayment _makeCustomerPayment(String id, DateTime date) =>
    CustomerPayment(
      id: id,
      customerId: 'c1',
      customerName: 'C1',
      reference: 'PAY-$id',
      notes: '',
      paymentDate: date,
      receivedAt: date,
      amount: 100,
      method: CustomerPaymentMethod(id: 'chk', label: 'Check', icon: 'chk'),
      status: CustomerPaymentStatus(
        id: 'cleared',
        label: 'Cleared',
        color: 'green',
      ),
      allocations: [],
    );

VendorPayment _makeVendorPayment(String id, DateTime date) => VendorPayment(
      id: id,
      vendorId: 'v1',
      vendorName: 'V1',
      reference: 'PMT-$id',
      notes: '',
      paymentDate: date,
      createdAt: date,
      amount: 100,
      method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'ach'),
      status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
      allocations: [],
    );

PurchaseOrder _makePo(String id, DateTime date) => PurchaseOrder(
      id: id,
      vendorId: 'v1',
      reference: 'PO-$id',
      title: 'PO $id',
      notes: '',
      orderDate: DateTime(2026, 7, 23),
      expectedDate: date,
      status: PurchaseOrderStatus(
        id: 'approved',
        label: 'Approved',
        color: 'green',
      ),
      lines: [],
    );

LeadOpportunity _makeLead(String id, DateTime date) => LeadOpportunity(
      id: id,
      customerId: 'c2',
      title: 'Lead $id',
      description: 'Desc $id',
      stage: PipelineStage.negotiation,
      estimatedValue: 10000,
      probability: 0.5,
      expectedCloseDate: date,
      owner: 'Alice',
      createdAt: DateTime(2026, 7, 23),
    );

final _today = DateTime(2026, 7, 23);
final _feb01 = DateTime(2026, 2, 1);
final _feb05 = DateTime(2026, 2, 5);
final _feb09 = DateTime(2026, 2, 9);
final _feb14 = DateTime(2026, 2, 14);
final _mar01 = DateTime(2026, 3, 1);
final _mar15 = DateTime(2026, 3, 15);
