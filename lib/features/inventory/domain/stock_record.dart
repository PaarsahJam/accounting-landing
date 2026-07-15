import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_record.freezed.dart';

@freezed
abstract class StockRecord with _$StockRecord {
  const factory StockRecord({
    required String productId,
    required String warehouseId,
    required double quantity,
    required String location,
  }) = _StockRecord;
}
