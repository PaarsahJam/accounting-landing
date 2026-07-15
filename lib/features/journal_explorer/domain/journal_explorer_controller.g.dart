// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_explorer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JournalExplorerController)
final journalExplorerControllerProvider = JournalExplorerControllerProvider._();

final class JournalExplorerControllerProvider
    extends
        $AsyncNotifierProvider<JournalExplorerController, List<JournalEntry>> {
  JournalExplorerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journalExplorerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journalExplorerControllerHash();

  @$internal
  @override
  JournalExplorerController create() => JournalExplorerController();
}

String _$journalExplorerControllerHash() =>
    r'1d7ebc1f883f8592e05a429faa9f5f0e286748cb';

abstract class _$JournalExplorerController
    extends $AsyncNotifier<List<JournalEntry>> {
  FutureOr<List<JournalEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<JournalEntry>>, List<JournalEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<JournalEntry>>, List<JournalEntry>>,
              AsyncValue<List<JournalEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
