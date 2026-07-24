// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lead_opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeadOpportunity {

 String get id; String get customerId; String? get contactId; String get title; String get description; PipelineStage get stage; double get estimatedValue; double get probability; DateTime get expectedCloseDate; String get owner; DateTime get createdAt; DateTime? get wonAt;
/// Create a copy of LeadOpportunity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeadOpportunityCopyWith<LeadOpportunity> get copyWith => _$LeadOpportunityCopyWithImpl<LeadOpportunity>(this as LeadOpportunity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeadOpportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.estimatedValue, estimatedValue) || other.estimatedValue == estimatedValue)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.expectedCloseDate, expectedCloseDate) || other.expectedCloseDate == expectedCloseDate)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.wonAt, wonAt) || other.wonAt == wonAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,contactId,title,description,stage,estimatedValue,probability,expectedCloseDate,owner,createdAt,wonAt);

@override
String toString() {
  return 'LeadOpportunity(id: $id, customerId: $customerId, contactId: $contactId, title: $title, description: $description, stage: $stage, estimatedValue: $estimatedValue, probability: $probability, expectedCloseDate: $expectedCloseDate, owner: $owner, createdAt: $createdAt, wonAt: $wonAt)';
}


}

/// @nodoc
abstract mixin class $LeadOpportunityCopyWith<$Res>  {
  factory $LeadOpportunityCopyWith(LeadOpportunity value, $Res Function(LeadOpportunity) _then) = _$LeadOpportunityCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String? contactId, String title, String description, PipelineStage stage, double estimatedValue, double probability, DateTime expectedCloseDate, String owner, DateTime createdAt, DateTime? wonAt
});




}
/// @nodoc
class _$LeadOpportunityCopyWithImpl<$Res>
    implements $LeadOpportunityCopyWith<$Res> {
  _$LeadOpportunityCopyWithImpl(this._self, this._then);

  final LeadOpportunity _self;
  final $Res Function(LeadOpportunity) _then;

/// Create a copy of LeadOpportunity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? contactId = freezed,Object? title = null,Object? description = null,Object? stage = null,Object? estimatedValue = null,Object? probability = null,Object? expectedCloseDate = null,Object? owner = null,Object? createdAt = null,Object? wonAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PipelineStage,estimatedValue: null == estimatedValue ? _self.estimatedValue : estimatedValue // ignore: cast_nullable_to_non_nullable
as double,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,expectedCloseDate: null == expectedCloseDate ? _self.expectedCloseDate : expectedCloseDate // ignore: cast_nullable_to_non_nullable
as DateTime,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,wonAt: freezed == wonAt ? _self.wonAt : wonAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeadOpportunity].
extension LeadOpportunityPatterns on LeadOpportunity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeadOpportunity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeadOpportunity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeadOpportunity value)  $default,){
final _that = this;
switch (_that) {
case _LeadOpportunity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeadOpportunity value)?  $default,){
final _that = this;
switch (_that) {
case _LeadOpportunity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String? contactId,  String title,  String description,  PipelineStage stage,  double estimatedValue,  double probability,  DateTime expectedCloseDate,  String owner,  DateTime createdAt,  DateTime? wonAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeadOpportunity() when $default != null:
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.stage,_that.estimatedValue,_that.probability,_that.expectedCloseDate,_that.owner,_that.createdAt,_that.wonAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String? contactId,  String title,  String description,  PipelineStage stage,  double estimatedValue,  double probability,  DateTime expectedCloseDate,  String owner,  DateTime createdAt,  DateTime? wonAt)  $default,) {final _that = this;
switch (_that) {
case _LeadOpportunity():
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.stage,_that.estimatedValue,_that.probability,_that.expectedCloseDate,_that.owner,_that.createdAt,_that.wonAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String? contactId,  String title,  String description,  PipelineStage stage,  double estimatedValue,  double probability,  DateTime expectedCloseDate,  String owner,  DateTime createdAt,  DateTime? wonAt)?  $default,) {final _that = this;
switch (_that) {
case _LeadOpportunity() when $default != null:
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.stage,_that.estimatedValue,_that.probability,_that.expectedCloseDate,_that.owner,_that.createdAt,_that.wonAt);case _:
  return null;

}
}

}

/// @nodoc


class _LeadOpportunity implements LeadOpportunity {
  const _LeadOpportunity({required this.id, required this.customerId, this.contactId, required this.title, required this.description, required this.stage, required this.estimatedValue, required this.probability, required this.expectedCloseDate, required this.owner, required this.createdAt, this.wonAt});
  

@override final  String id;
@override final  String customerId;
@override final  String? contactId;
@override final  String title;
@override final  String description;
@override final  PipelineStage stage;
@override final  double estimatedValue;
@override final  double probability;
@override final  DateTime expectedCloseDate;
@override final  String owner;
@override final  DateTime createdAt;
@override final  DateTime? wonAt;

/// Create a copy of LeadOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeadOpportunityCopyWith<_LeadOpportunity> get copyWith => __$LeadOpportunityCopyWithImpl<_LeadOpportunity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeadOpportunity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.estimatedValue, estimatedValue) || other.estimatedValue == estimatedValue)&&(identical(other.probability, probability) || other.probability == probability)&&(identical(other.expectedCloseDate, expectedCloseDate) || other.expectedCloseDate == expectedCloseDate)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.wonAt, wonAt) || other.wonAt == wonAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,contactId,title,description,stage,estimatedValue,probability,expectedCloseDate,owner,createdAt,wonAt);

@override
String toString() {
  return 'LeadOpportunity(id: $id, customerId: $customerId, contactId: $contactId, title: $title, description: $description, stage: $stage, estimatedValue: $estimatedValue, probability: $probability, expectedCloseDate: $expectedCloseDate, owner: $owner, createdAt: $createdAt, wonAt: $wonAt)';
}


}

/// @nodoc
abstract mixin class _$LeadOpportunityCopyWith<$Res> implements $LeadOpportunityCopyWith<$Res> {
  factory _$LeadOpportunityCopyWith(_LeadOpportunity value, $Res Function(_LeadOpportunity) _then) = __$LeadOpportunityCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String? contactId, String title, String description, PipelineStage stage, double estimatedValue, double probability, DateTime expectedCloseDate, String owner, DateTime createdAt, DateTime? wonAt
});




}
/// @nodoc
class __$LeadOpportunityCopyWithImpl<$Res>
    implements _$LeadOpportunityCopyWith<$Res> {
  __$LeadOpportunityCopyWithImpl(this._self, this._then);

  final _LeadOpportunity _self;
  final $Res Function(_LeadOpportunity) _then;

/// Create a copy of LeadOpportunity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? contactId = freezed,Object? title = null,Object? description = null,Object? stage = null,Object? estimatedValue = null,Object? probability = null,Object? expectedCloseDate = null,Object? owner = null,Object? createdAt = null,Object? wonAt = freezed,}) {
  return _then(_LeadOpportunity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PipelineStage,estimatedValue: null == estimatedValue ? _self.estimatedValue : estimatedValue // ignore: cast_nullable_to_non_nullable
as double,probability: null == probability ? _self.probability : probability // ignore: cast_nullable_to_non_nullable
as double,expectedCloseDate: null == expectedCloseDate ? _self.expectedCloseDate : expectedCloseDate // ignore: cast_nullable_to_non_nullable
as DateTime,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,wonAt: freezed == wonAt ? _self.wonAt : wonAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
