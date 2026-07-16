// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_currency_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(multiCurrencyRepository)
final multiCurrencyRepositoryProvider = MultiCurrencyRepositoryProvider._();

final class MultiCurrencyRepositoryProvider
    extends
        $FunctionalProvider<
          MultiCurrencyRepository,
          MultiCurrencyRepository,
          MultiCurrencyRepository
        >
    with $Provider<MultiCurrencyRepository> {
  MultiCurrencyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'multiCurrencyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$multiCurrencyRepositoryHash();

  @$internal
  @override
  $ProviderElement<MultiCurrencyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MultiCurrencyRepository create(Ref ref) {
    return multiCurrencyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MultiCurrencyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MultiCurrencyRepository>(value),
    );
  }
}

String _$multiCurrencyRepositoryHash() =>
    r'3c0ddf7f3b320061acb57e093d8455686bb76453';
