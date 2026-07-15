import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_of_measure.freezed.dart';

@freezed
abstract class UnitOfMeasure with _$UnitOfMeasure {
  const factory UnitOfMeasure({
    required String id,
    required String code,
    required String name,
  }) = _UnitOfMeasure;
}
