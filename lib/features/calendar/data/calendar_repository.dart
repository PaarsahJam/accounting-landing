import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';

import '../domain/calendar_event.dart';
import '../domain/calendar_filter.dart';

/// Repository for calendar events — both generated and user-created.
abstract class CalendarRepository {
  /// Fetches all events matching [filter].
  Future<AppResult<List<CalendarEvent>>> fetchEvents({
    CalendarFilter? filter,
  });

  /// Persists a new event (e.g. user-created reminder/task).
  Future<AppResult<CalendarEvent>> createEvent(CalendarEvent event);

  /// Updates an existing event.
  Future<AppResult<CalendarEvent>> updateEvent(CalendarEvent event);

  /// Deletes an event.
  Future<AppResult<void>> deleteEvent(String id);

  /// Seeds generated events for testing/preview.
  void seed(List<CalendarEvent> events);

  /// Clears all events.
  void clear();
}

/// In-memory mock implementation seeded with generated events.
class MockCalendarRepository implements CalendarRepository {
  final List<CalendarEvent> _events = [];

  @override
  Future<AppResult<List<CalendarEvent>>> fetchEvents({
    CalendarFilter? filter,
  }) async {
    Iterable<CalendarEvent> result = List.from(_events);
    if (filter != null) {
      result = result.where(filter.matches);
    }
    return AppResult.success(result.toList());
  }

  @override
  Future<AppResult<CalendarEvent>> createEvent(CalendarEvent event) async {
    _events.add(event);
    return AppResult.success(event);
  }

  @override
  Future<AppResult<CalendarEvent>> updateEvent(CalendarEvent event) async {
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index < 0) {
      return AppResult.failure(
        UnknownFailure(message: 'Event not found: ${event.id}'),
      );
    }
    _events[index] = event;
    return AppResult.success(event);
  }

  @override
  Future<AppResult<void>> deleteEvent(String id) async {
    _events.removeWhere((e) => e.id == id);
    return AppResult.success(null);
  }

  @override
  void seed(List<CalendarEvent> events) {
    _events.addAll(events);
  }

  @override
  void clear() => _events.clear();
}
