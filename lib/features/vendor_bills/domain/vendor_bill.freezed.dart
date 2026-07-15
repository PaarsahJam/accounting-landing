// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorBill {

 String get id; String get vendorId; String get purchaseOrderId; String get goodsReceiptId; String get reference; String get title; String get notes; DateTime get billDate; DateTime get dueDate; VendorBillStatus get status; List<VendorBillLine> get lines;
/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorBillCopyWith<VendorBill> get copyWith => _$VendorBillCopyWithImpl<VendorBill>(this as VendorBill, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorBill&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.purchaseOrderId, purchaseOrderId) || other.purchaseOrderId == purchaseOrderId)&&(identical(other.goodsReceiptId, goodsReceiptId) || other.goodsReceiptId == goodsReceiptId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.billDate, billDate) || other.billDate == billDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.lines, lines));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,purchaseOrderId,goodsReceiptId,reference,title,notes,billDate,dueDate,status,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'VendorBill(id: $id, vendorId: $vendorId, purchaseOrderId: $purchaseOrderId, goodsReceiptId: $goodsReceiptId, reference: $reference, title: $title, notes: $notes, billDate: $billDate, dueDate: $dueDate, status: $status, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $VendorBillCopyWith<$Res>  {
  factory $VendorBillCopyWith(VendorBill value, $Res Function(VendorBill) _then) = _$VendorBillCopyWithImpl;
@useResult
$Res call({
 String id, String vendorId, String purchaseOrderId, String goodsReceiptId, String reference, String title, String notes, DateTime billDate, DateTime dueDate, VendorBillStatus status, List<VendorBillLine> lines
});


$VendorBillStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$VendorBillCopyWithImpl<$Res>
    implements $VendorBillCopyWith<$Res> {
  _$VendorBillCopyWithImpl(this._self, this._then);

  final VendorBill _self;
  final $Res Function(VendorBill) _then;

/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendorId = null,Object? purchaseOrderId = null,Object? goodsReceiptId = null,Object? reference = null,Object? title = null,Object? notes = null,Object? billDate = null,Object? dueDate = null,Object? status = null,Object? lines = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,purchaseOrderId: null == purchaseOrderId ? _self.purchaseOrderId : purchaseOrderId // ignore: cast_nullable_to_non_nullable
as String,goodsReceiptId: null == goodsReceiptId ? _self.goodsReceiptId : goodsReceiptId // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,billDate: null == billDate ? _self.billDate : billDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorBillStatus,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<VendorBillLine>,
  ));
}
/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorBillStatusCopyWith<$Res> get status {
  
  return $VendorBillStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [VendorBill].
extension VendorBillPatterns on VendorBill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorBill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorBill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorBill value)  $default,){
final _that = this;
switch (_that) {
case _VendorBill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorBill value)?  $default,){
final _that = this;
switch (_that) {
case _VendorBill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vendorId,  String purchaseOrderId,  String goodsReceiptId,  String reference,  String title,  String notes,  DateTime billDate,  DateTime dueDate,  VendorBillStatus status,  List<VendorBillLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorBill() when $default != null:
return $default(_that.id,_that.vendorId,_that.purchaseOrderId,_that.goodsReceiptId,_that.reference,_that.title,_that.notes,_that.billDate,_that.dueDate,_that.status,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vendorId,  String purchaseOrderId,  String goodsReceiptId,  String reference,  String title,  String notes,  DateTime billDate,  DateTime dueDate,  VendorBillStatus status,  List<VendorBillLine> lines)  $default,) {final _that = this;
switch (_that) {
case _VendorBill():
return $default(_that.id,_that.vendorId,_that.purchaseOrderId,_that.goodsReceiptId,_that.reference,_that.title,_that.notes,_that.billDate,_that.dueDate,_that.status,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vendorId,  String purchaseOrderId,  String goodsReceiptId,  String reference,  String title,  String notes,  DateTime billDate,  DateTime dueDate,  VendorBillStatus status,  List<VendorBillLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _VendorBill() when $default != null:
return $default(_that.id,_that.vendorId,_that.purchaseOrderId,_that.goodsReceiptId,_that.reference,_that.title,_that.notes,_that.billDate,_that.dueDate,_that.status,_that.lines);case _:
  return null;

}
}

}

/// @nodoc


class _VendorBill implements VendorBill {
  const _VendorBill({required this.id, required this.vendorId, required this.purchaseOrderId, required this.goodsReceiptId, required this.reference, required this.title, required this.notes, required this.billDate, required this.dueDate, required this.status, required final  List<VendorBillLine> lines}): _lines = lines;
  

@override final  String id;
@override final  String vendorId;
@override final  String purchaseOrderId;
@override final  String goodsReceiptId;
@override final  String reference;
@override final  String title;
@override final  String notes;
@override final  DateTime billDate;
@override final  DateTime dueDate;
@override final  VendorBillStatus status;
 final  List<VendorBillLine> _lines;
@override List<VendorBillLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorBillCopyWith<_VendorBill> get copyWith => __$VendorBillCopyWithImpl<_VendorBill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorBill&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.purchaseOrderId, purchaseOrderId) || other.purchaseOrderId == purchaseOrderId)&&(identical(other.goodsReceiptId, goodsReceiptId) || other.goodsReceiptId == goodsReceiptId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.billDate, billDate) || other.billDate == billDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._lines, _lines));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,purchaseOrderId,goodsReceiptId,reference,title,notes,billDate,dueDate,status,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'VendorBill(id: $id, vendorId: $vendorId, purchaseOrderId: $purchaseOrderId, goodsReceiptId: $goodsReceiptId, reference: $reference, title: $title, notes: $notes, billDate: $billDate, dueDate: $dueDate, status: $status, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$VendorBillCopyWith<$Res> implements $VendorBillCopyWith<$Res> {
  factory _$VendorBillCopyWith(_VendorBill value, $Res Function(_VendorBill) _then) = __$VendorBillCopyWithImpl;
@override @useResult
$Res call({
 String id, String vendorId, String purchaseOrderId, String goodsReceiptId, String reference, String title, String notes, DateTime billDate, DateTime dueDate, VendorBillStatus status, List<VendorBillLine> lines
});


@override $VendorBillStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$VendorBillCopyWithImpl<$Res>
    implements _$VendorBillCopyWith<$Res> {
  __$VendorBillCopyWithImpl(this._self, this._then);

  final _VendorBill _self;
  final $Res Function(_VendorBill) _then;

/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendorId = null,Object? purchaseOrderId = null,Object? goodsReceiptId = null,Object? reference = null,Object? title = null,Object? notes = null,Object? billDate = null,Object? dueDate = null,Object? status = null,Object? lines = null,}) {
  return _then(_VendorBill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,purchaseOrderId: null == purchaseOrderId ? _self.purchaseOrderId : purchaseOrderId // ignore: cast_nullable_to_non_nullable
as String,goodsReceiptId: null == goodsReceiptId ? _self.goodsReceiptId : goodsReceiptId // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,billDate: null == billDate ? _self.billDate : billDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VendorBillStatus,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<VendorBillLine>,
  ));
}

/// Create a copy of VendorBill
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorBillStatusCopyWith<$Res> get status {
  
  return $VendorBillStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
