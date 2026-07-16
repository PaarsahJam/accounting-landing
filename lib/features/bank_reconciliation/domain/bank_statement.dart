import 'bank_statement_status.dart';
import 'bank_statement_transaction.dart';

/// A bank statement covering a specific period for one account.
class BankStatement {
  const BankStatement({
    required this.id,
    required this.bankAccountId,
    required this.bankAccountName,
    required this.periodStart,
    required this.periodEnd,
    required this.openingBalance,
    required this.closingBalance,
    required this.transactions,
    required this.status,
    required this.importedAt,
    this.reconciledAt,
  });

  final String id;
  final String bankAccountId;
  final String bankAccountName;
  final DateTime periodStart;
  final DateTime periodEnd;
  final double openingBalance;
  final double closingBalance;
  final List<BankStatementTransaction> transactions;
  final BankStatementStatus status;
  final DateTime importedAt;
  final DateTime? reconciledAt;

  List<BankStatementTransaction> get matched =>
      transactions.where((t) => t.isMatched).toList();

  List<BankStatementTransaction> get unmatched =>
      transactions.where((t) => !t.isMatched).toList();

  double get totalCredits =>
      transactions.where((t) => t.isCredit).fold(0, (sum, t) => sum + t.amount);

  double get totalDebits => transactions
      .where((t) => !t.isCredit)
      .fold(0, (sum, t) => sum + t.amount.abs());

  double get reconciledAmount =>
      matched.fold(0, (sum, t) => sum + t.amount.abs());

  double get unreconciledAmount =>
      unmatched.fold(0, (sum, t) => sum + t.amount.abs());

  double get difference =>
      closingBalance -
      openingBalance -
      transactions.fold(0, (sum, t) => sum + t.amount);

  double get progressPercent =>
      transactions.isEmpty ? 0 : matched.length / transactions.length;

  BankStatement copyWith({
    String? id,
    String? bankAccountId,
    String? bankAccountName,
    DateTime? periodStart,
    DateTime? periodEnd,
    double? openingBalance,
    double? closingBalance,
    List<BankStatementTransaction>? transactions,
    BankStatementStatus? status,
    DateTime? importedAt,
    Object? reconciledAt = _sentinel,
  }) {
    return BankStatement(
      id: id ?? this.id,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      openingBalance: openingBalance ?? this.openingBalance,
      closingBalance: closingBalance ?? this.closingBalance,
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      importedAt: importedAt ?? this.importedAt,
      reconciledAt: reconciledAt == _sentinel
          ? this.reconciledAt
          : reconciledAt as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankStatement &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'BankStatement(id: $id, account: $bankAccountName)';
}

const _sentinel = Object();
