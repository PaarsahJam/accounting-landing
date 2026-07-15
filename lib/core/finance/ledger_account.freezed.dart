// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LedgerAccount {

 String get id; String get code; String get name; LedgerAccountType get type; String get currency; double get openingBalance; bool get active;
/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<LedgerAccount> get copyWith => _$LedgerAccountCopyWithImpl<LedgerAccount>(this as LedgerAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,name,type,currency,openingBalance,active);

@override
String toString() {
  return 'LedgerAccount(id: $id, code: $code, name: $name, type: $type, currency: $currency, openingBalance: $openingBalance, active: $active)';
}


}

/// @nodoc
abstract mixin class $LedgerAccountCopyWith<$Res>  {
  factory $LedgerAccountCopyWith(LedgerAccount value, $Res Function(LedgerAccount) _then) = _$LedgerAccountCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name, LedgerAccountType type, String currency, double openingBalance, bool active
});




}
/// @nodoc
class _$LedgerAccountCopyWithImpl<$Res>
    implements $LedgerAccountCopyWith<$Res> {
  _$LedgerAccountCopyWithImpl(this._self, this._then);

  final LedgerAccount _self;
  final $Res Function(LedgerAccount) _then;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,Object? type = null,Object? currency = null,Object? openingBalance = null,Object? active = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerAccountType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerAccount].
extension LedgerAccountPatterns on LedgerAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerAccount value)  $default,){
final _that = this;
switch (_that) {
case _LedgerAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerAccount value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name,  LedgerAccountType type,  String currency,  double openingBalance,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.type,_that.currency,_that.openingBalance,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name,  LedgerAccountType type,  String currency,  double openingBalance,  bool active)  $default,) {final _that = this;
switch (_that) {
case _LedgerAccount():
return $default(_that.id,_that.code,_that.name,_that.type,_that.currency,_that.openingBalance,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name,  LedgerAccountType type,  String currency,  double openingBalance,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _LedgerAccount() when $default != null:
return $default(_that.id,_that.code,_that.name,_that.type,_that.currency,_that.openingBalance,_that.active);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerAccount implements LedgerAccount {
  const _LedgerAccount({required this.id, required this.code, required this.name, required this.type, required this.currency, required this.openingBalance, this.active = true});
  

@override final  String id;
@override final  String code;
@override final  String name;
@override final  LedgerAccountType type;
@override final  String currency;
@override final  double openingBalance;
@override@JsonKey() final  bool active;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerAccountCopyWith<_LedgerAccount> get copyWith => __$LedgerAccountCopyWithImpl<_LedgerAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,name,type,currency,openingBalance,active);

@override
String toString() {
  return 'LedgerAccount(id: $id, code: $code, name: $name, type: $type, currency: $currency, openingBalance: $openingBalance, active: $active)';
}


}

/// @nodoc
abstract mixin class _$LedgerAccountCopyWith<$Res> implements $LedgerAccountCopyWith<$Res> {
  factory _$LedgerAccountCopyWith(_LedgerAccount value, $Res Function(_LedgerAccount) _then) = __$LedgerAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name, LedgerAccountType type, String currency, double openingBalance, bool active
});




}
/// @nodoc
class __$LedgerAccountCopyWithImpl<$Res>
    implements _$LedgerAccountCopyWith<$Res> {
  __$LedgerAccountCopyWithImpl(this._self, this._then);

  final _LedgerAccount _self;
  final $Res Function(_LedgerAccount) _then;

/// Create a copy of LedgerAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,Object? type = null,Object? currency = null,Object? openingBalance = null,Object? active = null,}) {
  return _then(_LedgerAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LedgerAccountType,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
