import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_payment_status.freezed.dart';

@freezed
abstract class VendorPaymentStatus with _$VendorPaymentStatus {
  const factory VendorPaymentStatus({
    required String id,
    required String label,
    required String color,
  }) = _VendorPaymentStatus;
}
