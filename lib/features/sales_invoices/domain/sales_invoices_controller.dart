import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/sales_invoices_repository.dart';
import '../data/sales_invoices_repository_provider.dart';
import 'sales_invoice.dart';

part 'sales_invoices_controller.g.dart';

@riverpod
class SalesInvoicesController extends _$SalesInvoicesController {
  late final SalesInvoicesRepository _repository;

  @override
  FutureOr<List<SalesInvoice>> build() async {
    _repository = ref.watch(salesInvoicesRepositoryProvider);
    final result = await _repository.fetchSalesInvoices();
    if (result.isSuccess) {
      return result.data ?? const <SalesInvoice>[];
    }
    AppLogger.warning('Failed to load sales invoices', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createSalesInvoice(SalesInvoice invoice) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createSalesInvoice(invoice);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create sales invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSalesInvoice(SalesInvoice invoice) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateSalesInvoice(invoice);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update sales invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSalesInvoice(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteSalesInvoice(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete sales invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchSalesInvoices();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <SalesInvoice>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh sales invoices', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
