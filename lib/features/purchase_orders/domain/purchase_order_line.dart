import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order_line.freezed.dart';

@freezed
abstract class PurchaseOrderLine with _$PurchaseOrderLine {
  const factory PurchaseOrderLine({
    required String id,
    required String description,
    required double quantity,
    required double unitPrice,
  }) = _PurchaseOrderLine;
}
