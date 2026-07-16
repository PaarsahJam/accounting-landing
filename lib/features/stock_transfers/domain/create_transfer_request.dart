/// Value object used when creating a new stock transfer.
///
/// Carries the raw input before names are resolved from repositories.
class CreateTransferRequest {
  const CreateTransferRequest({
    required this.productId,
    required this.fromWarehouseId,
    required this.toWarehouseId,
    required this.quantity,
    required this.transferDate,
    required this.notes,
    required this.createdBy,
  });

  final String productId;
  final String fromWarehouseId;
  final String toWarehouseId;
  final double quantity;
  final DateTime transferDate;
  final String notes;
  final String createdBy;
}
