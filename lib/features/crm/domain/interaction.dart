import 'package:freezed_annotation/freezed_annotation.dart';

part 'interaction.freezed.dart';

enum InteractionType {
  call,
  email,
  meeting,
  note,
  task;

  String get label {
    switch (this) {
      case InteractionType.call:
        return 'Call';
      case InteractionType.email:
        return 'Email';
      case InteractionType.meeting:
        return 'Meeting';
      case InteractionType.note:
        return 'Note';
      case InteractionType.task:
        return 'Task';
    }
  }
}

@freezed
abstract class Interaction with _$Interaction {
  const factory Interaction({
    required String id,
    required String contactId,
    required String customerId,
    required InteractionType type,
    required String subject,
    required String description,
    required DateTime occurredAt,
    required String performedBy,
    required DateTime createdAt,
  }) = _Interaction;
}
