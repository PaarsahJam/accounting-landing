// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalEntry {

 String get journalNumber; DateTime get postingDate; String get sourceDocumentType; String get sourceDocumentId; String get sourceReference; String get narration; String get postingStatus; double get totalDebit; double get totalCredit; List<JournalLine> get lines;
/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalEntryCopyWith<JournalEntry> get copyWith => _$JournalEntryCopyWithImpl<JournalEntry>(this as JournalEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalEntry&&(identical(other.journalNumber, journalNumber) || other.journalNumber == journalNumber)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.sourceDocumentType, sourceDocumentType) || other.sourceDocumentType == sourceDocumentType)&&(identical(other.sourceDocumentId, sourceDocumentId) || other.sourceDocumentId == sourceDocumentId)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.narration, narration) || other.narration == narration)&&(identical(other.postingStatus, postingStatus) || other.postingStatus == postingStatus)&&(identical(other.totalDebit, totalDebit) || other.totalDebit == totalDebit)&&(identical(other.totalCredit, totalCredit) || other.totalCredit == totalCredit)&&const DeepCollectionEquality().equals(other.lines, lines));
}


@override
int get hashCode => Object.hash(runtimeType,journalNumber,postingDate,sourceDocumentType,sourceDocumentId,sourceReference,narration,postingStatus,totalDebit,totalCredit,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'JournalEntry(journalNumber: $journalNumber, postingDate: $postingDate, sourceDocumentType: $sourceDocumentType, sourceDocumentId: $sourceDocumentId, sourceReference: $sourceReference, narration: $narration, postingStatus: $postingStatus, totalDebit: $totalDebit, totalCredit: $totalCredit, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $JournalEntryCopyWith<$Res>  {
  factory $JournalEntryCopyWith(JournalEntry value, $Res Function(JournalEntry) _then) = _$JournalEntryCopyWithImpl;
@useResult
$Res call({
 String journalNumber, DateTime postingDate, String sourceDocumentType, String sourceDocumentId, String sourceReference, String narration, String postingStatus, double totalDebit, double totalCredit, List<JournalLine> lines
});




}
/// @nodoc
class _$JournalEntryCopyWithImpl<$Res>
    implements $JournalEntryCopyWith<$Res> {
  _$JournalEntryCopyWithImpl(this._self, this._then);

  final JournalEntry _self;
  final $Res Function(JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? journalNumber = null,Object? postingDate = null,Object? sourceDocumentType = null,Object? sourceDocumentId = null,Object? sourceReference = null,Object? narration = null,Object? postingStatus = null,Object? totalDebit = null,Object? totalCredit = null,Object? lines = null,}) {
  return _then(_self.copyWith(
journalNumber: null == journalNumber ? _self.journalNumber : journalNumber // ignore: cast_nullable_to_non_nullable
as String,postingDate: null == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime,sourceDocumentType: null == sourceDocumentType ? _self.sourceDocumentType : sourceDocumentType // ignore: cast_nullable_to_non_nullable
as String,sourceDocumentId: null == sourceDocumentId ? _self.sourceDocumentId : sourceDocumentId // ignore: cast_nullable_to_non_nullable
as String,sourceReference: null == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String,narration: null == narration ? _self.narration : narration // ignore: cast_nullable_to_non_nullable
as String,postingStatus: null == postingStatus ? _self.postingStatus : postingStatus // ignore: cast_nullable_to_non_nullable
as String,totalDebit: null == totalDebit ? _self.totalDebit : totalDebit // ignore: cast_nullable_to_non_nullable
as double,totalCredit: null == totalCredit ? _self.totalCredit : totalCredit // ignore: cast_nullable_to_non_nullable
as double,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<JournalLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalEntry].
extension JournalEntryPatterns on JournalEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalEntry value)  $default,){
final _that = this;
switch (_that) {
case _JournalEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalEntry value)?  $default,){
final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String journalNumber,  DateTime postingDate,  String sourceDocumentType,  String sourceDocumentId,  String sourceReference,  String narration,  String postingStatus,  double totalDebit,  double totalCredit,  List<JournalLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.journalNumber,_that.postingDate,_that.sourceDocumentType,_that.sourceDocumentId,_that.sourceReference,_that.narration,_that.postingStatus,_that.totalDebit,_that.totalCredit,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String journalNumber,  DateTime postingDate,  String sourceDocumentType,  String sourceDocumentId,  String sourceReference,  String narration,  String postingStatus,  double totalDebit,  double totalCredit,  List<JournalLine> lines)  $default,) {final _that = this;
switch (_that) {
case _JournalEntry():
return $default(_that.journalNumber,_that.postingDate,_that.sourceDocumentType,_that.sourceDocumentId,_that.sourceReference,_that.narration,_that.postingStatus,_that.totalDebit,_that.totalCredit,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String journalNumber,  DateTime postingDate,  String sourceDocumentType,  String sourceDocumentId,  String sourceReference,  String narration,  String postingStatus,  double totalDebit,  double totalCredit,  List<JournalLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _JournalEntry() when $default != null:
return $default(_that.journalNumber,_that.postingDate,_that.sourceDocumentType,_that.sourceDocumentId,_that.sourceReference,_that.narration,_that.postingStatus,_that.totalDebit,_that.totalCredit,_that.lines);case _:
  return null;

}
}

}

/// @nodoc


class _JournalEntry implements JournalEntry {
  const _JournalEntry({required this.journalNumber, required this.postingDate, required this.sourceDocumentType, required this.sourceDocumentId, required this.sourceReference, required this.narration, required this.postingStatus, required this.totalDebit, required this.totalCredit, required final  List<JournalLine> lines}): _lines = lines;
  

@override final  String journalNumber;
@override final  DateTime postingDate;
@override final  String sourceDocumentType;
@override final  String sourceDocumentId;
@override final  String sourceReference;
@override final  String narration;
@override final  String postingStatus;
@override final  double totalDebit;
@override final  double totalCredit;
 final  List<JournalLine> _lines;
@override List<JournalLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalEntryCopyWith<_JournalEntry> get copyWith => __$JournalEntryCopyWithImpl<_JournalEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalEntry&&(identical(other.journalNumber, journalNumber) || other.journalNumber == journalNumber)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.sourceDocumentType, sourceDocumentType) || other.sourceDocumentType == sourceDocumentType)&&(identical(other.sourceDocumentId, sourceDocumentId) || other.sourceDocumentId == sourceDocumentId)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.narration, narration) || other.narration == narration)&&(identical(other.postingStatus, postingStatus) || other.postingStatus == postingStatus)&&(identical(other.totalDebit, totalDebit) || other.totalDebit == totalDebit)&&(identical(other.totalCredit, totalCredit) || other.totalCredit == totalCredit)&&const DeepCollectionEquality().equals(other._lines, _lines));
}


@override
int get hashCode => Object.hash(runtimeType,journalNumber,postingDate,sourceDocumentType,sourceDocumentId,sourceReference,narration,postingStatus,totalDebit,totalCredit,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'JournalEntry(journalNumber: $journalNumber, postingDate: $postingDate, sourceDocumentType: $sourceDocumentType, sourceDocumentId: $sourceDocumentId, sourceReference: $sourceReference, narration: $narration, postingStatus: $postingStatus, totalDebit: $totalDebit, totalCredit: $totalCredit, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$JournalEntryCopyWith<$Res> implements $JournalEntryCopyWith<$Res> {
  factory _$JournalEntryCopyWith(_JournalEntry value, $Res Function(_JournalEntry) _then) = __$JournalEntryCopyWithImpl;
@override @useResult
$Res call({
 String journalNumber, DateTime postingDate, String sourceDocumentType, String sourceDocumentId, String sourceReference, String narration, String postingStatus, double totalDebit, double totalCredit, List<JournalLine> lines
});




}
/// @nodoc
class __$JournalEntryCopyWithImpl<$Res>
    implements _$JournalEntryCopyWith<$Res> {
  __$JournalEntryCopyWithImpl(this._self, this._then);

  final _JournalEntry _self;
  final $Res Function(_JournalEntry) _then;

/// Create a copy of JournalEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? journalNumber = null,Object? postingDate = null,Object? sourceDocumentType = null,Object? sourceDocumentId = null,Object? sourceReference = null,Object? narration = null,Object? postingStatus = null,Object? totalDebit = null,Object? totalCredit = null,Object? lines = null,}) {
  return _then(_JournalEntry(
journalNumber: null == journalNumber ? _self.journalNumber : journalNumber // ignore: cast_nullable_to_non_nullable
as String,postingDate: null == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime,sourceDocumentType: null == sourceDocumentType ? _self.sourceDocumentType : sourceDocumentType // ignore: cast_nullable_to_non_nullable
as String,sourceDocumentId: null == sourceDocumentId ? _self.sourceDocumentId : sourceDocumentId // ignore: cast_nullable_to_non_nullable
as String,sourceReference: null == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String,narration: null == narration ? _self.narration : narration // ignore: cast_nullable_to_non_nullable
as String,postingStatus: null == postingStatus ? _self.postingStatus : postingStatus // ignore: cast_nullable_to_non_nullable
as String,totalDebit: null == totalDebit ? _self.totalDebit : totalDebit // ignore: cast_nullable_to_non_nullable
as double,totalCredit: null == totalCredit ? _self.totalCredit : totalCredit // ignore: cast_nullable_to_non_nullable
as double,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<JournalLine>,
  ));
}


}

// dart format on
