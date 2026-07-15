import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/customer_statements_repository.dart';
import '../data/customer_statements_repository_provider.dart';
import 'customer_statement.dart';

part 'customer_statements_controller.g.dart';

@riverpod
class CustomerStatementsController extends _$CustomerStatementsController {
  late final CustomerStatementsRepository _repository;

  @override
  FutureOr<List<CustomerStatement>> build() async {
    _repository = ref.watch(customerStatementsRepositoryProvider);
    final result = await _repository.fetchCustomerStatements();
    if (result.isSuccess) {
      return result.data ?? const <CustomerStatement>[];
    }
    AppLogger.warning(
      'Failed to load customer statements',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchCustomerStatements();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <CustomerStatement>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh customer statements', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
