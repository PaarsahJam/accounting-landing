// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_export_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImportExportController)
final importExportControllerProvider = ImportExportControllerProvider._();

final class ImportExportControllerProvider
    extends
        $AsyncNotifierProvider<ImportExportController, List<ImportExportJob>> {
  ImportExportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importExportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importExportControllerHash();

  @$internal
  @override
  ImportExportController create() => ImportExportController();
}

String _$importExportControllerHash() =>
    r'2b6dca03d8642d0f087e61e75211c380f17ee732';

abstract class _$ImportExportController
    extends $AsyncNotifier<List<ImportExportJob>> {
  FutureOr<List<ImportExportJob>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ImportExportJob>>, List<ImportExportJob>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ImportExportJob>>,
                List<ImportExportJob>
              >,
              AsyncValue<List<ImportExportJob>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
