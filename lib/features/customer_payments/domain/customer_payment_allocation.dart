import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_payment_allocation.freezed.dart';

@freezed
abstract class CustomerPaymentAllocation with _$CustomerPaymentAllocation {
  const factory CustomerPaymentAllocation({
    required String invoiceId,
    required String invoiceReference,
    required double amount,
  }) = _CustomerPaymentAllocation;
}
