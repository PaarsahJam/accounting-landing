// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoadmapPreview {

 RoadmapItem get item; List<FinancialImpact> get impacts; bool get isBalanced; List<String> get warnings; List<String> get risks; bool get requiresConfirmation; bool get canCommit;
/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapPreviewCopyWith<RoadmapPreview> get copyWith => _$RoadmapPreviewCopyWithImpl<RoadmapPreview>(this as RoadmapPreview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapPreview&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other.impacts, impacts)&&(identical(other.isBalanced, isBalanced) || other.isBalanced == isBalanced)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&const DeepCollectionEquality().equals(other.risks, risks)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation)&&(identical(other.canCommit, canCommit) || other.canCommit == canCommit));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(impacts),isBalanced,const DeepCollectionEquality().hash(warnings),const DeepCollectionEquality().hash(risks),requiresConfirmation,canCommit);

@override
String toString() {
  return 'RoadmapPreview(item: $item, impacts: $impacts, isBalanced: $isBalanced, warnings: $warnings, risks: $risks, requiresConfirmation: $requiresConfirmation, canCommit: $canCommit)';
}


}

/// @nodoc
abstract mixin class $RoadmapPreviewCopyWith<$Res>  {
  factory $RoadmapPreviewCopyWith(RoadmapPreview value, $Res Function(RoadmapPreview) _then) = _$RoadmapPreviewCopyWithImpl;
@useResult
$Res call({
 RoadmapItem item, List<FinancialImpact> impacts, bool isBalanced, List<String> warnings, List<String> risks, bool requiresConfirmation, bool canCommit
});


$RoadmapItemCopyWith<$Res> get item;

}
/// @nodoc
class _$RoadmapPreviewCopyWithImpl<$Res>
    implements $RoadmapPreviewCopyWith<$Res> {
  _$RoadmapPreviewCopyWithImpl(this._self, this._then);

  final RoadmapPreview _self;
  final $Res Function(RoadmapPreview) _then;

/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,Object? impacts = null,Object? isBalanced = null,Object? warnings = null,Object? risks = null,Object? requiresConfirmation = null,Object? canCommit = null,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RoadmapItem,impacts: null == impacts ? _self.impacts : impacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,isBalanced: null == isBalanced ? _self.isBalanced : isBalanced // ignore: cast_nullable_to_non_nullable
as bool,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as List<String>,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,canCommit: null == canCommit ? _self.canCommit : canCommit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapItemCopyWith<$Res> get item {
  
  return $RoadmapItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoadmapPreview].
extension RoadmapPreviewPatterns on RoadmapPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapPreview value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapPreview value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoadmapItem item,  List<FinancialImpact> impacts,  bool isBalanced,  List<String> warnings,  List<String> risks,  bool requiresConfirmation,  bool canCommit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapPreview() when $default != null:
return $default(_that.item,_that.impacts,_that.isBalanced,_that.warnings,_that.risks,_that.requiresConfirmation,_that.canCommit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoadmapItem item,  List<FinancialImpact> impacts,  bool isBalanced,  List<String> warnings,  List<String> risks,  bool requiresConfirmation,  bool canCommit)  $default,) {final _that = this;
switch (_that) {
case _RoadmapPreview():
return $default(_that.item,_that.impacts,_that.isBalanced,_that.warnings,_that.risks,_that.requiresConfirmation,_that.canCommit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoadmapItem item,  List<FinancialImpact> impacts,  bool isBalanced,  List<String> warnings,  List<String> risks,  bool requiresConfirmation,  bool canCommit)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapPreview() when $default != null:
return $default(_that.item,_that.impacts,_that.isBalanced,_that.warnings,_that.risks,_that.requiresConfirmation,_that.canCommit);case _:
  return null;

}
}

}

/// @nodoc


class _RoadmapPreview extends RoadmapPreview {
  const _RoadmapPreview({required this.item, required final  List<FinancialImpact> impacts, required this.isBalanced, required final  List<String> warnings, required final  List<String> risks, required this.requiresConfirmation, required this.canCommit}): _impacts = impacts,_warnings = warnings,_risks = risks,super._();
  

@override final  RoadmapItem item;
 final  List<FinancialImpact> _impacts;
@override List<FinancialImpact> get impacts {
  if (_impacts is EqualUnmodifiableListView) return _impacts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_impacts);
}

@override final  bool isBalanced;
 final  List<String> _warnings;
@override List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}

 final  List<String> _risks;
@override List<String> get risks {
  if (_risks is EqualUnmodifiableListView) return _risks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_risks);
}

@override final  bool requiresConfirmation;
@override final  bool canCommit;

/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapPreviewCopyWith<_RoadmapPreview> get copyWith => __$RoadmapPreviewCopyWithImpl<_RoadmapPreview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapPreview&&(identical(other.item, item) || other.item == item)&&const DeepCollectionEquality().equals(other._impacts, _impacts)&&(identical(other.isBalanced, isBalanced) || other.isBalanced == isBalanced)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&const DeepCollectionEquality().equals(other._risks, _risks)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation)&&(identical(other.canCommit, canCommit) || other.canCommit == canCommit));
}


@override
int get hashCode => Object.hash(runtimeType,item,const DeepCollectionEquality().hash(_impacts),isBalanced,const DeepCollectionEquality().hash(_warnings),const DeepCollectionEquality().hash(_risks),requiresConfirmation,canCommit);

@override
String toString() {
  return 'RoadmapPreview(item: $item, impacts: $impacts, isBalanced: $isBalanced, warnings: $warnings, risks: $risks, requiresConfirmation: $requiresConfirmation, canCommit: $canCommit)';
}


}

/// @nodoc
abstract mixin class _$RoadmapPreviewCopyWith<$Res> implements $RoadmapPreviewCopyWith<$Res> {
  factory _$RoadmapPreviewCopyWith(_RoadmapPreview value, $Res Function(_RoadmapPreview) _then) = __$RoadmapPreviewCopyWithImpl;
@override @useResult
$Res call({
 RoadmapItem item, List<FinancialImpact> impacts, bool isBalanced, List<String> warnings, List<String> risks, bool requiresConfirmation, bool canCommit
});


@override $RoadmapItemCopyWith<$Res> get item;

}
/// @nodoc
class __$RoadmapPreviewCopyWithImpl<$Res>
    implements _$RoadmapPreviewCopyWith<$Res> {
  __$RoadmapPreviewCopyWithImpl(this._self, this._then);

  final _RoadmapPreview _self;
  final $Res Function(_RoadmapPreview) _then;

/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? impacts = null,Object? isBalanced = null,Object? warnings = null,Object? risks = null,Object? requiresConfirmation = null,Object? canCommit = null,}) {
  return _then(_RoadmapPreview(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as RoadmapItem,impacts: null == impacts ? _self._impacts : impacts // ignore: cast_nullable_to_non_nullable
as List<FinancialImpact>,isBalanced: null == isBalanced ? _self.isBalanced : isBalanced // ignore: cast_nullable_to_non_nullable
as bool,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,risks: null == risks ? _self._risks : risks // ignore: cast_nullable_to_non_nullable
as List<String>,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,canCommit: null == canCommit ? _self.canCommit : canCommit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RoadmapPreview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapItemCopyWith<$Res> get item {
  
  return $RoadmapItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
