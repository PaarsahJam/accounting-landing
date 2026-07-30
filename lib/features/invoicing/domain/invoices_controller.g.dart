// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InvoicesController)
final invoicesControllerProvider = InvoicesControllerProvider._();

final class InvoicesControllerProvider
    extends $AsyncNotifierProvider<InvoicesController, List<Invoice>> {
  InvoicesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invoicesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invoicesControllerHash();

  @$internal
  @override
  InvoicesController create() => InvoicesController();
}

String _$invoicesControllerHash() =>
    r'1d4d1440b1dc3819b8f86193632de8499ff8c32e';

abstract class _$InvoicesController extends $AsyncNotifier<List<Invoice>> {
  FutureOr<List<Invoice>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Invoice>>, List<Invoice>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Invoice>>, List<Invoice>>,
              AsyncValue<List<Invoice>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
