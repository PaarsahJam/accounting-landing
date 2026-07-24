import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

@freezed
abstract class Contact with _$Contact {
  const factory Contact({
    required String id,
    required String customerId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String jobTitle,
    required String department,
    required bool isPrimary,
    required String notes,
  }) = _Contact;

  const Contact._();

  String get fullName => '$firstName $lastName';
}
