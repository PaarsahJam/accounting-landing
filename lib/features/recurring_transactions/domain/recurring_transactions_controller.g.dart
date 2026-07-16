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
  String debugGetCreateSourceHash() =>
      _$recurringTransactionsControllerHash();

  @$internal
  @override
  RecurringTransactionsController create() =>
      RecurringTransactionsController();
}

String _$recurringTransactionsControllerHash() =>
    r'b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0';

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

// ─────────────────────────────────────────────────────────────────────────────
// activeRecurringTransactions
// ─────────────────────────────────────────────────────────────────────────────

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
  String debugGetCreateSourceHash() =>
      _$activeRecurringTransactionsHash();

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
      providerOverride:
          $SyncValueProvider<List<RecurringTransaction>>(value),
    );
  }
}

String _$activeRecurringTransactionsHash() =>
    r'c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1';

// ─────────────────────────────────────────────────────────────────────────────
// inactiveRecurringTransactions
// ─────────────────────────────────────────────────────────────────────────────

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
  String debugGetCreateSourceHash() =>
      _$inactiveRecurringTransactionsHash();

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
      providerOverride:
          $SyncValueProvider<List<RecurringTransaction>>(value),
    );
  }
}

String _$inactiveRecurringTransactionsHash() =>
    r'd3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2';
