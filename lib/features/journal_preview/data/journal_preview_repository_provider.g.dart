// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_preview_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journalPreviewRepository)
final journalPreviewRepositoryProvider = JournalPreviewRepositoryProvider._();

final class JournalPreviewRepositoryProvider
    extends
        $FunctionalProvider<
          JournalPreviewRepository,
          JournalPreviewRepository,
          JournalPreviewRepository
        >
    with $Provider<JournalPreviewRepository> {
  JournalPreviewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalPreviewRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalPreviewRepositoryHash();

  @$internal
  @override
  $ProviderElement<JournalPreviewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalPreviewRepository create(Ref ref) {
    return journalPreviewRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalPreviewRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalPreviewRepository>(value),
    );
  }
}

String _$journalPreviewRepositoryHash() =>
    r'c9b5972812366610026bf4beb6d6c0d767f40e86';
