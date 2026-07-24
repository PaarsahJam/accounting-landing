// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_processing_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(documentProcessingRepository)
final documentProcessingRepositoryProvider =
    DocumentProcessingRepositoryProvider._();

final class DocumentProcessingRepositoryProvider
    extends
        $FunctionalProvider<
          DocumentProcessingRepository,
          DocumentProcessingRepository,
          DocumentProcessingRepository
        >
    with $Provider<DocumentProcessingRepository> {
  DocumentProcessingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentProcessingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentProcessingRepositoryHash();

  @$internal
  @override
  $ProviderElement<DocumentProcessingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DocumentProcessingRepository create(Ref ref) {
    return documentProcessingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentProcessingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentProcessingRepository>(value),
    );
  }
}

String _$documentProcessingRepositoryHash() =>
    r'7013d1d8c41932dac59b784fe0b7e7e26140ce0d';
