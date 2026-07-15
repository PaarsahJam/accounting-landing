import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/vendor_repository.dart';
import '../data/vendor_repository_provider.dart';
import 'vendor.dart';

part 'vendors_controller.g.dart';

@riverpod
class VendorsController extends _$VendorsController {
  late final VendorRepository _repository;

  @override
  FutureOr<List<Vendor>> build() async {
    _repository = ref.watch(vendorRepositoryProvider);
    final result = await _repository.fetchVendors();
    if (result.isSuccess) {
      return result.data ?? const <Vendor>[];
    }
    AppLogger.warning('Failed to load vendors', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createVendor(Vendor vendor) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createVendor(vendor);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create vendor', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateVendor(Vendor vendor) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateVendor(vendor);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update vendor', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteVendor(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteVendor(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete vendor', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchVendors();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Vendor>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh vendors', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
