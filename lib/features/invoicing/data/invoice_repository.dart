import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/invoice.dart';

abstract class InvoiceRepository {
  Future<AppResult<List<Invoice>>> fetchInvoices();
  Future<AppResult<Invoice>> createInvoice(Invoice invoice);
  Future<AppResult<Invoice>> updateInvoice(Invoice invoice);
  Future<AppResult<void>> deleteInvoice(String id);
}

class MockInvoiceRepository implements InvoiceRepository {
  final List<Invoice> _invoices = [
    const Invoice(
      id: 'INV-1001',
      customer: 'Alpha Trading',
      amount: 1250000,
      status: 'پرداخت شده',
      description: 'فاکتور خدمات ماهانه',
    ),
    const Invoice(
      id: 'INV-1002',
      customer: 'Nova Retail',
      amount: 780000,
      status: 'در انتظار',
      description: 'فاکتور خرید مواد اولیه',
    ),
  ];

  @override
  Future<AppResult<List<Invoice>>> fetchInvoices() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return AppResult.success(List<Invoice>.from(_invoices));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Invoice>> createInvoice(Invoice invoice) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _invoices.add(invoice);
      return AppResult.success(invoice);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Invoice>> updateInvoice(Invoice invoice) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _invoices.indexWhere((item) => item.id == invoice.id);
      if (index >= 0) {
        _invoices[index] = invoice;
      } else {
        _invoices.add(invoice);
      }
      return AppResult.success(invoice);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteInvoice(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _invoices.removeWhere((item) => item.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
