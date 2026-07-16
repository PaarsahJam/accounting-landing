// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_workflow_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(approvalWorkflowRepository)
final approvalWorkflowRepositoryProvider =
    ApprovalWorkflowRepositoryProvider._();

final class ApprovalWorkflowRepositoryProvider
    extends
        $FunctionalProvider<
          ApprovalWorkflowRepository,
          ApprovalWorkflowRepository,
          ApprovalWorkflowRepository
        >
    with $Provider<ApprovalWorkflowRepository> {
  ApprovalWorkflowRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'approvalWorkflowRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$approvalWorkflowRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApprovalWorkflowRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApprovalWorkflowRepository create(Ref ref) {
    return approvalWorkflowRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApprovalWorkflowRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApprovalWorkflowRepository>(value),
    );
  }
}

String _$approvalWorkflowRepositoryHash() =>
    r'ed18184f4d8809608ed701b8c0ca7e24fee16abd';
