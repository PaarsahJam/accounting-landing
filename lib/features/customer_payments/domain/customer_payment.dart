import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer_payment_allocation.dart';
import 'customer_payment_method.dart';
import 'customer_payment_status.dart';

part 'customer_payment.freezed.dart';

@freezed
abstract class CustomerPayment with _$CustomerPayment {
  const factory CustomerPayment({
    required String id,
    required String customerId,
    required String customerName,
    required String reference,
    required String notes,
    required DateTime paymentDate,
    required DateTime receivedAt,
    required double amount,
    required CustomerPaymentMethod method,
    required CustomerPaymentStatus status,
    required List<CustomerPaymentAllocation> allocations,
  }) = _CustomerPayment;
}
