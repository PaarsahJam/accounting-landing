// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_bill_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorBillStatus {

 String get id; String get label; String get color;
/// Create a copy of VendorBillStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorBillStatusCopyWith<VendorBillStatus> get copyWith => _$VendorBillStatusCopyWithImpl<VendorBillStatus>(this as VendorBillStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorBillStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'VendorBillStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class $VendorBillStatusCopyWith<$Res>  {
  factory $VendorBillStatusCopyWith(VendorBillStatus value, $Res Function(VendorBillStatus) _then) = _$VendorBillStatusCopyWithImpl;
@useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class _$VendorBillStatusCopyWithImpl<$Res>
    implements $VendorBillStatusCopyWith<$Res> {
  _$VendorBillStatusCopyWithImpl(this._self, this._then);

  final VendorBillStatus _self;
  final $Res Function(VendorBillStatus) _then;

/// Create a copy of VendorBillStatus
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


/// Adds pattern-matching-related methods to [VendorBillStatus].
extension VendorBillStatusPatterns on VendorBillStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorBillStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorBillStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorBillStatus value)  $default,){
final _that = this;
switch (_that) {
case _VendorBillStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorBillStatus value)?  $default,){
final _that = this;
switch (_that) {
case _VendorBillStatus() when $default != null:
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
case _VendorBillStatus() when $default != null:
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
case _VendorBillStatus():
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
case _VendorBillStatus() when $default != null:
return $default(_that.id,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _VendorBillStatus implements VendorBillStatus {
  const _VendorBillStatus({required this.id, required this.label, required this.color});
  

@override final  String id;
@override final  String label;
@override final  String color;

/// Create a copy of VendorBillStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorBillStatusCopyWith<_VendorBillStatus> get copyWith => __$VendorBillStatusCopyWithImpl<_VendorBillStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorBillStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'VendorBillStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$VendorBillStatusCopyWith<$Res> implements $VendorBillStatusCopyWith<$Res> {
  factory _$VendorBillStatusCopyWith(_VendorBillStatus value, $Res Function(_VendorBillStatus) _then) = __$VendorBillStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class __$VendorBillStatusCopyWithImpl<$Res>
    implements _$VendorBillStatusCopyWith<$Res> {
  __$VendorBillStatusCopyWithImpl(this._self, this._then);

  final _VendorBillStatus _self;
  final $Res Function(_VendorBillStatus) _then;

/// Create a copy of VendorBillStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? color = null,}) {
  return _then(_VendorBillStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
