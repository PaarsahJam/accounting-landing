// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journal_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JournalPreview {

 String get documentType; String get documentId; String get documentReference; DateTime get postingDate; String get narration; List<JournalPreviewLine> get lines;
/// Create a copy of JournalPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalPreviewCopyWith<JournalPreview> get copyWith => _$JournalPreviewCopyWithImpl<JournalPreview>(this as JournalPreview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalPreview&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.documentReference, documentReference) || other.documentReference == documentReference)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.narration, narration) || other.narration == narration)&&const DeepCollectionEquality().equals(other.lines, lines));
}


@override
int get hashCode => Object.hash(runtimeType,documentType,documentId,documentReference,postingDate,narration,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'JournalPreview(documentType: $documentType, documentId: $documentId, documentReference: $documentReference, postingDate: $postingDate, narration: $narration, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $JournalPreviewCopyWith<$Res>  {
  factory $JournalPreviewCopyWith(JournalPreview value, $Res Function(JournalPreview) _then) = _$JournalPreviewCopyWithImpl;
@useResult
$Res call({
 String documentType, String documentId, String documentReference, DateTime postingDate, String narration, List<JournalPreviewLine> lines
});




}
/// @nodoc
class _$JournalPreviewCopyWithImpl<$Res>
    implements $JournalPreviewCopyWith<$Res> {
  _$JournalPreviewCopyWithImpl(this._self, this._then);

  final JournalPreview _self;
  final $Res Function(JournalPreview) _then;

/// Create a copy of JournalPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? documentType = null,Object? documentId = null,Object? documentReference = null,Object? postingDate = null,Object? narration = null,Object? lines = null,}) {
  return _then(_self.copyWith(
documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,documentReference: null == documentReference ? _self.documentReference : documentReference // ignore: cast_nullable_to_non_nullable
as String,postingDate: null == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime,narration: null == narration ? _self.narration : narration // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<JournalPreviewLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalPreview].
extension JournalPreviewPatterns on JournalPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalPreview value)  $default,){
final _that = this;
switch (_that) {
case _JournalPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalPreview value)?  $default,){
final _that = this;
switch (_that) {
case _JournalPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String documentType,  String documentId,  String documentReference,  DateTime postingDate,  String narration,  List<JournalPreviewLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalPreview() when $default != null:
return $default(_that.documentType,_that.documentId,_that.documentReference,_that.postingDate,_that.narration,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String documentType,  String documentId,  String documentReference,  DateTime postingDate,  String narration,  List<JournalPreviewLine> lines)  $default,) {final _that = this;
switch (_that) {
case _JournalPreview():
return $default(_that.documentType,_that.documentId,_that.documentReference,_that.postingDate,_that.narration,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String documentType,  String documentId,  String documentReference,  DateTime postingDate,  String narration,  List<JournalPreviewLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _JournalPreview() when $default != null:
return $default(_that.documentType,_that.documentId,_that.documentReference,_that.postingDate,_that.narration,_that.lines);case _:
  return null;

}
}

}

/// @nodoc


class _JournalPreview implements JournalPreview {
  const _JournalPreview({required this.documentType, required this.documentId, required this.documentReference, required this.postingDate, required this.narration, required final  List<JournalPreviewLine> lines}): _lines = lines;
  

@override final  String documentType;
@override final  String documentId;
@override final  String documentReference;
@override final  DateTime postingDate;
@override final  String narration;
 final  List<JournalPreviewLine> _lines;
@override List<JournalPreviewLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of JournalPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalPreviewCopyWith<_JournalPreview> get copyWith => __$JournalPreviewCopyWithImpl<_JournalPreview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalPreview&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.documentReference, documentReference) || other.documentReference == documentReference)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.narration, narration) || other.narration == narration)&&const DeepCollectionEquality().equals(other._lines, _lines));
}


@override
int get hashCode => Object.hash(runtimeType,documentType,documentId,documentReference,postingDate,narration,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'JournalPreview(documentType: $documentType, documentId: $documentId, documentReference: $documentReference, postingDate: $postingDate, narration: $narration, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$JournalPreviewCopyWith<$Res> implements $JournalPreviewCopyWith<$Res> {
  factory _$JournalPreviewCopyWith(_JournalPreview value, $Res Function(_JournalPreview) _then) = __$JournalPreviewCopyWithImpl;
@override @useResult
$Res call({
 String documentType, String documentId, String documentReference, DateTime postingDate, String narration, List<JournalPreviewLine> lines
});




}
/// @nodoc
class __$JournalPreviewCopyWithImpl<$Res>
    implements _$JournalPreviewCopyWith<$Res> {
  __$JournalPreviewCopyWithImpl(this._self, this._then);

  final _JournalPreview _self;
  final $Res Function(_JournalPreview) _then;

/// Create a copy of JournalPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? documentType = null,Object? documentId = null,Object? documentReference = null,Object? postingDate = null,Object? narration = null,Object? lines = null,}) {
  return _then(_JournalPreview(
documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,documentId: null == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String,documentReference: null == documentReference ? _self.documentReference : documentReference // ignore: cast_nullable_to_non_nullable
as String,postingDate: null == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime,narration: null == narration ? _self.narration : narration // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<JournalPreviewLine>,
  ));
}


}

/// @nodoc
mixin _$JournalPreviewLine {

 String get accountName; String get accountCode; double get amount; String get side; String get description;
/// Create a copy of JournalPreviewLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JournalPreviewLineCopyWith<JournalPreviewLine> get copyWith => _$JournalPreviewLineCopyWithImpl<JournalPreviewLine>(this as JournalPreviewLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JournalPreviewLine&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.side, side) || other.side == side)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountName,accountCode,amount,side,description);

@override
String toString() {
  return 'JournalPreviewLine(accountName: $accountName, accountCode: $accountCode, amount: $amount, side: $side, description: $description)';
}


}

/// @nodoc
abstract mixin class $JournalPreviewLineCopyWith<$Res>  {
  factory $JournalPreviewLineCopyWith(JournalPreviewLine value, $Res Function(JournalPreviewLine) _then) = _$JournalPreviewLineCopyWithImpl;
@useResult
$Res call({
 String accountName, String accountCode, double amount, String side, String description
});




}
/// @nodoc
class _$JournalPreviewLineCopyWithImpl<$Res>
    implements $JournalPreviewLineCopyWith<$Res> {
  _$JournalPreviewLineCopyWithImpl(this._self, this._then);

  final JournalPreviewLine _self;
  final $Res Function(JournalPreviewLine) _then;

/// Create a copy of JournalPreviewLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountName = null,Object? accountCode = null,Object? amount = null,Object? side = null,Object? description = null,}) {
  return _then(_self.copyWith(
accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JournalPreviewLine].
extension JournalPreviewLinePatterns on JournalPreviewLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JournalPreviewLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JournalPreviewLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JournalPreviewLine value)  $default,){
final _that = this;
switch (_that) {
case _JournalPreviewLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JournalPreviewLine value)?  $default,){
final _that = this;
switch (_that) {
case _JournalPreviewLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountName,  String accountCode,  double amount,  String side,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JournalPreviewLine() when $default != null:
return $default(_that.accountName,_that.accountCode,_that.amount,_that.side,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountName,  String accountCode,  double amount,  String side,  String description)  $default,) {final _that = this;
switch (_that) {
case _JournalPreviewLine():
return $default(_that.accountName,_that.accountCode,_that.amount,_that.side,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountName,  String accountCode,  double amount,  String side,  String description)?  $default,) {final _that = this;
switch (_that) {
case _JournalPreviewLine() when $default != null:
return $default(_that.accountName,_that.accountCode,_that.amount,_that.side,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _JournalPreviewLine implements JournalPreviewLine {
  const _JournalPreviewLine({required this.accountName, required this.accountCode, required this.amount, required this.side, required this.description});
  

@override final  String accountName;
@override final  String accountCode;
@override final  double amount;
@override final  String side;
@override final  String description;

/// Create a copy of JournalPreviewLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JournalPreviewLineCopyWith<_JournalPreviewLine> get copyWith => __$JournalPreviewLineCopyWithImpl<_JournalPreviewLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JournalPreviewLine&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountCode, accountCode) || other.accountCode == accountCode)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.side, side) || other.side == side)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,accountName,accountCode,amount,side,description);

@override
String toString() {
  return 'JournalPreviewLine(accountName: $accountName, accountCode: $accountCode, amount: $amount, side: $side, description: $description)';
}


}

/// @nodoc
abstract mixin class _$JournalPreviewLineCopyWith<$Res> implements $JournalPreviewLineCopyWith<$Res> {
  factory _$JournalPreviewLineCopyWith(_JournalPreviewLine value, $Res Function(_JournalPreviewLine) _then) = __$JournalPreviewLineCopyWithImpl;
@override @useResult
$Res call({
 String accountName, String accountCode, double amount, String side, String description
});




}
/// @nodoc
class __$JournalPreviewLineCopyWithImpl<$Res>
    implements _$JournalPreviewLineCopyWith<$Res> {
  __$JournalPreviewLineCopyWithImpl(this._self, this._then);

  final _JournalPreviewLine _self;
  final $Res Function(_JournalPreviewLine) _then;

/// Create a copy of JournalPreviewLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountName = null,Object? accountCode = null,Object? amount = null,Object? side = null,Object? description = null,}) {
  return _then(_JournalPreviewLine(
accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountCode: null == accountCode ? _self.accountCode : accountCode // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,side: null == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
