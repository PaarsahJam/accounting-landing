import 'event_type.dart';
import 'event_priority.dart';
import 'event_status.dart';

/// An immutable event in the internal calendar.
///
/// Events are generated from business entities (invoices, payments, etc.)
/// or created directly by the user (reminders, tasks, meetings).
class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.eventType,
    this.description,
    this.priority = EventPriority.medium,
    required this.startAt,
    this.endAt,
    this.allDay = false,
    this.status = EventStatus.pending,
    this.relatedEntityType,
    this.relatedEntityId,
    this.relatedEntityLabel,
  });

  final String id;
  final String title;
  final String? description;
  final EventType eventType;
  final EventPriority priority;
  final DateTime startAt;
  final DateTime? endAt;
  final bool allDay;
  final EventStatus status;
  final String? relatedEntityType;
  final String? relatedEntityId;
  final String? relatedEntityLabel;

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    EventType? eventType,
    EventPriority? priority,
    DateTime? startAt,
    DateTime? endAt,
    bool? allDay,
    EventStatus? status,
    String? relatedEntityType,
    String? relatedEntityId,
    String? relatedEntityLabel,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      eventType: eventType ?? this.eventType,
      priority: priority ?? this.priority,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      allDay: allDay ?? this.allDay,
      status: status ?? this.status,
      relatedEntityType: relatedEntityType ?? this.relatedEntityType,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      relatedEntityLabel: relatedEntityLabel ?? this.relatedEntityLabel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEvent &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'CalendarEvent(id: $id, title: $title, type: ${eventType.name}, start: $startAt, status: ${status.name})';
}
