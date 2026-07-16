// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_export_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(importExportRepository)
final importExportRepositoryProvider = ImportExportRepositoryProvider._();

final class ImportExportRepositoryProvider
    extends
        $FunctionalProvider<
          ImportExportRepository,
          ImportExportRepository,
          ImportExportRepository
        >
    with $Provider<ImportExportRepository> {
  ImportExportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importExportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importExportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ImportExportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ImportExportRepository create(Ref ref) {
    return importExportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImportExportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImportExportRepository>(value),
    );
  }
}

String _$importExportRepositoryHash() =>
    r'c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0';
