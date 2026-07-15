// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_statements_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customerStatementsRepository)
final customerStatementsRepositoryProvider =
    CustomerStatementsRepositoryProvider._();

final class CustomerStatementsRepositoryProvider
    extends
        $FunctionalProvider<
          CustomerStatementsRepository,
          CustomerStatementsRepository,
          CustomerStatementsRepository
        >
    with $Provider<CustomerStatementsRepository> {
  CustomerStatementsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerStatementsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerStatementsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomerStatementsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomerStatementsRepository create(Ref ref) {
    return customerStatementsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerStatementsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerStatementsRepository>(value),
    );
  }
}

String _$customerStatementsRepositoryHash() =>
    r'0aae0245459330d21964d0313ed14fbf4961b868';
