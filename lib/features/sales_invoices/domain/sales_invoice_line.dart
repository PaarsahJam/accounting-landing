import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_invoice_line.freezed.dart';

@freezed
abstract class SalesInvoiceLine with _$SalesInvoiceLine {
  const factory SalesInvoiceLine({
    required String id,
    required String description,
    required double quantity,
    required double unitPrice,
  }) = _SalesInvoiceLine;

  const SalesInvoiceLine._();

  double get amount => quantity * unitPrice;
}
