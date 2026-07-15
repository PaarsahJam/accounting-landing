// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_preview_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JournalPreviewController)
final journalPreviewControllerProvider = JournalPreviewControllerFamily._();

final class JournalPreviewControllerProvider
    extends $AsyncNotifierProvider<JournalPreviewController, JournalPreview?> {
  JournalPreviewControllerProvider._({
    required JournalPreviewControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'journalPreviewControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$journalPreviewControllerHash();

  @override
  String toString() {
    return r'journalPreviewControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  JournalPreviewController create() => JournalPreviewController();

  @override
  bool operator ==(Object other) {
    return other is JournalPreviewControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journalPreviewControllerHash() =>
    r'72432fe0b5b719cbd5b9306f58391990264190c5';

final class JournalPreviewControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          JournalPreviewController,
          AsyncValue<JournalPreview?>,
          JournalPreview?,
          FutureOr<JournalPreview?>,
          (String, String)
        > {
  JournalPreviewControllerFamily._()
    : super(
        retry: null,
        name: r'journalPreviewControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JournalPreviewControllerProvider call(
    String documentType,
    String documentId,
  ) => JournalPreviewControllerProvider._(
    argument: (documentType, documentId),
    from: this,
  );

  @override
  String toString() => r'journalPreviewControllerProvider';
}

abstract class _$JournalPreviewController
    extends $AsyncNotifier<JournalPreview?> {
  late final _$args = ref.$arg as (String, String);
  String get documentType => _$args.$1;
  String get documentId => _$args.$2;

  FutureOr<JournalPreview?> build(String documentType, String documentId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<JournalPreview?>, JournalPreview?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<JournalPreview?>, JournalPreview?>,
              AsyncValue<JournalPreview?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
