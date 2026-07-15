import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/vendor_statements_repository.dart';
import '../data/vendor_statements_repository_provider.dart';
import 'vendor_statement.dart';

part 'vendor_statements_controller.g.dart';

@riverpod
class VendorStatementsController extends _$VendorStatementsController {
  late final VendorStatementsRepository _repository;

  @override
  FutureOr<List<VendorStatement>> build() async {
    _repository = ref.watch(vendorStatementsRepositoryProvider);
    final result = await _repository.fetchVendorStatements();
    if (result.isSuccess) {
      return result.data ?? const <VendorStatement>[];
    }
    AppLogger.warning('Failed to load vendor statements', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchVendorStatements();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <VendorStatement>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh vendor statements', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
