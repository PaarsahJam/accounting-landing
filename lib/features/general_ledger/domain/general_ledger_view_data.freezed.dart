// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_ledger_view_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneralLedgerViewData {

 List<LedgerAccount> get accounts; List<JournalEntry> get entries; BalanceSnapshot get snapshot; List<TrialBalanceLine> get trialBalance;
/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralLedgerViewDataCopyWith<GeneralLedgerViewData> get copyWith => _$GeneralLedgerViewDataCopyWithImpl<GeneralLedgerViewData>(this as GeneralLedgerViewData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralLedgerViewData&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&const DeepCollectionEquality().equals(other.trialBalance, trialBalance));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(entries),snapshot,const DeepCollectionEquality().hash(trialBalance));

@override
String toString() {
  return 'GeneralLedgerViewData(accounts: $accounts, entries: $entries, snapshot: $snapshot, trialBalance: $trialBalance)';
}


}

/// @nodoc
abstract mixin class $GeneralLedgerViewDataCopyWith<$Res>  {
  factory $GeneralLedgerViewDataCopyWith(GeneralLedgerViewData value, $Res Function(GeneralLedgerViewData) _then) = _$GeneralLedgerViewDataCopyWithImpl;
@useResult
$Res call({
 List<LedgerAccount> accounts, List<JournalEntry> entries, BalanceSnapshot snapshot, List<TrialBalanceLine> trialBalance
});


$BalanceSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class _$GeneralLedgerViewDataCopyWithImpl<$Res>
    implements $GeneralLedgerViewDataCopyWith<$Res> {
  _$GeneralLedgerViewDataCopyWithImpl(this._self, this._then);

  final GeneralLedgerViewData _self;
  final $Res Function(GeneralLedgerViewData) _then;

/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,Object? entries = null,Object? snapshot = null,Object? trialBalance = null,}) {
  return _then(_self.copyWith(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<LedgerAccount>,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<JournalEntry>,snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as BalanceSnapshot,trialBalance: null == trialBalance ? _self.trialBalance : trialBalance // ignore: cast_nullable_to_non_nullable
as List<TrialBalanceLine>,
  ));
}
/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSnapshotCopyWith<$Res> get snapshot {
  
  return $BalanceSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [GeneralLedgerViewData].
extension GeneralLedgerViewDataPatterns on GeneralLedgerViewData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneralLedgerViewData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneralLedgerViewData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneralLedgerViewData value)  $default,){
final _that = this;
switch (_that) {
case _GeneralLedgerViewData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneralLedgerViewData value)?  $default,){
final _that = this;
switch (_that) {
case _GeneralLedgerViewData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LedgerAccount> accounts,  List<JournalEntry> entries,  BalanceSnapshot snapshot,  List<TrialBalanceLine> trialBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneralLedgerViewData() when $default != null:
return $default(_that.accounts,_that.entries,_that.snapshot,_that.trialBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LedgerAccount> accounts,  List<JournalEntry> entries,  BalanceSnapshot snapshot,  List<TrialBalanceLine> trialBalance)  $default,) {final _that = this;
switch (_that) {
case _GeneralLedgerViewData():
return $default(_that.accounts,_that.entries,_that.snapshot,_that.trialBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LedgerAccount> accounts,  List<JournalEntry> entries,  BalanceSnapshot snapshot,  List<TrialBalanceLine> trialBalance)?  $default,) {final _that = this;
switch (_that) {
case _GeneralLedgerViewData() when $default != null:
return $default(_that.accounts,_that.entries,_that.snapshot,_that.trialBalance);case _:
  return null;

}
}

}

/// @nodoc


class _GeneralLedgerViewData implements GeneralLedgerViewData {
  const _GeneralLedgerViewData({required final  List<LedgerAccount> accounts, required final  List<JournalEntry> entries, required this.snapshot, required final  List<TrialBalanceLine> trialBalance}): _accounts = accounts,_entries = entries,_trialBalance = trialBalance;
  

 final  List<LedgerAccount> _accounts;
@override List<LedgerAccount> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<JournalEntry> _entries;
@override List<JournalEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  BalanceSnapshot snapshot;
 final  List<TrialBalanceLine> _trialBalance;
@override List<TrialBalanceLine> get trialBalance {
  if (_trialBalance is EqualUnmodifiableListView) return _trialBalance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trialBalance);
}


/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralLedgerViewDataCopyWith<_GeneralLedgerViewData> get copyWith => __$GeneralLedgerViewDataCopyWithImpl<_GeneralLedgerViewData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralLedgerViewData&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.snapshot, snapshot) || other.snapshot == snapshot)&&const DeepCollectionEquality().equals(other._trialBalance, _trialBalance));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_entries),snapshot,const DeepCollectionEquality().hash(_trialBalance));

@override
String toString() {
  return 'GeneralLedgerViewData(accounts: $accounts, entries: $entries, snapshot: $snapshot, trialBalance: $trialBalance)';
}


}

/// @nodoc
abstract mixin class _$GeneralLedgerViewDataCopyWith<$Res> implements $GeneralLedgerViewDataCopyWith<$Res> {
  factory _$GeneralLedgerViewDataCopyWith(_GeneralLedgerViewData value, $Res Function(_GeneralLedgerViewData) _then) = __$GeneralLedgerViewDataCopyWithImpl;
@override @useResult
$Res call({
 List<LedgerAccount> accounts, List<JournalEntry> entries, BalanceSnapshot snapshot, List<TrialBalanceLine> trialBalance
});


@override $BalanceSnapshotCopyWith<$Res> get snapshot;

}
/// @nodoc
class __$GeneralLedgerViewDataCopyWithImpl<$Res>
    implements _$GeneralLedgerViewDataCopyWith<$Res> {
  __$GeneralLedgerViewDataCopyWithImpl(this._self, this._then);

  final _GeneralLedgerViewData _self;
  final $Res Function(_GeneralLedgerViewData) _then;

/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accounts = null,Object? entries = null,Object? snapshot = null,Object? trialBalance = null,}) {
  return _then(_GeneralLedgerViewData(
accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<LedgerAccount>,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<JournalEntry>,snapshot: null == snapshot ? _self.snapshot : snapshot // ignore: cast_nullable_to_non_nullable
as BalanceSnapshot,trialBalance: null == trialBalance ? _self._trialBalance : trialBalance // ignore: cast_nullable_to_non_nullable
as List<TrialBalanceLine>,
  ));
}

/// Create a copy of GeneralLedgerViewData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BalanceSnapshotCopyWith<$Res> get snapshot {
  
  return $BalanceSnapshotCopyWith<$Res>(_self.snapshot, (value) {
    return _then(_self.copyWith(snapshot: value));
  });
}
}

/// @nodoc
mixin _$TrialBalanceLine {

 LedgerAccount get account; double get debit; double get credit;
/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrialBalanceLineCopyWith<TrialBalanceLine> get copyWith => _$TrialBalanceLineCopyWithImpl<TrialBalanceLine>(this as TrialBalanceLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrialBalanceLine&&(identical(other.account, account) || other.account == account)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit));
}


@override
int get hashCode => Object.hash(runtimeType,account,debit,credit);

@override
String toString() {
  return 'TrialBalanceLine(account: $account, debit: $debit, credit: $credit)';
}


}

/// @nodoc
abstract mixin class $TrialBalanceLineCopyWith<$Res>  {
  factory $TrialBalanceLineCopyWith(TrialBalanceLine value, $Res Function(TrialBalanceLine) _then) = _$TrialBalanceLineCopyWithImpl;
@useResult
$Res call({
 LedgerAccount account, double debit, double credit
});


$LedgerAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$TrialBalanceLineCopyWithImpl<$Res>
    implements $TrialBalanceLineCopyWith<$Res> {
  _$TrialBalanceLineCopyWithImpl(this._self, this._then);

  final TrialBalanceLine _self;
  final $Res Function(TrialBalanceLine) _then;

/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? debit = null,Object? credit = null,}) {
  return _then(_self.copyWith(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as LedgerAccount,debit: null == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res> get account {
  
  return $LedgerAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrialBalanceLine].
extension TrialBalanceLinePatterns on TrialBalanceLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrialBalanceLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrialBalanceLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrialBalanceLine value)  $default,){
final _that = this;
switch (_that) {
case _TrialBalanceLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrialBalanceLine value)?  $default,){
final _that = this;
switch (_that) {
case _TrialBalanceLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LedgerAccount account,  double debit,  double credit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrialBalanceLine() when $default != null:
return $default(_that.account,_that.debit,_that.credit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LedgerAccount account,  double debit,  double credit)  $default,) {final _that = this;
switch (_that) {
case _TrialBalanceLine():
return $default(_that.account,_that.debit,_that.credit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LedgerAccount account,  double debit,  double credit)?  $default,) {final _that = this;
switch (_that) {
case _TrialBalanceLine() when $default != null:
return $default(_that.account,_that.debit,_that.credit);case _:
  return null;

}
}

}

/// @nodoc


class _TrialBalanceLine implements TrialBalanceLine {
  const _TrialBalanceLine({required this.account, required this.debit, required this.credit});
  

@override final  LedgerAccount account;
@override final  double debit;
@override final  double credit;

/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrialBalanceLineCopyWith<_TrialBalanceLine> get copyWith => __$TrialBalanceLineCopyWithImpl<_TrialBalanceLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrialBalanceLine&&(identical(other.account, account) || other.account == account)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit));
}


@override
int get hashCode => Object.hash(runtimeType,account,debit,credit);

@override
String toString() {
  return 'TrialBalanceLine(account: $account, debit: $debit, credit: $credit)';
}


}

/// @nodoc
abstract mixin class _$TrialBalanceLineCopyWith<$Res> implements $TrialBalanceLineCopyWith<$Res> {
  factory _$TrialBalanceLineCopyWith(_TrialBalanceLine value, $Res Function(_TrialBalanceLine) _then) = __$TrialBalanceLineCopyWithImpl;
@override @useResult
$Res call({
 LedgerAccount account, double debit, double credit
});


@override $LedgerAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$TrialBalanceLineCopyWithImpl<$Res>
    implements _$TrialBalanceLineCopyWith<$Res> {
  __$TrialBalanceLineCopyWithImpl(this._self, this._then);

  final _TrialBalanceLine _self;
  final $Res Function(_TrialBalanceLine) _then;

/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? debit = null,Object? credit = null,}) {
  return _then(_TrialBalanceLine(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as LedgerAccount,debit: null == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double,credit: null == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of TrialBalanceLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LedgerAccountCopyWith<$Res> get account {
  
  return $LedgerAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
