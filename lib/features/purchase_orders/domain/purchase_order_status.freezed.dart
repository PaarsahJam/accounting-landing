// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_order_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PurchaseOrderStatus {

 String get id; String get label; String get color;
/// Create a copy of PurchaseOrderStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseOrderStatusCopyWith<PurchaseOrderStatus> get copyWith => _$PurchaseOrderStatusCopyWithImpl<PurchaseOrderStatus>(this as PurchaseOrderStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseOrderStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'PurchaseOrderStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class $PurchaseOrderStatusCopyWith<$Res>  {
  factory $PurchaseOrderStatusCopyWith(PurchaseOrderStatus value, $Res Function(PurchaseOrderStatus) _then) = _$PurchaseOrderStatusCopyWithImpl;
@useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class _$PurchaseOrderStatusCopyWithImpl<$Res>
    implements $PurchaseOrderStatusCopyWith<$Res> {
  _$PurchaseOrderStatusCopyWithImpl(this._self, this._then);

  final PurchaseOrderStatus _self;
  final $Res Function(PurchaseOrderStatus) _then;

/// Create a copy of PurchaseOrderStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseOrderStatus].
extension PurchaseOrderStatusPatterns on PurchaseOrderStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseOrderStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseOrderStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseOrderStatus value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrderStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseOrderStatus value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseOrderStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseOrderStatus() when $default != null:
return $default(_that.id,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String color)  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrderStatus():
return $default(_that.id,_that.label,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String color)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseOrderStatus() when $default != null:
return $default(_that.id,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _PurchaseOrderStatus implements PurchaseOrderStatus {
  const _PurchaseOrderStatus({required this.id, required this.label, required this.color});
  

@override final  String id;
@override final  String label;
@override final  String color;

/// Create a copy of PurchaseOrderStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseOrderStatusCopyWith<_PurchaseOrderStatus> get copyWith => __$PurchaseOrderStatusCopyWithImpl<_PurchaseOrderStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseOrderStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'PurchaseOrderStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$PurchaseOrderStatusCopyWith<$Res> implements $PurchaseOrderStatusCopyWith<$Res> {
  factory _$PurchaseOrderStatusCopyWith(_PurchaseOrderStatus value, $Res Function(_PurchaseOrderStatus) _then) = __$PurchaseOrderStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class __$PurchaseOrderStatusCopyWithImpl<$Res>
    implements _$PurchaseOrderStatusCopyWith<$Res> {
  __$PurchaseOrderStatusCopyWithImpl(this._self, this._then);

  final _PurchaseOrderStatus _self;
  final $Res Function(_PurchaseOrderStatus) _then;

/// Create a copy of PurchaseOrderStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? color = null,}) {
  return _then(_PurchaseOrderStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
