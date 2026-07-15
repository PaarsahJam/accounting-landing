import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_bill_line.freezed.dart';

@freezed
abstract class VendorBillLine with _$VendorBillLine {
  const factory VendorBillLine({
    required String id,
    required String description,
    required double quantity,
    required double unitPrice,
  }) = _VendorBillLine;
}
