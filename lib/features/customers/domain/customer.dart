import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';

@freezed
abstract class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String name,
    required String company,
    required String email,
    required String phone,
    required double outstandingBalance,
    required String status,
    required String notes,
    @Default(1) int version,
  }) = _Customer;
}
