// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_invoice_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesInvoiceLine {

 String get id; String get description; double get quantity; double get unitPrice;
/// Create a copy of SalesInvoiceLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceLineCopyWith<SalesInvoiceLine> get copyWith => _$SalesInvoiceLineCopyWithImpl<SalesInvoiceLine>(this as SalesInvoiceLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceLine&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,quantity,unitPrice);

@override
String toString() {
  return 'SalesInvoiceLine(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceLineCopyWith<$Res>  {
  factory $SalesInvoiceLineCopyWith(SalesInvoiceLine value, $Res Function(SalesInvoiceLine) _then) = _$SalesInvoiceLineCopyWithImpl;
@useResult
$Res call({
 String id, String description, double quantity, double unitPrice
});




}
/// @nodoc
class _$SalesInvoiceLineCopyWithImpl<$Res>
    implements $SalesInvoiceLineCopyWith<$Res> {
  _$SalesInvoiceLineCopyWithImpl(this._self, this._then);

  final SalesInvoiceLine _self;
  final $Res Function(SalesInvoiceLine) _then;

/// Create a copy of SalesInvoiceLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesInvoiceLine].
extension SalesInvoiceLinePatterns on SalesInvoiceLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesInvoiceLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesInvoiceLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesInvoiceLine value)  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesInvoiceLine value)?  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String description,  double quantity,  double unitPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesInvoiceLine() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String description,  double quantity,  double unitPrice)  $default,) {final _that = this;
switch (_that) {
case _SalesInvoiceLine():
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String description,  double quantity,  double unitPrice)?  $default,) {final _that = this;
switch (_that) {
case _SalesInvoiceLine() when $default != null:
return $default(_that.id,_that.description,_that.quantity,_that.unitPrice);case _:
  return null;

}
}

}

/// @nodoc


class _SalesInvoiceLine extends SalesInvoiceLine {
  const _SalesInvoiceLine({required this.id, required this.description, required this.quantity, required this.unitPrice}): super._();
  

@override final  String id;
@override final  String description;
@override final  double quantity;
@override final  double unitPrice;

/// Create a copy of SalesInvoiceLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesInvoiceLineCopyWith<_SalesInvoiceLine> get copyWith => __$SalesInvoiceLineCopyWithImpl<_SalesInvoiceLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesInvoiceLine&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice));
}


@override
int get hashCode => Object.hash(runtimeType,id,description,quantity,unitPrice);

@override
String toString() {
  return 'SalesInvoiceLine(id: $id, description: $description, quantity: $quantity, unitPrice: $unitPrice)';
}


}

/// @nodoc
abstract mixin class _$SalesInvoiceLineCopyWith<$Res> implements $SalesInvoiceLineCopyWith<$Res> {
  factory _$SalesInvoiceLineCopyWith(_SalesInvoiceLine value, $Res Function(_SalesInvoiceLine) _then) = __$SalesInvoiceLineCopyWithImpl;
@override @useResult
$Res call({
 String id, String description, double quantity, double unitPrice
});




}
/// @nodoc
class __$SalesInvoiceLineCopyWithImpl<$Res>
    implements _$SalesInvoiceLineCopyWith<$Res> {
  __$SalesInvoiceLineCopyWithImpl(this._self, this._then);

  final _SalesInvoiceLine _self;
  final $Res Function(_SalesInvoiceLine) _then;

/// Create a copy of SalesInvoiceLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? description = null,Object? quantity = null,Object? unitPrice = null,}) {
  return _then(_SalesInvoiceLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unitPrice: null == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
