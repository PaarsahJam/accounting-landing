// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_ledger_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GeneralLedgerController)
final generalLedgerControllerProvider = GeneralLedgerControllerProvider._();

final class GeneralLedgerControllerProvider
    extends
        $AsyncNotifierProvider<GeneralLedgerController, GeneralLedgerViewData> {
  GeneralLedgerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generalLedgerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generalLedgerControllerHash();

  @$internal
  @override
  GeneralLedgerController create() => GeneralLedgerController();
}

String _$generalLedgerControllerHash() =>
    r'67c142a220d40fba06e20b1757481211b41b8bce';

abstract class _$GeneralLedgerController
    extends $AsyncNotifier<GeneralLedgerViewData> {
  FutureOr<GeneralLedgerViewData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<GeneralLedgerViewData>, GeneralLedgerViewData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<GeneralLedgerViewData>,
                GeneralLedgerViewData
              >,
              AsyncValue<GeneralLedgerViewData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
