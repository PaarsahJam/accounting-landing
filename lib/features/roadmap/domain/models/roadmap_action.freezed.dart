// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoadmapAction {

 String get id; String get label; RoadmapActionType get type; List<String> get targetAccountIds; double? get amount; String? get description; bool get requiresConfirmation;
/// Create a copy of RoadmapAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapActionCopyWith<RoadmapAction> get copyWith => _$RoadmapActionCopyWithImpl<RoadmapAction>(this as RoadmapAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapAction&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.targetAccountIds, targetAccountIds)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,type,const DeepCollectionEquality().hash(targetAccountIds),amount,description,requiresConfirmation);

@override
String toString() {
  return 'RoadmapAction(id: $id, label: $label, type: $type, targetAccountIds: $targetAccountIds, amount: $amount, description: $description, requiresConfirmation: $requiresConfirmation)';
}


}

/// @nodoc
abstract mixin class $RoadmapActionCopyWith<$Res>  {
  factory $RoadmapActionCopyWith(RoadmapAction value, $Res Function(RoadmapAction) _then) = _$RoadmapActionCopyWithImpl;
@useResult
$Res call({
 String id, String label, RoadmapActionType type, List<String> targetAccountIds, double? amount, String? description, bool requiresConfirmation
});




}
/// @nodoc
class _$RoadmapActionCopyWithImpl<$Res>
    implements $RoadmapActionCopyWith<$Res> {
  _$RoadmapActionCopyWithImpl(this._self, this._then);

  final RoadmapAction _self;
  final $Res Function(RoadmapAction) _then;

/// Create a copy of RoadmapAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? type = null,Object? targetAccountIds = null,Object? amount = freezed,Object? description = freezed,Object? requiresConfirmation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RoadmapActionType,targetAccountIds: null == targetAccountIds ? _self.targetAccountIds : targetAccountIds // ignore: cast_nullable_to_non_nullable
as List<String>,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadmapAction].
extension RoadmapActionPatterns on RoadmapAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapAction value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapAction value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  RoadmapActionType type,  List<String> targetAccountIds,  double? amount,  String? description,  bool requiresConfirmation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapAction() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.targetAccountIds,_that.amount,_that.description,_that.requiresConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  RoadmapActionType type,  List<String> targetAccountIds,  double? amount,  String? description,  bool requiresConfirmation)  $default,) {final _that = this;
switch (_that) {
case _RoadmapAction():
return $default(_that.id,_that.label,_that.type,_that.targetAccountIds,_that.amount,_that.description,_that.requiresConfirmation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  RoadmapActionType type,  List<String> targetAccountIds,  double? amount,  String? description,  bool requiresConfirmation)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapAction() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.targetAccountIds,_that.amount,_that.description,_that.requiresConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class _RoadmapAction extends RoadmapAction {
  const _RoadmapAction({required this.id, required this.label, required this.type, required final  List<String> targetAccountIds, this.amount, this.description, required this.requiresConfirmation}): _targetAccountIds = targetAccountIds,super._();
  

@override final  String id;
@override final  String label;
@override final  RoadmapActionType type;
 final  List<String> _targetAccountIds;
@override List<String> get targetAccountIds {
  if (_targetAccountIds is EqualUnmodifiableListView) return _targetAccountIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetAccountIds);
}

@override final  double? amount;
@override final  String? description;
@override final  bool requiresConfirmation;

/// Create a copy of RoadmapAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapActionCopyWith<_RoadmapAction> get copyWith => __$RoadmapActionCopyWithImpl<_RoadmapAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapAction&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._targetAccountIds, _targetAccountIds)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,type,const DeepCollectionEquality().hash(_targetAccountIds),amount,description,requiresConfirmation);

@override
String toString() {
  return 'RoadmapAction(id: $id, label: $label, type: $type, targetAccountIds: $targetAccountIds, amount: $amount, description: $description, requiresConfirmation: $requiresConfirmation)';
}


}

/// @nodoc
abstract mixin class _$RoadmapActionCopyWith<$Res> implements $RoadmapActionCopyWith<$Res> {
  factory _$RoadmapActionCopyWith(_RoadmapAction value, $Res Function(_RoadmapAction) _then) = __$RoadmapActionCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, RoadmapActionType type, List<String> targetAccountIds, double? amount, String? description, bool requiresConfirmation
});




}
/// @nodoc
class __$RoadmapActionCopyWithImpl<$Res>
    implements _$RoadmapActionCopyWith<$Res> {
  __$RoadmapActionCopyWithImpl(this._self, this._then);

  final _RoadmapAction _self;
  final $Res Function(_RoadmapAction) _then;

/// Create a copy of RoadmapAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? type = null,Object? targetAccountIds = null,Object? amount = freezed,Object? description = freezed,Object? requiresConfirmation = null,}) {
  return _then(_RoadmapAction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RoadmapActionType,targetAccountIds: null == targetAccountIds ? _self._targetAccountIds : targetAccountIds // ignore: cast_nullable_to_non_nullable
as List<String>,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
