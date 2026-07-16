// lib/features/recurring_transactions/data/recurring_transactions_repository_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/audit_trail/data/audit_trail_repository_provider.dart';
import 'recurring_transactions_repository.dart';

part 'recurring_transactions_repository_provider.g.dart';

@riverpod
RecurringTransactionsRepository recurringTransactionsRepository(Ref ref) {
  return MockRecurringTransactionsRepository(
    auditRepository: ref.watch(auditTrailRepositoryProvider),
  );
}
