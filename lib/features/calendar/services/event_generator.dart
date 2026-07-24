import 'package:accounting_app/features/crm/domain/lead_opportunity.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';

import '../domain/calendar_event.dart';
import '../domain/event_priority.dart';
import '../domain/event_status.dart';
import '../domain/event_type.dart';

/// Generates [CalendarEvent]s from various business domain entities.
///
/// Each method produces one or more events representing significant dates
/// (due dates, payment dates, expected close dates, etc.).
class EventGenerator {
  const EventGenerator();

  /// Generates a due-date event from a [SalesInvoice].
  CalendarEvent fromSalesInvoice(SalesInvoice invoice) {
    final isOverdue = invoice.dueDate.isBefore(DateTime.now());
    return CalendarEvent(
      id: 'si-${invoice.id}',
      title: 'Invoice ${invoice.reference} due',
      description: '${invoice.title} — ${invoice.customerName}. Total: \$${invoice.total.toStringAsFixed(2)}',
      eventType: EventType.dueDate,
      priority: isOverdue ? EventPriority.high : EventPriority.medium,
      startAt: invoice.dueDate,
      allDay: true,
      status: EventStatus.pending,
      relatedEntityType: 'salesInvoice',
      relatedEntityId: invoice.id,
      relatedEntityLabel: '${invoice.reference} — ${invoice.customerName}',
    );
  }

  /// Generates a due-date event from a [VendorBill].
  CalendarEvent fromVendorBill(VendorBill bill) {
    return CalendarEvent(
      id: 'vb-${bill.id}',
      title: 'Vendor Bill ${bill.reference} due',
      description: bill.title,
      eventType: EventType.dueDate,
      priority: EventPriority.medium,
      startAt: bill.dueDate,
      allDay: true,
      status: EventStatus.pending,
      relatedEntityType: 'vendorBill',
      relatedEntityId: bill.id,
      relatedEntityLabel: bill.reference,
    );
  }

  /// Generates a payment event from a [CustomerPayment].
  CalendarEvent fromCustomerPayment(CustomerPayment payment) {
    return CalendarEvent(
      id: 'cp-${payment.id}',
      title: 'Payment received from ${payment.customerName}',
      description:
          '${payment.reference} — \$${payment.amount.toStringAsFixed(2)}',
      eventType: EventType.payment,
      priority: EventPriority.medium,
      startAt: payment.paymentDate,
      allDay: true,
      status: EventStatus.completed,
      relatedEntityType: 'customerPayment',
      relatedEntityId: payment.id,
      relatedEntityLabel: payment.reference,
    );
  }

  /// Generates a payment event from a [VendorPayment].
  CalendarEvent fromVendorPayment(VendorPayment payment) {
    return CalendarEvent(
      id: 'vp-${payment.id}',
      title: 'Payment sent to ${payment.vendorName}',
      description:
          '${payment.reference} — \$${payment.amount.toStringAsFixed(2)}',
      eventType: EventType.payment,
      priority: EventPriority.medium,
      startAt: payment.paymentDate,
      allDay: true,
      status: EventStatus.completed,
      relatedEntityType: 'vendorPayment',
      relatedEntityId: payment.id,
      relatedEntityLabel: payment.reference,
    );
  }

  /// Generates an expected-delivery event from a [PurchaseOrder].
  CalendarEvent fromPurchaseOrder(PurchaseOrder po) {
    return CalendarEvent(
      id: 'po-${po.id}',
      title: 'PO ${po.reference} expected',
      description: po.title,
      eventType: EventType.dueDate,
      priority: EventPriority.medium,
      startAt: po.expectedDate,
      allDay: true,
      status: EventStatus.pending,
      relatedEntityType: 'purchaseOrder',
      relatedEntityId: po.id,
      relatedEntityLabel: po.reference,
    );
  }

  /// Generates an expected-close event from a [LeadOpportunity].
  CalendarEvent fromLeadOpportunity(LeadOpportunity lead) {
    return CalendarEvent(
      id: 'lead-${lead.id}',
      title: 'Expected close: ${lead.title}',
      description:
          '\$${lead.estimatedValue.toStringAsFixed(0)} — ${lead.stage.label}',
      eventType: EventType.followUp,
      priority: EventPriority.medium,
      startAt: lead.expectedCloseDate,
      allDay: true,
      status: EventStatus.pending,
      relatedEntityType: 'lead',
      relatedEntityId: lead.id,
      relatedEntityLabel: lead.title,
    );
  }
}
