import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/vendor_payments_repository.dart';
import '../data/vendor_payments_repository_provider.dart';
import 'vendor_payment.dart';

part 'vendor_payments_controller.g.dart';

@riverpod
class VendorPaymentsController extends _$VendorPaymentsController {
  late final VendorPaymentsRepository _repository;

  @override
  FutureOr<List<VendorPayment>> build() async {
    _repository = ref.watch(vendorPaymentsRepositoryProvider);
    final result = await _repository.fetchVendorPayments();
    if (result.isSuccess) {
      return result.data ?? const <VendorPayment>[];
    }
    AppLogger.warning('Failed to load vendor payments', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createVendorPayment(VendorPayment payment) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createVendorPayment(payment);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create vendor payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVendorPayment(VendorPayment payment) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateVendorPayment(payment);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update vendor payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVendorPayment(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteVendorPayment(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete vendor payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchVendorPayments();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <VendorPayment>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh vendor payments', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
