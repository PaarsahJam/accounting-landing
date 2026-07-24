// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crm_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CrmDashboardController)
final crmDashboardControllerProvider = CrmDashboardControllerProvider._();

final class CrmDashboardControllerProvider
    extends $AsyncNotifierProvider<CrmDashboardController, CrmDashboardData> {
  CrmDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crmDashboardControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crmDashboardControllerHash();

  @$internal
  @override
  CrmDashboardController create() => CrmDashboardController();
}

String _$crmDashboardControllerHash() =>
    r'b216c4775d2e760a40594c0488d4b522747a5eb2';

abstract class _$CrmDashboardController
    extends $AsyncNotifier<CrmDashboardData> {
  FutureOr<CrmDashboardData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CrmDashboardData>, CrmDashboardData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CrmDashboardData>, CrmDashboardData>,
              AsyncValue<CrmDashboardData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
