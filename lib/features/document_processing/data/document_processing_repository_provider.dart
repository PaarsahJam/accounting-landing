import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'document_processing_repository.dart';

part 'document_processing_repository_provider.g.dart';

@riverpod
DocumentProcessingRepository documentProcessingRepository(Ref ref) {
  return MockDocumentProcessingRepository();
}
