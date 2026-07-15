import 'package:freezed_annotation/freezed_annotation.dart';

part 'goods_receipt_status.freezed.dart';

@freezed
abstract class GoodsReceiptStatus with _$GoodsReceiptStatus {
  const factory GoodsReceiptStatus({
    required String id,
    required String label,
    required String color,
  }) = _GoodsReceiptStatus;
}
