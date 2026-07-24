// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Contact {

 String get id; String get customerId; String get firstName; String get lastName; String get email; String get phone; String get jobTitle; String get department; bool get isPrimary; String get notes;
/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactCopyWith<Contact> get copyWith => _$ContactCopyWithImpl<Contact>(this as Contact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.department, department) || other.department == department)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,firstName,lastName,email,phone,jobTitle,department,isPrimary,notes);

@override
String toString() {
  return 'Contact(id: $id, customerId: $customerId, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, jobTitle: $jobTitle, department: $department, isPrimary: $isPrimary, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ContactCopyWith<$Res>  {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) _then) = _$ContactCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String firstName, String lastName, String email, String phone, String jobTitle, String department, bool isPrimary, String notes
});




}
/// @nodoc
class _$ContactCopyWithImpl<$Res>
    implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._self, this._then);

  final Contact _self;
  final $Res Function(Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? jobTitle = null,Object? department = null,Object? isPrimary = null,Object? notes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Contact].
extension ContactPatterns on Contact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Contact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Contact value)  $default,){
final _that = this;
switch (_that) {
case _Contact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Contact value)?  $default,){
final _that = this;
switch (_that) {
case _Contact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String firstName,  String lastName,  String email,  String phone,  String jobTitle,  String department,  bool isPrimary,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.customerId,_that.firstName,_that.lastName,_that.email,_that.phone,_that.jobTitle,_that.department,_that.isPrimary,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String firstName,  String lastName,  String email,  String phone,  String jobTitle,  String department,  bool isPrimary,  String notes)  $default,) {final _that = this;
switch (_that) {
case _Contact():
return $default(_that.id,_that.customerId,_that.firstName,_that.lastName,_that.email,_that.phone,_that.jobTitle,_that.department,_that.isPrimary,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String firstName,  String lastName,  String email,  String phone,  String jobTitle,  String department,  bool isPrimary,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _Contact() when $default != null:
return $default(_that.id,_that.customerId,_that.firstName,_that.lastName,_that.email,_that.phone,_that.jobTitle,_that.department,_that.isPrimary,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _Contact extends Contact {
  const _Contact({required this.id, required this.customerId, required this.firstName, required this.lastName, required this.email, required this.phone, required this.jobTitle, required this.department, required this.isPrimary, required this.notes}): super._();
  

@override final  String id;
@override final  String customerId;
@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override final  String phone;
@override final  String jobTitle;
@override final  String department;
@override final  bool isPrimary;
@override final  String notes;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactCopyWith<_Contact> get copyWith => __$ContactCopyWithImpl<_Contact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Contact&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.department, department) || other.department == department)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,customerId,firstName,lastName,email,phone,jobTitle,department,isPrimary,notes);

@override
String toString() {
  return 'Contact(id: $id, customerId: $customerId, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, jobTitle: $jobTitle, department: $department, isPrimary: $isPrimary, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory _$ContactCopyWith(_Contact value, $Res Function(_Contact) _then) = __$ContactCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String firstName, String lastName, String email, String phone, String jobTitle, String department, bool isPrimary, String notes
});




}
/// @nodoc
class __$ContactCopyWithImpl<$Res>
    implements _$ContactCopyWith<$Res> {
  __$ContactCopyWithImpl(this._self, this._then);

  final _Contact _self;
  final $Res Function(_Contact) _then;

/// Create a copy of Contact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? jobTitle = null,Object? department = null,Object? isPrimary = null,Object? notes = null,}) {
  return _then(_Contact(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
