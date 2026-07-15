import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/invoice_repository.dart';
import '../data/invoice_repository_provider.dart';
import 'invoice.dart';

part 'invoices_controller.g.dart';

@riverpod
class InvoicesController extends _$InvoicesController {
  late final InvoiceRepository _repository;

  @override
  FutureOr<List<Invoice>> build() async {
    _repository = ref.watch(invoiceRepositoryProvider);
    final result = await _repository.fetchInvoices();
    if (result.isSuccess) {
      return result.data ?? const <Invoice>[];
    }
    AppLogger.warning('Failed to load invoices', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }

  Future<void> createInvoice(Invoice invoice) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createInvoice(invoice);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data([...current, result.data!]);
    } catch (e, st) {
      AppLogger.warning('Failed to create invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateInvoice(Invoice invoice) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateInvoice(invoice);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      final next = current
          .map((item) => item.id == result.data!.id ? result.data! : item)
          .toList();
      state = AsyncValue.data(next);
    } catch (e, st) {
      AppLogger.warning('Failed to update invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteInvoice(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteInvoice(id);
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      final current = await future;
      state = AsyncValue.data(current.where((item) => item.id != id).toList());
    } catch (e, st) {
      AppLogger.warning('Failed to delete invoice', error: e);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.fetchInvoices();
      if (!result.isSuccess) {
        throw result.error ?? const UnknownFailure(message: 'Unknown error');
      }
      state = AsyncValue.data(result.data ?? const <Invoice>[]);
    } catch (e, st) {
      AppLogger.warning('Failed to refresh invoices', error: e);
      state = AsyncValue.error(e, st);
    }
  }
}
