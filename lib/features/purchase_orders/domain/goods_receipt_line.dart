import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_receipt_line.freezed.dart';

@freezed
abstract class GoodsReceiptLine with _$GoodsReceiptLine {
  const factory GoodsReceiptLine({
    required String purchaseOrderLineId,
    required String description,
    required double orderedQuantity,
    required double receivedQuantity,
  }) = _GoodsReceiptLine;
}
