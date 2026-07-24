// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crm_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CrmTask {

 String get id; String get customerId; String? get contactId; String get title; String get description; TaskStatus get status; TaskPriority get priority; DateTime get dueDate; String get assignedTo; DateTime get createdAt; DateTime? get completedAt;
/// Create a copy of CrmTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrmTaskCopyWith<CrmTask> get copyWith => _$CrmTaskCopyWithImpl<CrmTask>(this as CrmTask, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrmTask&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,contactId,title,description,status,priority,dueDate,assignedTo,createdAt,completedAt);

@override
String toString() {
  return 'CrmTask(id: $id, customerId: $customerId, contactId: $contactId, title: $title, description: $description, status: $status, priority: $priority, dueDate: $dueDate, assignedTo: $assignedTo, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $CrmTaskCopyWith<$Res>  {
  factory $CrmTaskCopyWith(CrmTask value, $Res Function(CrmTask) _then) = _$CrmTaskCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String? contactId, String title, String description, TaskStatus status, TaskPriority priority, DateTime dueDate, String assignedTo, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class _$CrmTaskCopyWithImpl<$Res>
    implements $CrmTaskCopyWith<$Res> {
  _$CrmTaskCopyWithImpl(this._self, this._then);

  final CrmTask _self;
  final $Res Function(CrmTask) _then;

/// Create a copy of CrmTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? contactId = freezed,Object? title = null,Object? description = null,Object? status = null,Object? priority = null,Object? dueDate = null,Object? assignedTo = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,assignedTo: null == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CrmTask].
extension CrmTaskPatterns on CrmTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrmTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrmTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrmTask value)  $default,){
final _that = this;
switch (_that) {
case _CrmTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrmTask value)?  $default,){
final _that = this;
switch (_that) {
case _CrmTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String? contactId,  String title,  String description,  TaskStatus status,  TaskPriority priority,  DateTime dueDate,  String assignedTo,  DateTime createdAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrmTask() when $default != null:
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.status,_that.priority,_that.dueDate,_that.assignedTo,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String? contactId,  String title,  String description,  TaskStatus status,  TaskPriority priority,  DateTime dueDate,  String assignedTo,  DateTime createdAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _CrmTask():
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.status,_that.priority,_that.dueDate,_that.assignedTo,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String? contactId,  String title,  String description,  TaskStatus status,  TaskPriority priority,  DateTime dueDate,  String assignedTo,  DateTime createdAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _CrmTask() when $default != null:
return $default(_that.id,_that.customerId,_that.contactId,_that.title,_that.description,_that.status,_that.priority,_that.dueDate,_that.assignedTo,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CrmTask implements CrmTask {
  const _CrmTask({required this.id, required this.customerId, this.contactId, required this.title, required this.description, required this.status, required this.priority, required this.dueDate, required this.assignedTo, required this.createdAt, this.completedAt});
  

@override final  String id;
@override final  String customerId;
@override final  String? contactId;
@override final  String title;
@override final  String description;
@override final  TaskStatus status;
@override final  TaskPriority priority;
@override final  DateTime dueDate;
@override final  String assignedTo;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;

/// Create a copy of CrmTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrmTaskCopyWith<_CrmTask> get copyWith => __$CrmTaskCopyWithImpl<_CrmTask>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrmTask&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.assignedTo, assignedTo) || other.assignedTo == assignedTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,contactId,title,description,status,priority,dueDate,assignedTo,createdAt,completedAt);

@override
String toString() {
  return 'CrmTask(id: $id, customerId: $customerId, contactId: $contactId, title: $title, description: $description, status: $status, priority: $priority, dueDate: $dueDate, assignedTo: $assignedTo, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$CrmTaskCopyWith<$Res> implements $CrmTaskCopyWith<$Res> {
  factory _$CrmTaskCopyWith(_CrmTask value, $Res Function(_CrmTask) _then) = __$CrmTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String? contactId, String title, String description, TaskStatus status, TaskPriority priority, DateTime dueDate, String assignedTo, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class __$CrmTaskCopyWithImpl<$Res>
    implements _$CrmTaskCopyWith<$Res> {
  __$CrmTaskCopyWithImpl(this._self, this._then);

  final _CrmTask _self;
  final $Res Function(_CrmTask) _then;

/// Create a copy of CrmTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? contactId = freezed,Object? title = null,Object? description = null,Object? status = null,Object? priority = null,Object? dueDate = null,Object? assignedTo = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_CrmTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,assignedTo: null == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
