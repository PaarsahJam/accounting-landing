import 'package:freezed_annotation/freezed_annotation.dart';

import 'vendor_payment_allocation.dart';
import 'vendor_payment_method.dart';
import 'vendor_payment_status.dart';

part 'vendor_payment.freezed.dart';

@freezed
abstract class VendorPayment with _$VendorPayment {
  const factory VendorPayment({
    required String id,
    required String vendorId,
    required String vendorName,
    required String reference,
    required String notes,
    required DateTime paymentDate,
    required DateTime createdAt,
    required double amount,
    required VendorPaymentMethod method,
    required VendorPaymentStatus status,
    required List<VendorPaymentAllocation> allocations,
  }) = _VendorPayment;
}
