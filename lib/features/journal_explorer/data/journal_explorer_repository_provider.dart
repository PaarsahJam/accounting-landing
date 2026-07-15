import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'journal_explorer_repository.dart';

part 'journal_explorer_repository_provider.g.dart';

@riverpod
JournalExplorerRepository journalExplorerRepository(Ref ref) {
  return MockJournalExplorerRepository();
}
