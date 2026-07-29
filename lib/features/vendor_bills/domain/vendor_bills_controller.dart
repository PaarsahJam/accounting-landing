import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../../user_roles/domain/authorization.dart';
import '../../user_roles/domain/permission.dart';
import '../data/vendor_bills_repository.dart';
import '../data/vendor_bills_repository_provider.dart';
import 'vendor_bill.dart';

part 'vendor_bills_controller.g.dart';

@riverpod
class VendorBillsController extends _$VendorBillsController {
  late final VendorBillsRepository _repository;

  @override
  FutureOr<List<VendorBill>> build() async {
    _repository = ref.watch(vendorBillsRepositoryProvider);
    final result = await _repository.fetchVendorBills();
    if (result.isSuccess) {
      return result.data ?? const <VendorBill>[];
    }
    AppLogger.warning('Failed to load vendor bills', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createVendorBill(VendorBill bill) async {
    ref.requirePermission(Permission.editVendorBills, action: 'create vendor bills');
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createVendorBill(bill);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create vendor bill', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVendorBill(VendorBill bill) async {
    ref.requirePermission(Permission.editVendorBills, action: 'update vendor bills');
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateVendorBill(bill);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update vendor bill', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVendorBill(String id) async {
    ref.requirePermission(Permission.deleteVendorBills, action: 'delete vendor bills');
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteVendorBill(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete vendor bill', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchVendorBills();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <VendorBill>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh vendor bills', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
