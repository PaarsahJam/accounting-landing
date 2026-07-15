import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'financial_reports_repository.dart';

part 'financial_reports_repository_provider.g.dart';

@riverpod
FinancialReportsRepository financialReportsRepository(Ref ref) {
  return MockFinancialReportsRepository();
}
