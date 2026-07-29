// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RolesController)
final rolesControllerProvider = RolesControllerProvider._();

final class RolesControllerProvider
    extends $AsyncNotifierProvider<RolesController, List<AppRole>> {
  RolesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rolesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rolesControllerHash();

  @$internal
  @override
  RolesController create() => RolesController();
}

String _$rolesControllerHash() => r'4b99eeb5eaf0a0ad81db8e800f2110f9f7bc07e9';

abstract class _$RolesController extends $AsyncNotifier<List<AppRole>> {
  FutureOr<List<AppRole>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AppRole>>, List<AppRole>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AppRole>>, List<AppRole>>,
              AsyncValue<List<AppRole>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(UsersController)
final usersControllerProvider = UsersControllerProvider._();

final class UsersControllerProvider
    extends $AsyncNotifierProvider<UsersController, List<AppUser>> {
  UsersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersControllerHash();

  @$internal
  @override
  UsersController create() => UsersController();
}

String _$usersControllerHash() => r'fa987bf719f1ede33bc6a5284ac744cca43d7640';

abstract class _$UsersController extends $AsyncNotifier<List<AppUser>> {
  FutureOr<List<AppUser>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<AppUser>>, List<AppUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AppUser>>, List<AppUser>>,
              AsyncValue<List<AppUser>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(CurrentUserController)
final currentUserControllerProvider = CurrentUserControllerProvider._();

final class CurrentUserControllerProvider
    extends $AsyncNotifierProvider<CurrentUserController, AppUser?> {
  CurrentUserControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserControllerHash();

  @$internal
  @override
  CurrentUserController create() => CurrentUserController();
}

String _$currentUserControllerHash() =>
    r'1d38fd1393e939c8e5325bc405a60f609a8fd453';

abstract class _$CurrentUserController extends $AsyncNotifier<AppUser?> {
  FutureOr<AppUser?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppUser?>, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUser?>, AppUser?>,
              AsyncValue<AppUser?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Returns `true` if the current user has [permission].
///
/// Usage:
/// ```dart
/// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
/// ```

@ProviderFor(hasPermission)
final hasPermissionProvider = HasPermissionFamily._();

/// Returns `true` if the current user has [permission].
///
/// Usage:
/// ```dart
/// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
/// ```

final class HasPermissionProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Returns `true` if the current user has [permission].
  ///
  /// Usage:
  /// ```dart
  /// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
  /// ```
  HasPermissionProvider._({
    required HasPermissionFamily super.from,
    required Permission super.argument,
  }) : super(
         retry: null,
         name: r'hasPermissionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hasPermissionHash();

  @override
  String toString() {
    return r'hasPermissionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as Permission;
    return hasPermission(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HasPermissionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hasPermissionHash() => r'4f98a05c5db0171bfc793000c21321c1eb3b506e';

/// Returns `true` if the current user has [permission].
///
/// Usage:
/// ```dart
/// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
/// ```

final class HasPermissionFamily extends $Family
    with $FunctionalFamilyOverride<bool, Permission> {
  HasPermissionFamily._()
    : super(
        retry: null,
        name: r'hasPermissionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Returns `true` if the current user has [permission].
  ///
  /// Usage:
  /// ```dart
  /// final canPost = ref.watch(hasPermissionProvider(Permission.postJournal));
  /// ```

  HasPermissionProvider call(Permission permission) =>
      HasPermissionProvider._(argument: permission, from: this);

  @override
  String toString() => r'hasPermissionProvider';
}
