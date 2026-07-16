/// A stock adjustment document — corrects stock quantity up or down.
class StockAdjustment {
  const StockAdjustment({
    required this.id,
    required this.productId,
    required this.warehouseId,
    required this.adjustmentDate,
    required this.quantityBefore,
    required this.quantityAdjusted,
    required this.reason,
    required this.reference,
    required this.createdAt,
    required this.createdBy,
  });

  final String id;
  final String productId;
  final String warehouseId;
  final DateTime adjustmentDate;

  /// Stock quantity before the adjustment.
  final double quantityBefore;

  /// Delta — positive = stock added, negative = stock removed.
  final double quantityAdjusted;

  double get quantityAfter => quantityBefore + quantityAdjusted;

  final String reason;
  final String reference;
  final DateTime createdAt;
  final String createdBy;

  StockAdjustment copyWith({
    String? id,
    String? productId,
    String? warehouseId,
    DateTime? adjustmentDate,
    double? quantityBefore,
    double? quantityAdjusted,
    String? reason,
    String? reference,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return StockAdjustment(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      warehouseId: warehouseId ?? this.warehouseId,
      adjustmentDate: adjustmentDate ?? this.adjustmentDate,
      quantityBefore: quantityBefore ?? this.quantityBefore,
      quantityAdjusted: quantityAdjusted ?? this.quantityAdjusted,
      reason: reason ?? this.reason,
      reference: reference ?? this.reference,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockAdjustment &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'StockAdjustment(id: $id, delta: $quantityAdjusted)';
}
