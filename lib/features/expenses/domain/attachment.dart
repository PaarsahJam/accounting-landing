import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';

@freezed
abstract class ExpenseAttachment with _$ExpenseAttachment {
  const factory ExpenseAttachment({
    required String id,
    required String name,
    required String mimeType,
    required int sizeInBytes,
    required String uri,
    required DateTime uploadedAt,
  }) = _ExpenseAttachment;
}
