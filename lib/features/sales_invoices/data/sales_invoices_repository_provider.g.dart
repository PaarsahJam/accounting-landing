// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_invoices_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(salesInvoicesRepository)
final salesInvoicesRepositoryProvider = SalesInvoicesRepositoryProvider._();

final class SalesInvoicesRepositoryProvider
    extends
        $FunctionalProvider<
          SalesInvoicesRepository,
          SalesInvoicesRepository,
          SalesInvoicesRepository
        >
    with $Provider<SalesInvoicesRepository> {
  SalesInvoicesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesInvoicesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesInvoicesRepositoryHash();

  @$internal
  @override
  $ProviderElement<SalesInvoicesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SalesInvoicesRepository create(Ref ref) {
    return salesInvoicesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SalesInvoicesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SalesInvoicesRepository>(value),
    );
  }
}

String _$salesInvoicesRepositoryHash() =>
    r'6c828ecf6dae168e6812c7064d2172dbc0e17523';
