import '../../../../core/errors/app_result.dart';
import '../domain/calendar_event.dart';

/// Adapter interface for external calendar sync (Google Calendar, Outlook, etc.).
///
/// Implementations wrap a specific external calendar API so the rest
/// of the app never depends on a concrete provider.
abstract class CalendarProvider {
  /// Pushes [event] to the external calendar.
  Future<AppResult<CalendarEvent>> pushEvent(CalendarEvent event);

  /// Removes [event] from the external calendar.
  Future<AppResult<void>> removeEvent(CalendarEvent event);

  /// Pulls events from the external calendar in [range].
  Future<AppResult<List<CalendarEvent>>> pullEvents({
    required DateTime from,
    required DateTime to,
  });
}
