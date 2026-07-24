// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkflowInstanceController)
final workflowInstanceControllerProvider =
    WorkflowInstanceControllerProvider._();

final class WorkflowInstanceControllerProvider
    extends
        $AsyncNotifierProvider<
          WorkflowInstanceController,
          List<WorkflowInstance>
        > {
  WorkflowInstanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workflowInstanceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workflowInstanceControllerHash();

  @$internal
  @override
  WorkflowInstanceController create() => WorkflowInstanceController();
}

String _$workflowInstanceControllerHash() =>
    r'8d28aa7b1a1e12c5c6e49f06636f895392ded4c1';

abstract class _$WorkflowInstanceController
    extends $AsyncNotifier<List<WorkflowInstance>> {
  FutureOr<List<WorkflowInstance>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<WorkflowInstance>>, List<WorkflowInstance>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<WorkflowInstance>>,
                List<WorkflowInstance>
              >,
              AsyncValue<List<WorkflowInstance>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
