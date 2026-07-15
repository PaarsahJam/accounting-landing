import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse.freezed.dart';

@freezed
abstract class Warehouse with _$Warehouse {
  const factory Warehouse({
    required String id,
    required String code,
    required String name,
    required String location,
    required bool active,
  }) = _Warehouse;
}
