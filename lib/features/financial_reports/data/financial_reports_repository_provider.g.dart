// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_reports_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(financialReportsRepository)
final financialReportsRepositoryProvider =
    FinancialReportsRepositoryProvider._();

final class FinancialReportsRepositoryProvider
    extends
        $FunctionalProvider<
          FinancialReportsRepository,
          FinancialReportsRepository,
          FinancialReportsRepository
        >
    with $Provider<FinancialReportsRepository> {
  FinancialReportsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialReportsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialReportsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FinancialReportsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FinancialReportsRepository create(Ref ref) {
    return financialReportsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinancialReportsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinancialReportsRepository>(value),
    );
  }
}

String _$financialReportsRepositoryHash() =>
    r'98a6b3f093c756ad1a7a19b8e0da1d7cf9b2f59b';
