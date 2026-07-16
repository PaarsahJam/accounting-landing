import 'bank_account_status.dart';
import 'bank_account_type.dart';

/// A bank or cash account tracked in the system.
class BankAccount {
  const BankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.accountType,
    required this.currency,
    required this.currentBalance,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String accountNumber;
  final BankAccountType accountType;
  final String currency;
  final double currentBalance;
  final BankAccountStatus status;
  final DateTime createdAt;

  BankAccount copyWith({
    String? id,
    String? name,
    String? accountNumber,
    BankAccountType? accountType,
    String? currency,
    double? currentBalance,
    BankAccountStatus? status,
    DateTime? createdAt,
  }) {
    return BankAccount(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      currentBalance: currentBalance ?? this.currentBalance,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccount &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'BankAccount(id: $id, name: $name)';
}
