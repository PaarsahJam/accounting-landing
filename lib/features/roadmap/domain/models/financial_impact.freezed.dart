// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_impact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FinancialImpact {

 String get accountId; String get accountCode; String get accountName; double get debitAmount; double get creditAmount; String get currency; String get description;
/// Create a copy of FinancialImpact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinancialImpactCopyWith<FinancialImpact> get copyWith => _$FinancialImpactCopyWithImpl<FinancialImpact>(this as FinancialImpact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinancialImpact&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.debitAmount, debitAmount) || other.debitAmount == debitAmount)&&(identical(other.creditAmount, creditAmount) || other.creditAmount == creditAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,accountCode,accountName,debitAmount,creditAmount,currency,description);

@override
String toString() {
  return 'FinancialImpact(accountId: $accountId, accountCode: $accountCode, accountName: $accountName, debitAmount: $debitAmount, creditAmount: $creditAmount, currency: $currency, description: $description)';
}


}

/// @nodoc
abstract mixin class $FinancialImpactCopyWith<$Res>  {
  factory $FinancialImpactCopyWith(FinancialImpact value, $Res Function(FinancialImpact) _then) = _$FinancialImpactCopyWithImpl;
@useResult
$Res call({
 String accountId, String accountCode, String accountName, double debitAmount, double creditAmount, String currency, String description
});




}
/// @nodoc
class _$FinancialImpactCopyWithImpl<$Res>
    implements $FinancialImpactCopyWith<$Res> {
  _$FinancialImpactCopyWithImpl(this._self, this._then);

  final FinancialImpact _self;
  final $Res Function(FinancialImpact) _then;

/// Create a copy of FinancialImpact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? accountCode = null,Object? accountName = null,Object? debitAmount = null,Object? creditAmount = null,Object? currency = null,Object? description = null,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,debitAmount: null == debitAmount ? _self.debitAmount : debitAmount // ignore: cast_nullable_to_non_nullable
as double,creditAmount: null == creditAmount ? _self.creditAmount : creditAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FinancialImpact].
extension FinancialImpactPatterns on FinancialImpact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinancialImpact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinancialImpact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinancialImpact value)  $default,){
final _that = this;
switch (_that) {
case _FinancialImpact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinancialImpact value)?  $default,){
final _that = this;
switch (_that) {
case _FinancialImpact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  String accountCode,  String accountName,  double debitAmount,  double creditAmount,  String currency,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinancialImpact() when $default != null:
return $default(_that.accountId,_that.accountCode,_that.accountName,_that.debitAmount,_that.creditAmount,_that.currency,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  String accountCode,  String accountName,  double debitAmount,  double creditAmount,  String currency,  String description)  $default,) {final _that = this;
switch (_that) {
case _FinancialImpact():
return $default(_that.accountId,_that.accountCode,_that.accountName,_that.debitAmount,_that.creditAmount,_that.currency,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  String accountCode,  String accountName,  double debitAmount,  double creditAmount,  String currency,  String description)?  $default,) {final _that = this;
switch (_that) {
case _FinancialImpact() when $default != null:
return $default(_that.accountId,_that.accountCode,_that.accountName,_that.debitAmount,_that.creditAmount,_that.currency,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _FinancialImpact extends FinancialImpact {
  const _FinancialImpact({required this.accountId, required this.accountCode, required this.accountName, required this.debitAmount, required this.creditAmount, required this.currency, required this.description}): super._();
  

@override final  String accountId;
@override final  String accountCode;
@override final  String accountName;
@override final  double debitAmount;
@override final  double creditAmount;
@override final  String currency;
@override final  String description;

/// Create a copy of FinancialImpact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinancialImpactCopyWith<_FinancialImpact> get copyWith => __$FinancialImpactCopyWithImpl<_FinancialImpact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinancialImpact&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.debitAmount, debitAmount) || other.debitAmount == debitAmount)&&(identical(other.creditAmount, creditAmount) || other.creditAmount == creditAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,accountCode,accountName,debitAmount,creditAmount,currency,description);

@override
String toString() {
  return 'FinancialImpact(accountId: $accountId, accountCode: $accountCode, accountName: $accountName, debitAmount: $debitAmount, creditAmount: $creditAmount, currency: $currency, description: $description)';
}


}

/// @nodoc
abstract mixin class _$FinancialImpactCopyWith<$Res> implements $FinancialImpactCopyWith<$Res> {
  factory _$FinancialImpactCopyWith(_FinancialImpact value, $Res Function(_FinancialImpact) _then) = __$FinancialImpactCopyWithImpl;
@override @useResult
$Res call({
 String accountId, String accountCode, String accountName, double debitAmount, double creditAmount, String currency, String description
});




}
/// @nodoc
class __$FinancialImpactCopyWithImpl<$Res>
    implements _$FinancialImpactCopyWith<$Res> {
  __$FinancialImpactCopyWithImpl(this._self, this._then);

  final _FinancialImpact _self;
  final $Res Function(_FinancialImpact) _then;

/// Create a copy of FinancialImpact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? accountCode = null,Object? accountName = null,Object? debitAmount = null,Object? creditAmount = null,Object? currency = null,Object? description = null,}) {
  return _then(_FinancialImpact(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,debitAmount: null == debitAmount ? _self.debitAmount : debitAmount // ignore: cast_nullable_to_non_nullable
as double,creditAmount: null == creditAmount ? _self.creditAmount : creditAmount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
