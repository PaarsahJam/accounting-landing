// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FinancialDashboardController)
final financialDashboardControllerProvider =
    FinancialDashboardControllerProvider._();

final class FinancialDashboardControllerProvider
    extends
        $AsyncNotifierProvider<
          FinancialDashboardController,
          FinancialDashboard
        > {
  FinancialDashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialDashboardControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialDashboardControllerHash();

  @$internal
  @override
  FinancialDashboardController create() => FinancialDashboardController();
}

String _$financialDashboardControllerHash() =>
    r'03138273daf0fe74f775d90a4f7fba0b9e4c0769';

abstract class _$FinancialDashboardController
    extends $AsyncNotifier<FinancialDashboard> {
  FutureOr<FinancialDashboard> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<FinancialDashboard>, FinancialDashboard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FinancialDashboard>, FinancialDashboard>,
              AsyncValue<FinancialDashboard>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
