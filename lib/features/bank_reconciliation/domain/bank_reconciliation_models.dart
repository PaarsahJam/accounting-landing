import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_reconciliation_models.freezed.dart';

@freezed
abstract class BankAccount with _$BankAccount {
  const factory BankAccount({
    required String id,
    required String name,
    required String accountNumber,
    required double currentBalance,
    required String currency,
  }) = _BankAccount;
}

@freezed
abstract class BankTransaction with _$BankTransaction {
  const factory BankTransaction({
    required String id,
    required String reference,
    required DateTime occurredAt,
    required double amount,
    required String description,
    required bool matched,
    required String? matchedLedgerEntryId,
    required String bankAccountId,
  }) = _BankTransaction;
}

@freezed
abstract class LedgerEntryReference with _$LedgerEntryReference {
  const factory LedgerEntryReference({
    required String id,
    required String label,
    required String type,
    required double amount,
    required DateTime occurredAt,
  }) = _LedgerEntryReference;
}

@freezed
abstract class ReconciliationSession with _$ReconciliationSession {
  const factory ReconciliationSession({
    required String id,
    required String bankAccountId,
    required DateTime startedAt,
    required ReconciliationStatus status,
    required int matchedCount,
    required int unmatchedCount,
    required double totalAmount,
  }) = _ReconciliationSession;
}

enum ReconciliationStatus { inProgress, completed, needsAttention }
