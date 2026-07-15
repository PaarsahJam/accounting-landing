// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorPaymentMethod {

 String get id; String get label; String get icon;
/// Create a copy of VendorPaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorPaymentMethodCopyWith<VendorPaymentMethod> get copyWith => _$VendorPaymentMethodCopyWithImpl<VendorPaymentMethod>(this as VendorPaymentMethod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorPaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,icon);

@override
String toString() {
  return 'VendorPaymentMethod(id: $id, label: $label, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $VendorPaymentMethodCopyWith<$Res>  {
  factory $VendorPaymentMethodCopyWith(VendorPaymentMethod value, $Res Function(VendorPaymentMethod) _then) = _$VendorPaymentMethodCopyWithImpl;
@useResult
$Res call({
 String id, String label, String icon
});




}
/// @nodoc
class _$VendorPaymentMethodCopyWithImpl<$Res>
    implements $VendorPaymentMethodCopyWith<$Res> {
  _$VendorPaymentMethodCopyWithImpl(this._self, this._then);

  final VendorPaymentMethod _self;
  final $Res Function(VendorPaymentMethod) _then;

/// Create a copy of VendorPaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? icon = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorPaymentMethod].
extension VendorPaymentMethodPatterns on VendorPaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorPaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorPaymentMethod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorPaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentMethod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorPaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentMethod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorPaymentMethod() when $default != null:
return $default(_that.id,_that.label,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String icon)  $default,) {final _that = this;
switch (_that) {
case _VendorPaymentMethod():
return $default(_that.id,_that.label,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _VendorPaymentMethod() when $default != null:
return $default(_that.id,_that.label,_that.icon);case _:
  return null;

}
}

}

/// @nodoc


class _VendorPaymentMethod implements VendorPaymentMethod {
  const _VendorPaymentMethod({required this.id, required this.label, required this.icon});
  

@override final  String id;
@override final  String label;
@override final  String icon;

/// Create a copy of VendorPaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorPaymentMethodCopyWith<_VendorPaymentMethod> get copyWith => __$VendorPaymentMethodCopyWithImpl<_VendorPaymentMethod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorPaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,icon);

@override
String toString() {
  return 'VendorPaymentMethod(id: $id, label: $label, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$VendorPaymentMethodCopyWith<$Res> implements $VendorPaymentMethodCopyWith<$Res> {
  factory _$VendorPaymentMethodCopyWith(_VendorPaymentMethod value, $Res Function(_VendorPaymentMethod) _then) = __$VendorPaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String icon
});




}
/// @nodoc
class __$VendorPaymentMethodCopyWithImpl<$Res>
    implements _$VendorPaymentMethodCopyWith<$Res> {
  __$VendorPaymentMethodCopyWithImpl(this._self, this._then);

  final _VendorPaymentMethod _self;
  final $Res Function(_VendorPaymentMethod) _then;

/// Create a copy of VendorPaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? icon = null,}) {
  return _then(_VendorPaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
