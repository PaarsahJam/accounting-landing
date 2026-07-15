import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_payment_method.freezed.dart';

@freezed
abstract class CustomerPaymentMethod with _$CustomerPaymentMethod {
  const factory CustomerPaymentMethod({
    required String id,
    required String label,
    required String icon,
  }) = _CustomerPaymentMethod;
}
