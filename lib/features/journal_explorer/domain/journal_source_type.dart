import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_source_type.freezed.dart';

const journalSourceTypeAll = 'all';

@freezed
abstract class JournalSourceType with _$JournalSourceType {
  const factory JournalSourceType({required String id, required String label}) =
      _JournalSourceType;
}
