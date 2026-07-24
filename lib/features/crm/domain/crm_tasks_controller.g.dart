// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CrmTasksController)
final crmTasksControllerProvider = CrmTasksControllerFamily._();

final class CrmTasksControllerProvider
    extends $AsyncNotifierProvider<CrmTasksController, List<CrmTask>> {
  CrmTasksControllerProvider._({
    required CrmTasksControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'crmTasksControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$crmTasksControllerHash();

  @override
  String toString() {
    return r'crmTasksControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CrmTasksController create() => CrmTasksController();

  @override
  bool operator ==(Object other) {
    return other is CrmTasksControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$crmTasksControllerHash() =>
    r'995499a36fe9995624b803e29cf3c3207c8f5462';

final class CrmTasksControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CrmTasksController,
          AsyncValue<List<CrmTask>>,
          List<CrmTask>,
          FutureOr<List<CrmTask>>,
          String?
        > {
  CrmTasksControllerFamily._()
    : super(
        retry: null,
        name: r'crmTasksControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CrmTasksControllerProvider call({String? customerId}) =>
      CrmTasksControllerProvider._(argument: customerId, from: this);

  @override
  String toString() => r'crmTasksControllerProvider';
}

abstract class _$CrmTasksController extends $AsyncNotifier<List<CrmTask>> {
  late final _$args = ref.$arg as String?;
  String? get customerId => _$args;

  FutureOr<List<CrmTask>> build({String? customerId});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<CrmTask>>, List<CrmTask>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CrmTask>>, List<CrmTask>>,
              AsyncValue<List<CrmTask>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(customerId: _$args));
  }
}
