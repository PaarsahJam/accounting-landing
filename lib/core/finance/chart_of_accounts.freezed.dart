// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_of_accounts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartOfAccounts {

 List<LedgerAccount> get accounts;
/// Create a copy of ChartOfAccounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartOfAccountsCopyWith<ChartOfAccounts> get copyWith => _$ChartOfAccountsCopyWithImpl<ChartOfAccounts>(this as ChartOfAccounts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartOfAccounts&&const DeepCollectionEquality().equals(other.accounts, accounts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accounts));

@override
String toString() {
  return 'ChartOfAccounts(accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $ChartOfAccountsCopyWith<$Res>  {
  factory $ChartOfAccountsCopyWith(ChartOfAccounts value, $Res Function(ChartOfAccounts) _then) = _$ChartOfAccountsCopyWithImpl;
@useResult
$Res call({
 List<LedgerAccount> accounts
});




}
/// @nodoc
class _$ChartOfAccountsCopyWithImpl<$Res>
    implements $ChartOfAccountsCopyWith<$Res> {
  _$ChartOfAccountsCopyWithImpl(this._self, this._then);

  final ChartOfAccounts _self;
  final $Res Function(ChartOfAccounts) _then;

/// Create a copy of ChartOfAccounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,}) {
  return _then(_self.copyWith(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<LedgerAccount>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChartOfAccounts].
extension ChartOfAccountsPatterns on ChartOfAccounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartOfAccounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartOfAccounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartOfAccounts value)  $default,){
final _that = this;
switch (_that) {
case _ChartOfAccounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartOfAccounts value)?  $default,){
final _that = this;
switch (_that) {
case _ChartOfAccounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LedgerAccount> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartOfAccounts() when $default != null:
return $default(_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LedgerAccount> accounts)  $default,) {final _that = this;
switch (_that) {
case _ChartOfAccounts():
return $default(_that.accounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LedgerAccount> accounts)?  $default,) {final _that = this;
switch (_that) {
case _ChartOfAccounts() when $default != null:
return $default(_that.accounts);case _:
  return null;

}
}

}

/// @nodoc


class _ChartOfAccounts extends ChartOfAccounts {
  const _ChartOfAccounts({required final  List<LedgerAccount> accounts}): _accounts = accounts,super._();
  

 final  List<LedgerAccount> _accounts;
@override List<LedgerAccount> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of ChartOfAccounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartOfAccountsCopyWith<_ChartOfAccounts> get copyWith => __$ChartOfAccountsCopyWithImpl<_ChartOfAccounts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartOfAccounts&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accounts));

@override
String toString() {
  return 'ChartOfAccounts(accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$ChartOfAccountsCopyWith<$Res> implements $ChartOfAccountsCopyWith<$Res> {
  factory _$ChartOfAccountsCopyWith(_ChartOfAccounts value, $Res Function(_ChartOfAccounts) _then) = __$ChartOfAccountsCopyWithImpl;
@override @useResult
$Res call({
 List<LedgerAccount> accounts
});




}
/// @nodoc
class __$ChartOfAccountsCopyWithImpl<$Res>
    implements _$ChartOfAccountsCopyWith<$Res> {
  __$ChartOfAccountsCopyWithImpl(this._self, this._then);

  final _ChartOfAccounts _self;
  final $Res Function(_ChartOfAccounts) _then;

/// Create a copy of ChartOfAccounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accounts = null,}) {
  return _then(_ChartOfAccounts(
accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<LedgerAccount>,
  ));
}


}

// dart format on
