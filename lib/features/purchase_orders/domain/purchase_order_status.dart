import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order_status.freezed.dart';

@freezed
abstract class PurchaseOrderStatus with _$PurchaseOrderStatus {
  const factory PurchaseOrderStatus({
    required String id,
    required String label,
    required String color,
  }) = _PurchaseOrderStatus;
}
