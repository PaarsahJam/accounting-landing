import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_payment_status.freezed.dart';

@freezed
abstract class CustomerPaymentStatus with _$CustomerPaymentStatus {
  const factory CustomerPaymentStatus({
    required String id,
    required String label,
    required String color,
  }) = _CustomerPaymentStatus;
}
