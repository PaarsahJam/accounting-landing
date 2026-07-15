import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_statement.freezed.dart';

@freezed
abstract class VendorStatement with _$VendorStatement {
  const factory VendorStatement({
    required String id,
    required String vendorId,
    required String vendorName,
    required double openingBalance,
    required double runningBalance,
    required double outstandingBalance,
    required List<VendorStatementEntry> entries,
    required List<VendorStatementBill> billHistory,
    required List<VendorStatementPayment> paymentHistory,
    required List<VendorAgingBucket> agingBuckets,
  }) = _VendorStatement;
}

@freezed
abstract class VendorStatementEntry with _$VendorStatementEntry {
  const factory VendorStatementEntry({
    required String id,
    required DateTime date,
    required String description,
    required double amount,
    required String type,
    required double runningBalance,
  }) = _VendorStatementEntry;
}

@freezed
abstract class VendorStatementBill with _$VendorStatementBill {
  const factory VendorStatementBill({
    required String id,
    required String reference,
    required DateTime billDate,
    required DateTime dueDate,
    required double amount,
    required String status,
  }) = _VendorStatementBill;
}

@freezed
abstract class VendorStatementPayment with _$VendorStatementPayment {
  const factory VendorStatementPayment({
    required String id,
    required String reference,
    required DateTime paymentDate,
    required double amount,
    required String method,
  }) = _VendorStatementPayment;
}

@freezed
abstract class VendorAgingBucket with _$VendorAgingBucket {
  const factory VendorAgingBucket({
    required String id,
    required String label,
    required double amount,
  }) = _VendorAgingBucket;
}
