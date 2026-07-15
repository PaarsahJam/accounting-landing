// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalLine {

 String get accountCode; String get accountName; double get debit; double get credit; String get currency; String get costCenter; String get notes;
/// Create a copy of JournalLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalLineCopyWith<JournalLine> get copyWith => _$JournalLineCopyWithImpl<JournalLine>(this as JournalLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalLine&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,accountCode,accountName,debit,credit,currency,costCenter,notes);

@override
String toString() {
  return 'JournalLine(accountCode: $accountCode, accountName: $accountName, debit: $debit, credit: $credit, currency: $currency, costCenter: $costCenter, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $JournalLineCopyWith<$Res>  {
  factory $JournalLineCopyWith(JournalLine value, $Res Function(JournalLine) _then) = _$JournalLineCopyWithImpl;
@useResult
$Res call({
 String accountCode, String accountName, double debit, double credit, String currency, String costCenter, String notes
});




}
/// @nodoc
class _$JournalLineCopyWithImpl<$Res>
    implements $JournalLineCopyWith<$Res> {
  _$JournalLineCopyWithImpl(this._self, this._then);

  final JournalLine _self;
  final $Res Function(JournalLine) _then;

/// Create a copy of JournalLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountCode = null,Object? accountName = null,Object? debit = null,Object? credit = null,Object? currency = null,Object? costCenter = null,Object? notes = null,}) {
  return _then(_self.copyWith(
accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,debit: null == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,costCenter: null == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalLine].
extension JournalLinePatterns on JournalLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalLine value)  $default,){
final _that = this;
switch (_that) {
case _JournalLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalLine value)?  $default,){
final _that = this;
switch (_that) {
case _JournalLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountCode,  String accountName,  double debit,  double credit,  String currency,  String costCenter,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalLine() when $default != null:
return $default(_that.accountCode,_that.accountName,_that.debit,_that.credit,_that.currency,_that.costCenter,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountCode,  String accountName,  double debit,  double credit,  String currency,  String costCenter,  String notes)  $default,) {final _that = this;
switch (_that) {
case _JournalLine():
return $default(_that.accountCode,_that.accountName,_that.debit,_that.credit,_that.currency,_that.costCenter,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountCode,  String accountName,  double debit,  double credit,  String currency,  String costCenter,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _JournalLine() when $default != null:
return $default(_that.accountCode,_that.accountName,_that.debit,_that.credit,_that.currency,_that.costCenter,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _JournalLine implements JournalLine {
  const _JournalLine({required this.accountCode, required this.accountName, required this.debit, required this.credit, this.currency = 'IRR', this.costCenter = '', this.notes = ''});
  

@override final  String accountCode;
@override final  String accountName;
@override final  double debit;
@override final  double credit;
@override@JsonKey() final  String currency;
@override@JsonKey() final  String costCenter;
@override@JsonKey() final  String notes;

/// Create a copy of JournalLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalLineCopyWith<_JournalLine> get copyWith => __$JournalLineCopyWithImpl<_JournalLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalLine&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.costCenter, costCenter) || other.costCenter == costCenter)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,accountCode,accountName,debit,credit,currency,costCenter,notes);

@override
String toString() {
  return 'JournalLine(accountCode: $accountCode, accountName: $accountName, debit: $debit, credit: $credit, currency: $currency, costCenter: $costCenter, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$JournalLineCopyWith<$Res> implements $JournalLineCopyWith<$Res> {
  factory _$JournalLineCopyWith(_JournalLine value, $Res Function(_JournalLine) _then) = __$JournalLineCopyWithImpl;
@override @useResult
$Res call({
 String accountCode, String accountName, double debit, double credit, String currency, String costCenter, String notes
});




}
/// @nodoc
class __$JournalLineCopyWithImpl<$Res>
    implements _$JournalLineCopyWith<$Res> {
  __$JournalLineCopyWithImpl(this._self, this._then);

  final _JournalLine _self;
  final $Res Function(_JournalLine) _then;

/// Create a copy of JournalLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountCode = null,Object? accountName = null,Object? debit = null,Object? credit = null,Object? currency = null,Object? costCenter = null,Object? notes = null,}) {
  return _then(_JournalLine(
accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,debit: null == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,costCenter: null == costCenter ? _self.costCenter : costCenter // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
