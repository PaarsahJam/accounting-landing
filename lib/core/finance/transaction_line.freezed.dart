// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionLine {

 String get accountId; double get amount; String get currency; String? get description;
/// Create a copy of TransactionLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionLineCopyWith<TransactionLine> get copyWith => _$TransactionLineCopyWithImpl<TransactionLine>(this as TransactionLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionLine&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,amount,currency,description);

@override
String toString() {
  return 'TransactionLine(accountId: $accountId, amount: $amount, currency: $currency, description: $description)';
}


}

/// @nodoc
abstract mixin class $TransactionLineCopyWith<$Res>  {
  factory $TransactionLineCopyWith(TransactionLine value, $Res Function(TransactionLine) _then) = _$TransactionLineCopyWithImpl;
@useResult
$Res call({
 String accountId, double amount, String currency, String? description
});




}
/// @nodoc
class _$TransactionLineCopyWithImpl<$Res>
    implements $TransactionLineCopyWith<$Res> {
  _$TransactionLineCopyWithImpl(this._self, this._then);

  final TransactionLine _self;
  final $Res Function(TransactionLine) _then;

/// Create a copy of TransactionLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? amount = null,Object? currency = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionLine].
extension TransactionLinePatterns on TransactionLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionLine value)  $default,){
final _that = this;
switch (_that) {
case _TransactionLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionLine value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  double amount,  String currency,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionLine() when $default != null:
return $default(_that.accountId,_that.amount,_that.currency,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  double amount,  String currency,  String? description)  $default,) {final _that = this;
switch (_that) {
case _TransactionLine():
return $default(_that.accountId,_that.amount,_that.currency,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  double amount,  String currency,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _TransactionLine() when $default != null:
return $default(_that.accountId,_that.amount,_that.currency,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionLine implements TransactionLine {
  const _TransactionLine({required this.accountId, required this.amount, required this.currency, this.description});
  

@override final  String accountId;
@override final  double amount;
@override final  String currency;
@override final  String? description;

/// Create a copy of TransactionLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionLineCopyWith<_TransactionLine> get copyWith => __$TransactionLineCopyWithImpl<_TransactionLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionLine&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,amount,currency,description);

@override
String toString() {
  return 'TransactionLine(accountId: $accountId, amount: $amount, currency: $currency, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TransactionLineCopyWith<$Res> implements $TransactionLineCopyWith<$Res> {
  factory _$TransactionLineCopyWith(_TransactionLine value, $Res Function(_TransactionLine) _then) = __$TransactionLineCopyWithImpl;
@override @useResult
$Res call({
 String accountId, double amount, String currency, String? description
});




}
/// @nodoc
class __$TransactionLineCopyWithImpl<$Res>
    implements _$TransactionLineCopyWith<$Res> {
  __$TransactionLineCopyWithImpl(this._self, this._then);

  final _TransactionLine _self;
  final $Res Function(_TransactionLine) _then;

/// Create a copy of TransactionLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? amount = null,Object? currency = null,Object? description = freezed,}) {
  return _then(_TransactionLine(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
