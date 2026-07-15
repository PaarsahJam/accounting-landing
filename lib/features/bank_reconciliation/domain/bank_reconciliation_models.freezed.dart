// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_reconciliation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BankAccount {

 String get id; String get name; String get accountNumber; double get currentBalance; String get currency;
/// Create a copy of BankAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankAccountCopyWith<BankAccount> get copyWith => _$BankAccountCopyWithImpl<BankAccount>(this as BankAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,accountNumber,currentBalance,currency);

@override
String toString() {
  return 'BankAccount(id: $id, name: $name, accountNumber: $accountNumber, currentBalance: $currentBalance, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $BankAccountCopyWith<$Res>  {
  factory $BankAccountCopyWith(BankAccount value, $Res Function(BankAccount) _then) = _$BankAccountCopyWithImpl;
@useResult
$Res call({
 String id, String name, String accountNumber, double currentBalance, String currency
});




}
/// @nodoc
class _$BankAccountCopyWithImpl<$Res>
    implements $BankAccountCopyWith<$Res> {
  _$BankAccountCopyWithImpl(this._self, this._then);

  final BankAccount _self;
  final $Res Function(BankAccount) _then;

/// Create a copy of BankAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? accountNumber = null,Object? currentBalance = null,Object? currency = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BankAccount].
extension BankAccountPatterns on BankAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankAccount value)  $default,){
final _that = this;
switch (_that) {
case _BankAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankAccount value)?  $default,){
final _that = this;
switch (_that) {
case _BankAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String accountNumber,  double currentBalance,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankAccount() when $default != null:
return $default(_that.id,_that.name,_that.accountNumber,_that.currentBalance,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String accountNumber,  double currentBalance,  String currency)  $default,) {final _that = this;
switch (_that) {
case _BankAccount():
return $default(_that.id,_that.name,_that.accountNumber,_that.currentBalance,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String accountNumber,  double currentBalance,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _BankAccount() when $default != null:
return $default(_that.id,_that.name,_that.accountNumber,_that.currentBalance,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _BankAccount implements BankAccount {
  const _BankAccount({required this.id, required this.name, required this.accountNumber, required this.currentBalance, required this.currency});
  

@override final  String id;
@override final  String name;
@override final  String accountNumber;
@override final  double currentBalance;
@override final  String currency;

/// Create a copy of BankAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankAccountCopyWith<_BankAccount> get copyWith => __$BankAccountCopyWithImpl<_BankAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,accountNumber,currentBalance,currency);

@override
String toString() {
  return 'BankAccount(id: $id, name: $name, accountNumber: $accountNumber, currentBalance: $currentBalance, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$BankAccountCopyWith<$Res> implements $BankAccountCopyWith<$Res> {
  factory _$BankAccountCopyWith(_BankAccount value, $Res Function(_BankAccount) _then) = __$BankAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String accountNumber, double currentBalance, String currency
});




}
/// @nodoc
class __$BankAccountCopyWithImpl<$Res>
    implements _$BankAccountCopyWith<$Res> {
  __$BankAccountCopyWithImpl(this._self, this._then);

  final _BankAccount _self;
  final $Res Function(_BankAccount) _then;

/// Create a copy of BankAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? accountNumber = null,Object? currentBalance = null,Object? currency = null,}) {
  return _then(_BankAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BankTransaction {

 String get id; String get reference; DateTime get occurredAt; double get amount; String get description; bool get matched; String? get matchedLedgerEntryId; String get bankAccountId;
/// Create a copy of BankTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankTransactionCopyWith<BankTransaction> get copyWith => _$BankTransactionCopyWithImpl<BankTransaction>(this as BankTransaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BankTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.matched, matched) || other.matched == matched)&&(identical(other.matchedLedgerEntryId, matchedLedgerEntryId) || other.matchedLedgerEntryId == matchedLedgerEntryId)&&(identical(other.bankAccountId, bankAccountId) || other.bankAccountId == bankAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,occurredAt,amount,description,matched,matchedLedgerEntryId,bankAccountId);

@override
String toString() {
  return 'BankTransaction(id: $id, reference: $reference, occurredAt: $occurredAt, amount: $amount, description: $description, matched: $matched, matchedLedgerEntryId: $matchedLedgerEntryId, bankAccountId: $bankAccountId)';
}


}

/// @nodoc
abstract mixin class $BankTransactionCopyWith<$Res>  {
  factory $BankTransactionCopyWith(BankTransaction value, $Res Function(BankTransaction) _then) = _$BankTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String reference, DateTime occurredAt, double amount, String description, bool matched, String? matchedLedgerEntryId, String bankAccountId
});




}
/// @nodoc
class _$BankTransactionCopyWithImpl<$Res>
    implements $BankTransactionCopyWith<$Res> {
  _$BankTransactionCopyWithImpl(this._self, this._then);

  final BankTransaction _self;
  final $Res Function(BankTransaction) _then;

/// Create a copy of BankTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? occurredAt = null,Object? amount = null,Object? description = null,Object? matched = null,Object? matchedLedgerEntryId = freezed,Object? bankAccountId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,matched: null == matched ? _self.matched : matched // ignore: cast_nullable_to_non_nullable
as bool,matchedLedgerEntryId: freezed == matchedLedgerEntryId ? _self.matchedLedgerEntryId : matchedLedgerEntryId // ignore: cast_nullable_to_non_nullable
as String?,bankAccountId: null == bankAccountId ? _self.bankAccountId : bankAccountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BankTransaction].
extension BankTransactionPatterns on BankTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BankTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BankTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BankTransaction value)  $default,){
final _that = this;
switch (_that) {
case _BankTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BankTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _BankTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime occurredAt,  double amount,  String description,  bool matched,  String? matchedLedgerEntryId,  String bankAccountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BankTransaction() when $default != null:
return $default(_that.id,_that.reference,_that.occurredAt,_that.amount,_that.description,_that.matched,_that.matchedLedgerEntryId,_that.bankAccountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime occurredAt,  double amount,  String description,  bool matched,  String? matchedLedgerEntryId,  String bankAccountId)  $default,) {final _that = this;
switch (_that) {
case _BankTransaction():
return $default(_that.id,_that.reference,_that.occurredAt,_that.amount,_that.description,_that.matched,_that.matchedLedgerEntryId,_that.bankAccountId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  DateTime occurredAt,  double amount,  String description,  bool matched,  String? matchedLedgerEntryId,  String bankAccountId)?  $default,) {final _that = this;
switch (_that) {
case _BankTransaction() when $default != null:
return $default(_that.id,_that.reference,_that.occurredAt,_that.amount,_that.description,_that.matched,_that.matchedLedgerEntryId,_that.bankAccountId);case _:
  return null;

}
}

}

/// @nodoc


class _BankTransaction implements BankTransaction {
  const _BankTransaction({required this.id, required this.reference, required this.occurredAt, required this.amount, required this.description, required this.matched, required this.matchedLedgerEntryId, required this.bankAccountId});
  

@override final  String id;
@override final  String reference;
@override final  DateTime occurredAt;
@override final  double amount;
@override final  String description;
@override final  bool matched;
@override final  String? matchedLedgerEntryId;
@override final  String bankAccountId;

/// Create a copy of BankTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankTransactionCopyWith<_BankTransaction> get copyWith => __$BankTransactionCopyWithImpl<_BankTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BankTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.matched, matched) || other.matched == matched)&&(identical(other.matchedLedgerEntryId, matchedLedgerEntryId) || other.matchedLedgerEntryId == matchedLedgerEntryId)&&(identical(other.bankAccountId, bankAccountId) || other.bankAccountId == bankAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,occurredAt,amount,description,matched,matchedLedgerEntryId,bankAccountId);

@override
String toString() {
  return 'BankTransaction(id: $id, reference: $reference, occurredAt: $occurredAt, amount: $amount, description: $description, matched: $matched, matchedLedgerEntryId: $matchedLedgerEntryId, bankAccountId: $bankAccountId)';
}


}

/// @nodoc
abstract mixin class _$BankTransactionCopyWith<$Res> implements $BankTransactionCopyWith<$Res> {
  factory _$BankTransactionCopyWith(_BankTransaction value, $Res Function(_BankTransaction) _then) = __$BankTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, DateTime occurredAt, double amount, String description, bool matched, String? matchedLedgerEntryId, String bankAccountId
});




}
/// @nodoc
class __$BankTransactionCopyWithImpl<$Res>
    implements _$BankTransactionCopyWith<$Res> {
  __$BankTransactionCopyWithImpl(this._self, this._then);

  final _BankTransaction _self;
  final $Res Function(_BankTransaction) _then;

/// Create a copy of BankTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? occurredAt = null,Object? amount = null,Object? description = null,Object? matched = null,Object? matchedLedgerEntryId = freezed,Object? bankAccountId = null,}) {
  return _then(_BankTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,matched: null == matched ? _self.matched : matched // ignore: cast_nullable_to_non_nullable
as bool,matchedLedgerEntryId: freezed == matchedLedgerEntryId ? _self.matchedLedgerEntryId : matchedLedgerEntryId // ignore: cast_nullable_to_non_nullable
as String?,bankAccountId: null == bankAccountId ? _self.bankAccountId : bankAccountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LedgerEntryReference {

 String get id; String get label; String get type; double get amount; DateTime get occurredAt;
/// Create a copy of LedgerEntryReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LedgerEntryReferenceCopyWith<LedgerEntryReference> get copyWith => _$LedgerEntryReferenceCopyWithImpl<LedgerEntryReference>(this as LedgerEntryReference, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LedgerEntryReference&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,type,amount,occurredAt);

@override
String toString() {
  return 'LedgerEntryReference(id: $id, label: $label, type: $type, amount: $amount, occurredAt: $occurredAt)';
}


}

/// @nodoc
abstract mixin class $LedgerEntryReferenceCopyWith<$Res>  {
  factory $LedgerEntryReferenceCopyWith(LedgerEntryReference value, $Res Function(LedgerEntryReference) _then) = _$LedgerEntryReferenceCopyWithImpl;
@useResult
$Res call({
 String id, String label, String type, double amount, DateTime occurredAt
});




}
/// @nodoc
class _$LedgerEntryReferenceCopyWithImpl<$Res>
    implements $LedgerEntryReferenceCopyWith<$Res> {
  _$LedgerEntryReferenceCopyWithImpl(this._self, this._then);

  final LedgerEntryReference _self;
  final $Res Function(LedgerEntryReference) _then;

/// Create a copy of LedgerEntryReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? type = null,Object? amount = null,Object? occurredAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LedgerEntryReference].
extension LedgerEntryReferencePatterns on LedgerEntryReference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LedgerEntryReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LedgerEntryReference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LedgerEntryReference value)  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryReference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LedgerEntryReference value)?  $default,){
final _that = this;
switch (_that) {
case _LedgerEntryReference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String type,  double amount,  DateTime occurredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LedgerEntryReference() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.amount,_that.occurredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String type,  double amount,  DateTime occurredAt)  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryReference():
return $default(_that.id,_that.label,_that.type,_that.amount,_that.occurredAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String type,  double amount,  DateTime occurredAt)?  $default,) {final _that = this;
switch (_that) {
case _LedgerEntryReference() when $default != null:
return $default(_that.id,_that.label,_that.type,_that.amount,_that.occurredAt);case _:
  return null;

}
}

}

/// @nodoc


class _LedgerEntryReference implements LedgerEntryReference {
  const _LedgerEntryReference({required this.id, required this.label, required this.type, required this.amount, required this.occurredAt});
  

@override final  String id;
@override final  String label;
@override final  String type;
@override final  double amount;
@override final  DateTime occurredAt;

/// Create a copy of LedgerEntryReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LedgerEntryReferenceCopyWith<_LedgerEntryReference> get copyWith => __$LedgerEntryReferenceCopyWithImpl<_LedgerEntryReference>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LedgerEntryReference&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,type,amount,occurredAt);

@override
String toString() {
  return 'LedgerEntryReference(id: $id, label: $label, type: $type, amount: $amount, occurredAt: $occurredAt)';
}


}

/// @nodoc
abstract mixin class _$LedgerEntryReferenceCopyWith<$Res> implements $LedgerEntryReferenceCopyWith<$Res> {
  factory _$LedgerEntryReferenceCopyWith(_LedgerEntryReference value, $Res Function(_LedgerEntryReference) _then) = __$LedgerEntryReferenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String type, double amount, DateTime occurredAt
});




}
/// @nodoc
class __$LedgerEntryReferenceCopyWithImpl<$Res>
    implements _$LedgerEntryReferenceCopyWith<$Res> {
  __$LedgerEntryReferenceCopyWithImpl(this._self, this._then);

  final _LedgerEntryReference _self;
  final $Res Function(_LedgerEntryReference) _then;

/// Create a copy of LedgerEntryReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? type = null,Object? amount = null,Object? occurredAt = null,}) {
  return _then(_LedgerEntryReference(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$ReconciliationSession {

 String get id; String get bankAccountId; DateTime get startedAt; ReconciliationStatus get status; int get matchedCount; int get unmatchedCount; double get totalAmount;
/// Create a copy of ReconciliationSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReconciliationSessionCopyWith<ReconciliationSession> get copyWith => _$ReconciliationSessionCopyWithImpl<ReconciliationSession>(this as ReconciliationSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReconciliationSession&&(identical(other.id, id) || other.id == id)&&(identical(other.bankAccountId, bankAccountId) || other.bankAccountId == bankAccountId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.matchedCount, matchedCount) || other.matchedCount == matchedCount)&&(identical(other.unmatchedCount, unmatchedCount) || other.unmatchedCount == unmatchedCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,bankAccountId,startedAt,status,matchedCount,unmatchedCount,totalAmount);

@override
String toString() {
  return 'ReconciliationSession(id: $id, bankAccountId: $bankAccountId, startedAt: $startedAt, status: $status, matchedCount: $matchedCount, unmatchedCount: $unmatchedCount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $ReconciliationSessionCopyWith<$Res>  {
  factory $ReconciliationSessionCopyWith(ReconciliationSession value, $Res Function(ReconciliationSession) _then) = _$ReconciliationSessionCopyWithImpl;
@useResult
$Res call({
 String id, String bankAccountId, DateTime startedAt, ReconciliationStatus status, int matchedCount, int unmatchedCount, double totalAmount
});




}
/// @nodoc
class _$ReconciliationSessionCopyWithImpl<$Res>
    implements $ReconciliationSessionCopyWith<$Res> {
  _$ReconciliationSessionCopyWithImpl(this._self, this._then);

  final ReconciliationSession _self;
  final $Res Function(ReconciliationSession) _then;

/// Create a copy of ReconciliationSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bankAccountId = null,Object? startedAt = null,Object? status = null,Object? matchedCount = null,Object? unmatchedCount = null,Object? totalAmount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bankAccountId: null == bankAccountId ? _self.bankAccountId : bankAccountId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReconciliationStatus,matchedCount: null == matchedCount ? _self.matchedCount : matchedCount // ignore: cast_nullable_to_non_nullable
as int,unmatchedCount: null == unmatchedCount ? _self.unmatchedCount : unmatchedCount // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ReconciliationSession].
extension ReconciliationSessionPatterns on ReconciliationSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReconciliationSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReconciliationSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReconciliationSession value)  $default,){
final _that = this;
switch (_that) {
case _ReconciliationSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReconciliationSession value)?  $default,){
final _that = this;
switch (_that) {
case _ReconciliationSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bankAccountId,  DateTime startedAt,  ReconciliationStatus status,  int matchedCount,  int unmatchedCount,  double totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReconciliationSession() when $default != null:
return $default(_that.id,_that.bankAccountId,_that.startedAt,_that.status,_that.matchedCount,_that.unmatchedCount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bankAccountId,  DateTime startedAt,  ReconciliationStatus status,  int matchedCount,  int unmatchedCount,  double totalAmount)  $default,) {final _that = this;
switch (_that) {
case _ReconciliationSession():
return $default(_that.id,_that.bankAccountId,_that.startedAt,_that.status,_that.matchedCount,_that.unmatchedCount,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bankAccountId,  DateTime startedAt,  ReconciliationStatus status,  int matchedCount,  int unmatchedCount,  double totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _ReconciliationSession() when $default != null:
return $default(_that.id,_that.bankAccountId,_that.startedAt,_that.status,_that.matchedCount,_that.unmatchedCount,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc


class _ReconciliationSession implements ReconciliationSession {
  const _ReconciliationSession({required this.id, required this.bankAccountId, required this.startedAt, required this.status, required this.matchedCount, required this.unmatchedCount, required this.totalAmount});
  

@override final  String id;
@override final  String bankAccountId;
@override final  DateTime startedAt;
@override final  ReconciliationStatus status;
@override final  int matchedCount;
@override final  int unmatchedCount;
@override final  double totalAmount;

/// Create a copy of ReconciliationSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReconciliationSessionCopyWith<_ReconciliationSession> get copyWith => __$ReconciliationSessionCopyWithImpl<_ReconciliationSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReconciliationSession&&(identical(other.id, id) || other.id == id)&&(identical(other.bankAccountId, bankAccountId) || other.bankAccountId == bankAccountId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.matchedCount, matchedCount) || other.matchedCount == matchedCount)&&(identical(other.unmatchedCount, unmatchedCount) || other.unmatchedCount == unmatchedCount)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,bankAccountId,startedAt,status,matchedCount,unmatchedCount,totalAmount);

@override
String toString() {
  return 'ReconciliationSession(id: $id, bankAccountId: $bankAccountId, startedAt: $startedAt, status: $status, matchedCount: $matchedCount, unmatchedCount: $unmatchedCount, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$ReconciliationSessionCopyWith<$Res> implements $ReconciliationSessionCopyWith<$Res> {
  factory _$ReconciliationSessionCopyWith(_ReconciliationSession value, $Res Function(_ReconciliationSession) _then) = __$ReconciliationSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String bankAccountId, DateTime startedAt, ReconciliationStatus status, int matchedCount, int unmatchedCount, double totalAmount
});




}
/// @nodoc
class __$ReconciliationSessionCopyWithImpl<$Res>
    implements _$ReconciliationSessionCopyWith<$Res> {
  __$ReconciliationSessionCopyWithImpl(this._self, this._then);

  final _ReconciliationSession _self;
  final $Res Function(_ReconciliationSession) _then;

/// Create a copy of ReconciliationSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bankAccountId = null,Object? startedAt = null,Object? status = null,Object? matchedCount = null,Object? unmatchedCount = null,Object? totalAmount = null,}) {
  return _then(_ReconciliationSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bankAccountId: null == bankAccountId ? _self.bankAccountId : bankAccountId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReconciliationStatus,matchedCount: null == matchedCount ? _self.matchedCount : matchedCount // ignore: cast_nullable_to_non_nullable
as int,unmatchedCount: null == unmatchedCount ? _self.unmatchedCount : unmatchedCount // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
