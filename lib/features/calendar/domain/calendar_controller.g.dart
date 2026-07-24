// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CalendarController)
final calendarControllerProvider = CalendarControllerProvider._();

final class CalendarControllerProvider
    extends $AsyncNotifierProvider<CalendarController, List<CalendarEvent>> {
  CalendarControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'calendarControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$calendarControllerHash();

  @$internal
  @override
  CalendarController create() => CalendarController();
}

String _$calendarControllerHash() =>
    r'402e6887565bc84e0f6f6a5acc9df50ea5064f61';

abstract class _$CalendarController
    extends $AsyncNotifier<List<CalendarEvent>> {
  FutureOr<List<CalendarEvent>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CalendarEvent>>, List<CalendarEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CalendarEvent>>, List<CalendarEvent>>,
              AsyncValue<List<CalendarEvent>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
