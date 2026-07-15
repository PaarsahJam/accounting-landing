import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor.freezed.dart';

@freezed
abstract class Vendor with _$Vendor {
  const factory Vendor({
    required String id,
    required String companyName,
    required String contactName,
    required String email,
    required String phone,
    required String address,
    required String taxIdentifier,
    required String notes,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Vendor;
}
