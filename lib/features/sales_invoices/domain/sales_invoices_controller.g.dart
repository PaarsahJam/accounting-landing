// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_invoices_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SalesInvoicesController)
final salesInvoicesControllerProvider = SalesInvoicesControllerProvider._();

final class SalesInvoicesControllerProvider
    extends
        $AsyncNotifierProvider<SalesInvoicesController, List<SalesInvoice>> {
  SalesInvoicesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'salesInvoicesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$salesInvoicesControllerHash();

  @$internal
  @override
  SalesInvoicesController create() => SalesInvoicesController();
}

String _$salesInvoicesControllerHash() =>
    r'717cd8508747af61b483c5388fcba3a4e50931eb';

abstract class _$SalesInvoicesController
    extends $AsyncNotifier<List<SalesInvoice>> {
  FutureOr<List<SalesInvoice>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SalesInvoice>>, List<SalesInvoice>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SalesInvoice>>, List<SalesInvoice>>,
              AsyncValue<List<SalesInvoice>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
