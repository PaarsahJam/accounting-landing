import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_bill_status.freezed.dart';

@freezed
abstract class VendorBillStatus with _$VendorBillStatus {
  const factory VendorBillStatus({
    required String id,
    required String label,
    required String color,
  }) = _VendorBillStatus;
}
