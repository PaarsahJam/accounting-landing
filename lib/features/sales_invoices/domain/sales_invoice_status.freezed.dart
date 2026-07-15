// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_invoice_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesInvoiceStatus {

 String get id; String get label; String get color;
/// Create a copy of SalesInvoiceStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceStatusCopyWith<SalesInvoiceStatus> get copyWith => _$SalesInvoiceStatusCopyWithImpl<SalesInvoiceStatus>(this as SalesInvoiceStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'SalesInvoiceStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceStatusCopyWith<$Res>  {
  factory $SalesInvoiceStatusCopyWith(SalesInvoiceStatus value, $Res Function(SalesInvoiceStatus) _then) = _$SalesInvoiceStatusCopyWithImpl;
@useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class _$SalesInvoiceStatusCopyWithImpl<$Res>
    implements $SalesInvoiceStatusCopyWith<$Res> {
  _$SalesInvoiceStatusCopyWithImpl(this._self, this._then);

  final SalesInvoiceStatus _self;
  final $Res Function(SalesInvoiceStatus) _then;

/// Create a copy of SalesInvoiceStatus
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


/// Adds pattern-matching-related methods to [SalesInvoiceStatus].
extension SalesInvoiceStatusPatterns on SalesInvoiceStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesInvoiceStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesInvoiceStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesInvoiceStatus value)  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesInvoiceStatus value)?  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceStatus() when $default != null:
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
case _SalesInvoiceStatus() when $default != null:
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
case _SalesInvoiceStatus():
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
case _SalesInvoiceStatus() when $default != null:
return $default(_that.id,_that.label,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _SalesInvoiceStatus implements SalesInvoiceStatus {
  const _SalesInvoiceStatus({required this.id, required this.label, required this.color});
  

@override final  String id;
@override final  String label;
@override final  String color;

/// Create a copy of SalesInvoiceStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesInvoiceStatusCopyWith<_SalesInvoiceStatus> get copyWith => __$SalesInvoiceStatusCopyWithImpl<_SalesInvoiceStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesInvoiceStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,color);

@override
String toString() {
  return 'SalesInvoiceStatus(id: $id, label: $label, color: $color)';
}


}

/// @nodoc
abstract mixin class _$SalesInvoiceStatusCopyWith<$Res> implements $SalesInvoiceStatusCopyWith<$Res> {
  factory _$SalesInvoiceStatusCopyWith(_SalesInvoiceStatus value, $Res Function(_SalesInvoiceStatus) _then) = __$SalesInvoiceStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String color
});




}
/// @nodoc
class __$SalesInvoiceStatusCopyWithImpl<$Res>
    implements _$SalesInvoiceStatusCopyWith<$Res> {
  __$SalesInvoiceStatusCopyWithImpl(this._self, this._then);

  final _SalesInvoiceStatus _self;
  final $Res Function(_SalesInvoiceStatus) _then;

/// Create a copy of SalesInvoiceStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? color = null,}) {
  return _then(_SalesInvoiceStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
