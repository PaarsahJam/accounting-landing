// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_currency_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrenciesController)
final currenciesControllerProvider = CurrenciesControllerProvider._();

final class CurrenciesControllerProvider
    extends $AsyncNotifierProvider<CurrenciesController, List<Currency>> {
  CurrenciesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currenciesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currenciesControllerHash();

  @$internal
  @override
  CurrenciesController create() => CurrenciesController();
}

String _$currenciesControllerHash() =>
    r'ff6434fc9da78bcee5f76838c73ab6085bb5355a';

abstract class _$CurrenciesController extends $AsyncNotifier<List<Currency>> {
  FutureOr<List<Currency>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Currency>>, List<Currency>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Currency>>, List<Currency>>,
              AsyncValue<List<Currency>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ExchangeRatesController)
final exchangeRatesControllerProvider = ExchangeRatesControllerProvider._();

final class ExchangeRatesControllerProvider
    extends
        $AsyncNotifierProvider<ExchangeRatesController, List<ExchangeRate>> {
  ExchangeRatesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exchangeRatesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exchangeRatesControllerHash();

  @$internal
  @override
  ExchangeRatesController create() => ExchangeRatesController();
}

String _$exchangeRatesControllerHash() =>
    r'8cfb1644bd4cbb78ddb3ea7c1295e4fed55a79e9';

abstract class _$ExchangeRatesController
    extends $AsyncNotifier<List<ExchangeRate>> {
  FutureOr<List<ExchangeRate>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ExchangeRate>>, List<ExchangeRate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ExchangeRate>>, List<ExchangeRate>>,
              AsyncValue<List<ExchangeRate>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(baseCurrency)
final baseCurrencyProvider = BaseCurrencyProvider._();

final class BaseCurrencyProvider
    extends $FunctionalProvider<Currency?, Currency?, Currency?>
    with $Provider<Currency?> {
  BaseCurrencyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'baseCurrencyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$baseCurrencyHash();

  @$internal
  @override
  $ProviderElement<Currency?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Currency? create(Ref ref) {
    return baseCurrency(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Currency? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Currency?>(value),
    );
  }
}

String _$baseCurrencyHash() => r'ae97cce8d8a35dcd48696f054039f8a1e82e8fbc';
