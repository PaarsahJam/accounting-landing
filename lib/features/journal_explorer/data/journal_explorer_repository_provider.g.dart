// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_explorer_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journalExplorerRepository)
final journalExplorerRepositoryProvider = JournalExplorerRepositoryProvider._();

final class JournalExplorerRepositoryProvider
    extends
        $FunctionalProvider<
          JournalExplorerRepository,
          JournalExplorerRepository,
          JournalExplorerRepository
        >
    with $Provider<JournalExplorerRepository> {
  JournalExplorerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalExplorerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalExplorerRepositoryHash();

  @$internal
  @override
  $ProviderElement<JournalExplorerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  JournalExplorerRepository create(Ref ref) {
    return journalExplorerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JournalExplorerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JournalExplorerRepository>(value),
    );
  }
}

String _$journalExplorerRepositoryHash() =>
    r'161aca22f5da6ca950a17635839a92f95af11090';
