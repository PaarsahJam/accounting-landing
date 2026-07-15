// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseAttachment {

 String get id; String get name; String get mimeType; int get sizeInBytes; String get uri; DateTime get uploadedAt;
/// Create a copy of ExpenseAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseAttachmentCopyWith<ExpenseAttachment> get copyWith => _$ExpenseAttachmentCopyWithImpl<ExpenseAttachment>(this as ExpenseAttachment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeInBytes, sizeInBytes) || other.sizeInBytes == sizeInBytes)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,mimeType,sizeInBytes,uri,uploadedAt);

@override
String toString() {
  return 'ExpenseAttachment(id: $id, name: $name, mimeType: $mimeType, sizeInBytes: $sizeInBytes, uri: $uri, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class $ExpenseAttachmentCopyWith<$Res>  {
  factory $ExpenseAttachmentCopyWith(ExpenseAttachment value, $Res Function(ExpenseAttachment) _then) = _$ExpenseAttachmentCopyWithImpl;
@useResult
$Res call({
 String id, String name, String mimeType, int sizeInBytes, String uri, DateTime uploadedAt
});




}
/// @nodoc
class _$ExpenseAttachmentCopyWithImpl<$Res>
    implements $ExpenseAttachmentCopyWith<$Res> {
  _$ExpenseAttachmentCopyWithImpl(this._self, this._then);

  final ExpenseAttachment _self;
  final $Res Function(ExpenseAttachment) _then;

/// Create a copy of ExpenseAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? mimeType = null,Object? sizeInBytes = null,Object? uri = null,Object? uploadedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeInBytes: null == sizeInBytes ? _self.sizeInBytes : sizeInBytes // ignore: cast_nullable_to_non_nullable
as int,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseAttachment].
extension ExpenseAttachmentPatterns on ExpenseAttachment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseAttachment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseAttachment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseAttachment value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseAttachment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseAttachment value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseAttachment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String mimeType,  int sizeInBytes,  String uri,  DateTime uploadedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseAttachment() when $default != null:
return $default(_that.id,_that.name,_that.mimeType,_that.sizeInBytes,_that.uri,_that.uploadedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String mimeType,  int sizeInBytes,  String uri,  DateTime uploadedAt)  $default,) {final _that = this;
switch (_that) {
case _ExpenseAttachment():
return $default(_that.id,_that.name,_that.mimeType,_that.sizeInBytes,_that.uri,_that.uploadedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String mimeType,  int sizeInBytes,  String uri,  DateTime uploadedAt)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseAttachment() when $default != null:
return $default(_that.id,_that.name,_that.mimeType,_that.sizeInBytes,_that.uri,_that.uploadedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseAttachment implements ExpenseAttachment {
  const _ExpenseAttachment({required this.id, required this.name, required this.mimeType, required this.sizeInBytes, required this.uri, required this.uploadedAt});
  

@override final  String id;
@override final  String name;
@override final  String mimeType;
@override final  int sizeInBytes;
@override final  String uri;
@override final  DateTime uploadedAt;

/// Create a copy of ExpenseAttachment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseAttachmentCopyWith<_ExpenseAttachment> get copyWith => __$ExpenseAttachmentCopyWithImpl<_ExpenseAttachment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeInBytes, sizeInBytes) || other.sizeInBytes == sizeInBytes)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,mimeType,sizeInBytes,uri,uploadedAt);

@override
String toString() {
  return 'ExpenseAttachment(id: $id, name: $name, mimeType: $mimeType, sizeInBytes: $sizeInBytes, uri: $uri, uploadedAt: $uploadedAt)';
}


}

/// @nodoc
abstract mixin class _$ExpenseAttachmentCopyWith<$Res> implements $ExpenseAttachmentCopyWith<$Res> {
  factory _$ExpenseAttachmentCopyWith(_ExpenseAttachment value, $Res Function(_ExpenseAttachment) _then) = __$ExpenseAttachmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String mimeType, int sizeInBytes, String uri, DateTime uploadedAt
});




}
/// @nodoc
class __$ExpenseAttachmentCopyWithImpl<$Res>
    implements _$ExpenseAttachmentCopyWith<$Res> {
  __$ExpenseAttachmentCopyWithImpl(this._self, this._then);

  final _ExpenseAttachment _self;
  final $Res Function(_ExpenseAttachment) _then;

/// Create a copy of ExpenseAttachment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? mimeType = null,Object? sizeInBytes = null,Object? uri = null,Object? uploadedAt = null,}) {
  return _then(_ExpenseAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeInBytes: null == sizeInBytes ? _self.sizeInBytes : sizeInBytes // ignore: cast_nullable_to_non_nullable
as int,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
