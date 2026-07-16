import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/banking_repository.dart';
import '../data/banking_repository_provider.dart';
import 'bank_account.dart';

part 'bank_accounts_controller.g.dart';

@riverpod
class BankAccountsController extends _$BankAccountsController {
  late final BankingRepository _repository;

  @override
  FutureOr<List<BankAccount>> build() async {
    _repository = ref.watch(bankingRepositoryProvider);
    final result = await _repository.fetchAccounts();
    if (result.isSuccess) {
      return result.data ?? const <BankAccount>[];
    }
    AppLogger.warning('Failed to load bank accounts', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchAccounts();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <BankAccount>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh bank accounts', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
