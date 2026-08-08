// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton copilot controller shared by the trigger, overlay and panel.

@ProviderFor(workflowController)
final workflowControllerProvider = WorkflowControllerProvider._();

/// Singleton copilot controller shared by the trigger, overlay and panel.

final class WorkflowControllerProvider
    extends
        $FunctionalProvider<
          WorkflowController,
          WorkflowController,
          WorkflowController
        >
    with $Provider<WorkflowController> {
  /// Singleton copilot controller shared by the trigger, overlay and panel.
  WorkflowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workflowControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workflowControllerHash();

  @$internal
  @override
  $ProviderElement<WorkflowController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WorkflowController create(Ref ref) {
    return workflowController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkflowController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkflowController>(value),
    );
  }
}

String _$workflowControllerHash() =>
    r'950502b85ddfb8ec21c95de6ca5dbae7f76646f3';

/// Tracks the active workflow task, its completed steps, and finished tasks.
///
/// Persisted in secure storage so a task can be resumed after the app is
/// closed. Persistence is best-effort: storage failures are ignored.

@ProviderFor(WorkflowProgressNotifier)
final workflowProgressProvider = WorkflowProgressNotifierProvider._();

/// Tracks the active workflow task, its completed steps, and finished tasks.
///
/// Persisted in secure storage so a task can be resumed after the app is
/// closed. Persistence is best-effort: storage failures are ignored.
final class WorkflowProgressNotifierProvider
    extends $NotifierProvider<WorkflowProgressNotifier, WorkflowProgress> {
  /// Tracks the active workflow task, its completed steps, and finished tasks.
  ///
  /// Persisted in secure storage so a task can be resumed after the app is
  /// closed. Persistence is best-effort: storage failures are ignored.
  WorkflowProgressNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workflowProgressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workflowProgressNotifierHash();

  @$internal
  @override
  WorkflowProgressNotifier create() => WorkflowProgressNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkflowProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkflowProgress>(value),
    );
  }
}

String _$workflowProgressNotifierHash() =>
    r'c2da3e4e1c92fb603c14df13f4e4f84e3a0e8366';

/// Tracks the active workflow task, its completed steps, and finished tasks.
///
/// Persisted in secure storage so a task can be resumed after the app is
/// closed. Persistence is best-effort: storage failures are ignored.

abstract class _$WorkflowProgressNotifier extends $Notifier<WorkflowProgress> {
  WorkflowProgress build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<WorkflowProgress, WorkflowProgress>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkflowProgress, WorkflowProgress>,
              WorkflowProgress,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
