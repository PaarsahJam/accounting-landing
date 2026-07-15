// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_reports_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FinancialReportsController)
final financialReportsControllerProvider =
    FinancialReportsControllerProvider._();

final class FinancialReportsControllerProvider
    extends
        $AsyncNotifierProvider<
          FinancialReportsController,
          FinancialReportsState
        > {
  FinancialReportsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialReportsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialReportsControllerHash();

  @$internal
  @override
  FinancialReportsController create() => FinancialReportsController();
}

String _$financialReportsControllerHash() =>
    r'd20c83f0dab2a89d9beb0e145f0a08d744cb7bd3';

abstract class _$FinancialReportsController
    extends $AsyncNotifier<FinancialReportsState> {
  FutureOr<FinancialReportsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<FinancialReportsState>, FinancialReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<FinancialReportsState>,
                FinancialReportsState
              >,
              AsyncValue<FinancialReportsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
