import 'bank_transaction_type.dart';

/// A single transaction entry on a bank account.
class BankTransaction {
  const BankTransaction({
    required this.id,
    required this.accountId,
    required this.date,
    required this.amount,
    required this.transactionType,
    required this.reference,
    required this.description,
    required this.runningBalance,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String accountId;
  final DateTime date;

  /// Positive = credit to account, negative = debit from account.
  final double amount;
  final BankTransactionType transactionType;
  final String reference;
  final String description;
  final double runningBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankTransaction copyWith({
    String? id,
    String? accountId,
    DateTime? date,
    double? amount,
    BankTransactionType? transactionType,
    String? reference,
    String? description,
    double? runningBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BankTransaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      transactionType: transactionType ?? this.transactionType,
      reference: reference ?? this.reference,
      description: description ?? this.description,
      runningBalance: runningBalance ?? this.runningBalance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'BankTransaction(id: $id, amount: $amount, type: $transactionType)';
}
