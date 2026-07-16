import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/bank_statement_repository.dart';
import '../data/bank_statement_repository_provider.dart';
import 'bank_statement.dart';

part 'bank_statements_controller.g.dart';

@riverpod
class BankStatementsController extends _$BankStatementsController {
  late final BankStatementRepository _repository;

  @override
  FutureOr<List<BankStatement>> build() async {
    _repository = ref.watch(bankStatementRepositoryProvider);
    final result = await _repository.fetchStatements();
    if (result.isSuccess) {
      return result.data ?? const <BankStatement>[];
    }
    AppLogger.warning('Failed to load bank statements', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchStatements();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <BankStatement>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh bank statements', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
