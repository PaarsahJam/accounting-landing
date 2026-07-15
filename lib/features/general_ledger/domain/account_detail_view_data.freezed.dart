// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_detail_view_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountDetailViewData {

 LedgerAccount get account; List<AccountTransactionView> get transactions; double get currentBalance;
/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDetailViewDataCopyWith<AccountDetailViewData> get copyWith => _$AccountDetailViewDataCopyWithImpl<AccountDetailViewData>(this as AccountDetailViewData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDetailViewData&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance));
}


@override
int get hashCode => Object.hash(runtimeType,account,const DeepCollectionEquality().hash(transactions),currentBalance);

@override
String toString() {
  return 'AccountDetailViewData(account: $account, transactions: $transactions, currentBalance: $currentBalance)';
}


}

/// @nodoc
abstract mixin class $AccountDetailViewDataCopyWith<$Res>  {
  factory $AccountDetailViewDataCopyWith(AccountDetailViewData value, $Res Function(AccountDetailViewData) _then) = _$AccountDetailViewDataCopyWithImpl;
@useResult
$Res call({
 LedgerAccount account, List<AccountTransactionView> transactions, double currentBalance
});


$LedgerAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountDetailViewDataCopyWithImpl<$Res>
    implements $AccountDetailViewDataCopyWith<$Res> {
  _$AccountDetailViewDataCopyWithImpl(this._self, this._then);

  final AccountDetailViewData _self;
  final $Res Function(AccountDetailViewData) _then;

/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? transactions = null,Object? currentBalance = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as LedgerAccount,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<AccountTransactionView>,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res> get account {
  
  return $LedgerAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountDetailViewData].
extension AccountDetailViewDataPatterns on AccountDetailViewData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDetailViewData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDetailViewData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDetailViewData value)  $default,){
final _that = this;
switch (_that) {
case _AccountDetailViewData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDetailViewData value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDetailViewData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LedgerAccount account,  List<AccountTransactionView> transactions,  double currentBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDetailViewData() when $default != null:
return $default(_that.account,_that.transactions,_that.currentBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LedgerAccount account,  List<AccountTransactionView> transactions,  double currentBalance)  $default,) {final _that = this;
switch (_that) {
case _AccountDetailViewData():
return $default(_that.account,_that.transactions,_that.currentBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LedgerAccount account,  List<AccountTransactionView> transactions,  double currentBalance)?  $default,) {final _that = this;
switch (_that) {
case _AccountDetailViewData() when $default != null:
return $default(_that.account,_that.transactions,_that.currentBalance);case _:
  return null;

}
}

}

/// @nodoc


class _AccountDetailViewData implements AccountDetailViewData {
  const _AccountDetailViewData({required this.account, required final  List<AccountTransactionView> transactions, required this.currentBalance}): _transactions = transactions;
  

@override final  LedgerAccount account;
 final  List<AccountTransactionView> _transactions;
@override List<AccountTransactionView> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override final  double currentBalance;

/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDetailViewDataCopyWith<_AccountDetailViewData> get copyWith => __$AccountDetailViewDataCopyWithImpl<_AccountDetailViewData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDetailViewData&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance));
}


@override
int get hashCode => Object.hash(runtimeType,account,const DeepCollectionEquality().hash(_transactions),currentBalance);

@override
String toString() {
  return 'AccountDetailViewData(account: $account, transactions: $transactions, currentBalance: $currentBalance)';
}


}

/// @nodoc
abstract mixin class _$AccountDetailViewDataCopyWith<$Res> implements $AccountDetailViewDataCopyWith<$Res> {
  factory _$AccountDetailViewDataCopyWith(_AccountDetailViewData value, $Res Function(_AccountDetailViewData) _then) = __$AccountDetailViewDataCopyWithImpl;
@override @useResult
$Res call({
 LedgerAccount account, List<AccountTransactionView> transactions, double currentBalance
});


@override $LedgerAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$AccountDetailViewDataCopyWithImpl<$Res>
    implements _$AccountDetailViewDataCopyWith<$Res> {
  __$AccountDetailViewDataCopyWithImpl(this._self, this._then);

  final _AccountDetailViewData _self;
  final $Res Function(_AccountDetailViewData) _then;

/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? transactions = null,Object? currentBalance = null,}) {
  return _then(_AccountDetailViewData(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as LedgerAccount,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<AccountTransactionView>,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of AccountDetailViewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res> get account {
  
  return $LedgerAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

/// @nodoc
mixin _$AccountTransactionView {

 JournalEntry get entry; double get amount; bool get isDebit; String get description;
/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountTransactionViewCopyWith<AccountTransactionView> get copyWith => _$AccountTransactionViewCopyWithImpl<AccountTransactionView>(this as AccountTransactionView, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountTransactionView&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isDebit, isDebit) || other.isDebit == isDebit)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,entry,amount,isDebit,description);

@override
String toString() {
  return 'AccountTransactionView(entry: $entry, amount: $amount, isDebit: $isDebit, description: $description)';
}


}

/// @nodoc
abstract mixin class $AccountTransactionViewCopyWith<$Res>  {
  factory $AccountTransactionViewCopyWith(AccountTransactionView value, $Res Function(AccountTransactionView) _then) = _$AccountTransactionViewCopyWithImpl;
@useResult
$Res call({
 JournalEntry entry, double amount, bool isDebit, String description
});


$JournalEntryCopyWith<$Res> get entry;

}
/// @nodoc
class _$AccountTransactionViewCopyWithImpl<$Res>
    implements $AccountTransactionViewCopyWith<$Res> {
  _$AccountTransactionViewCopyWithImpl(this._self, this._then);

  final AccountTransactionView _self;
  final $Res Function(AccountTransactionView) _then;

/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entry = null,Object? amount = null,Object? isDebit = null,Object? description = null,}) {
  return _then(_self.copyWith(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as JournalEntry,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,isDebit: null == isDebit ? _self.isDebit : isDebit // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<$Res> get entry {
  
  return $JournalEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountTransactionView].
extension AccountTransactionViewPatterns on AccountTransactionView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountTransactionView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountTransactionView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountTransactionView value)  $default,){
final _that = this;
switch (_that) {
case _AccountTransactionView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountTransactionView value)?  $default,){
final _that = this;
switch (_that) {
case _AccountTransactionView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JournalEntry entry,  double amount,  bool isDebit,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountTransactionView() when $default != null:
return $default(_that.entry,_that.amount,_that.isDebit,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JournalEntry entry,  double amount,  bool isDebit,  String description)  $default,) {final _that = this;
switch (_that) {
case _AccountTransactionView():
return $default(_that.entry,_that.amount,_that.isDebit,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JournalEntry entry,  double amount,  bool isDebit,  String description)?  $default,) {final _that = this;
switch (_that) {
case _AccountTransactionView() when $default != null:
return $default(_that.entry,_that.amount,_that.isDebit,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _AccountTransactionView implements AccountTransactionView {
  const _AccountTransactionView({required this.entry, required this.amount, required this.isDebit, required this.description});
  

@override final  JournalEntry entry;
@override final  double amount;
@override final  bool isDebit;
@override final  String description;

/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountTransactionViewCopyWith<_AccountTransactionView> get copyWith => __$AccountTransactionViewCopyWithImpl<_AccountTransactionView>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountTransactionView&&(identical(other.entry, entry) || other.entry == entry)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isDebit, isDebit) || other.isDebit == isDebit)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,entry,amount,isDebit,description);

@override
String toString() {
  return 'AccountTransactionView(entry: $entry, amount: $amount, isDebit: $isDebit, description: $description)';
}


}

/// @nodoc
abstract mixin class _$AccountTransactionViewCopyWith<$Res> implements $AccountTransactionViewCopyWith<$Res> {
  factory _$AccountTransactionViewCopyWith(_AccountTransactionView value, $Res Function(_AccountTransactionView) _then) = __$AccountTransactionViewCopyWithImpl;
@override @useResult
$Res call({
 JournalEntry entry, double amount, bool isDebit, String description
});


@override $JournalEntryCopyWith<$Res> get entry;

}
/// @nodoc
class __$AccountTransactionViewCopyWithImpl<$Res>
    implements _$AccountTransactionViewCopyWith<$Res> {
  __$AccountTransactionViewCopyWithImpl(this._self, this._then);

  final _AccountTransactionView _self;
  final $Res Function(_AccountTransactionView) _then;

/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entry = null,Object? amount = null,Object? isDebit = null,Object? description = null,}) {
  return _then(_AccountTransactionView(
entry: null == entry ? _self.entry : entry // ignore: cast_nullable_to_non_nullable
as JournalEntry,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,isDebit: null == isDebit ? _self.isDebit : isDebit // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of AccountTransactionView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<$Res> get entry {
  
  return $JournalEntryCopyWith<$Res>(_self.entry, (value) {
    return _then(_self.copyWith(entry: value));
  });
}
}

// dart format on
