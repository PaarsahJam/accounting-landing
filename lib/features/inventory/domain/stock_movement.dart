import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_movement.freezed.dart';

@freezed
abstract class StockMovement with _$StockMovement {
  const factory StockMovement({
    required String id,
    required String productId,
    required String warehouseId,
    required String type,
    required double quantity,
    required String description,
    required DateTime occurredAt,
  }) = _StockMovement;
}
