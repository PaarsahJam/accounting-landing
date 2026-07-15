// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerPayment {

 String get id; String get customerId; String get customerName; String get reference; String get notes; DateTime get paymentDate; DateTime get receivedAt; double get amount; CustomerPaymentMethod get method; CustomerPaymentStatus get status; List<CustomerPaymentAllocation> get allocations;
/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerPaymentCopyWith<CustomerPayment> get copyWith => _$CustomerPaymentCopyWithImpl<CustomerPayment>(this as CustomerPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allocations, allocations));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,reference,notes,paymentDate,receivedAt,amount,method,status,const DeepCollectionEquality().hash(allocations));

@override
String toString() {
  return 'CustomerPayment(id: $id, customerId: $customerId, customerName: $customerName, reference: $reference, notes: $notes, paymentDate: $paymentDate, receivedAt: $receivedAt, amount: $amount, method: $method, status: $status, allocations: $allocations)';
}


}

/// @nodoc
abstract mixin class $CustomerPaymentCopyWith<$Res>  {
  factory $CustomerPaymentCopyWith(CustomerPayment value, $Res Function(CustomerPayment) _then) = _$CustomerPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String reference, String notes, DateTime paymentDate, DateTime receivedAt, double amount, CustomerPaymentMethod method, CustomerPaymentStatus status, List<CustomerPaymentAllocation> allocations
});


$CustomerPaymentMethodCopyWith<$Res> get method;$CustomerPaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$CustomerPaymentCopyWithImpl<$Res>
    implements $CustomerPaymentCopyWith<$Res> {
  _$CustomerPaymentCopyWithImpl(this._self, this._then);

  final CustomerPayment _self;
  final $Res Function(CustomerPayment) _then;

/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? reference = null,Object? notes = null,Object? paymentDate = null,Object? receivedAt = null,Object? amount = null,Object? method = null,Object? status = null,Object? allocations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CustomerPaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomerPaymentStatus,allocations: null == allocations ? _self.allocations : allocations // ignore: cast_nullable_to_non_nullable
as List<CustomerPaymentAllocation>,
  ));
}
/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerPaymentMethodCopyWith<$Res> get method {
  
  return $CustomerPaymentMethodCopyWith<$Res>(_self.method, (value) {
    return _then(_self.copyWith(method: value));
  });
}/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerPaymentStatusCopyWith<$Res> get status {
  
  return $CustomerPaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerPayment].
extension CustomerPaymentPatterns on CustomerPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerPayment value)  $default,){
final _that = this;
switch (_that) {
case _CustomerPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerPayment value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String reference,  String notes,  DateTime paymentDate,  DateTime receivedAt,  double amount,  CustomerPaymentMethod method,  CustomerPaymentStatus status,  List<CustomerPaymentAllocation> allocations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerPayment() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.notes,_that.paymentDate,_that.receivedAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String reference,  String notes,  DateTime paymentDate,  DateTime receivedAt,  double amount,  CustomerPaymentMethod method,  CustomerPaymentStatus status,  List<CustomerPaymentAllocation> allocations)  $default,) {final _that = this;
switch (_that) {
case _CustomerPayment():
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.notes,_that.paymentDate,_that.receivedAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String reference,  String notes,  DateTime paymentDate,  DateTime receivedAt,  double amount,  CustomerPaymentMethod method,  CustomerPaymentStatus status,  List<CustomerPaymentAllocation> allocations)?  $default,) {final _that = this;
switch (_that) {
case _CustomerPayment() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.notes,_that.paymentDate,_that.receivedAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerPayment implements CustomerPayment {
  const _CustomerPayment({required this.id, required this.customerId, required this.customerName, required this.reference, required this.notes, required this.paymentDate, required this.receivedAt, required this.amount, required this.method, required this.status, required final  List<CustomerPaymentAllocation> allocations}): _allocations = allocations;
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String reference;
@override final  String notes;
@override final  DateTime paymentDate;
@override final  DateTime receivedAt;
@override final  double amount;
@override final  CustomerPaymentMethod method;
@override final  CustomerPaymentStatus status;
 final  List<CustomerPaymentAllocation> _allocations;
@override List<CustomerPaymentAllocation> get allocations {
  if (_allocations is EqualUnmodifiableListView) return _allocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allocations);
}


/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerPaymentCopyWith<_CustomerPayment> get copyWith => __$CustomerPaymentCopyWithImpl<_CustomerPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allocations, _allocations));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,reference,notes,paymentDate,receivedAt,amount,method,status,const DeepCollectionEquality().hash(_allocations));

@override
String toString() {
  return 'CustomerPayment(id: $id, customerId: $customerId, customerName: $customerName, reference: $reference, notes: $notes, paymentDate: $paymentDate, receivedAt: $receivedAt, amount: $amount, method: $method, status: $status, allocations: $allocations)';
}


}

/// @nodoc
abstract mixin class _$CustomerPaymentCopyWith<$Res> implements $CustomerPaymentCopyWith<$Res> {
  factory _$CustomerPaymentCopyWith(_CustomerPayment value, $Res Function(_CustomerPayment) _then) = __$CustomerPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String reference, String notes, DateTime paymentDate, DateTime receivedAt, double amount, CustomerPaymentMethod method, CustomerPaymentStatus status, List<CustomerPaymentAllocation> allocations
});


@override $CustomerPaymentMethodCopyWith<$Res> get method;@override $CustomerPaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$CustomerPaymentCopyWithImpl<$Res>
    implements _$CustomerPaymentCopyWith<$Res> {
  __$CustomerPaymentCopyWithImpl(this._self, this._then);

  final _CustomerPayment _self;
  final $Res Function(_CustomerPayment) _then;

/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? reference = null,Object? notes = null,Object? paymentDate = null,Object? receivedAt = null,Object? amount = null,Object? method = null,Object? status = null,Object? allocations = null,}) {
  return _then(_CustomerPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as CustomerPaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomerPaymentStatus,allocations: null == allocations ? _self._allocations : allocations // ignore: cast_nullable_to_non_nullable
as List<CustomerPaymentAllocation>,
  ));
}

/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerPaymentMethodCopyWith<$Res> get method {
  
  return $CustomerPaymentMethodCopyWith<$Res>(_self.method, (value) {
    return _then(_self.copyWith(method: value));
  });
}/// Create a copy of CustomerPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerPaymentStatusCopyWith<$Res> get status {
  
  return $CustomerPaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
