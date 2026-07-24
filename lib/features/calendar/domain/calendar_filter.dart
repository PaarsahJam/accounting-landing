import 'event_type.dart';
import 'event_priority.dart';
import 'event_status.dart';
import 'calendar_event.dart';

/// Filter for querying calendar events.
class CalendarFilter {
  const CalendarFilter({
    this.eventTypes,
    this.priorities,
    this.statuses,
    this.from,
    this.to,
    this.relatedEntityType,
    this.relatedEntityId,
    this.searchQuery,
  });

  /// Only include these event types (null = all).
  final List<EventType>? eventTypes;

  /// Only include these priorities (null = all).
  final List<EventPriority>? priorities;

  /// Only include these statuses (null = all).
  final List<EventStatus>? statuses;

  /// Only events starting at or after this date.
  final DateTime? from;

  /// Only events starting at or before this date.
  final DateTime? to;

  /// Only events linked to this entity type.
  final String? relatedEntityType;

  /// Only events linked to this entity id.
  final String? relatedEntityId;

  /// Text search on title.
  final String? searchQuery;

  /// Returns true if [event] passes all filter criteria.
  bool matches(CalendarEvent event) {
    if (eventTypes != null && !eventTypes!.contains(event.eventType)) {
      return false;
    }
    if (priorities != null && !priorities!.contains(event.priority)) {
      return false;
    }
    if (statuses != null && !statuses!.contains(event.status)) {
      return false;
    }
    if (from != null && event.startAt.isBefore(from!)) {
      return false;
    }
    if (to != null && event.startAt.isAfter(to!)) {
      return false;
    }
    if (relatedEntityType != null &&
        event.relatedEntityType != relatedEntityType) {
      return false;
    }
    if (relatedEntityId != null &&
        event.relatedEntityId != relatedEntityId) {
      return false;
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      if (!event.title.toLowerCase().contains(searchQuery!.toLowerCase())) {
        return false;
      }
    }
    return true;
  }

  /// A filter that matches everything.
  static const CalendarFilter none = CalendarFilter();
}
