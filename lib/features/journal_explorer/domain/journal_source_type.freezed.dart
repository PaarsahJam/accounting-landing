// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_source_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalSourceType {

 String get id; String get label;
/// Create a copy of JournalSourceType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalSourceTypeCopyWith<JournalSourceType> get copyWith => _$JournalSourceTypeCopyWithImpl<JournalSourceType>(this as JournalSourceType, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalSourceType&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'JournalSourceType(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $JournalSourceTypeCopyWith<$Res>  {
  factory $JournalSourceTypeCopyWith(JournalSourceType value, $Res Function(JournalSourceType) _then) = _$JournalSourceTypeCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$JournalSourceTypeCopyWithImpl<$Res>
    implements $JournalSourceTypeCopyWith<$Res> {
  _$JournalSourceTypeCopyWithImpl(this._self, this._then);

  final JournalSourceType _self;
  final $Res Function(JournalSourceType) _then;

/// Create a copy of JournalSourceType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalSourceType].
extension JournalSourceTypePatterns on JournalSourceType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalSourceType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalSourceType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalSourceType value)  $default,){
final _that = this;
switch (_that) {
case _JournalSourceType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalSourceType value)?  $default,){
final _that = this;
switch (_that) {
case _JournalSourceType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalSourceType() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label)  $default,) {final _that = this;
switch (_that) {
case _JournalSourceType():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _JournalSourceType() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _JournalSourceType implements JournalSourceType {
  const _JournalSourceType({required this.id, required this.label});
  

@override final  String id;
@override final  String label;

/// Create a copy of JournalSourceType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalSourceTypeCopyWith<_JournalSourceType> get copyWith => __$JournalSourceTypeCopyWithImpl<_JournalSourceType>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalSourceType&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'JournalSourceType(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$JournalSourceTypeCopyWith<$Res> implements $JournalSourceTypeCopyWith<$Res> {
  factory _$JournalSourceTypeCopyWith(_JournalSourceType value, $Res Function(_JournalSourceType) _then) = __$JournalSourceTypeCopyWithImpl;
@override @useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class __$JournalSourceTypeCopyWithImpl<$Res>
    implements _$JournalSourceTypeCopyWith<$Res> {
  __$JournalSourceTypeCopyWithImpl(this._self, this._then);

  final _JournalSourceType _self;
  final $Res Function(_JournalSourceType) _then;

/// Create a copy of JournalSourceType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_JournalSourceType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
