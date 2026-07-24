// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_mutation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoadmapMutationRequest {

 RoadmapItem get item; RoadmapMutation get mutation; bool get isDestructive; bool get isPosting; String get confirmationToken; String get requestedBy;
/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapMutationRequestCopyWith<RoadmapMutationRequest> get copyWith => _$RoadmapMutationRequestCopyWithImpl<RoadmapMutationRequest>(this as RoadmapMutationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapMutationRequest&&(identical(other.item, item) || other.item == item)&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.isDestructive, isDestructive) || other.isDestructive == isDestructive)&&(identical(other.isPosting, isPosting) || other.isPosting == isPosting)&&(identical(other.confirmationToken, confirmationToken) || other.confirmationToken == confirmationToken)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy));
}


@override
int get hashCode => Object.hash(runtimeType,item,mutation,isDestructive,isPosting,confirmationToken,requestedBy);

@override
String toString() {
  return 'RoadmapMutationRequest(item: $item, mutation: $mutation, isDestructive: $isDestructive, isPosting: $isPosting, confirmationToken: $confirmationToken, requestedBy: $requestedBy)';
}


}

/// @nodoc
abstract mixin class $RoadmapMutationRequestCopyWith<$Res>  {
  factory $RoadmapMutationRequestCopyWith(RoadmapMutationRequest value, $Res Function(RoadmapMutationRequest) _then) = _$RoadmapMutationRequestCopyWithImpl;
@useResult
$Res call({
 RoadmapItem item, RoadmapMutation mutation, bool isDestructive, bool isPosting, String confirmationToken, String requestedBy
});


$RoadmapItemCopyWith<$Res> get item;$RoadmapMutationCopyWith<$Res> get mutation;

}
/// @nodoc
class _$RoadmapMutationRequestCopyWithImpl<$Res>
    implements $RoadmapMutationRequestCopyWith<$Res> {
  _$RoadmapMutationRequestCopyWithImpl(this._self, this._then);

  final RoadmapMutationRequest _self;
  final $Res Function(RoadmapMutationRequest) _then;

/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,Object? mutation = null,Object? isDestructive = null,Object? isPosting = null,Object? confirmationToken = null,Object? requestedBy = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RoadmapItem,mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as RoadmapMutation,isDestructive: null == isDestructive ? _self.isDestructive : isDestructive // ignore: cast_nullable_to_non_nullable
as bool,isPosting: null == isPosting ? _self.isPosting : isPosting // ignore: cast_nullable_to_non_nullable
as bool,confirmationToken: null == confirmationToken ? _self.confirmationToken : confirmationToken // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapItemCopyWith<$Res> get item {
  
  return $RoadmapItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapMutationCopyWith<$Res> get mutation {
  
  return $RoadmapMutationCopyWith<$Res>(_self.mutation, (value) {
    return _then(_self.copyWith(mutation: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoadmapMutationRequest].
extension RoadmapMutationRequestPatterns on RoadmapMutationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapMutationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapMutationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapMutationRequest value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapMutationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapMutationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapMutationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoadmapItem item,  RoadmapMutation mutation,  bool isDestructive,  bool isPosting,  String confirmationToken,  String requestedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapMutationRequest() when $default != null:
return $default(_that.item,_that.mutation,_that.isDestructive,_that.isPosting,_that.confirmationToken,_that.requestedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoadmapItem item,  RoadmapMutation mutation,  bool isDestructive,  bool isPosting,  String confirmationToken,  String requestedBy)  $default,) {final _that = this;
switch (_that) {
case _RoadmapMutationRequest():
return $default(_that.item,_that.mutation,_that.isDestructive,_that.isPosting,_that.confirmationToken,_that.requestedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoadmapItem item,  RoadmapMutation mutation,  bool isDestructive,  bool isPosting,  String confirmationToken,  String requestedBy)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapMutationRequest() when $default != null:
return $default(_that.item,_that.mutation,_that.isDestructive,_that.isPosting,_that.confirmationToken,_that.requestedBy);case _:
  return null;

}
}

}

/// @nodoc


class _RoadmapMutationRequest extends RoadmapMutationRequest {
  const _RoadmapMutationRequest({required this.item, required this.mutation, required this.isDestructive, required this.isPosting, required this.confirmationToken, required this.requestedBy}): super._();
  

@override final  RoadmapItem item;
@override final  RoadmapMutation mutation;
@override final  bool isDestructive;
@override final  bool isPosting;
@override final  String confirmationToken;
@override final  String requestedBy;

/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapMutationRequestCopyWith<_RoadmapMutationRequest> get copyWith => __$RoadmapMutationRequestCopyWithImpl<_RoadmapMutationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapMutationRequest&&(identical(other.item, item) || other.item == item)&&(identical(other.mutation, mutation) || other.mutation == mutation)&&(identical(other.isDestructive, isDestructive) || other.isDestructive == isDestructive)&&(identical(other.isPosting, isPosting) || other.isPosting == isPosting)&&(identical(other.confirmationToken, confirmationToken) || other.confirmationToken == confirmationToken)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy));
}


@override
int get hashCode => Object.hash(runtimeType,item,mutation,isDestructive,isPosting,confirmationToken,requestedBy);

@override
String toString() {
  return 'RoadmapMutationRequest(item: $item, mutation: $mutation, isDestructive: $isDestructive, isPosting: $isPosting, confirmationToken: $confirmationToken, requestedBy: $requestedBy)';
}


}

/// @nodoc
abstract mixin class _$RoadmapMutationRequestCopyWith<$Res> implements $RoadmapMutationRequestCopyWith<$Res> {
  factory _$RoadmapMutationRequestCopyWith(_RoadmapMutationRequest value, $Res Function(_RoadmapMutationRequest) _then) = __$RoadmapMutationRequestCopyWithImpl;
@override @useResult
$Res call({
 RoadmapItem item, RoadmapMutation mutation, bool isDestructive, bool isPosting, String confirmationToken, String requestedBy
});


@override $RoadmapItemCopyWith<$Res> get item;@override $RoadmapMutationCopyWith<$Res> get mutation;

}
/// @nodoc
class __$RoadmapMutationRequestCopyWithImpl<$Res>
    implements _$RoadmapMutationRequestCopyWith<$Res> {
  __$RoadmapMutationRequestCopyWithImpl(this._self, this._then);

  final _RoadmapMutationRequest _self;
  final $Res Function(_RoadmapMutationRequest) _then;

/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? mutation = null,Object? isDestructive = null,Object? isPosting = null,Object? confirmationToken = null,Object? requestedBy = null,}) {
  return _then(_RoadmapMutationRequest(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RoadmapItem,mutation: null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as RoadmapMutation,isDestructive: null == isDestructive ? _self.isDestructive : isDestructive // ignore: cast_nullable_to_non_nullable
as bool,isPosting: null == isPosting ? _self.isPosting : isPosting // ignore: cast_nullable_to_non_nullable
as bool,confirmationToken: null == confirmationToken ? _self.confirmationToken : confirmationToken // ignore: cast_nullable_to_non_nullable
as String,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapItemCopyWith<$Res> get item {
  
  return $RoadmapItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}/// Create a copy of RoadmapMutationRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapMutationCopyWith<$Res> get mutation {
  
  return $RoadmapMutationCopyWith<$Res>(_self.mutation, (value) {
    return _then(_self.copyWith(mutation: value));
  });
}
}

// dart format on
