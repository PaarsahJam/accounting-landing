// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goods_receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoodsReceipt {

 String get id; String get purchaseOrderId; String get reference; String get title; DateTime get receivedAt; GoodsReceiptStatus get status; List<GoodsReceiptLine> get lines;
/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoodsReceiptCopyWith<GoodsReceipt> get copyWith => _$GoodsReceiptCopyWithImpl<GoodsReceipt>(this as GoodsReceipt, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoodsReceipt&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseOrderId, purchaseOrderId) || other.purchaseOrderId == purchaseOrderId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.lines, lines));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseOrderId,reference,title,receivedAt,status,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'GoodsReceipt(id: $id, purchaseOrderId: $purchaseOrderId, reference: $reference, title: $title, receivedAt: $receivedAt, status: $status, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $GoodsReceiptCopyWith<$Res>  {
  factory $GoodsReceiptCopyWith(GoodsReceipt value, $Res Function(GoodsReceipt) _then) = _$GoodsReceiptCopyWithImpl;
@useResult
$Res call({
 String id, String purchaseOrderId, String reference, String title, DateTime receivedAt, GoodsReceiptStatus status, List<GoodsReceiptLine> lines
});


$GoodsReceiptStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$GoodsReceiptCopyWithImpl<$Res>
    implements $GoodsReceiptCopyWith<$Res> {
  _$GoodsReceiptCopyWithImpl(this._self, this._then);

  final GoodsReceipt _self;
  final $Res Function(GoodsReceipt) _then;

/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? purchaseOrderId = null,Object? reference = null,Object? title = null,Object? receivedAt = null,Object? status = null,Object? lines = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseOrderId: null == purchaseOrderId ? _self.purchaseOrderId : purchaseOrderId // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoodsReceiptStatus,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<GoodsReceiptLine>,
  ));
}
/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoodsReceiptStatusCopyWith<$Res> get status {
  
  return $GoodsReceiptStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoodsReceipt].
extension GoodsReceiptPatterns on GoodsReceipt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoodsReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoodsReceipt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoodsReceipt value)  $default,){
final _that = this;
switch (_that) {
case _GoodsReceipt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoodsReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _GoodsReceipt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String purchaseOrderId,  String reference,  String title,  DateTime receivedAt,  GoodsReceiptStatus status,  List<GoodsReceiptLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoodsReceipt() when $default != null:
return $default(_that.id,_that.purchaseOrderId,_that.reference,_that.title,_that.receivedAt,_that.status,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String purchaseOrderId,  String reference,  String title,  DateTime receivedAt,  GoodsReceiptStatus status,  List<GoodsReceiptLine> lines)  $default,) {final _that = this;
switch (_that) {
case _GoodsReceipt():
return $default(_that.id,_that.purchaseOrderId,_that.reference,_that.title,_that.receivedAt,_that.status,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String purchaseOrderId,  String reference,  String title,  DateTime receivedAt,  GoodsReceiptStatus status,  List<GoodsReceiptLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _GoodsReceipt() when $default != null:
return $default(_that.id,_that.purchaseOrderId,_that.reference,_that.title,_that.receivedAt,_that.status,_that.lines);case _:
  return null;

}
}

}

/// @nodoc


class _GoodsReceipt implements GoodsReceipt {
  const _GoodsReceipt({required this.id, required this.purchaseOrderId, required this.reference, required this.title, required this.receivedAt, required this.status, required final  List<GoodsReceiptLine> lines}): _lines = lines;
  

@override final  String id;
@override final  String purchaseOrderId;
@override final  String reference;
@override final  String title;
@override final  DateTime receivedAt;
@override final  GoodsReceiptStatus status;
 final  List<GoodsReceiptLine> _lines;
@override List<GoodsReceiptLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoodsReceiptCopyWith<_GoodsReceipt> get copyWith => __$GoodsReceiptCopyWithImpl<_GoodsReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoodsReceipt&&(identical(other.id, id) || other.id == id)&&(identical(other.purchaseOrderId, purchaseOrderId) || other.purchaseOrderId == purchaseOrderId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.title, title) || other.title == title)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._lines, _lines));
}


@override
int get hashCode => Object.hash(runtimeType,id,purchaseOrderId,reference,title,receivedAt,status,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'GoodsReceipt(id: $id, purchaseOrderId: $purchaseOrderId, reference: $reference, title: $title, receivedAt: $receivedAt, status: $status, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$GoodsReceiptCopyWith<$Res> implements $GoodsReceiptCopyWith<$Res> {
  factory _$GoodsReceiptCopyWith(_GoodsReceipt value, $Res Function(_GoodsReceipt) _then) = __$GoodsReceiptCopyWithImpl;
@override @useResult
$Res call({
 String id, String purchaseOrderId, String reference, String title, DateTime receivedAt, GoodsReceiptStatus status, List<GoodsReceiptLine> lines
});


@override $GoodsReceiptStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$GoodsReceiptCopyWithImpl<$Res>
    implements _$GoodsReceiptCopyWith<$Res> {
  __$GoodsReceiptCopyWithImpl(this._self, this._then);

  final _GoodsReceipt _self;
  final $Res Function(_GoodsReceipt) _then;

/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? purchaseOrderId = null,Object? reference = null,Object? title = null,Object? receivedAt = null,Object? status = null,Object? lines = null,}) {
  return _then(_GoodsReceipt(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,purchaseOrderId: null == purchaseOrderId ? _self.purchaseOrderId : purchaseOrderId // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoodsReceiptStatus,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<GoodsReceiptLine>,
  ));
}

/// Create a copy of GoodsReceipt
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoodsReceiptStatusCopyWith<$Res> get status {
  
  return $GoodsReceiptStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
