// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_metrics_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardMetricsController)
final dashboardMetricsControllerProvider =
    DashboardMetricsControllerProvider._();

final class DashboardMetricsControllerProvider
    extends
        $AsyncNotifierProvider<DashboardMetricsController, DashboardMetrics> {
  DashboardMetricsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardMetricsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardMetricsControllerHash();

  @$internal
  @override
  DashboardMetricsController create() => DashboardMetricsController();
}

String _$dashboardMetricsControllerHash() =>
    r'8e76bf113d5a2e4a52cbb237b55f64e24236511b';

abstract class _$DashboardMetricsController
    extends $AsyncNotifier<DashboardMetrics> {
  FutureOr<DashboardMetrics> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<DashboardMetrics>, DashboardMetrics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardMetrics>, DashboardMetrics>,
              AsyncValue<DashboardMetrics>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
