// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(calendarRepository)
final calendarRepositoryProvider = CalendarRepositoryProvider._();

final class CalendarRepositoryProvider
    extends
        $FunctionalProvider<
          CalendarRepository,
          CalendarRepository,
          CalendarRepository
        >
    with $Provider<CalendarRepository> {
  CalendarRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarRepositoryHash();

  @$internal
  @override
  $ProviderElement<CalendarRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CalendarRepository create(Ref ref) {
    return calendarRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarRepository>(value),
    );
  }
}

String _$calendarRepositoryHash() =>
    r'afff307e881256d677d9ac827b17c22cb8fb8f86';

@ProviderFor(eventGenerator)
final eventGeneratorProvider = EventGeneratorProvider._();

final class EventGeneratorProvider
    extends $FunctionalProvider<EventGenerator, EventGenerator, EventGenerator>
    with $Provider<EventGenerator> {
  EventGeneratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventGeneratorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventGeneratorHash();

  @$internal
  @override
  $ProviderElement<EventGenerator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventGenerator create(Ref ref) {
    return eventGenerator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventGenerator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventGenerator>(value),
    );
  }
}

String _$eventGeneratorHash() => r'3ffe67877f8a425c1b299b7101fab25a2e98f607';

@ProviderFor(calendarService)
final calendarServiceProvider = CalendarServiceProvider._();

final class CalendarServiceProvider
    extends
        $FunctionalProvider<CalendarService, CalendarService, CalendarService>
    with $Provider<CalendarService> {
  CalendarServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarServiceHash();

  @$internal
  @override
  $ProviderElement<CalendarService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CalendarService create(Ref ref) {
    return calendarService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarService>(value),
    );
  }
}

String _$calendarServiceHash() => r'c51e1e0e5fbcc215d164f047ec5c8d864e7de60f';
