// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_payment_allocation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorPaymentAllocation {

 String get billId; String get billReference; double get amount;
/// Create a copy of VendorPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorPaymentAllocationCopyWith<VendorPaymentAllocation> get copyWith => _$VendorPaymentAllocationCopyWithImpl<VendorPaymentAllocation>(this as VendorPaymentAllocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorPaymentAllocation&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.billReference, billReference) || other.billReference == billReference)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,billId,billReference,amount);

@override
String toString() {
  return 'VendorPaymentAllocation(billId: $billId, billReference: $billReference, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $VendorPaymentAllocationCopyWith<$Res>  {
  factory $VendorPaymentAllocationCopyWith(VendorPaymentAllocation value, $Res Function(VendorPaymentAllocation) _then) = _$VendorPaymentAllocationCopyWithImpl;
@useResult
$Res call({
 String billId, String billReference, double amount
});




}
/// @nodoc
class _$VendorPaymentAllocationCopyWithImpl<$Res>
    implements $VendorPaymentAllocationCopyWith<$Res> {
  _$VendorPaymentAllocationCopyWithImpl(this._self, this._then);

  final VendorPaymentAllocation _self;
  final $Res Function(VendorPaymentAllocation) _then;

/// Create a copy of VendorPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billId = null,Object? billReference = null,Object? amount = null,}) {
  return _then(_self.copyWith(
billId: null == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String,billReference: null == billReference ? _self.billReference : billReference // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorPaymentAllocation].
extension VendorPaymentAllocationPatterns on VendorPaymentAllocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorPaymentAllocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorPaymentAllocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorPaymentAllocation value)  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentAllocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorPaymentAllocation value)?  $default,){
final _that = this;
switch (_that) {
case _VendorPaymentAllocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billId,  String billReference,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorPaymentAllocation() when $default != null:
return $default(_that.billId,_that.billReference,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billId,  String billReference,  double amount)  $default,) {final _that = this;
switch (_that) {
case _VendorPaymentAllocation():
return $default(_that.billId,_that.billReference,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billId,  String billReference,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _VendorPaymentAllocation() when $default != null:
return $default(_that.billId,_that.billReference,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _VendorPaymentAllocation implements VendorPaymentAllocation {
  const _VendorPaymentAllocation({required this.billId, required this.billReference, required this.amount});
  

@override final  String billId;
@override final  String billReference;
@override final  double amount;

/// Create a copy of VendorPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorPaymentAllocationCopyWith<_VendorPaymentAllocation> get copyWith => __$VendorPaymentAllocationCopyWithImpl<_VendorPaymentAllocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorPaymentAllocation&&(identical(other.billId, billId) || other.billId == billId)&&(identical(other.billReference, billReference) || other.billReference == billReference)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,billId,billReference,amount);

@override
String toString() {
  return 'VendorPaymentAllocation(billId: $billId, billReference: $billReference, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$VendorPaymentAllocationCopyWith<$Res> implements $VendorPaymentAllocationCopyWith<$Res> {
  factory _$VendorPaymentAllocationCopyWith(_VendorPaymentAllocation value, $Res Function(_VendorPaymentAllocation) _then) = __$VendorPaymentAllocationCopyWithImpl;
@override @useResult
$Res call({
 String billId, String billReference, double amount
});




}
/// @nodoc
class __$VendorPaymentAllocationCopyWithImpl<$Res>
    implements _$VendorPaymentAllocationCopyWith<$Res> {
  __$VendorPaymentAllocationCopyWithImpl(this._self, this._then);

  final _VendorPaymentAllocation _self;
  final $Res Function(_VendorPaymentAllocation) _then;

/// Create a copy of VendorPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billId = null,Object? billReference = null,Object? amount = null,}) {
  return _then(_VendorPaymentAllocation(
billId: null == billId ? _self.billId : billId // ignore: cast_nullable_to_non_nullable
as String,billReference: null == billReference ? _self.billReference : billReference // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
