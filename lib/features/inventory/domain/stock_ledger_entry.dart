import 'stock_movement_type.dart';

/// A single entry in the stock ledger for a product/warehouse combination.
/// Maintains a running balance of stock quantity.
class StockLedgerEntry {
  const StockLedgerEntry({
    required this.id,
    required this.productId,
    required this.warehouseId,
    required this.date,
    required this.movementType,
    required this.quantity,
    required this.runningBalance,
    required this.unitCost,
    required this.reference,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final String productId;
  final String warehouseId;
  final DateTime date;
  final StockMovementType movementType;

  /// Positive = stock in, negative = stock out.
  final double quantity;

  /// Running stock balance after this entry.
  final double runningBalance;

  /// Cost per unit at time of movement (for valuation).
  final double unitCost;

  final String reference;
  final String description;
  final DateTime createdAt;

  double get lineValue => quantity.abs() * unitCost;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockLedgerEntry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'StockLedgerEntry(id: $id, qty: $quantity, bal: $runningBalance)';
}
