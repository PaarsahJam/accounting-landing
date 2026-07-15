import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_invoice_status.freezed.dart';

@freezed
abstract class SalesInvoiceStatus with _$SalesInvoiceStatus {
  const factory SalesInvoiceStatus({
    required String id,
    required String label,
    required String color,
  }) = _SalesInvoiceStatus;
}
