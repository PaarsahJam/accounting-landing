import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_payment_allocation.freezed.dart';

@freezed
abstract class VendorPaymentAllocation with _$VendorPaymentAllocation {
  const factory VendorPaymentAllocation({
    required String billId,
    required String billReference,
    required double amount,
  }) = _VendorPaymentAllocation;
}
