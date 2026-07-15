import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/customer_payments_repository.dart';
import '../data/customer_payments_repository_provider.dart';
import 'customer_payment.dart';

part 'customer_payments_controller.g.dart';

@riverpod
class CustomerPaymentsController extends _$CustomerPaymentsController {
  late final CustomerPaymentsRepository _repository;

  @override
  FutureOr<List<CustomerPayment>> build() async {
    _repository = ref.watch(customerPaymentsRepositoryProvider);
    final result = await _repository.fetchCustomerPayments();
    if (result.isSuccess) {
      return result.data ?? const <CustomerPayment>[];
    }
    AppLogger.warning('Failed to load customer payments', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createCustomerPayment(CustomerPayment payment) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createCustomerPayment(payment);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create customer payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateCustomerPayment(CustomerPayment payment) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateCustomerPayment(payment);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update customer payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteCustomerPayment(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteCustomerPayment(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete customer payment', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchCustomerPayments();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <CustomerPayment>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh customer payments', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
