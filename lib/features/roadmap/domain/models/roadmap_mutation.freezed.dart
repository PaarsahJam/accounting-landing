// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_mutation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoadmapMutation {

 String get id; String get roadmapItemId; String get roadmapItemTitle; List<FinancialImpact> get impacts; List<RoadmapAction> get actions; MutationKind get kind; DateTime get plannedDate; String get performedBy;
/// Create a copy of RoadmapMutation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapMutationCopyWith<RoadmapMutation> get copyWith => _$RoadmapMutationCopyWithImpl<RoadmapMutation>(this as RoadmapMutation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapMutation&&(identical(other.id, id) || other.id == id)&&(identical(other.roadmapItemId, roadmapItemId) || other.roadmapItemId == roadmapItemId)&&(identical(other.roadmapItemTitle, roadmapItemTitle) || other.roadmapItemTitle == roadmapItemTitle)&&const DeepCollectionEquality().equals(other.impacts, impacts)&&const DeepCollectionEquality().equals(other.actions, actions)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.performedBy, performedBy) || other.performedBy == performedBy));
}


@override
int get hashCode => Object.hash(runtimeType,id,roadmapItemId,roadmapItemTitle,const DeepCollectionEquality().hash(impacts),const DeepCollectionEquality().hash(actions),kind,plannedDate,performedBy);

@override
String toString() {
  return 'RoadmapMutation(id: $id, roadmapItemId: $roadmapItemId, roadmapItemTitle: $roadmapItemTitle, impacts: $impacts, actions: $actions, kind: $kind, plannedDate: $plannedDate, performedBy: $performedBy)';
}


}

/// @nodoc
abstract mixin class $RoadmapMutationCopyWith<$Res>  {
  factory $RoadmapMutationCopyWith(RoadmapMutation value, $Res Function(RoadmapMutation) _then) = _$RoadmapMutationCopyWithImpl;
@useResult
$Res call({
 String id, String roadmapItemId, String roadmapItemTitle, List<FinancialImpact> impacts, List<RoadmapAction> actions, MutationKind kind, DateTime plannedDate, String performedBy
});




}
/// @nodoc
class _$RoadmapMutationCopyWithImpl<$Res>
    implements $RoadmapMutationCopyWith<$Res> {
  _$RoadmapMutationCopyWithImpl(this._self, this._then);

  final RoadmapMutation _self;
  final $Res Function(RoadmapMutation) _then;

/// Create a copy of RoadmapMutation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roadmapItemId = null,Object? roadmapItemTitle = null,Object? impacts = null,Object? actions = null,Object? kind = null,Object? plannedDate = null,Object? performedBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roadmapItemId: null == roadmapItemId ? _self.roadmapItemId : roadmapItemId // ignore: cast_nullable_to_non_nullable
as String,roadmapItemTitle: null == roadmapItemTitle ? _self.roadmapItemTitle : roadmapItemTitle // ignore: cast_nullable_to_non_nullable
as String,impacts: null == impacts ? _self.impacts : impacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoadmapAction>,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MutationKind,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,performedBy: null == performedBy ? _self.performedBy : performedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadmapMutation].
extension RoadmapMutationPatterns on RoadmapMutation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapMutation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapMutation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapMutation value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapMutation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapMutation value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapMutation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roadmapItemId,  String roadmapItemTitle,  List<FinancialImpact> impacts,  List<RoadmapAction> actions,  MutationKind kind,  DateTime plannedDate,  String performedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapMutation() when $default != null:
return $default(_that.id,_that.roadmapItemId,_that.roadmapItemTitle,_that.impacts,_that.actions,_that.kind,_that.plannedDate,_that.performedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roadmapItemId,  String roadmapItemTitle,  List<FinancialImpact> impacts,  List<RoadmapAction> actions,  MutationKind kind,  DateTime plannedDate,  String performedBy)  $default,) {final _that = this;
switch (_that) {
case _RoadmapMutation():
return $default(_that.id,_that.roadmapItemId,_that.roadmapItemTitle,_that.impacts,_that.actions,_that.kind,_that.plannedDate,_that.performedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roadmapItemId,  String roadmapItemTitle,  List<FinancialImpact> impacts,  List<RoadmapAction> actions,  MutationKind kind,  DateTime plannedDate,  String performedBy)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapMutation() when $default != null:
return $default(_that.id,_that.roadmapItemId,_that.roadmapItemTitle,_that.impacts,_that.actions,_that.kind,_that.plannedDate,_that.performedBy);case _:
  return null;

}
}

}

/// @nodoc


class _RoadmapMutation extends RoadmapMutation {
  const _RoadmapMutation({required this.id, required this.roadmapItemId, required this.roadmapItemTitle, required final  List<FinancialImpact> impacts, required final  List<RoadmapAction> actions, required this.kind, required this.plannedDate, required this.performedBy}): _impacts = impacts,_actions = actions,super._();
  

@override final  String id;
@override final  String roadmapItemId;
@override final  String roadmapItemTitle;
 final  List<FinancialImpact> _impacts;
@override List<FinancialImpact> get impacts {
  if (_impacts is EqualUnmodifiableListView) return _impacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_impacts);
}

 final  List<RoadmapAction> _actions;
@override List<RoadmapAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

@override final  MutationKind kind;
@override final  DateTime plannedDate;
@override final  String performedBy;

/// Create a copy of RoadmapMutation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapMutationCopyWith<_RoadmapMutation> get copyWith => __$RoadmapMutationCopyWithImpl<_RoadmapMutation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapMutation&&(identical(other.id, id) || other.id == id)&&(identical(other.roadmapItemId, roadmapItemId) || other.roadmapItemId == roadmapItemId)&&(identical(other.roadmapItemTitle, roadmapItemTitle) || other.roadmapItemTitle == roadmapItemTitle)&&const DeepCollectionEquality().equals(other._impacts, _impacts)&&const DeepCollectionEquality().equals(other._actions, _actions)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.performedBy, performedBy) || other.performedBy == performedBy));
}


@override
int get hashCode => Object.hash(runtimeType,id,roadmapItemId,roadmapItemTitle,const DeepCollectionEquality().hash(_impacts),const DeepCollectionEquality().hash(_actions),kind,plannedDate,performedBy);

@override
String toString() {
  return 'RoadmapMutation(id: $id, roadmapItemId: $roadmapItemId, roadmapItemTitle: $roadmapItemTitle, impacts: $impacts, actions: $actions, kind: $kind, plannedDate: $plannedDate, performedBy: $performedBy)';
}


}

/// @nodoc
abstract mixin class _$RoadmapMutationCopyWith<$Res> implements $RoadmapMutationCopyWith<$Res> {
  factory _$RoadmapMutationCopyWith(_RoadmapMutation value, $Res Function(_RoadmapMutation) _then) = __$RoadmapMutationCopyWithImpl;
@override @useResult
$Res call({
 String id, String roadmapItemId, String roadmapItemTitle, List<FinancialImpact> impacts, List<RoadmapAction> actions, MutationKind kind, DateTime plannedDate, String performedBy
});




}
/// @nodoc
class __$RoadmapMutationCopyWithImpl<$Res>
    implements _$RoadmapMutationCopyWith<$Res> {
  __$RoadmapMutationCopyWithImpl(this._self, this._then);

  final _RoadmapMutation _self;
  final $Res Function(_RoadmapMutation) _then;

/// Create a copy of RoadmapMutation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roadmapItemId = null,Object? roadmapItemTitle = null,Object? impacts = null,Object? actions = null,Object? kind = null,Object? plannedDate = null,Object? performedBy = null,}) {
  return _then(_RoadmapMutation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roadmapItemId: null == roadmapItemId ? _self.roadmapItemId : roadmapItemId // ignore: cast_nullable_to_non_nullable
as String,roadmapItemTitle: null == roadmapItemTitle ? _self.roadmapItemTitle : roadmapItemTitle // ignore: cast_nullable_to_non_nullable
as String,impacts: null == impacts ? _self._impacts : impacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoadmapAction>,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as MutationKind,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,performedBy: null == performedBy ? _self.performedBy : performedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
