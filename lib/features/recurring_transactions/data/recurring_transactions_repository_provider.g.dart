// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_transactions_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recurringTransactionsRepository)
final recurringTransactionsRepositoryProvider =
    RecurringTransactionsRepositoryProvider._();

final class RecurringTransactionsRepositoryProvider
    extends
        $FunctionalProvider<
          RecurringTransactionsRepository,
          RecurringTransactionsRepository,
          RecurringTransactionsRepository
        >
    with $Provider<RecurringTransactionsRepository> {
  RecurringTransactionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringTransactionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringTransactionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RecurringTransactionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RecurringTransactionsRepository create(Ref ref) {
    return recurringTransactionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecurringTransactionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecurringTransactionsRepository>(
        value,
      ),
    );
  }
}

String _$recurringTransactionsRepositoryHash() =>
    r'e5323c78e03e965a7fb8e0e8fdd8c0740560706d';
