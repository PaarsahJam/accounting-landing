// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_statement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerStatement {

 String get id; String get customerId; String get customerName; double get openingBalance; double get runningBalance; double get outstandingBalance; List<CustomerStatementEntry> get entries; List<CustomerStatementInvoice> get invoiceHistory; List<CustomerStatementPayment> get paymentHistory; List<CustomerAgingBucket> get agingBuckets;
/// Create a copy of CustomerStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatementCopyWith<CustomerStatement> get copyWith => _$CustomerStatementCopyWithImpl<CustomerStatement>(this as CustomerStatement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStatement&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.outstandingBalance, outstandingBalance) || other.outstandingBalance == outstandingBalance)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.invoiceHistory, invoiceHistory)&&const DeepCollectionEquality().equals(other.paymentHistory, paymentHistory)&&const DeepCollectionEquality().equals(other.agingBuckets, agingBuckets));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,openingBalance,runningBalance,outstandingBalance,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(invoiceHistory),const DeepCollectionEquality().hash(paymentHistory),const DeepCollectionEquality().hash(agingBuckets));

@override
String toString() {
  return 'CustomerStatement(id: $id, customerId: $customerId, customerName: $customerName, openingBalance: $openingBalance, runningBalance: $runningBalance, outstandingBalance: $outstandingBalance, entries: $entries, invoiceHistory: $invoiceHistory, paymentHistory: $paymentHistory, agingBuckets: $agingBuckets)';
}


}

/// @nodoc
abstract mixin class $CustomerStatementCopyWith<$Res>  {
  factory $CustomerStatementCopyWith(CustomerStatement value, $Res Function(CustomerStatement) _then) = _$CustomerStatementCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, double openingBalance, double runningBalance, double outstandingBalance, List<CustomerStatementEntry> entries, List<CustomerStatementInvoice> invoiceHistory, List<CustomerStatementPayment> paymentHistory, List<CustomerAgingBucket> agingBuckets
});




}
/// @nodoc
class _$CustomerStatementCopyWithImpl<$Res>
    implements $CustomerStatementCopyWith<$Res> {
  _$CustomerStatementCopyWithImpl(this._self, this._then);

  final CustomerStatement _self;
  final $Res Function(CustomerStatement) _then;

/// Create a copy of CustomerStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? openingBalance = null,Object? runningBalance = null,Object? outstandingBalance = null,Object? entries = null,Object? invoiceHistory = null,Object? paymentHistory = null,Object? agingBuckets = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,outstandingBalance: null == outstandingBalance ? _self.outstandingBalance : outstandingBalance // ignore: cast_nullable_to_non_nullable
as double,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementEntry>,invoiceHistory: null == invoiceHistory ? _self.invoiceHistory : invoiceHistory // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementInvoice>,paymentHistory: null == paymentHistory ? _self.paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementPayment>,agingBuckets: null == agingBuckets ? _self.agingBuckets : agingBuckets // ignore: cast_nullable_to_non_nullable
as List<CustomerAgingBucket>,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerStatement].
extension CustomerStatementPatterns on CustomerStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStatement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStatement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStatement value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStatement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStatement value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStatement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<CustomerStatementEntry> entries,  List<CustomerStatementInvoice> invoiceHistory,  List<CustomerStatementPayment> paymentHistory,  List<CustomerAgingBucket> agingBuckets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerStatement() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.invoiceHistory,_that.paymentHistory,_that.agingBuckets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<CustomerStatementEntry> entries,  List<CustomerStatementInvoice> invoiceHistory,  List<CustomerStatementPayment> paymentHistory,  List<CustomerAgingBucket> agingBuckets)  $default,) {final _that = this;
switch (_that) {
case _CustomerStatement():
return $default(_that.id,_that.customerId,_that.customerName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.invoiceHistory,_that.paymentHistory,_that.agingBuckets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  double openingBalance,  double runningBalance,  double outstandingBalance,  List<CustomerStatementEntry> entries,  List<CustomerStatementInvoice> invoiceHistory,  List<CustomerStatementPayment> paymentHistory,  List<CustomerAgingBucket> agingBuckets)?  $default,) {final _that = this;
switch (_that) {
case _CustomerStatement() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.openingBalance,_that.runningBalance,_that.outstandingBalance,_that.entries,_that.invoiceHistory,_that.paymentHistory,_that.agingBuckets);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStatement implements CustomerStatement {
  const _CustomerStatement({required this.id, required this.customerId, required this.customerName, required this.openingBalance, required this.runningBalance, required this.outstandingBalance, required final  List<CustomerStatementEntry> entries, required final  List<CustomerStatementInvoice> invoiceHistory, required final  List<CustomerStatementPayment> paymentHistory, required final  List<CustomerAgingBucket> agingBuckets}): _entries = entries,_invoiceHistory = invoiceHistory,_paymentHistory = paymentHistory,_agingBuckets = agingBuckets;
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  double openingBalance;
@override final  double runningBalance;
@override final  double outstandingBalance;
 final  List<CustomerStatementEntry> _entries;
@override List<CustomerStatementEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<CustomerStatementInvoice> _invoiceHistory;
@override List<CustomerStatementInvoice> get invoiceHistory {
  if (_invoiceHistory is EqualUnmodifiableListView) return _invoiceHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_invoiceHistory);
}

 final  List<CustomerStatementPayment> _paymentHistory;
@override List<CustomerStatementPayment> get paymentHistory {
  if (_paymentHistory is EqualUnmodifiableListView) return _paymentHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentHistory);
}

 final  List<CustomerAgingBucket> _agingBuckets;
@override List<CustomerAgingBucket> get agingBuckets {
  if (_agingBuckets is EqualUnmodifiableListView) return _agingBuckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_agingBuckets);
}


/// Create a copy of CustomerStatement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatementCopyWith<_CustomerStatement> get copyWith => __$CustomerStatementCopyWithImpl<_CustomerStatement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStatement&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.outstandingBalance, outstandingBalance) || other.outstandingBalance == outstandingBalance)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._invoiceHistory, _invoiceHistory)&&const DeepCollectionEquality().equals(other._paymentHistory, _paymentHistory)&&const DeepCollectionEquality().equals(other._agingBuckets, _agingBuckets));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,customerName,openingBalance,runningBalance,outstandingBalance,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_invoiceHistory),const DeepCollectionEquality().hash(_paymentHistory),const DeepCollectionEquality().hash(_agingBuckets));

@override
String toString() {
  return 'CustomerStatement(id: $id, customerId: $customerId, customerName: $customerName, openingBalance: $openingBalance, runningBalance: $runningBalance, outstandingBalance: $outstandingBalance, entries: $entries, invoiceHistory: $invoiceHistory, paymentHistory: $paymentHistory, agingBuckets: $agingBuckets)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatementCopyWith<$Res> implements $CustomerStatementCopyWith<$Res> {
  factory _$CustomerStatementCopyWith(_CustomerStatement value, $Res Function(_CustomerStatement) _then) = __$CustomerStatementCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, double openingBalance, double runningBalance, double outstandingBalance, List<CustomerStatementEntry> entries, List<CustomerStatementInvoice> invoiceHistory, List<CustomerStatementPayment> paymentHistory, List<CustomerAgingBucket> agingBuckets
});




}
/// @nodoc
class __$CustomerStatementCopyWithImpl<$Res>
    implements _$CustomerStatementCopyWith<$Res> {
  __$CustomerStatementCopyWithImpl(this._self, this._then);

  final _CustomerStatement _self;
  final $Res Function(_CustomerStatement) _then;

/// Create a copy of CustomerStatement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? openingBalance = null,Object? runningBalance = null,Object? outstandingBalance = null,Object? entries = null,Object? invoiceHistory = null,Object? paymentHistory = null,Object? agingBuckets = null,}) {
  return _then(_CustomerStatement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,runningBalance: null == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double,outstandingBalance: null == outstandingBalance ? _self.outstandingBalance : outstandingBalance // ignore: cast_nullable_to_non_nullable
as double,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementEntry>,invoiceHistory: null == invoiceHistory ? _self._invoiceHistory : invoiceHistory // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementInvoice>,paymentHistory: null == paymentHistory ? _self._paymentHistory : paymentHistory // ignore: cast_nullable_to_non_nullable
as List<CustomerStatementPayment>,agingBuckets: null == agingBuckets ? _self._agingBuckets : agingBuckets // ignore: cast_nullable_to_non_nullable
as List<CustomerAgingBucket>,
  ));
}


}

/// @nodoc
mixin _$CustomerStatementEntry {

 String get id; DateTime get date; String get description; double get amount; String get type; double get runningBalance;
/// Create a copy of CustomerStatementEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatementEntryCopyWith<CustomerStatementEntry> get copyWith => _$CustomerStatementEntryCopyWithImpl<CustomerStatementEntry>(this as CustomerStatementEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStatementEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,description,amount,type,runningBalance);

@override
String toString() {
  return 'CustomerStatementEntry(id: $id, date: $date, description: $description, amount: $amount, type: $type, runningBalance: $runningBalance)';
}


}

/// @nodoc
abstract mixin class $CustomerStatementEntryCopyWith<$Res>  {
  factory $CustomerStatementEntryCopyWith(CustomerStatementEntry value, $Res Function(CustomerStatementEntry) _then) = _$CustomerStatementEntryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String description, double amount, String type, double runningBalance
});




}
/// @nodoc
class _$CustomerStatementEntryCopyWithImpl<$Res>
    implements $CustomerStatementEntryCopyWith<$Res> {
  _$CustomerStatementEntryCopyWithImpl(this._self, this._then);

  final CustomerStatementEntry _self;
  final $Res Function(CustomerStatementEntry) _then;

/// Create a copy of CustomerStatementEntry
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


/// Adds pattern-matching-related methods to [CustomerStatementEntry].
extension CustomerStatementEntryPatterns on CustomerStatementEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStatementEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStatementEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStatementEntry value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStatementEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementEntry() when $default != null:
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
case _CustomerStatementEntry() when $default != null:
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
case _CustomerStatementEntry():
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
case _CustomerStatementEntry() when $default != null:
return $default(_that.id,_that.date,_that.description,_that.amount,_that.type,_that.runningBalance);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStatementEntry implements CustomerStatementEntry {
  const _CustomerStatementEntry({required this.id, required this.date, required this.description, required this.amount, required this.type, required this.runningBalance});
  

@override final  String id;
@override final  DateTime date;
@override final  String description;
@override final  double amount;
@override final  String type;
@override final  double runningBalance;

/// Create a copy of CustomerStatementEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatementEntryCopyWith<_CustomerStatementEntry> get copyWith => __$CustomerStatementEntryCopyWithImpl<_CustomerStatementEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStatementEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,description,amount,type,runningBalance);

@override
String toString() {
  return 'CustomerStatementEntry(id: $id, date: $date, description: $description, amount: $amount, type: $type, runningBalance: $runningBalance)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatementEntryCopyWith<$Res> implements $CustomerStatementEntryCopyWith<$Res> {
  factory _$CustomerStatementEntryCopyWith(_CustomerStatementEntry value, $Res Function(_CustomerStatementEntry) _then) = __$CustomerStatementEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String description, double amount, String type, double runningBalance
});




}
/// @nodoc
class __$CustomerStatementEntryCopyWithImpl<$Res>
    implements _$CustomerStatementEntryCopyWith<$Res> {
  __$CustomerStatementEntryCopyWithImpl(this._self, this._then);

  final _CustomerStatementEntry _self;
  final $Res Function(_CustomerStatementEntry) _then;

/// Create a copy of CustomerStatementEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? description = null,Object? amount = null,Object? type = null,Object? runningBalance = null,}) {
  return _then(_CustomerStatementEntry(
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
mixin _$CustomerStatementInvoice {

 String get id; String get reference; DateTime get invoiceDate; DateTime get dueDate; double get amount; String get status;
/// Create a copy of CustomerStatementInvoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatementInvoiceCopyWith<CustomerStatementInvoice> get copyWith => _$CustomerStatementInvoiceCopyWithImpl<CustomerStatementInvoice>(this as CustomerStatementInvoice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStatementInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,invoiceDate,dueDate,amount,status);

@override
String toString() {
  return 'CustomerStatementInvoice(id: $id, reference: $reference, invoiceDate: $invoiceDate, dueDate: $dueDate, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class $CustomerStatementInvoiceCopyWith<$Res>  {
  factory $CustomerStatementInvoiceCopyWith(CustomerStatementInvoice value, $Res Function(CustomerStatementInvoice) _then) = _$CustomerStatementInvoiceCopyWithImpl;
@useResult
$Res call({
 String id, String reference, DateTime invoiceDate, DateTime dueDate, double amount, String status
});




}
/// @nodoc
class _$CustomerStatementInvoiceCopyWithImpl<$Res>
    implements $CustomerStatementInvoiceCopyWith<$Res> {
  _$CustomerStatementInvoiceCopyWithImpl(this._self, this._then);

  final CustomerStatementInvoice _self;
  final $Res Function(CustomerStatementInvoice) _then;

/// Create a copy of CustomerStatementInvoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? invoiceDate = null,Object? dueDate = null,Object? amount = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerStatementInvoice].
extension CustomerStatementInvoicePatterns on CustomerStatementInvoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStatementInvoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStatementInvoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStatementInvoice value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementInvoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStatementInvoice value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementInvoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime invoiceDate,  DateTime dueDate,  double amount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerStatementInvoice() when $default != null:
return $default(_that.id,_that.reference,_that.invoiceDate,_that.dueDate,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  DateTime invoiceDate,  DateTime dueDate,  double amount,  String status)  $default,) {final _that = this;
switch (_that) {
case _CustomerStatementInvoice():
return $default(_that.id,_that.reference,_that.invoiceDate,_that.dueDate,_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  DateTime invoiceDate,  DateTime dueDate,  double amount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _CustomerStatementInvoice() when $default != null:
return $default(_that.id,_that.reference,_that.invoiceDate,_that.dueDate,_that.amount,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStatementInvoice implements CustomerStatementInvoice {
  const _CustomerStatementInvoice({required this.id, required this.reference, required this.invoiceDate, required this.dueDate, required this.amount, required this.status});
  

@override final  String id;
@override final  String reference;
@override final  DateTime invoiceDate;
@override final  DateTime dueDate;
@override final  double amount;
@override final  String status;

/// Create a copy of CustomerStatementInvoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatementInvoiceCopyWith<_CustomerStatementInvoice> get copyWith => __$CustomerStatementInvoiceCopyWithImpl<_CustomerStatementInvoice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStatementInvoice&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.invoiceDate, invoiceDate) || other.invoiceDate == invoiceDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,invoiceDate,dueDate,amount,status);

@override
String toString() {
  return 'CustomerStatementInvoice(id: $id, reference: $reference, invoiceDate: $invoiceDate, dueDate: $dueDate, amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatementInvoiceCopyWith<$Res> implements $CustomerStatementInvoiceCopyWith<$Res> {
  factory _$CustomerStatementInvoiceCopyWith(_CustomerStatementInvoice value, $Res Function(_CustomerStatementInvoice) _then) = __$CustomerStatementInvoiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, DateTime invoiceDate, DateTime dueDate, double amount, String status
});




}
/// @nodoc
class __$CustomerStatementInvoiceCopyWithImpl<$Res>
    implements _$CustomerStatementInvoiceCopyWith<$Res> {
  __$CustomerStatementInvoiceCopyWithImpl(this._self, this._then);

  final _CustomerStatementInvoice _self;
  final $Res Function(_CustomerStatementInvoice) _then;

/// Create a copy of CustomerStatementInvoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? invoiceDate = null,Object? dueDate = null,Object? amount = null,Object? status = null,}) {
  return _then(_CustomerStatementInvoice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,invoiceDate: null == invoiceDate ? _self.invoiceDate : invoiceDate // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CustomerStatementPayment {

 String get id; String get reference; DateTime get paymentDate; double get amount; String get method;
/// Create a copy of CustomerStatementPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerStatementPaymentCopyWith<CustomerStatementPayment> get copyWith => _$CustomerStatementPaymentCopyWithImpl<CustomerStatementPayment>(this as CustomerStatementPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerStatementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,paymentDate,amount,method);

@override
String toString() {
  return 'CustomerStatementPayment(id: $id, reference: $reference, paymentDate: $paymentDate, amount: $amount, method: $method)';
}


}

/// @nodoc
abstract mixin class $CustomerStatementPaymentCopyWith<$Res>  {
  factory $CustomerStatementPaymentCopyWith(CustomerStatementPayment value, $Res Function(CustomerStatementPayment) _then) = _$CustomerStatementPaymentCopyWithImpl;
@useResult
$Res call({
 String id, String reference, DateTime paymentDate, double amount, String method
});




}
/// @nodoc
class _$CustomerStatementPaymentCopyWithImpl<$Res>
    implements $CustomerStatementPaymentCopyWith<$Res> {
  _$CustomerStatementPaymentCopyWithImpl(this._self, this._then);

  final CustomerStatementPayment _self;
  final $Res Function(CustomerStatementPayment) _then;

/// Create a copy of CustomerStatementPayment
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


/// Adds pattern-matching-related methods to [CustomerStatementPayment].
extension CustomerStatementPaymentPatterns on CustomerStatementPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerStatementPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerStatementPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerStatementPayment value)  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerStatementPayment value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerStatementPayment() when $default != null:
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
case _CustomerStatementPayment() when $default != null:
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
case _CustomerStatementPayment():
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
case _CustomerStatementPayment() when $default != null:
return $default(_that.id,_that.reference,_that.paymentDate,_that.amount,_that.method);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerStatementPayment implements CustomerStatementPayment {
  const _CustomerStatementPayment({required this.id, required this.reference, required this.paymentDate, required this.amount, required this.method});
  

@override final  String id;
@override final  String reference;
@override final  DateTime paymentDate;
@override final  double amount;
@override final  String method;

/// Create a copy of CustomerStatementPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerStatementPaymentCopyWith<_CustomerStatementPayment> get copyWith => __$CustomerStatementPaymentCopyWithImpl<_CustomerStatementPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerStatementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,id,reference,paymentDate,amount,method);

@override
String toString() {
  return 'CustomerStatementPayment(id: $id, reference: $reference, paymentDate: $paymentDate, amount: $amount, method: $method)';
}


}

/// @nodoc
abstract mixin class _$CustomerStatementPaymentCopyWith<$Res> implements $CustomerStatementPaymentCopyWith<$Res> {
  factory _$CustomerStatementPaymentCopyWith(_CustomerStatementPayment value, $Res Function(_CustomerStatementPayment) _then) = __$CustomerStatementPaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, DateTime paymentDate, double amount, String method
});




}
/// @nodoc
class __$CustomerStatementPaymentCopyWithImpl<$Res>
    implements _$CustomerStatementPaymentCopyWith<$Res> {
  __$CustomerStatementPaymentCopyWithImpl(this._self, this._then);

  final _CustomerStatementPayment _self;
  final $Res Function(_CustomerStatementPayment) _then;

/// Create a copy of CustomerStatementPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? paymentDate = null,Object? amount = null,Object? method = null,}) {
  return _then(_CustomerStatementPayment(
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
mixin _$CustomerAgingBucket {

 String get id; String get label; double get amount;
/// Create a copy of CustomerAgingBucket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerAgingBucketCopyWith<CustomerAgingBucket> get copyWith => _$CustomerAgingBucketCopyWithImpl<CustomerAgingBucket>(this as CustomerAgingBucket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerAgingBucket&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,amount);

@override
String toString() {
  return 'CustomerAgingBucket(id: $id, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $CustomerAgingBucketCopyWith<$Res>  {
  factory $CustomerAgingBucketCopyWith(CustomerAgingBucket value, $Res Function(CustomerAgingBucket) _then) = _$CustomerAgingBucketCopyWithImpl;
@useResult
$Res call({
 String id, String label, double amount
});




}
/// @nodoc
class _$CustomerAgingBucketCopyWithImpl<$Res>
    implements $CustomerAgingBucketCopyWith<$Res> {
  _$CustomerAgingBucketCopyWithImpl(this._self, this._then);

  final CustomerAgingBucket _self;
  final $Res Function(CustomerAgingBucket) _then;

/// Create a copy of CustomerAgingBucket
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


/// Adds pattern-matching-related methods to [CustomerAgingBucket].
extension CustomerAgingBucketPatterns on CustomerAgingBucket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerAgingBucket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerAgingBucket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerAgingBucket value)  $default,){
final _that = this;
switch (_that) {
case _CustomerAgingBucket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerAgingBucket value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerAgingBucket() when $default != null:
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
case _CustomerAgingBucket() when $default != null:
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
case _CustomerAgingBucket():
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
case _CustomerAgingBucket() when $default != null:
return $default(_that.id,_that.label,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _CustomerAgingBucket implements CustomerAgingBucket {
  const _CustomerAgingBucket({required this.id, required this.label, required this.amount});
  

@override final  String id;
@override final  String label;
@override final  double amount;

/// Create a copy of CustomerAgingBucket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerAgingBucketCopyWith<_CustomerAgingBucket> get copyWith => __$CustomerAgingBucketCopyWithImpl<_CustomerAgingBucket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerAgingBucket&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,amount);

@override
String toString() {
  return 'CustomerAgingBucket(id: $id, label: $label, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CustomerAgingBucketCopyWith<$Res> implements $CustomerAgingBucketCopyWith<$Res> {
  factory _$CustomerAgingBucketCopyWith(_CustomerAgingBucket value, $Res Function(_CustomerAgingBucket) _then) = __$CustomerAgingBucketCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, double amount
});




}
/// @nodoc
class __$CustomerAgingBucketCopyWithImpl<$Res>
    implements _$CustomerAgingBucketCopyWith<$Res> {
  __$CustomerAgingBucketCopyWithImpl(this._self, this._then);

  final _CustomerAgingBucket _self;
  final $Res Function(_CustomerAgingBucket) _then;

/// Create a copy of CustomerAgingBucket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? amount = null,}) {
  return _then(_CustomerAgingBucket(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
