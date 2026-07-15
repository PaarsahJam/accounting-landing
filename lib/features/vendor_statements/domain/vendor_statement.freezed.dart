// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_statement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VendorStatement {

 String get id; String get vendorId; String get vendorName; double get openingBalance; double get runningBalance; double get outstandingBalance; List<VendorStatementEntry> get entries; List<VendorStatementBill> get billHistory; List<VendorStatementPayment> get paymentHistory; List<VendorAgingBucket> get agingBuckets;
/// Create a copy of VendorStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorStatementCopyWith<VendorStatement> get copyWith => _$VendorStatementCopyWithImpl<VendorStatement>(this as VendorStatement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorStatement&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.outstandingBalance, outstandingBalance) || other.outstandingBalance == outstandingBalance)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.billHistory, billHistory)&&const DeepCollectionEquality().equals(other.paymentHistory, paymentHistory)&&const DeepCollectionEquality().equals(other.agingBuckets, agingBuckets));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,openingBalance,runningBalance,outstandingBalance,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(billHistory),const DeepCollectionEquality().hash(paymentHistory),const DeepCollectionEquality().hash(agingBuckets));

@override
String toString() {
  return 'VendorStatement(id: $id, vendorId: $vendorId, vendorName: $vendorName, openingBalance: $openingBalance, runningBalance: $runningBalance, outstandingBalance: $outstandingBalance, entries: $entries, billHistory: $billHistory, paymentHistory: $paymentHistory, agingBuckets: $agingBuckets)';
}


}

/// @nodoc
abstract mixin class $VendorStatementCopyWith<$Res>  {
  factory $VendorStatementCopyWith(VendorStatement value, $Res Function(VendorStatement) _then) = _$VendorStatementCopyWithImpl;
@useResult
$Res call({
 String id, String vendorId, String vendorName, double openingBalance, double runningBalance, double outstandingBalance, List<VendorStatementEntry> entries, List<VendorStatementBill> billHistory, List<VendorStatementPayment> paymentHistory, List<VendorAgingBucket> agingBuckets
});




}
/// @nodoc
class _$VendorStatementCopyWithImpl<$Res>
    implements $VendorStatementCopyWith<$Res> {
  _$VendorStatementCopyWithImpl(this._self, this._then);

  final VendorStatement _self;
  final $Res Function(VendorStatement) _then;

/// Create a copy of VendorStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? openingBalance = null,Object? runningBalance = null,Object? outstandingBalance = null,Object? entries = null,Object? billHistory = null,Object? paymentHistory = null,Object? agingBuckets = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,outstandingBalance: null == outstandingBalance ? _self.outstandingBalance : outstandingBalance // ignore: cast_nullable_to_non_nullable
as double,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<VendorStatementEntry>,billHistory: null == billHistory ? _self.billHistory : billHistory // ignore: cast_nullable_to_non_nullable
as List<VendorStatementBill>,paymentHistory: null == paymentHistory ? _self.paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as List<VendorStatementPayment>,agingBuckets: null == agingBuckets ? _self.agingBuckets : agingBuckets // ignore: cast_nullable_to_non_nullable
as List<VendorAgingBucket>,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorStatement].
extension VendorStatementPatterns on VendorStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorStatement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorStatement value)  $default,){
final _that = this;
switch (_that) {
case _VendorStatement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorStatement value)?  $default,){
final _that = this;
switch (_that) {
case _VendorStatement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<VendorStatementEntry> entries,  List<VendorStatementBill> billHistory,  List<VendorStatementPayment> paymentHistory,  List<VendorAgingBucket> agingBuckets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorStatement() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.billHistory,_that.paymentHistory,_that.agingBuckets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String vendorId,  String vendorName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<VendorStatementEntry> entries,  List<VendorStatementBill> billHistory,  List<VendorStatementPayment> paymentHistory,  List<VendorAgingBucket> agingBuckets)  $default,) {final _that = this;
switch (_that) {
case _VendorStatement():
return $default(_that.id,_that.vendorId,_that.vendorName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.billHistory,_that.paymentHistory,_that.agingBuckets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String vendorId,  String vendorName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<VendorStatementEntry> entries,  List<VendorStatementBill> billHistory,  List<VendorStatementPayment> paymentHistory,  List<VendorAgingBucket> agingBuckets)?  $default,) {final _that = this;
switch (_that) {
case _VendorStatement() when $default != null:
return $default(_that.id,_that.vendorId,_that.vendorName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.billHistory,_that.paymentHistory,_that.agingBuckets);case _:
  return null;

}
}

}

/// @nodoc


class _VendorStatement implements VendorStatement {
  const _VendorStatement({required this.id, required this.vendorId, required this.vendorName, required this.openingBalance, required this.runningBalance, required this.outstandingBalance, required final  List<VendorStatementEntry> entries, required final  List<VendorStatementBill> billHistory, required final  List<VendorStatementPayment> paymentHistory, required final  List<VendorAgingBucket> agingBuckets}): _entries = entries,_billHistory = billHistory,_paymentHistory = paymentHistory,_agingBuckets = agingBuckets;
  

@override final  String id;
@override final  String vendorId;
@override final  String vendorName;
@override final  double openingBalance;
@override final  double runningBalance;
@override final  double outstandingBalance;
 final  List<VendorStatementEntry> _entries;
@override List<VendorStatementEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<VendorStatementBill> _billHistory;
@override List<VendorStatementBill> get billHistory {
  if (_billHistory is EqualUnmodifiableListView) return _billHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_billHistory);
}

 final  List<VendorStatementPayment> _paymentHistory;
@override List<VendorStatementPayment> get paymentHistory {
  if (_paymentHistory is EqualUnmodifiableListView) return _paymentHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentHistory);
}

 final  List<VendorAgingBucket> _agingBuckets;
@override List<VendorAgingBucket> get agingBuckets {
  if (_agingBuckets is EqualUnmodifiableListView) return _agingBuckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_agingBuckets);
}


/// Create a copy of VendorStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorStatementCopyWith<_VendorStatement> get copyWith => __$VendorStatementCopyWithImpl<_VendorStatement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorStatement&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.outstandingBalance, outstandingBalance) || other.outstandingBalance == outstandingBalance)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._billHistory, _billHistory)&&const DeepCollectionEquality().equals(other._paymentHistory, _paymentHistory)&&const DeepCollectionEquality().equals(other._agingBuckets, _agingBuckets));
}


@override
int get hashCode => Object.hash(runtimeType,id,vendorId,vendorName,openingBalance,runningBalance,outstandingBalance,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_billHistory),const DeepCollectionEquality().hash(_paymentHistory),const DeepCollectionEquality().hash(_agingBuckets));

@override
String toString() {
  return 'VendorStatement(id: $id, vendorId: $vendorId, vendorName: $vendorName, openingBalance: $openingBalance, runningBalance: $runningBalance, outstandingBalance: $outstandingBalance, entries: $entries, billHistory: $billHistory, paymentHistory: $paymentHistory, agingBuckets: $agingBuckets)';
}


}

/// @nodoc
abstract mixin class _$VendorStatementCopyWith<$Res> implements $VendorStatementCopyWith<$Res> {
  factory _$VendorStatementCopyWith(_VendorStatement value, $Res Function(_VendorStatement) _then) = __$VendorStatementCopyWithImpl;
@override @useResult
$Res call({
 String id, String vendorId, String vendorName, double openingBalance, double runningBalance, double outstandingBalance, List<VendorStatementEntry> entries, List<VendorStatementBill> billHistory, List<VendorStatementPayment> paymentHistory, List<VendorAgingBucket> agingBuckets
});




}
/// @nodoc
class __$VendorStatementCopyWithImpl<$Res>
    implements _$VendorStatementCopyWith<$Res> {
  __$VendorStatementCopyWithImpl(this._self, this._then);

  final _VendorStatement _self;
  final $Res Function(_VendorStatement) _then;

/// Create a copy of VendorStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendorId = null,Object? vendorName = null,Object? openingBalance = null,Object? runningBalance = null,Object? outstandingBalance = null,Object? entries = null,Object? billHistory = null,Object? paymentHistory = null,Object? agingBuckets = null,}) {
  return _then(_VendorStatement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,outstandingBalance: null == outstandingBalance ? _self.outstandingBalance : outstandingBalance // ignore: cast_nullable_to_non_nullable
as double,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<VendorStatementEntry>,billHistory: null == billHistory ? _self._billHistory : billHistory // ignore: cast_nullable_to_non_nullable
as List<VendorStatementBill>,paymentHistory: null == paymentHistory ? _self._paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as List<VendorStatementPayment>,agingBuckets: null == agingBuckets ? _self._agingBuckets : agingBuckets // ignore: cast_nullable_to_non_nullable
as List<VendorAgingBucket>,
  ));
}


}

/// @nodoc
mixin _$VendorStatementEntry {

 String get id; DateTime get date; String get description; double get amount; String get type; double get runningBalance;
/// Create a copy of VendorStatementEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorStatementEntryCopyWith<VendorStatementEntry> get copyWith => _$VendorStatementEntryCopyWithImpl<VendorStatementEntry>(this as VendorStatementEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorStatementEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,description,amount,type,runningBalance);

@override
String toString() {
  return 'VendorStatementEntry(id: $id, date: $date, description: $description, amount: $amount, type: $type, runningBalance: $runningBalance)';
}


}

/// @nodoc
abstract mixin class $VendorStatementEntryCopyWith<$Res>  {
  factory $VendorStatementEntryCopyWith(VendorStatementEntry value, $Res Function(VendorStatementEntry) _then) = _$VendorStatementEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String description, double amount, String type, double runningBalance
});




}
/// @nodoc
class _$VendorStatementEntryCopyWithImpl<$Res>
    implements $VendorStatementEntryCopyWith<$Res> {
  _$VendorStatementEntryCopyWithImpl(this._self, this._then);

  final VendorStatementEntry _self;
  final $Res Function(VendorStatementEntry) _then;

/// Create a copy of VendorStatementEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? description = null,Object? amount = null,Object? type = null,Object? runningBalance = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorStatementEntry].
extension VendorStatementEntryPatterns on VendorStatementEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorStatementEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorStatementEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorStatementEntry value)  $default,){
final _that = this;
switch (_that) {
case _VendorStatementEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorStatementEntry value)?  $default,){
final _that = this;
switch (_that) {
case _VendorStatementEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String description,  double amount,  String type,  double runningBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorStatementEntry() when $default != null:
return $default(_that.id,_that.date,_that.description,_that.amount,_that.type,_that.runningBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String description,  double amount,  String type,  double runningBalance)  $default,) {final _that = this;
switch (_that) {
case _VendorStatementEntry():
return $default(_that.id,_that.date,_that.description,_that.amount,_that.type,_that.runningBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String description,  double amount,  String type,  double runningBalance)?  $default,) {final _that = this;
switch (_that) {
case _VendorStatementEntry() when $default != null:
return $default(_that.id,_that.date,_that.description,_that.amount,_that.type,_that.runningBalance);case _:
  return null;

}
}

}

/// @nodoc


class _VendorStatementEntry implements VendorStatementEntry {
  const _VendorStatementEntry({required this.id, required this.date, required this.description, required this.amount, required this.type, required this.runningBalance});
  

@override final  String id;
@override final  DateTime date;
@override final  String description;
@override final  double amount;
@override final  String type;
@override final  double runningBalance;

/// Create a copy of VendorStatementEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorStatementEntryCopyWith<_VendorStatementEntry> get copyWith => __$VendorStatementEntryCopyWithImpl<_VendorStatementEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorStatementEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,description,amount,type,runningBalance);

@override
String toString() {
  return 'VendorStatementEntry(id: $id, date: $date, description: $description, amount: $amount, type: $type, runningBalance: $runningBalance)';
}


}

/// @nodoc
abstract mixin class _$VendorStatementEntryCopyWith<$Res> implements $VendorStatementEntryCopyWith<$Res> {
  factory _$VendorStatementEntryCopyWith(_VendorStatementEntry value, $Res Function(_VendorStatementEntry) _then) = __$VendorStatementEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String description, double amount, String type, double runningBalance
});




}
/// @nodoc
class __$VendorStatementEntryCopyWithImpl<$Res>
    implements _$VendorStatementEntryCopyWith<$Res> {
  __$VendorStatementEntryCopyWithImpl(this._self, this._then);

  final _VendorStatementEntry _self;
  final $Res Function(_VendorStatementEntry) _then;

/// Create a copy of VendorStatementEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? description = null,Object? amount = null,Object? type = null,Object? runningBalance = null,}) {
  return _then(_VendorStatementEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$VendorStatementBill {

 String get id; String get reference; DateTime get billDate; DateTime get dueDate; double get amount; String get status;
/// Create a copy of VendorStatementBill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorStatementBillCopyWith<VendorStatementBill> get copyWith => _$VendorStatementBillCopyWithImpl<VendorStatementBill>(this as VendorStatementBill, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorStatementBill&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.billDate, billDate) || other.billDate == billDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,billDate,dueDate,amount,status);

@override
String toString() {
  return 'VendorStatementBill(id: $id, reference: $reference, billDate: $billDate, dueDate: $dueDate, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class $VendorStatementBillCopyWith<$Res>  {
  factory $VendorStatementBillCopyWith(VendorStatementBill value, $Res Function(VendorStatementBill) _then) = _$VendorStatementBillCopyWithImpl;
@useResult
$Res call({
 String id, String reference, DateTime billDate, DateTime dueDate, double amount, String status
});




}
/// @nodoc
class _$VendorStatementBillCopyWithImpl<$Res>
    implements $VendorStatementBillCopyWith<$Res> {
  _$VendorStatementBillCopyWithImpl(this._self, this._then);

  final VendorStatementBill _self;
  final $Res Function(VendorStatementBill) _then;

/// Create a copy of VendorStatementBill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? billDate = null,Object? dueDate = null,Object? amount = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,billDate: null == billDate ? _self.billDate : billDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorStatementBill].
extension VendorStatementBillPatterns on VendorStatementBill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorStatementBill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorStatementBill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorStatementBill value)  $default,){
final _that = this;
switch (_that) {
case _VendorStatementBill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorStatementBill value)?  $default,){
final _that = this;
switch (_that) {
case _VendorStatementBill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime billDate,  DateTime dueDate,  double amount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorStatementBill() when $default != null:
return $default(_that.id,_that.reference,_that.billDate,_that.dueDate,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime billDate,  DateTime dueDate,  double amount,  String status)  $default,) {final _that = this;
switch (_that) {
case _VendorStatementBill():
return $default(_that.id,_that.reference,_that.billDate,_that.dueDate,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  DateTime billDate,  DateTime dueDate,  double amount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _VendorStatementBill() when $default != null:
return $default(_that.id,_that.reference,_that.billDate,_that.dueDate,_that.amount,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _VendorStatementBill implements VendorStatementBill {
  const _VendorStatementBill({required this.id, required this.reference, required this.billDate, required this.dueDate, required this.amount, required this.status});
  

@override final  String id;
@override final  String reference;
@override final  DateTime billDate;
@override final  DateTime dueDate;
@override final  double amount;
@override final  String status;

/// Create a copy of VendorStatementBill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorStatementBillCopyWith<_VendorStatementBill> get copyWith => __$VendorStatementBillCopyWithImpl<_VendorStatementBill>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorStatementBill&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.billDate, billDate) || other.billDate == billDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,billDate,dueDate,amount,status);

@override
String toString() {
  return 'VendorStatementBill(id: $id, reference: $reference, billDate: $billDate, dueDate: $dueDate, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$VendorStatementBillCopyWith<$Res> implements $VendorStatementBillCopyWith<$Res> {
  factory _$VendorStatementBillCopyWith(_VendorStatementBill value, $Res Function(_VendorStatementBill) _then) = __$VendorStatementBillCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, DateTime billDate, DateTime dueDate, double amount, String status
});




}
/// @nodoc
class __$VendorStatementBillCopyWithImpl<$Res>
    implements _$VendorStatementBillCopyWith<$Res> {
  __$VendorStatementBillCopyWithImpl(this._self, this._then);

  final _VendorStatementBill _self;
  final $Res Function(_VendorStatementBill) _then;

/// Create a copy of VendorStatementBill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? billDate = null,Object? dueDate = null,Object? amount = null,Object? status = null,}) {
  return _then(_VendorStatementBill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,billDate: null == billDate ? _self.billDate : billDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VendorStatementPayment {

 String get id; String get reference; DateTime get paymentDate; double get amount; String get method;
/// Create a copy of VendorStatementPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorStatementPaymentCopyWith<VendorStatementPayment> get copyWith => _$VendorStatementPaymentCopyWithImpl<VendorStatementPayment>(this as VendorStatementPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorStatementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,paymentDate,amount,method);

@override
String toString() {
  return 'VendorStatementPayment(id: $id, reference: $reference, paymentDate: $paymentDate, amount: $amount, method: $method)';
}


}

/// @nodoc
abstract mixin class $VendorStatementPaymentCopyWith<$Res>  {
  factory $VendorStatementPaymentCopyWith(VendorStatementPayment value, $Res Function(VendorStatementPayment) _then) = _$VendorStatementPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String reference, DateTime paymentDate, double amount, String method
});




}
/// @nodoc
class _$VendorStatementPaymentCopyWithImpl<$Res>
    implements $VendorStatementPaymentCopyWith<$Res> {
  _$VendorStatementPaymentCopyWithImpl(this._self, this._then);

  final VendorStatementPayment _self;
  final $Res Function(VendorStatementPayment) _then;

/// Create a copy of VendorStatementPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? paymentDate = null,Object? amount = null,Object? method = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorStatementPayment].
extension VendorStatementPaymentPatterns on VendorStatementPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorStatementPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorStatementPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorStatementPayment value)  $default,){
final _that = this;
switch (_that) {
case _VendorStatementPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorStatementPayment value)?  $default,){
final _that = this;
switch (_that) {
case _VendorStatementPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime paymentDate,  double amount,  String method)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorStatementPayment() when $default != null:
return $default(_that.id,_that.reference,_that.paymentDate,_that.amount,_that.method);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime paymentDate,  double amount,  String method)  $default,) {final _that = this;
switch (_that) {
case _VendorStatementPayment():
return $default(_that.id,_that.reference,_that.paymentDate,_that.amount,_that.method);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  DateTime paymentDate,  double amount,  String method)?  $default,) {final _that = this;
switch (_that) {
case _VendorStatementPayment() when $default != null:
return $default(_that.id,_that.reference,_that.paymentDate,_that.amount,_that.method);case _:
  return null;

}
}

}

/// @nodoc


class _VendorStatementPayment implements VendorStatementPayment {
  const _VendorStatementPayment({required this.id, required this.reference, required this.paymentDate, required this.amount, required this.method});
  

@override final  String id;
@override final  String reference;
@override final  DateTime paymentDate;
@override final  double amount;
@override final  String method;

/// Create a copy of VendorStatementPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorStatementPaymentCopyWith<_VendorStatementPayment> get copyWith => __$VendorStatementPaymentCopyWithImpl<_VendorStatementPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorStatementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,paymentDate,amount,method);

@override
String toString() {
  return 'VendorStatementPayment(id: $id, reference: $reference, paymentDate: $paymentDate, amount: $amount, method: $method)';
}


}

/// @nodoc
abstract mixin class _$VendorStatementPaymentCopyWith<$Res> implements $VendorStatementPaymentCopyWith<$Res> {
  factory _$VendorStatementPaymentCopyWith(_VendorStatementPayment value, $Res Function(_VendorStatementPayment) _then) = __$VendorStatementPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, DateTime paymentDate, double amount, String method
});




}
/// @nodoc
class __$VendorStatementPaymentCopyWithImpl<$Res>
    implements _$VendorStatementPaymentCopyWith<$Res> {
  __$VendorStatementPaymentCopyWithImpl(this._self, this._then);

  final _VendorStatementPayment _self;
  final $Res Function(_VendorStatementPayment) _then;

/// Create a copy of VendorStatementPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? paymentDate = null,Object? amount = null,Object? method = null,}) {
  return _then(_VendorStatementPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VendorAgingBucket {

 String get id; String get label; double get amount;
/// Create a copy of VendorAgingBucket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorAgingBucketCopyWith<VendorAgingBucket> get copyWith => _$VendorAgingBucketCopyWithImpl<VendorAgingBucket>(this as VendorAgingBucket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorAgingBucket&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,amount);

@override
String toString() {
  return 'VendorAgingBucket(id: $id, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $VendorAgingBucketCopyWith<$Res>  {
  factory $VendorAgingBucketCopyWith(VendorAgingBucket value, $Res Function(VendorAgingBucket) _then) = _$VendorAgingBucketCopyWithImpl;
@useResult
$Res call({
 String id, String label, double amount
});




}
/// @nodoc
class _$VendorAgingBucketCopyWithImpl<$Res>
    implements $VendorAgingBucketCopyWith<$Res> {
  _$VendorAgingBucketCopyWithImpl(this._self, this._then);

  final VendorAgingBucket _self;
  final $Res Function(VendorAgingBucket) _then;

/// Create a copy of VendorAgingBucket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? amount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorAgingBucket].
extension VendorAgingBucketPatterns on VendorAgingBucket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorAgingBucket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorAgingBucket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorAgingBucket value)  $default,){
final _that = this;
switch (_that) {
case _VendorAgingBucket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorAgingBucket value)?  $default,){
final _that = this;
switch (_that) {
case _VendorAgingBucket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorAgingBucket() when $default != null:
return $default(_that.id,_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  double amount)  $default,) {final _that = this;
switch (_that) {
case _VendorAgingBucket():
return $default(_that.id,_that.label,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _VendorAgingBucket() when $default != null:
return $default(_that.id,_that.label,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _VendorAgingBucket implements VendorAgingBucket {
  const _VendorAgingBucket({required this.id, required this.label, required this.amount});
  

@override final  String id;
@override final  String label;
@override final  double amount;

/// Create a copy of VendorAgingBucket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorAgingBucketCopyWith<_VendorAgingBucket> get copyWith => __$VendorAgingBucketCopyWithImpl<_VendorAgingBucket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorAgingBucket&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,amount);

@override
String toString() {
  return 'VendorAgingBucket(id: $id, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$VendorAgingBucketCopyWith<$Res> implements $VendorAgingBucketCopyWith<$Res> {
  factory _$VendorAgingBucketCopyWith(_VendorAgingBucket value, $Res Function(_VendorAgingBucket) _then) = __$VendorAgingBucketCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, double amount
});




}
/// @nodoc
class __$VendorAgingBucketCopyWithImpl<$Res>
    implements _$VendorAgingBucketCopyWith<$Res> {
  __$VendorAgingBucketCopyWithImpl(this._self, this._then);

  final _VendorAgingBucket _self;
  final $Res Function(_VendorAgingBucket) _then;

/// Create a copy of VendorAgingBucket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? amount = null,}) {
  return _then(_VendorAgingBucket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
