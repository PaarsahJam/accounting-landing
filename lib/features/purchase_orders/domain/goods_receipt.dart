import 'package:freezed_annotation/freezed_annotation.dart';

import 'goods_receipt_line.dart';
import 'goods_receipt_status.dart';

part 'goods_receipt.freezed.dart';

@freezed
abstract class GoodsReceipt with _$GoodsReceipt {
  const factory GoodsReceipt({
    required String id,
    required String purchaseOrderId,
    required String reference,
    required String title,
    required DateTime receivedAt,
    required GoodsReceiptStatus status,
    required List<GoodsReceiptLine> lines,
  }) = _GoodsReceipt;
}
