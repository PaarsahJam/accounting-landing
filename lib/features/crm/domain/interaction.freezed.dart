// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Interaction {

 String get id; String get contactId; String get customerId; InteractionType get type; String get subject; String get description; DateTime get occurredAt; String get performedBy; DateTime get createdAt;
/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InteractionCopyWith<Interaction> get copyWith => _$InteractionCopyWithImpl<Interaction>(this as Interaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interaction&&(identical(other.id, id) || other.id == id)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.performedBy, performedBy) || other.performedBy == performedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,contactId,customerId,type,subject,description,occurredAt,performedBy,createdAt);

@override
String toString() {
  return 'Interaction(id: $id, contactId: $contactId, customerId: $customerId, type: $type, subject: $subject, description: $description, occurredAt: $occurredAt, performedBy: $performedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InteractionCopyWith<$Res>  {
  factory $InteractionCopyWith(Interaction value, $Res Function(Interaction) _then) = _$InteractionCopyWithImpl;
@useResult
$Res call({
 String id, String contactId, String customerId, InteractionType type, String subject, String description, DateTime occurredAt, String performedBy, DateTime createdAt
});




}
/// @nodoc
class _$InteractionCopyWithImpl<$Res>
    implements $InteractionCopyWith<$Res> {
  _$InteractionCopyWithImpl(this._self, this._then);

  final Interaction _self;
  final $Res Function(Interaction) _then;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? contactId = null,Object? customerId = null,Object? type = null,Object? subject = null,Object? description = null,Object? occurredAt = null,Object? performedBy = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InteractionType,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,performedBy: null == performedBy ? _self.performedBy : performedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Interaction].
extension InteractionPatterns on Interaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interaction value)  $default,){
final _that = this;
switch (_that) {
case _Interaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interaction value)?  $default,){
final _that = this;
switch (_that) {
case _Interaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String contactId,  String customerId,  InteractionType type,  String subject,  String description,  DateTime occurredAt,  String performedBy,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interaction() when $default != null:
return $default(_that.id,_that.contactId,_that.customerId,_that.type,_that.subject,_that.description,_that.occurredAt,_that.performedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String contactId,  String customerId,  InteractionType type,  String subject,  String description,  DateTime occurredAt,  String performedBy,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Interaction():
return $default(_that.id,_that.contactId,_that.customerId,_that.type,_that.subject,_that.description,_that.occurredAt,_that.performedBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String contactId,  String customerId,  InteractionType type,  String subject,  String description,  DateTime occurredAt,  String performedBy,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Interaction() when $default != null:
return $default(_that.id,_that.contactId,_that.customerId,_that.type,_that.subject,_that.description,_that.occurredAt,_that.performedBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Interaction implements Interaction {
  const _Interaction({required this.id, required this.contactId, required this.customerId, required this.type, required this.subject, required this.description, required this.occurredAt, required this.performedBy, required this.createdAt});
  

@override final  String id;
@override final  String contactId;
@override final  String customerId;
@override final  InteractionType type;
@override final  String subject;
@override final  String description;
@override final  DateTime occurredAt;
@override final  String performedBy;
@override final  DateTime createdAt;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InteractionCopyWith<_Interaction> get copyWith => __$InteractionCopyWithImpl<_Interaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interaction&&(identical(other.id, id) || other.id == id)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.type, type) || other.type == type)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.performedBy, performedBy) || other.performedBy == performedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,contactId,customerId,type,subject,description,occurredAt,performedBy,createdAt);

@override
String toString() {
  return 'Interaction(id: $id, contactId: $contactId, customerId: $customerId, type: $type, subject: $subject, description: $description, occurredAt: $occurredAt, performedBy: $performedBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InteractionCopyWith<$Res> implements $InteractionCopyWith<$Res> {
  factory _$InteractionCopyWith(_Interaction value, $Res Function(_Interaction) _then) = __$InteractionCopyWithImpl;
@override @useResult
$Res call({
 String id, String contactId, String customerId, InteractionType type, String subject, String description, DateTime occurredAt, String performedBy, DateTime createdAt
});




}
/// @nodoc
class __$InteractionCopyWithImpl<$Res>
    implements _$InteractionCopyWith<$Res> {
  __$InteractionCopyWithImpl(this._self, this._then);

  final _Interaction _self;
  final $Res Function(_Interaction) _then;

/// Create a copy of Interaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? contactId = null,Object? customerId = null,Object? type = null,Object? subject = null,Object? description = null,Object? occurredAt = null,Object? performedBy = null,Object? createdAt = null,}) {
  return _then(_Interaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InteractionType,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,performedBy: null == performedBy ? _self.performedBy : performedBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
