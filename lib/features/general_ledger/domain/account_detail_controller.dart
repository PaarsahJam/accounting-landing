import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/general_ledger_repository.dart';
import '../data/general_ledger_repository_provider.dart';
import 'account_detail_view_data.dart';

part 'account_detail_controller.g.dart';

@riverpod
class AccountDetailController extends _$AccountDetailController {
  late final GeneralLedgerRepository _repository;

  @override
  FutureOr<AccountDetailViewData> build(String accountId) async {
    _repository = ref.watch(generalLedgerRepositoryProvider);
    final result = await _repository.fetchAccountDetail(accountId);
    if (result.isSuccess) {
      return result.data!;
    }

    AppLogger.warning('Failed to load account detail', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh(String accountId) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchAccountDetail(accountId);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data!);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh account detail', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
