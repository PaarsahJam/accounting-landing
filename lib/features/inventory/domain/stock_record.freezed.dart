// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StockRecord {

 String get productId; String get warehouseId; double get quantity; String get location;
/// Create a copy of StockRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockRecordCopyWith<StockRecord> get copyWith => _$StockRecordCopyWithImpl<StockRecord>(this as StockRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockRecord&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,productId,warehouseId,quantity,location);

@override
String toString() {
  return 'StockRecord(productId: $productId, warehouseId: $warehouseId, quantity: $quantity, location: $location)';
}


}

/// @nodoc
abstract mixin class $StockRecordCopyWith<$Res>  {
  factory $StockRecordCopyWith(StockRecord value, $Res Function(StockRecord) _then) = _$StockRecordCopyWithImpl;
@useResult
$Res call({
 String productId, String warehouseId, double quantity, String location
});




}
/// @nodoc
class _$StockRecordCopyWithImpl<$Res>
    implements $StockRecordCopyWith<$Res> {
  _$StockRecordCopyWithImpl(this._self, this._then);

  final StockRecord _self;
  final $Res Function(StockRecord) _then;

/// Create a copy of StockRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? warehouseId = null,Object? quantity = null,Object? location = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,warehouseId: null == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StockRecord].
extension StockRecordPatterns on StockRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockRecord value)  $default,){
final _that = this;
switch (_that) {
case _StockRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockRecord value)?  $default,){
final _that = this;
switch (_that) {
case _StockRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String warehouseId,  double quantity,  String location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockRecord() when $default != null:
return $default(_that.productId,_that.warehouseId,_that.quantity,_that.location);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String warehouseId,  double quantity,  String location)  $default,) {final _that = this;
switch (_that) {
case _StockRecord():
return $default(_that.productId,_that.warehouseId,_that.quantity,_that.location);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String warehouseId,  double quantity,  String location)?  $default,) {final _that = this;
switch (_that) {
case _StockRecord() when $default != null:
return $default(_that.productId,_that.warehouseId,_that.quantity,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _StockRecord implements StockRecord {
  const _StockRecord({required this.productId, required this.warehouseId, required this.quantity, required this.location});
  

@override final  String productId;
@override final  String warehouseId;
@override final  double quantity;
@override final  String location;

/// Create a copy of StockRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockRecordCopyWith<_StockRecord> get copyWith => __$StockRecordCopyWithImpl<_StockRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockRecord&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.warehouseId, warehouseId) || other.warehouseId == warehouseId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,productId,warehouseId,quantity,location);

@override
String toString() {
  return 'StockRecord(productId: $productId, warehouseId: $warehouseId, quantity: $quantity, location: $location)';
}


}

/// @nodoc
abstract mixin class _$StockRecordCopyWith<$Res> implements $StockRecordCopyWith<$Res> {
  factory _$StockRecordCopyWith(_StockRecord value, $Res Function(_StockRecord) _then) = __$StockRecordCopyWithImpl;
@override @useResult
$Res call({
 String productId, String warehouseId, double quantity, String location
});




}
/// @nodoc
class __$StockRecordCopyWithImpl<$Res>
    implements _$StockRecordCopyWith<$Res> {
  __$StockRecordCopyWithImpl(this._self, this._then);

  final _StockRecord _self;
  final $Res Function(_StockRecord) _then;

/// Create a copy of StockRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? warehouseId = null,Object? quantity = null,Object? location = null,}) {
  return _then(_StockRecord(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,warehouseId: null == warehouseId ? _self.warehouseId : warehouseId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
