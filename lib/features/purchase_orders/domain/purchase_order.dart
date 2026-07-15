import 'package:freezed_annotation/freezed_annotation.dart';

import 'purchase_order_line.dart';
import 'purchase_order_status.dart';

part 'purchase_order.freezed.dart';

@freezed
abstract class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required String id,
    required String vendorId,
    required String reference,
    required String title,
    required String notes,
    required DateTime orderDate,
    required DateTime expectedDate,
    required PurchaseOrderStatus status,
    required List<PurchaseOrderLine> lines,
  }) = _PurchaseOrder;
}
