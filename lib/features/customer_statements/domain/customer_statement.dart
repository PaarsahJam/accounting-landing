import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_statement.freezed.dart';

@freezed
abstract class CustomerStatement with _$CustomerStatement {
  const factory CustomerStatement({
    required String id,
    required String customerId,
    required String customerName,
    required double openingBalance,
    required double runningBalance,
    required double outstandingBalance,
    required List<CustomerStatementEntry> entries,
    required List<CustomerStatementInvoice> invoiceHistory,
    required List<CustomerStatementPayment> paymentHistory,
    required List<CustomerAgingBucket> agingBuckets,
  }) = _CustomerStatement;
}

@freezed
abstract class CustomerStatementEntry with _$CustomerStatementEntry {
  const factory CustomerStatementEntry({
    required String id,
    required DateTime date,
    required String description,
    required double amount,
    required String type,
    required double runningBalance,
  }) = _CustomerStatementEntry;
}

@freezed
abstract class CustomerStatementInvoice with _$CustomerStatementInvoice {
  const factory CustomerStatementInvoice({
    required String id,
    required String reference,
    required DateTime invoiceDate,
    required DateTime dueDate,
    required double amount,
    required String status,
  }) = _CustomerStatementInvoice;
}

@freezed
abstract class CustomerStatementPayment with _$CustomerStatementPayment {
  const factory CustomerStatementPayment({
    required String id,
    required String reference,
    required DateTime paymentDate,
    required double amount,
    required String method,
  }) = _CustomerStatementPayment;
}

@freezed
abstract class CustomerAgingBucket with _$CustomerAgingBucket {
  const factory CustomerAgingBucket({
    required String id,
    required String label,
    required double amount,
  }) = _CustomerAgingBucket;
}
