/// Aggregated inventory valuation for a product across all warehouses.
class InventoryValuation {
  const InventoryValuation({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.warehouseId,
    required this.warehouseName,
    required this.quantityOnHand,
    required this.averageUnitCost,
    required this.totalValue,
    required this.valuationDate,
  });

  final String productId;
  final String productName;
  final String sku;
  final String warehouseId;
  final String warehouseName;
  final double quantityOnHand;
  final double averageUnitCost;
  final double totalValue;
  final DateTime valuationDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryValuation &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          warehouseId == other.warehouseId;

  @override
  int get hashCode => Object.hash(productId, warehouseId);

  @override
  String toString() =>
      'InventoryValuation(product: $productId, wh: $warehouseId, value: $totalValue)';
}
