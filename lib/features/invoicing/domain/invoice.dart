import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice.freezed.dart';

@freezed
abstract class Invoice with _$Invoice {
  const factory Invoice({
    required String id,
    required String customer,
    required double amount,
    required String status,
    required String description,
  }) = _Invoice;
}
