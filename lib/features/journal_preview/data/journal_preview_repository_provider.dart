import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'journal_preview_repository.dart';

part 'journal_preview_repository_provider.g.dart';

@riverpod
JournalPreviewRepository journalPreviewRepository(Ref ref) {
  return MockJournalPreviewRepository();
}
