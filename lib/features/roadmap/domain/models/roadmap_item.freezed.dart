// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoadmapItem {

 String get id; String get title; String get description; RoadmapStatus get status; List<RoadmapAction> get actions; List<FinancialImpact> get financialImpacts; DateTime get createdAt; DateTime get updatedAt; String? get proposedBy; bool get requiresConfirmation;
/// Create a copy of RoadmapItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapItemCopyWith<RoadmapItem> get copyWith => _$RoadmapItemCopyWithImpl<RoadmapItem>(this as RoadmapItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.actions, actions)&&const DeepCollectionEquality().equals(other.financialImpacts, financialImpacts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.proposedBy, proposedBy) || other.proposedBy == proposedBy)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,const DeepCollectionEquality().hash(actions),const DeepCollectionEquality().hash(financialImpacts),createdAt,updatedAt,proposedBy,requiresConfirmation);

@override
String toString() {
  return 'RoadmapItem(id: $id, title: $title, description: $description, status: $status, actions: $actions, financialImpacts: $financialImpacts, createdAt: $createdAt, updatedAt: $updatedAt, proposedBy: $proposedBy, requiresConfirmation: $requiresConfirmation)';
}


}

/// @nodoc
abstract mixin class $RoadmapItemCopyWith<$Res>  {
  factory $RoadmapItemCopyWith(RoadmapItem value, $Res Function(RoadmapItem) _then) = _$RoadmapItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, RoadmapStatus status, List<RoadmapAction> actions, List<FinancialImpact> financialImpacts, DateTime createdAt, DateTime updatedAt, String? proposedBy, bool requiresConfirmation
});




}
/// @nodoc
class _$RoadmapItemCopyWithImpl<$Res>
    implements $RoadmapItemCopyWith<$Res> {
  _$RoadmapItemCopyWithImpl(this._self, this._then);

  final RoadmapItem _self;
  final $Res Function(RoadmapItem) _then;

/// Create a copy of RoadmapItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? status = null,Object? actions = null,Object? financialImpacts = null,Object? createdAt = null,Object? updatedAt = null,Object? proposedBy = freezed,Object? requiresConfirmation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoadmapStatus,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoadmapAction>,financialImpacts: null == financialImpacts ? _self.financialImpacts : financialImpacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,proposedBy: freezed == proposedBy ? _self.proposedBy : proposedBy // ignore: cast_nullable_to_non_nullable
as String?,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadmapItem].
extension RoadmapItemPatterns on RoadmapItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapItem value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapItem value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  RoadmapStatus status,  List<RoadmapAction> actions,  List<FinancialImpact> financialImpacts,  DateTime createdAt,  DateTime updatedAt,  String? proposedBy,  bool requiresConfirmation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapItem() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.status,_that.actions,_that.financialImpacts,_that.createdAt,_that.updatedAt,_that.proposedBy,_that.requiresConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  RoadmapStatus status,  List<RoadmapAction> actions,  List<FinancialImpact> financialImpacts,  DateTime createdAt,  DateTime updatedAt,  String? proposedBy,  bool requiresConfirmation)  $default,) {final _that = this;
switch (_that) {
case _RoadmapItem():
return $default(_that.id,_that.title,_that.description,_that.status,_that.actions,_that.financialImpacts,_that.createdAt,_that.updatedAt,_that.proposedBy,_that.requiresConfirmation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  RoadmapStatus status,  List<RoadmapAction> actions,  List<FinancialImpact> financialImpacts,  DateTime createdAt,  DateTime updatedAt,  String? proposedBy,  bool requiresConfirmation)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapItem() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.status,_that.actions,_that.financialImpacts,_that.createdAt,_that.updatedAt,_that.proposedBy,_that.requiresConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class _RoadmapItem extends RoadmapItem {
  const _RoadmapItem({required this.id, required this.title, required this.description, required this.status, required final  List<RoadmapAction> actions, required final  List<FinancialImpact> financialImpacts, required this.createdAt, required this.updatedAt, this.proposedBy, required this.requiresConfirmation}): _actions = actions,_financialImpacts = financialImpacts,super._();
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  RoadmapStatus status;
 final  List<RoadmapAction> _actions;
@override List<RoadmapAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

 final  List<FinancialImpact> _financialImpacts;
@override List<FinancialImpact> get financialImpacts {
  if (_financialImpacts is EqualUnmodifiableListView) return _financialImpacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_financialImpacts);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? proposedBy;
@override final  bool requiresConfirmation;

/// Create a copy of RoadmapItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapItemCopyWith<_RoadmapItem> get copyWith => __$RoadmapItemCopyWithImpl<_RoadmapItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._actions, _actions)&&const DeepCollectionEquality().equals(other._financialImpacts, _financialImpacts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.proposedBy, proposedBy) || other.proposedBy == proposedBy)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,status,const DeepCollectionEquality().hash(_actions),const DeepCollectionEquality().hash(_financialImpacts),createdAt,updatedAt,proposedBy,requiresConfirmation);

@override
String toString() {
  return 'RoadmapItem(id: $id, title: $title, description: $description, status: $status, actions: $actions, financialImpacts: $financialImpacts, createdAt: $createdAt, updatedAt: $updatedAt, proposedBy: $proposedBy, requiresConfirmation: $requiresConfirmation)';
}


}

/// @nodoc
abstract mixin class _$RoadmapItemCopyWith<$Res> implements $RoadmapItemCopyWith<$Res> {
  factory _$RoadmapItemCopyWith(_RoadmapItem value, $Res Function(_RoadmapItem) _then) = __$RoadmapItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, RoadmapStatus status, List<RoadmapAction> actions, List<FinancialImpact> financialImpacts, DateTime createdAt, DateTime updatedAt, String? proposedBy, bool requiresConfirmation
});




}
/// @nodoc
class __$RoadmapItemCopyWithImpl<$Res>
    implements _$RoadmapItemCopyWith<$Res> {
  __$RoadmapItemCopyWithImpl(this._self, this._then);

  final _RoadmapItem _self;
  final $Res Function(_RoadmapItem) _then;

/// Create a copy of RoadmapItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? status = null,Object? actions = null,Object? financialImpacts = null,Object? createdAt = null,Object? updatedAt = null,Object? proposedBy = freezed,Object? requiresConfirmation = null,}) {
  return _then(_RoadmapItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoadmapStatus,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<RoadmapAction>,financialImpacts: null == financialImpacts ? _self._financialImpacts : financialImpacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,proposedBy: freezed == proposedBy ? _self.proposedBy : proposedBy // ignore: cast_nullable_to_non_nullable
as String?,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
