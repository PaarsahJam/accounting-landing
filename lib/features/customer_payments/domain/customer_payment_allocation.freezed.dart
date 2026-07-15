// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_payment_allocation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerPaymentAllocation {

 String get invoiceId; String get invoiceReference; double get amount;
/// Create a copy of CustomerPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerPaymentAllocationCopyWith<CustomerPaymentAllocation> get copyWith => _$CustomerPaymentAllocationCopyWithImpl<CustomerPaymentAllocation>(this as CustomerPaymentAllocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerPaymentAllocation&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.invoiceReference, invoiceReference) || other.invoiceReference == invoiceReference)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,invoiceId,invoiceReference,amount);

@override
String toString() {
  return 'CustomerPaymentAllocation(invoiceId: $invoiceId, invoiceReference: $invoiceReference, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $CustomerPaymentAllocationCopyWith<$Res>  {
  factory $CustomerPaymentAllocationCopyWith(CustomerPaymentAllocation value, $Res Function(CustomerPaymentAllocation) _then) = _$CustomerPaymentAllocationCopyWithImpl;
@useResult
$Res call({
 String invoiceId, String invoiceReference, double amount
});




}
/// @nodoc
class _$CustomerPaymentAllocationCopyWithImpl<$Res>
    implements $CustomerPaymentAllocationCopyWith<$Res> {
  _$CustomerPaymentAllocationCopyWithImpl(this._self, this._then);

  final CustomerPaymentAllocation _self;
  final $Res Function(CustomerPaymentAllocation) _then;

/// Create a copy of CustomerPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceId = null,Object? invoiceReference = null,Object? amount = null,}) {
  return _then(_self.copyWith(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,invoiceReference: null == invoiceReference ? _self.invoiceReference : invoiceReference // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerPaymentAllocation].
extension CustomerPaymentAllocationPatterns on CustomerPaymentAllocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerPaymentAllocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerPaymentAllocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerPaymentAllocation value)  $default,){
final _that = this;
switch (_that) {
case _CustomerPaymentAllocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerPaymentAllocation value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerPaymentAllocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invoiceId,  String invoiceReference,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerPaymentAllocation() when $default != null:
return $default(_that.invoiceId,_that.invoiceReference,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invoiceId,  String invoiceReference,  double amount)  $default,) {final _that = this;
switch (_that) {
case _CustomerPaymentAllocation():
return $default(_that.invoiceId,_that.invoiceReference,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invoiceId,  String invoiceReference,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _CustomerPaymentAllocation() when $default != null:
return $default(_that.invoiceId,_that.invoiceReference,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerPaymentAllocation implements CustomerPaymentAllocation {
  const _CustomerPaymentAllocation({required this.invoiceId, required this.invoiceReference, required this.amount});
  

@override final  String invoiceId;
@override final  String invoiceReference;
@override final  double amount;

/// Create a copy of CustomerPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerPaymentAllocationCopyWith<_CustomerPaymentAllocation> get copyWith => __$CustomerPaymentAllocationCopyWithImpl<_CustomerPaymentAllocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerPaymentAllocation&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.invoiceReference, invoiceReference) || other.invoiceReference == invoiceReference)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,invoiceId,invoiceReference,amount);

@override
String toString() {
  return 'CustomerPaymentAllocation(invoiceId: $invoiceId, invoiceReference: $invoiceReference, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CustomerPaymentAllocationCopyWith<$Res> implements $CustomerPaymentAllocationCopyWith<$Res> {
  factory _$CustomerPaymentAllocationCopyWith(_CustomerPaymentAllocation value, $Res Function(_CustomerPaymentAllocation) _then) = __$CustomerPaymentAllocationCopyWithImpl;
@override @useResult
$Res call({
 String invoiceId, String invoiceReference, double amount
});




}
/// @nodoc
class __$CustomerPaymentAllocationCopyWithImpl<$Res>
    implements _$CustomerPaymentAllocationCopyWith<$Res> {
  __$CustomerPaymentAllocationCopyWithImpl(this._self, this._then);

  final _CustomerPaymentAllocation _self;
  final $Res Function(_CustomerPaymentAllocation) _then;

/// Create a copy of CustomerPaymentAllocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,Object? invoiceReference = null,Object? amount = null,}) {
  return _then(_CustomerPaymentAllocation(
invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,invoiceReference: null == invoiceReference ? _self.invoiceReference : invoiceReference // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
