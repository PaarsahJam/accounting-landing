import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/crm/domain/lead_opportunity.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';

import '../data/calendar_repository.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_filter.dart';
import 'event_generator.dart';

/// Orchestrates event generation from business entities and delegates
/// persistence to [CalendarRepository].
class CalendarService {
  CalendarService({
    required CalendarRepository repository,
    required this.generator,
  }) : _repo = repository;

  final CalendarRepository _repo;
  final EventGenerator generator;

  // ── Fetch ────────────────────────────────────────────────────────────────

  Future<AppResult<List<CalendarEvent>>> fetchEvents({
    CalendarFilter? filter,
  }) {
    return _repo.fetchEvents(filter: filter);
  }

  // ── Generate + seed ──────────────────────────────────────────────────────

  /// Generates events from all known business entities and stores them.
  void generateAndSeed({
    required List<SalesInvoice> invoices,
    required List<VendorBill> bills,
    required List<CustomerPayment> customerPayments,
    required List<VendorPayment> vendorPayments,
    required List<PurchaseOrder> purchaseOrders,
    required List<LeadOpportunity> leads,
  }) {
    final events = <CalendarEvent>[
      for (final inv in invoices) generator.fromSalesInvoice(inv),
      for (final bill in bills) generator.fromVendorBill(bill),
      for (final cp in customerPayments) generator.fromCustomerPayment(cp),
      for (final vp in vendorPayments) generator.fromVendorPayment(vp),
      for (final po in purchaseOrders) generator.fromPurchaseOrder(po),
      for (final lead in leads) generator.fromLeadOpportunity(lead),
    ];

    _repo.seed(events);
  }

  // ── CRUD ─────────────────────────────────────────────────────────────────

  Future<AppResult<CalendarEvent>> createEvent(CalendarEvent event) {
    return _repo.createEvent(event);
  }

  Future<AppResult<CalendarEvent>> updateEvent(CalendarEvent event) {
    return _repo.updateEvent(event);
  }

  Future<AppResult<void>> deleteEvent(String id) {
    return _repo.deleteEvent(id);
  }
}
