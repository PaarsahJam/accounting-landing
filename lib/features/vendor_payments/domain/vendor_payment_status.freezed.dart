// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_payment_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorPaymentStatus {

 String get id; String get label; String get color;
/// Create a copy of VendorPaymentStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorPaymentStatusCopyWith<VendorPaymentStatus> get copyWith => _$VendorPaymentStatusCopyWithImpl<VendorPaymentStatus>(this as VendorPaymentStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorPaymentStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'VendorPaymentStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class $VendorPaymentStatusCopyWith<$Res>  {
  factory $VendorPaymentStatusCopyWith(VendorPaymentStatus value, $Res Function(VendorPaymentStatus) _then) = _$VendorPaymentStatusCopyWithImpl;
@useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class _$VendorPaymentStatusCopyWithImpl<$Res>
    implements $VendorPaymentStatusCopyWith<$Res> {
  _$VendorPaymentStatusCopyWithImpl(this._self, this._then);

  final VendorPaymentStatus _self;
  final $Res Function(VendorPaymentStatus) _then;

/// Create a copy of VendorPaymentStatus
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


/// Adds pattern-matching-related methods to [VendorPaymentStatus].
extension VendorPaymentStatusPatterns on VendorPaymentStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorPaymentStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorPaymentStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorPaymentStatus value)  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorPaymentStatus value)?  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentStatus() when $default != null:
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
case _VendorPaymentStatus() when $default != null:
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
case _VendorPaymentStatus():
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
case _VendorPaymentStatus() when $default != null:
return $default(_that.id,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _VendorPaymentStatus implements VendorPaymentStatus {
  const _VendorPaymentStatus({required this.id, required this.label, required this.color});
  

@override final  String id;
@override final  String label;
@override final  String color;

/// Create a copy of VendorPaymentStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorPaymentStatusCopyWith<_VendorPaymentStatus> get copyWith => __$VendorPaymentStatusCopyWithImpl<_VendorPaymentStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorPaymentStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'VendorPaymentStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$VendorPaymentStatusCopyWith<$Res> implements $VendorPaymentStatusCopyWith<$Res> {
  factory _$VendorPaymentStatusCopyWith(_VendorPaymentStatus value, $Res Function(_VendorPaymentStatus) _then) = __$VendorPaymentStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class __$VendorPaymentStatusCopyWithImpl<$Res>
    implements _$VendorPaymentStatusCopyWith<$Res> {
  __$VendorPaymentStatusCopyWithImpl(this._self, this._then);

  final _VendorPaymentStatus _self;
  final $Res Function(_VendorPaymentStatus) _then;

/// Create a copy of VendorPaymentStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? color = null,}) {
  return _then(_VendorPaymentStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
