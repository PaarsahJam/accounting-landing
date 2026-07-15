// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorPayment {

 String get id; String get vendorId; String get vendorName; String get reference; String get notes; DateTime get paymentDate; DateTime get createdAt; double get amount; VendorPaymentMethod get method; VendorPaymentStatus get status; List<VendorPaymentAllocation> get allocations;
/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorPaymentCopyWith<VendorPayment> get copyWith => _$VendorPaymentCopyWithImpl<VendorPayment>(this as VendorPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allocations, allocations));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,reference,notes,paymentDate,createdAt,amount,method,status,const DeepCollectionEquality().hash(allocations));

@override
String toString() {
  return 'VendorPayment(id: $id, vendorId: $vendorId, vendorName: $vendorName, reference: $reference, notes: $notes, paymentDate: $paymentDate, createdAt: $createdAt, amount: $amount, method: $method, status: $status, allocations: $allocations)';
}


}

/// @nodoc
abstract mixin class $VendorPaymentCopyWith<$Res>  {
  factory $VendorPaymentCopyWith(VendorPayment value, $Res Function(VendorPayment) _then) = _$VendorPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String vendorId, String vendorName, String reference, String notes, DateTime paymentDate, DateTime createdAt, double amount, VendorPaymentMethod method, VendorPaymentStatus status, List<VendorPaymentAllocation> allocations
});


$VendorPaymentMethodCopyWith<$Res> get method;$VendorPaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$VendorPaymentCopyWithImpl<$Res>
    implements $VendorPaymentCopyWith<$Res> {
  _$VendorPaymentCopyWithImpl(this._self, this._then);

  final VendorPayment _self;
  final $Res Function(VendorPayment) _then;

/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? reference = null,Object? notes = null,Object? paymentDate = null,Object? createdAt = null,Object? amount = null,Object? method = null,Object? status = null,Object? allocations = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as VendorPaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorPaymentStatus,allocations: null == allocations ? _self.allocations : allocations // ignore: cast_nullable_to_non_nullable
as List<VendorPaymentAllocation>,
  ));
}
/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorPaymentMethodCopyWith<$Res> get method {
  
  return $VendorPaymentMethodCopyWith<$Res>(_self.method, (value) {
    return _then(_self.copyWith(method: value));
  });
}/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorPaymentStatusCopyWith<$Res> get status {
  
  return $VendorPaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [VendorPayment].
extension VendorPaymentPatterns on VendorPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorPayment value)  $default,){
final _that = this;
switch (_that) {
case _VendorPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorPayment value)?  $default,){
final _that = this;
switch (_that) {
case _VendorPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  String reference,  String notes,  DateTime paymentDate,  DateTime createdAt,  double amount,  VendorPaymentMethod method,  VendorPaymentStatus status,  List<VendorPaymentAllocation> allocations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorPayment() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.reference,_that.notes,_that.paymentDate,_that.createdAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  String reference,  String notes,  DateTime paymentDate,  DateTime createdAt,  double amount,  VendorPaymentMethod method,  VendorPaymentStatus status,  List<VendorPaymentAllocation> allocations)  $default,) {final _that = this;
switch (_that) {
case _VendorPayment():
return $default(_that.id,_that.vendorId,_that.vendorName,_that.reference,_that.notes,_that.paymentDate,_that.createdAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vendorId,  String vendorName,  String reference,  String notes,  DateTime paymentDate,  DateTime createdAt,  double amount,  VendorPaymentMethod method,  VendorPaymentStatus status,  List<VendorPaymentAllocation> allocations)?  $default,) {final _that = this;
switch (_that) {
case _VendorPayment() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.reference,_that.notes,_that.paymentDate,_that.createdAt,_that.amount,_that.method,_that.status,_that.allocations);case _:
  return null;

}
}

}

/// @nodoc


class _VendorPayment implements VendorPayment {
  const _VendorPayment({required this.id, required this.vendorId, required this.vendorName, required this.reference, required this.notes, required this.paymentDate, required this.createdAt, required this.amount, required this.method, required this.status, required final  List<VendorPaymentAllocation> allocations}): _allocations = allocations;
  

@override final  String id;
@override final  String vendorId;
@override final  String vendorName;
@override final  String reference;
@override final  String notes;
@override final  DateTime paymentDate;
@override final  DateTime createdAt;
@override final  double amount;
@override final  VendorPaymentMethod method;
@override final  VendorPaymentStatus status;
 final  List<VendorPaymentAllocation> _allocations;
@override List<VendorPaymentAllocation> get allocations {
  if (_allocations is EqualUnmodifiableListView) return _allocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allocations);
}


/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorPaymentCopyWith<_VendorPayment> get copyWith => __$VendorPaymentCopyWithImpl<_VendorPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allocations, _allocations));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,reference,notes,paymentDate,createdAt,amount,method,status,const DeepCollectionEquality().hash(_allocations));

@override
String toString() {
  return 'VendorPayment(id: $id, vendorId: $vendorId, vendorName: $vendorName, reference: $reference, notes: $notes, paymentDate: $paymentDate, createdAt: $createdAt, amount: $amount, method: $method, status: $status, allocations: $allocations)';
}


}

/// @nodoc
abstract mixin class _$VendorPaymentCopyWith<$Res> implements $VendorPaymentCopyWith<$Res> {
  factory _$VendorPaymentCopyWith(_VendorPayment value, $Res Function(_VendorPayment) _then) = __$VendorPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String vendorId, String vendorName, String reference, String notes, DateTime paymentDate, DateTime createdAt, double amount, VendorPaymentMethod method, VendorPaymentStatus status, List<VendorPaymentAllocation> allocations
});


@override $VendorPaymentMethodCopyWith<$Res> get method;@override $VendorPaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$VendorPaymentCopyWithImpl<$Res>
    implements _$VendorPaymentCopyWith<$Res> {
  __$VendorPaymentCopyWithImpl(this._self, this._then);

  final _VendorPayment _self;
  final $Res Function(_VendorPayment) _then;

/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? reference = null,Object? notes = null,Object? paymentDate = null,Object? createdAt = null,Object? amount = null,Object? method = null,Object? status = null,Object? allocations = null,}) {
  return _then(_VendorPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as VendorPaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorPaymentStatus,allocations: null == allocations ? _self._allocations : allocations // ignore: cast_nullable_to_non_nullable
as List<VendorPaymentAllocation>,
  ));
}

/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorPaymentMethodCopyWith<$Res> get method {
  
  return $VendorPaymentMethodCopyWith<$Res>(_self.method, (value) {
    return _then(_self.copyWith(method: value));
  });
}/// Create a copy of VendorPayment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorPaymentStatusCopyWith<$Res> get status {
  
  return $VendorPaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
