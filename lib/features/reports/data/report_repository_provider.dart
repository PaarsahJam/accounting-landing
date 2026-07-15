import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'report_repository.dart';

part 'report_repository_provider.g.dart';

@riverpod
ReportRepository reportRepository(Ref ref) {
  return MockReportRepository();
}
