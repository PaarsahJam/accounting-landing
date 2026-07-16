/// A cost layer for a product — tracks batches of stock at specific unit costs
/// (simplified FIFO / weighted-average mock).
class CostLayer {
  const CostLayer({
    required this.id,
    required this.productId,
    required this.warehouseId,
    required this.receivedAt,
    required this.quantity,
    required this.unitCost,
    required this.remainingQuantity,
    required this.reference,
  });

  final String id;
  final String productId;
  final String warehouseId;
  final DateTime receivedAt;
  final double quantity;
  final double unitCost;
  final double remainingQuantity;
  final String reference;

  double get totalCost => remainingQuantity * unitCost;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CostLayer && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'CostLayer(id: $id, qty: $remainingQuantity, cost: $unitCost)';
}
