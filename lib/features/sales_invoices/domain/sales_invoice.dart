import 'package:freezed_annotation/freezed_annotation.dart';

import 'sales_invoice_line.dart';
import 'sales_invoice_status.dart';

part 'sales_invoice.freezed.dart';

@freezed
abstract class SalesInvoice with _$SalesInvoice {
  const factory SalesInvoice({
    required String id,
    required String customerId,
    required String customerName,
    required String reference,
    required String title,
    required String notes,
    required DateTime invoiceDate,
    required DateTime dueDate,
    required SalesInvoiceStatus status,
    required List<SalesInvoiceLine> lines,
    required double subtotal,
    required double tax,
    required double total,
  }) = _SalesInvoice;
}
