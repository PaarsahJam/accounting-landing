/// A stock transfer — moves quantity from one warehouse to another.
class StockTransfer {
  const StockTransfer({
    required this.id,
    required this.productId,
    required this.fromWarehouseId,
    required this.toWarehouseId,
    required this.quantity,
    required this.transferDate,
    required this.reference,
    required this.notes,
    required this.createdAt,
    required this.createdBy,
  });

  final String id;
  final String productId;
  final String fromWarehouseId;
  final String toWarehouseId;
  final double quantity;
  final DateTime transferDate;
  final String reference;
  final String notes;
  final DateTime createdAt;
  final String createdBy;

  StockTransfer copyWith({
    String? id,
    String? productId,
    String? fromWarehouseId,
    String? toWarehouseId,
    double? quantity,
    DateTime? transferDate,
    String? reference,
    String? notes,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return StockTransfer(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      fromWarehouseId: fromWarehouseId ?? this.fromWarehouseId,
      toWarehouseId: toWarehouseId ?? this.toWarehouseId,
      quantity: quantity ?? this.quantity,
      transferDate: transferDate ?? this.transferDate,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockTransfer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'StockTransfer(id: $id, qty: $quantity, from: $fromWarehouseId → $toWarehouseId)';
}
