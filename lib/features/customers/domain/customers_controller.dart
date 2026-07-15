import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/customer_repository.dart';
import '../data/customer_repository_provider.dart';
import 'customer.dart';

part 'customers_controller.g.dart';

@riverpod
class CustomersController extends _$CustomersController {
  late final CustomerRepository _repository;

  @override
  FutureOr<List<Customer>> build() async {
    _repository = ref.watch(customerRepositoryProvider);
    final result = await _repository.fetchCustomers();
    if (result.isSuccess) {
      return result.data ?? const <Customer>[];
    }
    AppLogger.warning('Failed to load customers', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createCustomer(Customer customer) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createCustomer(customer);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create customer', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateCustomer(customer);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update customer', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteCustomer(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteCustomer(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete customer', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchCustomers();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Customer>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh customers', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
