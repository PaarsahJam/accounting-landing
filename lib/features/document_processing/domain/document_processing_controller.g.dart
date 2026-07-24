// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_processing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DocumentProcessingController)
final documentProcessingControllerProvider =
    DocumentProcessingControllerProvider._();

final class DocumentProcessingControllerProvider
    extends
        $AsyncNotifierProvider<
          DocumentProcessingController,
          List<DocumentProcessingJob>
        > {
  DocumentProcessingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'documentProcessingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$documentProcessingControllerHash();

  @$internal
  @override
  DocumentProcessingController create() => DocumentProcessingController();
}

String _$documentProcessingControllerHash() =>
    r'19a47e3ef7c7be8ab5ebc9d7bba08550736c839c';

abstract class _$DocumentProcessingController
    extends $AsyncNotifier<List<DocumentProcessingJob>> {
  FutureOr<List<DocumentProcessingJob>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DocumentProcessingJob>>,
              List<DocumentProcessingJob>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DocumentProcessingJob>>,
                List<DocumentProcessingJob>
              >,
              AsyncValue<List<DocumentProcessingJob>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
