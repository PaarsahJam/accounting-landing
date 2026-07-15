// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_dashboard_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(financialDashboardRepository)
final financialDashboardRepositoryProvider =
    FinancialDashboardRepositoryProvider._();

final class FinancialDashboardRepositoryProvider
    extends
        $FunctionalProvider<
          FinancialDashboardRepository,
          FinancialDashboardRepository,
          FinancialDashboardRepository
        >
    with $Provider<FinancialDashboardRepository> {
  FinancialDashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialDashboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialDashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinancialDashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinancialDashboardRepository create(Ref ref) {
    return financialDashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinancialDashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinancialDashboardRepository>(value),
    );
  }
}

String _$financialDashboardRepositoryHash() =>
    r'783e762fb4d6682f7135698f1e7baedcfcffc360';
