import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/calendar_repository.dart';
import 'calendar_service.dart';
import 'event_generator.dart';

part 'calendar_providers.g.dart';

@Riverpod(keepAlive: true)
CalendarRepository calendarRepository(Ref ref) => MockCalendarRepository();

@Riverpod(keepAlive: true)
EventGenerator eventGenerator(Ref ref) => const EventGenerator();

@Riverpod(keepAlive: true)
CalendarService calendarService(Ref ref) {
  return CalendarService(
    repository: ref.watch(calendarRepositoryProvider),
    generator: ref.watch(eventGeneratorProvider),
  );
}
