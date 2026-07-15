// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_payments_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(customerPaymentsRepository)
final customerPaymentsRepositoryProvider =
    CustomerPaymentsRepositoryProvider._();

final class CustomerPaymentsRepositoryProvider
    extends
        $FunctionalProvider<
          CustomerPaymentsRepository,
          CustomerPaymentsRepository,
          CustomerPaymentsRepository
        >
    with $Provider<CustomerPaymentsRepository> {
  CustomerPaymentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerPaymentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerPaymentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomerPaymentsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomerPaymentsRepository create(Ref ref) {
    return customerPaymentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerPaymentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerPaymentsRepository>(value),
    );
  }
}

String _$customerPaymentsRepositoryHash() =>
    r'938bb56fae66eb7cbabdef0818342bd5d34214bb';
