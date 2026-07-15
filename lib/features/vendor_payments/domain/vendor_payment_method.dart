import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_payment_method.freezed.dart';

@freezed
abstract class VendorPaymentMethod with _$VendorPaymentMethod {
  const factory VendorPaymentMethod({
    required String id,
    required String label,
    required String icon,
  }) = _VendorPaymentMethod;
}
