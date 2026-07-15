// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportDefinition {

 String get id; String get title; String get description; double get defaultAmount; List<String> get tags;
/// Create a copy of ReportDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDefinitionCopyWith<ReportDefinition> get copyWith => _$ReportDefinitionCopyWithImpl<ReportDefinition>(this as ReportDefinition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultAmount, defaultAmount) || other.defaultAmount == defaultAmount)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,defaultAmount,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'ReportDefinition(id: $id, title: $title, description: $description, defaultAmount: $defaultAmount, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ReportDefinitionCopyWith<$Res>  {
  factory $ReportDefinitionCopyWith(ReportDefinition value, $Res Function(ReportDefinition) _then) = _$ReportDefinitionCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, double defaultAmount, List<String> tags
});




}
/// @nodoc
class _$ReportDefinitionCopyWithImpl<$Res>
    implements $ReportDefinitionCopyWith<$Res> {
  _$ReportDefinitionCopyWithImpl(this._self, this._then);

  final ReportDefinition _self;
  final $Res Function(ReportDefinition) _then;

/// Create a copy of ReportDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? defaultAmount = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,defaultAmount: null == defaultAmount ? _self.defaultAmount : defaultAmount // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportDefinition].
extension ReportDefinitionPatterns on ReportDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportDefinition value)  $default,){
final _that = this;
switch (_that) {
case _ReportDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _ReportDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double defaultAmount,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.defaultAmount,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double defaultAmount,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _ReportDefinition():
return $default(_that.id,_that.title,_that.description,_that.defaultAmount,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  double defaultAmount,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _ReportDefinition() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.defaultAmount,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _ReportDefinition implements ReportDefinition {
  const _ReportDefinition({required this.id, required this.title, required this.description, required this.defaultAmount, required final  List<String> tags}): _tags = tags;
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  double defaultAmount;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of ReportDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDefinitionCopyWith<_ReportDefinition> get copyWith => __$ReportDefinitionCopyWithImpl<_ReportDefinition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportDefinition&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.defaultAmount, defaultAmount) || other.defaultAmount == defaultAmount)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,defaultAmount,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'ReportDefinition(id: $id, title: $title, description: $description, defaultAmount: $defaultAmount, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ReportDefinitionCopyWith<$Res> implements $ReportDefinitionCopyWith<$Res> {
  factory _$ReportDefinitionCopyWith(_ReportDefinition value, $Res Function(_ReportDefinition) _then) = __$ReportDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, double defaultAmount, List<String> tags
});




}
/// @nodoc
class __$ReportDefinitionCopyWithImpl<$Res>
    implements _$ReportDefinitionCopyWith<$Res> {
  __$ReportDefinitionCopyWithImpl(this._self, this._then);

  final _ReportDefinition _self;
  final $Res Function(_ReportDefinition) _then;

/// Create a copy of ReportDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? defaultAmount = null,Object? tags = null,}) {
  return _then(_ReportDefinition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,defaultAmount: null == defaultAmount ? _self.defaultAmount : defaultAmount // ignore: cast_nullable_to_non_nullable
as double,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$ReportSection {

 String get title; List<ReportRow> get rows;
/// Create a copy of ReportSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSectionCopyWith<ReportSection> get copyWith => _$ReportSectionCopyWithImpl<ReportSection>(this as ReportSection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.rows, rows));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'ReportSection(title: $title, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $ReportSectionCopyWith<$Res>  {
  factory $ReportSectionCopyWith(ReportSection value, $Res Function(ReportSection) _then) = _$ReportSectionCopyWithImpl;
@useResult
$Res call({
 String title, List<ReportRow> rows
});




}
/// @nodoc
class _$ReportSectionCopyWithImpl<$Res>
    implements $ReportSectionCopyWith<$Res> {
  _$ReportSectionCopyWithImpl(this._self, this._then);

  final ReportSection _self;
  final $Res Function(ReportSection) _then;

/// Create a copy of ReportSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? rows = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<ReportRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportSection].
extension ReportSectionPatterns on ReportSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSection value)  $default,){
final _that = this;
switch (_that) {
case _ReportSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSection value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<ReportRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportSection() when $default != null:
return $default(_that.title,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<ReportRow> rows)  $default,) {final _that = this;
switch (_that) {
case _ReportSection():
return $default(_that.title,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<ReportRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _ReportSection() when $default != null:
return $default(_that.title,_that.rows);case _:
  return null;

}
}

}

/// @nodoc


class _ReportSection implements ReportSection {
  const _ReportSection({required this.title, required final  List<ReportRow> rows}): _rows = rows;
  

@override final  String title;
 final  List<ReportRow> _rows;
@override List<ReportRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of ReportSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSectionCopyWith<_ReportSection> get copyWith => __$ReportSectionCopyWithImpl<_ReportSection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._rows, _rows));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'ReportSection(title: $title, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$ReportSectionCopyWith<$Res> implements $ReportSectionCopyWith<$Res> {
  factory _$ReportSectionCopyWith(_ReportSection value, $Res Function(_ReportSection) _then) = __$ReportSectionCopyWithImpl;
@override @useResult
$Res call({
 String title, List<ReportRow> rows
});




}
/// @nodoc
class __$ReportSectionCopyWithImpl<$Res>
    implements _$ReportSectionCopyWith<$Res> {
  __$ReportSectionCopyWithImpl(this._self, this._then);

  final _ReportSection _self;
  final $Res Function(_ReportSection) _then;

/// Create a copy of ReportSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? rows = null,}) {
  return _then(_ReportSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<ReportRow>,
  ));
}


}

/// @nodoc
mixin _$ReportRow {

 String get label; double get amount; String? get note;
/// Create a copy of ReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportRowCopyWith<ReportRow> get copyWith => _$ReportRowCopyWithImpl<ReportRow>(this as ReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportRow&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,label,amount,note);

@override
String toString() {
  return 'ReportRow(label: $label, amount: $amount, note: $note)';
}


}

/// @nodoc
abstract mixin class $ReportRowCopyWith<$Res>  {
  factory $ReportRowCopyWith(ReportRow value, $Res Function(ReportRow) _then) = _$ReportRowCopyWithImpl;
@useResult
$Res call({
 String label, double amount, String? note
});




}
/// @nodoc
class _$ReportRowCopyWithImpl<$Res>
    implements $ReportRowCopyWith<$Res> {
  _$ReportRowCopyWithImpl(this._self, this._then);

  final ReportRow _self;
  final $Res Function(ReportRow) _then;

/// Create a copy of ReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? amount = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportRow].
extension ReportRowPatterns on ReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportRow value)  $default,){
final _that = this;
switch (_that) {
case _ReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _ReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double amount,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportRow() when $default != null:
return $default(_that.label,_that.amount,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double amount,  String? note)  $default,) {final _that = this;
switch (_that) {
case _ReportRow():
return $default(_that.label,_that.amount,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double amount,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _ReportRow() when $default != null:
return $default(_that.label,_that.amount,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _ReportRow implements ReportRow {
  const _ReportRow({required this.label, required this.amount, this.note});
  

@override final  String label;
@override final  double amount;
@override final  String? note;

/// Create a copy of ReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportRowCopyWith<_ReportRow> get copyWith => __$ReportRowCopyWithImpl<_ReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportRow&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,label,amount,note);

@override
String toString() {
  return 'ReportRow(label: $label, amount: $amount, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ReportRowCopyWith<$Res> implements $ReportRowCopyWith<$Res> {
  factory _$ReportRowCopyWith(_ReportRow value, $Res Function(_ReportRow) _then) = __$ReportRowCopyWithImpl;
@override @useResult
$Res call({
 String label, double amount, String? note
});




}
/// @nodoc
class __$ReportRowCopyWithImpl<$Res>
    implements _$ReportRowCopyWith<$Res> {
  __$ReportRowCopyWithImpl(this._self, this._then);

  final _ReportRow _self;
  final $Res Function(_ReportRow) _then;

/// Create a copy of ReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? amount = null,Object? note = freezed,}) {
  return _then(_ReportRow(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ReportFilter {

 String get id; String get label; String get category; String get description;
/// Create a copy of ReportFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportFilterCopyWith<ReportFilter> get copyWith => _$ReportFilterCopyWithImpl<ReportFilter>(this as ReportFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,category,description);

@override
String toString() {
  return 'ReportFilter(id: $id, label: $label, category: $category, description: $description)';
}


}

/// @nodoc
abstract mixin class $ReportFilterCopyWith<$Res>  {
  factory $ReportFilterCopyWith(ReportFilter value, $Res Function(ReportFilter) _then) = _$ReportFilterCopyWithImpl;
@useResult
$Res call({
 String id, String label, String category, String description
});




}
/// @nodoc
class _$ReportFilterCopyWithImpl<$Res>
    implements $ReportFilterCopyWith<$Res> {
  _$ReportFilterCopyWithImpl(this._self, this._then);

  final ReportFilter _self;
  final $Res Function(ReportFilter) _then;

/// Create a copy of ReportFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? category = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportFilter].
extension ReportFilterPatterns on ReportFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportFilter value)  $default,){
final _that = this;
switch (_that) {
case _ReportFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportFilter value)?  $default,){
final _that = this;
switch (_that) {
case _ReportFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String category,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportFilter() when $default != null:
return $default(_that.id,_that.label,_that.category,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String category,  String description)  $default,) {final _that = this;
switch (_that) {
case _ReportFilter():
return $default(_that.id,_that.label,_that.category,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String category,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ReportFilter() when $default != null:
return $default(_that.id,_that.label,_that.category,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _ReportFilter implements ReportFilter {
  const _ReportFilter({required this.id, required this.label, required this.category, required this.description});
  

@override final  String id;
@override final  String label;
@override final  String category;
@override final  String description;

/// Create a copy of ReportFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportFilterCopyWith<_ReportFilter> get copyWith => __$ReportFilterCopyWithImpl<_ReportFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,category,description);

@override
String toString() {
  return 'ReportFilter(id: $id, label: $label, category: $category, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ReportFilterCopyWith<$Res> implements $ReportFilterCopyWith<$Res> {
  factory _$ReportFilterCopyWith(_ReportFilter value, $Res Function(_ReportFilter) _then) = __$ReportFilterCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String category, String description
});




}
/// @nodoc
class __$ReportFilterCopyWithImpl<$Res>
    implements _$ReportFilterCopyWith<$Res> {
  __$ReportFilterCopyWithImpl(this._self, this._then);

  final _ReportFilter _self;
  final $Res Function(_ReportFilter) _then;

/// Create a copy of ReportFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? category = null,Object? description = null,}) {
  return _then(_ReportFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ReportPeriod {

 String get id; String get label;
/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<ReportPeriod> get copyWith => _$ReportPeriodCopyWithImpl<ReportPeriod>(this as ReportPeriod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'ReportPeriod(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $ReportPeriodCopyWith<$Res>  {
  factory $ReportPeriodCopyWith(ReportPeriod value, $Res Function(ReportPeriod) _then) = _$ReportPeriodCopyWithImpl;
@useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class _$ReportPeriodCopyWithImpl<$Res>
    implements $ReportPeriodCopyWith<$Res> {
  _$ReportPeriodCopyWithImpl(this._self, this._then);

  final ReportPeriod _self;
  final $Res Function(ReportPeriod) _then;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportPeriod].
extension ReportPeriodPatterns on ReportPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportPeriod value)  $default,){
final _that = this;
switch (_that) {
case _ReportPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label)  $default,) {final _that = this;
switch (_that) {
case _ReportPeriod():
return $default(_that.id,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label)?  $default,) {final _that = this;
switch (_that) {
case _ReportPeriod() when $default != null:
return $default(_that.id,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _ReportPeriod implements ReportPeriod {
  const _ReportPeriod({required this.id, required this.label});
  

@override final  String id;
@override final  String label;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportPeriodCopyWith<_ReportPeriod> get copyWith => __$ReportPeriodCopyWithImpl<_ReportPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'ReportPeriod(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ReportPeriodCopyWith<$Res> implements $ReportPeriodCopyWith<$Res> {
  factory _$ReportPeriodCopyWith(_ReportPeriod value, $Res Function(_ReportPeriod) _then) = __$ReportPeriodCopyWithImpl;
@override @useResult
$Res call({
 String id, String label
});




}
/// @nodoc
class __$ReportPeriodCopyWithImpl<$Res>
    implements _$ReportPeriodCopyWith<$Res> {
  __$ReportPeriodCopyWithImpl(this._self, this._then);

  final _ReportPeriod _self;
  final $Res Function(_ReportPeriod) _then;

/// Create a copy of ReportPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_ReportPeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ReportMetadata {

 String get reportId; String get summary; List<String> get tags;
/// Create a copy of ReportMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportMetadataCopyWith<ReportMetadata> get copyWith => _$ReportMetadataCopyWithImpl<ReportMetadata>(this as ReportMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportMetadata&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,reportId,summary,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'ReportMetadata(reportId: $reportId, summary: $summary, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ReportMetadataCopyWith<$Res>  {
  factory $ReportMetadataCopyWith(ReportMetadata value, $Res Function(ReportMetadata) _then) = _$ReportMetadataCopyWithImpl;
@useResult
$Res call({
 String reportId, String summary, List<String> tags
});




}
/// @nodoc
class _$ReportMetadataCopyWithImpl<$Res>
    implements $ReportMetadataCopyWith<$Res> {
  _$ReportMetadataCopyWithImpl(this._self, this._then);

  final ReportMetadata _self;
  final $Res Function(ReportMetadata) _then;

/// Create a copy of ReportMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reportId = null,Object? summary = null,Object? tags = null,}) {
  return _then(_self.copyWith(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportMetadata].
extension ReportMetadataPatterns on ReportMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ReportMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ReportMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String reportId,  String summary,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportMetadata() when $default != null:
return $default(_that.reportId,_that.summary,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String reportId,  String summary,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _ReportMetadata():
return $default(_that.reportId,_that.summary,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String reportId,  String summary,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _ReportMetadata() when $default != null:
return $default(_that.reportId,_that.summary,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _ReportMetadata implements ReportMetadata {
  const _ReportMetadata({required this.reportId, required this.summary, required final  List<String> tags}): _tags = tags;
  

@override final  String reportId;
@override final  String summary;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of ReportMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportMetadataCopyWith<_ReportMetadata> get copyWith => __$ReportMetadataCopyWithImpl<_ReportMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportMetadata&&(identical(other.reportId, reportId) || other.reportId == reportId)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,reportId,summary,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'ReportMetadata(reportId: $reportId, summary: $summary, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ReportMetadataCopyWith<$Res> implements $ReportMetadataCopyWith<$Res> {
  factory _$ReportMetadataCopyWith(_ReportMetadata value, $Res Function(_ReportMetadata) _then) = __$ReportMetadataCopyWithImpl;
@override @useResult
$Res call({
 String reportId, String summary, List<String> tags
});




}
/// @nodoc
class __$ReportMetadataCopyWithImpl<$Res>
    implements _$ReportMetadataCopyWith<$Res> {
  __$ReportMetadataCopyWithImpl(this._self, this._then);

  final _ReportMetadata _self;
  final $Res Function(_ReportMetadata) _then;

/// Create a copy of ReportMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reportId = null,Object? summary = null,Object? tags = null,}) {
  return _then(_ReportMetadata(
reportId: null == reportId ? _self.reportId : reportId // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$ReportRegistry {

 List<ReportDefinition> get reports; List<ReportPeriod> get periods;
/// Create a copy of ReportRegistry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportRegistryCopyWith<ReportRegistry> get copyWith => _$ReportRegistryCopyWithImpl<ReportRegistry>(this as ReportRegistry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportRegistry&&const DeepCollectionEquality().equals(other.reports, reports)&&const DeepCollectionEquality().equals(other.periods, periods));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reports),const DeepCollectionEquality().hash(periods));

@override
String toString() {
  return 'ReportRegistry(reports: $reports, periods: $periods)';
}


}

/// @nodoc
abstract mixin class $ReportRegistryCopyWith<$Res>  {
  factory $ReportRegistryCopyWith(ReportRegistry value, $Res Function(ReportRegistry) _then) = _$ReportRegistryCopyWithImpl;
@useResult
$Res call({
 List<ReportDefinition> reports, List<ReportPeriod> periods
});




}
/// @nodoc
class _$ReportRegistryCopyWithImpl<$Res>
    implements $ReportRegistryCopyWith<$Res> {
  _$ReportRegistryCopyWithImpl(this._self, this._then);

  final ReportRegistry _self;
  final $Res Function(ReportRegistry) _then;

/// Create a copy of ReportRegistry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reports = null,Object? periods = null,}) {
  return _then(_self.copyWith(
reports: null == reports ? _self.reports : reports // ignore: cast_nullable_to_non_nullable
as List<ReportDefinition>,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<ReportPeriod>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportRegistry].
extension ReportRegistryPatterns on ReportRegistry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportRegistry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportRegistry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportRegistry value)  $default,){
final _that = this;
switch (_that) {
case _ReportRegistry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportRegistry value)?  $default,){
final _that = this;
switch (_that) {
case _ReportRegistry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReportDefinition> reports,  List<ReportPeriod> periods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportRegistry() when $default != null:
return $default(_that.reports,_that.periods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReportDefinition> reports,  List<ReportPeriod> periods)  $default,) {final _that = this;
switch (_that) {
case _ReportRegistry():
return $default(_that.reports,_that.periods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReportDefinition> reports,  List<ReportPeriod> periods)?  $default,) {final _that = this;
switch (_that) {
case _ReportRegistry() when $default != null:
return $default(_that.reports,_that.periods);case _:
  return null;

}
}

}

/// @nodoc


class _ReportRegistry implements ReportRegistry {
  const _ReportRegistry({required final  List<ReportDefinition> reports, required final  List<ReportPeriod> periods}): _reports = reports,_periods = periods;
  

 final  List<ReportDefinition> _reports;
@override List<ReportDefinition> get reports {
  if (_reports is EqualUnmodifiableListView) return _reports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reports);
}

 final  List<ReportPeriod> _periods;
@override List<ReportPeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}


/// Create a copy of ReportRegistry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportRegistryCopyWith<_ReportRegistry> get copyWith => __$ReportRegistryCopyWithImpl<_ReportRegistry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportRegistry&&const DeepCollectionEquality().equals(other._reports, _reports)&&const DeepCollectionEquality().equals(other._periods, _periods));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reports),const DeepCollectionEquality().hash(_periods));

@override
String toString() {
  return 'ReportRegistry(reports: $reports, periods: $periods)';
}


}

/// @nodoc
abstract mixin class _$ReportRegistryCopyWith<$Res> implements $ReportRegistryCopyWith<$Res> {
  factory _$ReportRegistryCopyWith(_ReportRegistry value, $Res Function(_ReportRegistry) _then) = __$ReportRegistryCopyWithImpl;
@override @useResult
$Res call({
 List<ReportDefinition> reports, List<ReportPeriod> periods
});




}
/// @nodoc
class __$ReportRegistryCopyWithImpl<$Res>
    implements _$ReportRegistryCopyWith<$Res> {
  __$ReportRegistryCopyWithImpl(this._self, this._then);

  final _ReportRegistry _self;
  final $Res Function(_ReportRegistry) _then;

/// Create a copy of ReportRegistry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reports = null,Object? periods = null,}) {
  return _then(_ReportRegistry(
reports: null == reports ? _self._reports : reports // ignore: cast_nullable_to_non_nullable
as List<ReportDefinition>,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<ReportPeriod>,
  ));
}


}

/// @nodoc
mixin _$ReportData {

 ReportDefinition get definition; ReportPeriod get period; List<ReportSection> get sections; double get total;
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportDataCopyWith<ReportData> get copyWith => _$ReportDataCopyWithImpl<ReportData>(this as ReportData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportData&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,definition,period,const DeepCollectionEquality().hash(sections),total);

@override
String toString() {
  return 'ReportData(definition: $definition, period: $period, sections: $sections, total: $total)';
}


}

/// @nodoc
abstract mixin class $ReportDataCopyWith<$Res>  {
  factory $ReportDataCopyWith(ReportData value, $Res Function(ReportData) _then) = _$ReportDataCopyWithImpl;
@useResult
$Res call({
 ReportDefinition definition, ReportPeriod period, List<ReportSection> sections, double total
});


$ReportDefinitionCopyWith<$Res> get definition;$ReportPeriodCopyWith<$Res> get period;

}
/// @nodoc
class _$ReportDataCopyWithImpl<$Res>
    implements $ReportDataCopyWith<$Res> {
  _$ReportDataCopyWithImpl(this._self, this._then);

  final ReportData _self;
  final $Res Function(ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? period = null,Object? sections = null,Object? total = null,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as ReportDefinition,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ReportSection>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDefinitionCopyWith<$Res> get definition {
  
  return $ReportDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<$Res> get period {
  
  return $ReportPeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportData].
extension ReportDataPatterns on ReportData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportData value)  $default,){
final _that = this;
switch (_that) {
case _ReportData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportData value)?  $default,){
final _that = this;
switch (_that) {
case _ReportData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportDefinition definition,  ReportPeriod period,  List<ReportSection> sections,  double total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.definition,_that.period,_that.sections,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportDefinition definition,  ReportPeriod period,  List<ReportSection> sections,  double total)  $default,) {final _that = this;
switch (_that) {
case _ReportData():
return $default(_that.definition,_that.period,_that.sections,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportDefinition definition,  ReportPeriod period,  List<ReportSection> sections,  double total)?  $default,) {final _that = this;
switch (_that) {
case _ReportData() when $default != null:
return $default(_that.definition,_that.period,_that.sections,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _ReportData implements ReportData {
  const _ReportData({required this.definition, required this.period, required final  List<ReportSection> sections, required this.total}): _sections = sections;
  

@override final  ReportDefinition definition;
@override final  ReportPeriod period;
 final  List<ReportSection> _sections;
@override List<ReportSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  double total;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportDataCopyWith<_ReportData> get copyWith => __$ReportDataCopyWithImpl<_ReportData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportData&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,definition,period,const DeepCollectionEquality().hash(_sections),total);

@override
String toString() {
  return 'ReportData(definition: $definition, period: $period, sections: $sections, total: $total)';
}


}

/// @nodoc
abstract mixin class _$ReportDataCopyWith<$Res> implements $ReportDataCopyWith<$Res> {
  factory _$ReportDataCopyWith(_ReportData value, $Res Function(_ReportData) _then) = __$ReportDataCopyWithImpl;
@override @useResult
$Res call({
 ReportDefinition definition, ReportPeriod period, List<ReportSection> sections, double total
});


@override $ReportDefinitionCopyWith<$Res> get definition;@override $ReportPeriodCopyWith<$Res> get period;

}
/// @nodoc
class __$ReportDataCopyWithImpl<$Res>
    implements _$ReportDataCopyWith<$Res> {
  __$ReportDataCopyWithImpl(this._self, this._then);

  final _ReportData _self;
  final $Res Function(_ReportData) _then;

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? period = null,Object? sections = null,Object? total = null,}) {
  return _then(_ReportData(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as ReportDefinition,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ReportPeriod,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ReportSection>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportDefinitionCopyWith<$Res> get definition {
  
  return $ReportDefinitionCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of ReportData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPeriodCopyWith<$Res> get period {
  
  return $ReportPeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}

// dart format on
