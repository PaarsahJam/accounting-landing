import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/general_ledger_repository.dart';
import '../data/general_ledger_repository_provider.dart';
import 'general_ledger_view_data.dart';

part 'general_ledger_controller.g.dart';

@riverpod
class GeneralLedgerController extends _$GeneralLedgerController {
  late final GeneralLedgerRepository _repository;

  @override
  FutureOr<GeneralLedgerViewData> build() async {
    _repository = ref.watch(generalLedgerRepositoryProvider);
    final result = await _repository.fetchViewData();
    if (result.isSuccess) {
      return result.data!;
    }
    AppLogger.warning(
      'Failed to load general ledger view data',
      error: result.error,
    );
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchViewData();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data!);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh general ledger', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
