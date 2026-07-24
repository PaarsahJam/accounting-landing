// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NotificationPreferencesController)
final notificationPreferencesControllerProvider =
    NotificationPreferencesControllerProvider._();

final class NotificationPreferencesControllerProvider
    extends
        $AsyncNotifierProvider<
          NotificationPreferencesController,
          NotificationPreferences
        > {
  NotificationPreferencesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationPreferencesControllerHash();

  @$internal
  @override
  NotificationPreferencesController create() =>
      NotificationPreferencesController();
}

String _$notificationPreferencesControllerHash() =>
    r'414a2aca6dd8e1bc0d83cae1775de2ebcb993cfb';

abstract class _$NotificationPreferencesController
    extends $AsyncNotifier<NotificationPreferences> {
  FutureOr<NotificationPreferences> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<NotificationPreferences>,
              NotificationPreferences
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationPreferences>,
                NotificationPreferences
              >,
              AsyncValue<NotificationPreferences>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
