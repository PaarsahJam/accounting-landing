// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_transactions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecurringTransactionsController)
final recurringTransactionsControllerProvider =
    RecurringTransactionsControllerProvider._();

final class RecurringTransactionsControllerProvider
    extends
        $AsyncNotifierProvider<
          RecurringTransactionsController,
          List<RecurringTransaction>
        > {
  RecurringTransactionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recurringTransactionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recurringTransactionsControllerHash();

  @$internal
  @override
  RecurringTransactionsController create() => RecurringTransactionsController();
}

String _$recurringTransactionsControllerHash() =>
    r'509667c6ecc37dd1f39e981a225dee244e4e314a';

abstract class _$RecurringTransactionsController
    extends $AsyncNotifier<List<RecurringTransaction>> {
  FutureOr<List<RecurringTransaction>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<RecurringTransaction>>,
              List<RecurringTransaction>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<RecurringTransaction>>,
                List<RecurringTransaction>
              >,
              AsyncValue<List<RecurringTransaction>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(activeRecurringTransactions)
final activeRecurringTransactionsProvider =
    ActiveRecurringTransactionsProvider._();

final class ActiveRecurringTransactionsProvider
    extends
        $FunctionalProvider<
          List<RecurringTransaction>,
          List<RecurringTransaction>,
          List<RecurringTransaction>
        >
    with $Provider<List<RecurringTransaction>> {
  ActiveRecurringTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeRecurringTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeRecurringTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<RecurringTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<RecurringTransaction> create(Ref ref) {
    return activeRecurringTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<RecurringTransaction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<RecurringTransaction>>(value),
    );
  }
}

String _$activeRecurringTransactionsHash() =>
    r'fd99c60d109f3a1542d26889bc7d9dceb455d053';

@ProviderFor(inactiveRecurringTransactions)
final inactiveRecurringTransactionsProvider =
    InactiveRecurringTransactionsProvider._();

final class InactiveRecurringTransactionsProvider
    extends
        $FunctionalProvider<
          List<RecurringTransaction>,
          List<RecurringTransaction>,
          List<RecurringTransaction>
        >
    with $Provider<List<RecurringTransaction>> {
  InactiveRecurringTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inactiveRecurringTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inactiveRecurringTransactionsHash();

  @$internal
  @override
  $ProviderElement<List<RecurringTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<RecurringTransaction> create(Ref ref) {
    return inactiveRecurringTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<RecurringTransaction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<RecurringTransaction>>(value),
    );
  }
}

String _$inactiveRecurringTransactionsHash() =>
    r'5e1245b40e0ffe4ea5e5a64de8a84919666a4e43';
