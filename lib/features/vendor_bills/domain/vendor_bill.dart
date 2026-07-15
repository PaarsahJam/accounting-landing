import 'package:freezed_annotation/freezed_annotation.dart';

import 'vendor_bill_line.dart';
import 'vendor_bill_status.dart';

part 'vendor_bill.freezed.dart';

@freezed
abstract class VendorBill with _$VendorBill {
  const factory VendorBill({
    required String id,
    required String vendorId,
    required String purchaseOrderId,
    required String goodsReceiptId,
    required String reference,
    required String title,
    required String notes,
    required DateTime billDate,
    required DateTime dueDate,
    required VendorBillStatus status,
    required List<VendorBillLine> lines,
  }) = _VendorBill;
}
