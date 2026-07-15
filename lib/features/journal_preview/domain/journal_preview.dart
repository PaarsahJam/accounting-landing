import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_preview.freezed.dart';

@freezed
abstract class JournalPreview with _$JournalPreview {
  const factory JournalPreview({
    required String documentType,
    required String documentId,
    required String documentReference,
    required DateTime postingDate,
    required String narration,
    required List<JournalPreviewLine> lines,
  }) = _JournalPreview;
}

@freezed
abstract class JournalPreviewLine with _$JournalPreviewLine {
  const factory JournalPreviewLine({
    required String accountName,
    required String accountCode,
    required double amount,
    required String side,
    required String description,
  }) = _JournalPreviewLine;
}
