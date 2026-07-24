import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/crm/domain/lead_opportunity.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/purchase_orders/domain/purchase_order.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';
import 'package:accounting_app/features/calendar/services/calendar_providers.dart';
import 'package:accounting_app/features/calendar/domain/calendar_event.dart';
import 'package:accounting_app/features/calendar/domain/calendar_filter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_controller.g.dart';

@riverpod
class CalendarController extends _$CalendarController {
  CalendarFilter _filter = CalendarFilter.none;

  @override
  FutureOr<List<CalendarEvent>> build() async {
    final service = ref.watch(calendarServiceProvider);
    final result = await service.fetchEvents(filter: _filter);
    if (result.isSuccess) return result.data ?? [];
    throw result.error!;
  }

  /// Seeds the calendar with generated events from business entities.
  Future<void> seedFromEntities({
    required List<SalesInvoice> invoices,
    required List<VendorBill> bills,
    required List<CustomerPayment> customerPayments,
    required List<VendorPayment> vendorPayments,
    required List<PurchaseOrder> purchaseOrders,
    required List<LeadOpportunity> leads,
  }) async {
    final service = ref.read(calendarServiceProvider);
    service.generateAndSeed(
      invoices: invoices,
      bills: bills,
      customerPayments: customerPayments,
      vendorPayments: vendorPayments,
      purchaseOrders: purchaseOrders,
      leads: leads,
    );
    ref.invalidateSelf();
  }

  Future<AppResult<CalendarEvent>> createEvent(CalendarEvent event) async {
    final service = ref.read(calendarServiceProvider);
    final result = await service.createEvent(event);
    if (result.isSuccess) {
      ref.invalidateSelf();
    }
    return result;
  }

  Future<AppResult<CalendarEvent>> updateEvent(CalendarEvent event) async {
    final service = ref.read(calendarServiceProvider);
    final result = await service.updateEvent(event);
    if (result.isSuccess) {
      ref.invalidateSelf();
    }
    return result;
  }

  Future<AppResult<void>> deleteEvent(String id) async {
    final service = ref.read(calendarServiceProvider);
    final result = await service.deleteEvent(id);
    if (result.isSuccess) {
      ref.invalidateSelf();
    }
    return result;
  }

  void applyFilter(CalendarFilter filter) {
    _filter = filter;
    ref.invalidateSelf();
  }

  void clearFilter() {
    _filter = CalendarFilter.none;
    ref.invalidateSelf();
  }
}
