// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_receipt_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoodsReceiptLine {

 String get purchaseOrderLineId; String get description; double get orderedQuantity; double get receivedQuantity;
/// Create a copy of GoodsReceiptLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoodsReceiptLineCopyWith<GoodsReceiptLine> get copyWith => _$GoodsReceiptLineCopyWithImpl<GoodsReceiptLine>(this as GoodsReceiptLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoodsReceiptLine&&(identical(other.purchaseOrderLineId, purchaseOrderLineId) || other.purchaseOrderLineId == purchaseOrderLineId)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderedQuantity, orderedQuantity) || other.orderedQuantity == orderedQuantity)&&(identical(other.receivedQuantity, receivedQuantity) || other.receivedQuantity == receivedQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,purchaseOrderLineId,description,orderedQuantity,receivedQuantity);

@override
String toString() {
  return 'GoodsReceiptLine(purchaseOrderLineId: $purchaseOrderLineId, description: $description, orderedQuantity: $orderedQuantity, receivedQuantity: $receivedQuantity)';
}


}

/// @nodoc
abstract mixin class $GoodsReceiptLineCopyWith<$Res>  {
  factory $GoodsReceiptLineCopyWith(GoodsReceiptLine value, $Res Function(GoodsReceiptLine) _then) = _$GoodsReceiptLineCopyWithImpl;
@useResult
$Res call({
 String purchaseOrderLineId, String description, double orderedQuantity, double receivedQuantity
});




}
/// @nodoc
class _$GoodsReceiptLineCopyWithImpl<$Res>
    implements $GoodsReceiptLineCopyWith<$Res> {
  _$GoodsReceiptLineCopyWithImpl(this._self, this._then);

  final GoodsReceiptLine _self;
  final $Res Function(GoodsReceiptLine) _then;

/// Create a copy of GoodsReceiptLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purchaseOrderLineId = null,Object? description = null,Object? orderedQuantity = null,Object? receivedQuantity = null,}) {
  return _then(_self.copyWith(
purchaseOrderLineId: null == purchaseOrderLineId ? _self.purchaseOrderLineId : purchaseOrderLineId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orderedQuantity: null == orderedQuantity ? _self.orderedQuantity : orderedQuantity // ignore: cast_nullable_to_non_nullable
as double,receivedQuantity: null == receivedQuantity ? _self.receivedQuantity : receivedQuantity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GoodsReceiptLine].
extension GoodsReceiptLinePatterns on GoodsReceiptLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoodsReceiptLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoodsReceiptLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoodsReceiptLine value)  $default,){
final _that = this;
switch (_that) {
case _GoodsReceiptLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoodsReceiptLine value)?  $default,){
final _that = this;
switch (_that) {
case _GoodsReceiptLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String purchaseOrderLineId,  String description,  double orderedQuantity,  double receivedQuantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoodsReceiptLine() when $default != null:
return $default(_that.purchaseOrderLineId,_that.description,_that.orderedQuantity,_that.receivedQuantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String purchaseOrderLineId,  String description,  double orderedQuantity,  double receivedQuantity)  $default,) {final _that = this;
switch (_that) {
case _GoodsReceiptLine():
return $default(_that.purchaseOrderLineId,_that.description,_that.orderedQuantity,_that.receivedQuantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String purchaseOrderLineId,  String description,  double orderedQuantity,  double receivedQuantity)?  $default,) {final _that = this;
switch (_that) {
case _GoodsReceiptLine() when $default != null:
return $default(_that.purchaseOrderLineId,_that.description,_that.orderedQuantity,_that.receivedQuantity);case _:
  return null;

}
}

}

/// @nodoc


class _GoodsReceiptLine implements GoodsReceiptLine {
  const _GoodsReceiptLine({required this.purchaseOrderLineId, required this.description, required this.orderedQuantity, required this.receivedQuantity});
  

@override final  String purchaseOrderLineId;
@override final  String description;
@override final  double orderedQuantity;
@override final  double receivedQuantity;

/// Create a copy of GoodsReceiptLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoodsReceiptLineCopyWith<_GoodsReceiptLine> get copyWith => __$GoodsReceiptLineCopyWithImpl<_GoodsReceiptLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoodsReceiptLine&&(identical(other.purchaseOrderLineId, purchaseOrderLineId) || other.purchaseOrderLineId == purchaseOrderLineId)&&(identical(other.description, description) || other.description == description)&&(identical(other.orderedQuantity, orderedQuantity) || other.orderedQuantity == orderedQuantity)&&(identical(other.receivedQuantity, receivedQuantity) || other.receivedQuantity == receivedQuantity));
}


@override
int get hashCode => Object.hash(runtimeType,purchaseOrderLineId,description,orderedQuantity,receivedQuantity);

@override
String toString() {
  return 'GoodsReceiptLine(purchaseOrderLineId: $purchaseOrderLineId, description: $description, orderedQuantity: $orderedQuantity, receivedQuantity: $receivedQuantity)';
}


}

/// @nodoc
abstract mixin class _$GoodsReceiptLineCopyWith<$Res> implements $GoodsReceiptLineCopyWith<$Res> {
  factory _$GoodsReceiptLineCopyWith(_GoodsReceiptLine value, $Res Function(_GoodsReceiptLine) _then) = __$GoodsReceiptLineCopyWithImpl;
@override @useResult
$Res call({
 String purchaseOrderLineId, String description, double orderedQuantity, double receivedQuantity
});




}
/// @nodoc
class __$GoodsReceiptLineCopyWithImpl<$Res>
    implements _$GoodsReceiptLineCopyWith<$Res> {
  __$GoodsReceiptLineCopyWithImpl(this._self, this._then);

  final _GoodsReceiptLine _self;
  final $Res Function(_GoodsReceiptLine) _then;

/// Create a copy of GoodsReceiptLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purchaseOrderLineId = null,Object? description = null,Object? orderedQuantity = null,Object? receivedQuantity = null,}) {
  return _then(_GoodsReceiptLine(
purchaseOrderLineId: null == purchaseOrderLineId ? _self.purchaseOrderLineId : purchaseOrderLineId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,orderedQuantity: null == orderedQuantity ? _self.orderedQuantity : orderedQuantity // ignore: cast_nullable_to_non_nullable
as double,receivedQuantity: null == receivedQuantity ? _self.receivedQuantity : receivedQuantity // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
