// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BalanceSnapshot {

 String get periodId; Map<String, double> get balances;
/// Create a copy of BalanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BalanceSnapshotCopyWith<BalanceSnapshot> get copyWith => _$BalanceSnapshotCopyWithImpl<BalanceSnapshot>(this as BalanceSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BalanceSnapshot&&(identical(other.periodId, periodId) || other.periodId == periodId)&&const DeepCollectionEquality().equals(other.balances, balances));
}


@override
int get hashCode => Object.hash(runtimeType,periodId,const DeepCollectionEquality().hash(balances));

@override
String toString() {
  return 'BalanceSnapshot(periodId: $periodId, balances: $balances)';
}


}

/// @nodoc
abstract mixin class $BalanceSnapshotCopyWith<$Res>  {
  factory $BalanceSnapshotCopyWith(BalanceSnapshot value, $Res Function(BalanceSnapshot) _then) = _$BalanceSnapshotCopyWithImpl;
@useResult
$Res call({
 String periodId, Map<String, double> balances
});




}
/// @nodoc
class _$BalanceSnapshotCopyWithImpl<$Res>
    implements $BalanceSnapshotCopyWith<$Res> {
  _$BalanceSnapshotCopyWithImpl(this._self, this._then);

  final BalanceSnapshot _self;
  final $Res Function(BalanceSnapshot) _then;

/// Create a copy of BalanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? periodId = null,Object? balances = null,}) {
  return _then(_self.copyWith(
periodId: null == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as String,balances: null == balances ? _self.balances : balances // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [BalanceSnapshot].
extension BalanceSnapshotPatterns on BalanceSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BalanceSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BalanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BalanceSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _BalanceSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BalanceSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _BalanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String periodId,  Map<String, double> balances)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BalanceSnapshot() when $default != null:
return $default(_that.periodId,_that.balances);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String periodId,  Map<String, double> balances)  $default,) {final _that = this;
switch (_that) {
case _BalanceSnapshot():
return $default(_that.periodId,_that.balances);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String periodId,  Map<String, double> balances)?  $default,) {final _that = this;
switch (_that) {
case _BalanceSnapshot() when $default != null:
return $default(_that.periodId,_that.balances);case _:
  return null;

}
}

}

/// @nodoc


class _BalanceSnapshot implements BalanceSnapshot {
  const _BalanceSnapshot({required this.periodId, required final  Map<String, double> balances}): _balances = balances;
  

@override final  String periodId;
 final  Map<String, double> _balances;
@override Map<String, double> get balances {
  if (_balances is EqualUnmodifiableMapView) return _balances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_balances);
}


/// Create a copy of BalanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BalanceSnapshotCopyWith<_BalanceSnapshot> get copyWith => __$BalanceSnapshotCopyWithImpl<_BalanceSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BalanceSnapshot&&(identical(other.periodId, periodId) || other.periodId == periodId)&&const DeepCollectionEquality().equals(other._balances, _balances));
}


@override
int get hashCode => Object.hash(runtimeType,periodId,const DeepCollectionEquality().hash(_balances));

@override
String toString() {
  return 'BalanceSnapshot(periodId: $periodId, balances: $balances)';
}


}

/// @nodoc
abstract mixin class _$BalanceSnapshotCopyWith<$Res> implements $BalanceSnapshotCopyWith<$Res> {
  factory _$BalanceSnapshotCopyWith(_BalanceSnapshot value, $Res Function(_BalanceSnapshot) _then) = __$BalanceSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String periodId, Map<String, double> balances
});




}
/// @nodoc
class __$BalanceSnapshotCopyWithImpl<$Res>
    implements _$BalanceSnapshotCopyWith<$Res> {
  __$BalanceSnapshotCopyWithImpl(this._self, this._then);

  final _BalanceSnapshot _self;
  final $Res Function(_BalanceSnapshot) _then;

/// Create a copy of BalanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? periodId = null,Object? balances = null,}) {
  return _then(_BalanceSnapshot(
periodId: null == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as String,balances: null == balances ? _self._balances : balances // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
