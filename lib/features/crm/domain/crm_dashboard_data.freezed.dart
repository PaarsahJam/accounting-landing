// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crm_dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CrmDashboardData {

 int get totalContacts; int get totalTasks; int get openTasks; int get overdueTasks; int get totalLeads; int get activeOpportunities; double get pipelineValue; double get wonValueThisMonth;
/// Create a copy of CrmDashboardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrmDashboardDataCopyWith<CrmDashboardData> get copyWith => _$CrmDashboardDataCopyWithImpl<CrmDashboardData>(this as CrmDashboardData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrmDashboardData&&(identical(other.totalContacts, totalContacts) || other.totalContacts == totalContacts)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.openTasks, openTasks) || other.openTasks == openTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks)&&(identical(other.totalLeads, totalLeads) || other.totalLeads == totalLeads)&&(identical(other.activeOpportunities, activeOpportunities) || other.activeOpportunities == activeOpportunities)&&(identical(other.pipelineValue, pipelineValue) || other.pipelineValue == pipelineValue)&&(identical(other.wonValueThisMonth, wonValueThisMonth) || other.wonValueThisMonth == wonValueThisMonth));
}


@override
int get hashCode => Object.hash(runtimeType,totalContacts,totalTasks,openTasks,overdueTasks,totalLeads,activeOpportunities,pipelineValue,wonValueThisMonth);

@override
String toString() {
  return 'CrmDashboardData(totalContacts: $totalContacts, totalTasks: $totalTasks, openTasks: $openTasks, overdueTasks: $overdueTasks, totalLeads: $totalLeads, activeOpportunities: $activeOpportunities, pipelineValue: $pipelineValue, wonValueThisMonth: $wonValueThisMonth)';
}


}

/// @nodoc
abstract mixin class $CrmDashboardDataCopyWith<$Res>  {
  factory $CrmDashboardDataCopyWith(CrmDashboardData value, $Res Function(CrmDashboardData) _then) = _$CrmDashboardDataCopyWithImpl;
@useResult
$Res call({
 int totalContacts, int totalTasks, int openTasks, int overdueTasks, int totalLeads, int activeOpportunities, double pipelineValue, double wonValueThisMonth
});




}
/// @nodoc
class _$CrmDashboardDataCopyWithImpl<$Res>
    implements $CrmDashboardDataCopyWith<$Res> {
  _$CrmDashboardDataCopyWithImpl(this._self, this._then);

  final CrmDashboardData _self;
  final $Res Function(CrmDashboardData) _then;

/// Create a copy of CrmDashboardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalContacts = null,Object? totalTasks = null,Object? openTasks = null,Object? overdueTasks = null,Object? totalLeads = null,Object? activeOpportunities = null,Object? pipelineValue = null,Object? wonValueThisMonth = null,}) {
  return _then(_self.copyWith(
totalContacts: null == totalContacts ? _self.totalContacts : totalContacts // ignore: cast_nullable_to_non_nullable
as int,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,openTasks: null == openTasks ? _self.openTasks : openTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,totalLeads: null == totalLeads ? _self.totalLeads : totalLeads // ignore: cast_nullable_to_non_nullable
as int,activeOpportunities: null == activeOpportunities ? _self.activeOpportunities : activeOpportunities // ignore: cast_nullable_to_non_nullable
as int,pipelineValue: null == pipelineValue ? _self.pipelineValue : pipelineValue // ignore: cast_nullable_to_non_nullable
as double,wonValueThisMonth: null == wonValueThisMonth ? _self.wonValueThisMonth : wonValueThisMonth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CrmDashboardData].
extension CrmDashboardDataPatterns on CrmDashboardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrmDashboardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrmDashboardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrmDashboardData value)  $default,){
final _that = this;
switch (_that) {
case _CrmDashboardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrmDashboardData value)?  $default,){
final _that = this;
switch (_that) {
case _CrmDashboardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalContacts,  int totalTasks,  int openTasks,  int overdueTasks,  int totalLeads,  int activeOpportunities,  double pipelineValue,  double wonValueThisMonth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrmDashboardData() when $default != null:
return $default(_that.totalContacts,_that.totalTasks,_that.openTasks,_that.overdueTasks,_that.totalLeads,_that.activeOpportunities,_that.pipelineValue,_that.wonValueThisMonth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalContacts,  int totalTasks,  int openTasks,  int overdueTasks,  int totalLeads,  int activeOpportunities,  double pipelineValue,  double wonValueThisMonth)  $default,) {final _that = this;
switch (_that) {
case _CrmDashboardData():
return $default(_that.totalContacts,_that.totalTasks,_that.openTasks,_that.overdueTasks,_that.totalLeads,_that.activeOpportunities,_that.pipelineValue,_that.wonValueThisMonth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalContacts,  int totalTasks,  int openTasks,  int overdueTasks,  int totalLeads,  int activeOpportunities,  double pipelineValue,  double wonValueThisMonth)?  $default,) {final _that = this;
switch (_that) {
case _CrmDashboardData() when $default != null:
return $default(_that.totalContacts,_that.totalTasks,_that.openTasks,_that.overdueTasks,_that.totalLeads,_that.activeOpportunities,_that.pipelineValue,_that.wonValueThisMonth);case _:
  return null;

}
}

}

/// @nodoc


class _CrmDashboardData implements CrmDashboardData {
  const _CrmDashboardData({required this.totalContacts, required this.totalTasks, required this.openTasks, required this.overdueTasks, required this.totalLeads, required this.activeOpportunities, required this.pipelineValue, required this.wonValueThisMonth});
  

@override final  int totalContacts;
@override final  int totalTasks;
@override final  int openTasks;
@override final  int overdueTasks;
@override final  int totalLeads;
@override final  int activeOpportunities;
@override final  double pipelineValue;
@override final  double wonValueThisMonth;

/// Create a copy of CrmDashboardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrmDashboardDataCopyWith<_CrmDashboardData> get copyWith => __$CrmDashboardDataCopyWithImpl<_CrmDashboardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrmDashboardData&&(identical(other.totalContacts, totalContacts) || other.totalContacts == totalContacts)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.openTasks, openTasks) || other.openTasks == openTasks)&&(identical(other.overdueTasks, overdueTasks) || other.overdueTasks == overdueTasks)&&(identical(other.totalLeads, totalLeads) || other.totalLeads == totalLeads)&&(identical(other.activeOpportunities, activeOpportunities) || other.activeOpportunities == activeOpportunities)&&(identical(other.pipelineValue, pipelineValue) || other.pipelineValue == pipelineValue)&&(identical(other.wonValueThisMonth, wonValueThisMonth) || other.wonValueThisMonth == wonValueThisMonth));
}


@override
int get hashCode => Object.hash(runtimeType,totalContacts,totalTasks,openTasks,overdueTasks,totalLeads,activeOpportunities,pipelineValue,wonValueThisMonth);

@override
String toString() {
  return 'CrmDashboardData(totalContacts: $totalContacts, totalTasks: $totalTasks, openTasks: $openTasks, overdueTasks: $overdueTasks, totalLeads: $totalLeads, activeOpportunities: $activeOpportunities, pipelineValue: $pipelineValue, wonValueThisMonth: $wonValueThisMonth)';
}


}

/// @nodoc
abstract mixin class _$CrmDashboardDataCopyWith<$Res> implements $CrmDashboardDataCopyWith<$Res> {
  factory _$CrmDashboardDataCopyWith(_CrmDashboardData value, $Res Function(_CrmDashboardData) _then) = __$CrmDashboardDataCopyWithImpl;
@override @useResult
$Res call({
 int totalContacts, int totalTasks, int openTasks, int overdueTasks, int totalLeads, int activeOpportunities, double pipelineValue, double wonValueThisMonth
});




}
/// @nodoc
class __$CrmDashboardDataCopyWithImpl<$Res>
    implements _$CrmDashboardDataCopyWith<$Res> {
  __$CrmDashboardDataCopyWithImpl(this._self, this._then);

  final _CrmDashboardData _self;
  final $Res Function(_CrmDashboardData) _then;

/// Create a copy of CrmDashboardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalContacts = null,Object? totalTasks = null,Object? openTasks = null,Object? overdueTasks = null,Object? totalLeads = null,Object? activeOpportunities = null,Object? pipelineValue = null,Object? wonValueThisMonth = null,}) {
  return _then(_CrmDashboardData(
totalContacts: null == totalContacts ? _self.totalContacts : totalContacts // ignore: cast_nullable_to_non_nullable
as int,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,openTasks: null == openTasks ? _self.openTasks : openTasks // ignore: cast_nullable_to_non_nullable
as int,overdueTasks: null == overdueTasks ? _self.overdueTasks : overdueTasks // ignore: cast_nullable_to_non_nullable
as int,totalLeads: null == totalLeads ? _self.totalLeads : totalLeads // ignore: cast_nullable_to_non_nullable
as int,activeOpportunities: null == activeOpportunities ? _self.activeOpportunities : activeOpportunities // ignore: cast_nullable_to_non_nullable
as int,pipelineValue: null == pipelineValue ? _self.pipelineValue : pipelineValue // ignore: cast_nullable_to_non_nullable
as double,wonValueThisMonth: null == wonValueThisMonth ? _self.wonValueThisMonth : wonValueThisMonth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
