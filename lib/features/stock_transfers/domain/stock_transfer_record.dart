import 'stock_transfer_status.dart';

/// A stock transfer record owned by the stock_transfers feature.
///
/// Wraps the core transfer data and adds display-friendly resolved names
/// plus a lifecycle [status].
class StockTransferRecord {
  const StockTransferRecord({
    required this.id,
    required this.reference,
    required this.productId,
    required this.productName,
    required this.fromWarehouseId,
    required this.fromWarehouseName,
    required this.toWarehouseId,
    required this.toWarehouseName,
    required this.quantity,
    required this.transferDate,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    this.notes = '',
  });

  final String id;
  final String reference;
  final String productId;
  final String productName;
  final String fromWarehouseId;
  final String fromWarehouseName;
  final String toWarehouseId;
  final String toWarehouseName;
  final double quantity;
  final DateTime transferDate;
  final StockTransferStatus status;
  final DateTime createdAt;
  final String createdBy;
  final String notes;

  StockTransferRecord copyWith({
    String? id,
    String? reference,
    String? productId,
    String? productName,
    String? fromWarehouseId,
    String? fromWarehouseName,
    String? toWarehouseId,
    String? toWarehouseName,
    double? quantity,
    DateTime? transferDate,
    StockTransferStatus? status,
    DateTime? createdAt,
    String? createdBy,
    String? notes,
  }) {
    return StockTransferRecord(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      fromWarehouseId: fromWarehouseId ?? this.fromWarehouseId,
      fromWarehouseName: fromWarehouseName ?? this.fromWarehouseName,
      toWarehouseId: toWarehouseId ?? this.toWarehouseId,
      toWarehouseName: toWarehouseName ?? this.toWarehouseName,
      quantity: quantity ?? this.quantity,
      transferDate: transferDate ?? this.transferDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockTransferRecord &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'StockTransferRecord(id: $id, ref: $reference, status: ${status.label})';
}
