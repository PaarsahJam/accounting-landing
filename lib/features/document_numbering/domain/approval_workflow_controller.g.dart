// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_workflow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ApprovalWorkflowController)
final approvalWorkflowControllerProvider =
    ApprovalWorkflowControllerProvider._();

final class ApprovalWorkflowControllerProvider
    extends
        $AsyncNotifierProvider<
          ApprovalWorkflowController,
          List<DocumentRecord>
        > {
  ApprovalWorkflowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'approvalWorkflowControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$approvalWorkflowControllerHash();

  @$internal
  @override
  ApprovalWorkflowController create() => ApprovalWorkflowController();
}

String _$approvalWorkflowControllerHash() =>
    r'689f28d0d50535e2e1c216353944aeba8e999791';

abstract class _$ApprovalWorkflowController
    extends $AsyncNotifier<List<DocumentRecord>> {
  FutureOr<List<DocumentRecord>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DocumentRecord>>, List<DocumentRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DocumentRecord>>,
                List<DocumentRecord>
              >,
              AsyncValue<List<DocumentRecord>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
