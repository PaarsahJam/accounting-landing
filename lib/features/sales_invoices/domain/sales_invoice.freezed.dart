// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_invoice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesInvoice {

 String get id; String get customerId; String get customerName; String get reference; String get title; String get notes; DateTime get invoiceDate; DateTime get dueDate; SalesInvoiceStatus get status; List<SalesInvoiceLine> get lines; double get subtotal; double get tax; double get total;
/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceCopyWith<SalesInvoice> get copyWith => _$SalesInvoiceCopyWithImpl<SalesInvoice>(this as SalesInvoice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,reference,title,notes,invoiceDate,dueDate,status,const DeepCollectionEquality().hash(lines),subtotal,tax,total);

@override
String toString() {
  return 'SalesInvoice(id: $id, customerId: $customerId, customerName: $customerName, reference: $reference, title: $title, notes: $notes, invoiceDate: $invoiceDate, dueDate: $dueDate, status: $status, lines: $lines, subtotal: $subtotal, tax: $tax, total: $total)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceCopyWith<$Res>  {
  factory $SalesInvoiceCopyWith(SalesInvoice value, $Res Function(SalesInvoice) _then) = _$SalesInvoiceCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String reference, String title, String notes, DateTime invoiceDate, DateTime dueDate, SalesInvoiceStatus status, List<SalesInvoiceLine> lines, double subtotal, double tax, double total
});


$SalesInvoiceStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SalesInvoiceCopyWithImpl<$Res>
    implements $SalesInvoiceCopyWith<$Res> {
  _$SalesInvoiceCopyWithImpl(this._self, this._then);

  final SalesInvoice _self;
  final $Res Function(SalesInvoice) _then;

/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? reference = null,Object? title = null,Object? notes = null,Object? invoiceDate = null,Object? dueDate = null,Object? status = null,Object? lines = null,Object? subtotal = null,Object? tax = null,Object? total = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SalesInvoiceStatus,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<SalesInvoiceLine>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesInvoiceStatusCopyWith<$Res> get status {
  
  return $SalesInvoiceStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SalesInvoice].
extension SalesInvoicePatterns on SalesInvoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesInvoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesInvoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesInvoice value)  $default,){
final _that = this;
switch (_that) {
case _SalesInvoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesInvoice value)?  $default,){
final _that = this;
switch (_that) {
case _SalesInvoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String reference,  String title,  String notes,  DateTime invoiceDate,  DateTime dueDate,  SalesInvoiceStatus status,  List<SalesInvoiceLine> lines,  double subtotal,  double tax,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesInvoice() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.title,_that.notes,_that.invoiceDate,_that.dueDate,_that.status,_that.lines,_that.subtotal,_that.tax,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String reference,  String title,  String notes,  DateTime invoiceDate,  DateTime dueDate,  SalesInvoiceStatus status,  List<SalesInvoiceLine> lines,  double subtotal,  double tax,  double total)  $default,) {final _that = this;
switch (_that) {
case _SalesInvoice():
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.title,_that.notes,_that.invoiceDate,_that.dueDate,_that.status,_that.lines,_that.subtotal,_that.tax,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String reference,  String title,  String notes,  DateTime invoiceDate,  DateTime dueDate,  SalesInvoiceStatus status,  List<SalesInvoiceLine> lines,  double subtotal,  double tax,  double total)?  $default,) {final _that = this;
switch (_that) {
case _SalesInvoice() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.reference,_that.title,_that.notes,_that.invoiceDate,_that.dueDate,_that.status,_that.lines,_that.subtotal,_that.tax,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _SalesInvoice implements SalesInvoice {
  const _SalesInvoice({required this.id, required this.customerId, required this.customerName, required this.reference, required this.title, required this.notes, required this.invoiceDate, required this.dueDate, required this.status, required final  List<SalesInvoiceLine> lines, required this.subtotal, required this.tax, required this.total}): _lines = lines;
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String reference;
@override final  String title;
@override final  String notes;
@override final  DateTime invoiceDate;
@override final  DateTime dueDate;
@override final  SalesInvoiceStatus status;
 final  List<SalesInvoiceLine> _lines;
@override List<SalesInvoiceLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  double subtotal;
@override final  double tax;
@override final  double total;

/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesInvoiceCopyWith<_SalesInvoice> get copyWith => __$SalesInvoiceCopyWithImpl<_SalesInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,reference,title,notes,invoiceDate,dueDate,status,const DeepCollectionEquality().hash(_lines),subtotal,tax,total);

@override
String toString() {
  return 'SalesInvoice(id: $id, customerId: $customerId, customerName: $customerName, reference: $reference, title: $title, notes: $notes, invoiceDate: $invoiceDate, dueDate: $dueDate, status: $status, lines: $lines, subtotal: $subtotal, tax: $tax, total: $total)';
}


}

/// @nodoc
abstract mixin class _$SalesInvoiceCopyWith<$Res> implements $SalesInvoiceCopyWith<$Res> {
  factory _$SalesInvoiceCopyWith(_SalesInvoice value, $Res Function(_SalesInvoice) _then) = __$SalesInvoiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String reference, String title, String notes, DateTime invoiceDate, DateTime dueDate, SalesInvoiceStatus status, List<SalesInvoiceLine> lines, double subtotal, double tax, double total
});


@override $SalesInvoiceStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$SalesInvoiceCopyWithImpl<$Res>
    implements _$SalesInvoiceCopyWith<$Res> {
  __$SalesInvoiceCopyWithImpl(this._self, this._then);

  final _SalesInvoice _self;
  final $Res Function(_SalesInvoice) _then;

/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? reference = null,Object? title = null,Object? notes = null,Object? invoiceDate = null,Object? dueDate = null,Object? status = null,Object? lines = null,Object? subtotal = null,Object? tax = null,Object? total = null,}) {
  return _then(_SalesInvoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SalesInvoiceStatus,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<SalesInvoiceLine>,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as double,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as double,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of SalesInvoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesInvoiceStatusCopyWith<$Res> get status {
  
  return $SalesInvoiceStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
