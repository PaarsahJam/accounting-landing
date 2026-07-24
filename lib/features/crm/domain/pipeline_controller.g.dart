// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PipelineController)
final pipelineControllerProvider = PipelineControllerFamily._();

final class PipelineControllerProvider
    extends $AsyncNotifierProvider<PipelineController, List<LeadOpportunity>> {
  PipelineControllerProvider._({
    required PipelineControllerFamily super.from,
    required ({String? customerId, PipelineStage? stage}) super.argument,
  }) : super(
         retry: null,
         name: r'pipelineControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pipelineControllerHash();

  @override
  String toString() {
    return r'pipelineControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PipelineController create() => PipelineController();

  @override
  bool operator ==(Object other) {
    return other is PipelineControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pipelineControllerHash() =>
    r'7191bf03eab8931819977659682fd1a3013811dd';

final class PipelineControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PipelineController,
          AsyncValue<List<LeadOpportunity>>,
          List<LeadOpportunity>,
          FutureOr<List<LeadOpportunity>>,
          ({String? customerId, PipelineStage? stage})
        > {
  PipelineControllerFamily._()
    : super(
        retry: null,
        name: r'pipelineControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PipelineControllerProvider call({String? customerId, PipelineStage? stage}) =>
      PipelineControllerProvider._(
        argument: (customerId: customerId, stage: stage),
        from: this,
      );

  @override
  String toString() => r'pipelineControllerProvider';
}

abstract class _$PipelineController
    extends $AsyncNotifier<List<LeadOpportunity>> {
  late final _$args = ref.$arg as ({String? customerId, PipelineStage? stage});
  String? get customerId => _$args.customerId;
  PipelineStage? get stage => _$args.stage;

  FutureOr<List<LeadOpportunity>> build({
    String? customerId,
    PipelineStage? stage,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<LeadOpportunity>>, List<LeadOpportunity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<LeadOpportunity>>,
                List<LeadOpportunity>
              >,
              AsyncValue<List<LeadOpportunity>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(customerId: _$args.customerId, stage: _$args.stage),
    );
  }
}
