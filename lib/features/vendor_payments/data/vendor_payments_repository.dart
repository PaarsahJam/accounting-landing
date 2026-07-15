import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../../vendor_bills/domain/vendor_bill.dart';
import '../../vendor_bills/domain/vendor_bill_status.dart';
import '../domain/vendor_payment.dart';
import '../domain/vendor_payment_allocation.dart';
import '../domain/vendor_payment_method.dart';
import '../domain/vendor_payment_status.dart';

abstract class VendorPaymentsRepository {
  Future<AppResult<List<VendorPayment>>> fetchVendorPayments();
  Future<AppResult<VendorPayment>> createVendorPayment(VendorPayment payment);
  Future<AppResult<VendorPayment>> updateVendorPayment(VendorPayment payment);
  Future<AppResult<void>> deleteVendorPayment(String id);
  Future<AppResult<List<VendorBill>>> fetchVendorBills();
}

class MockVendorPaymentsRepository implements VendorPaymentsRepository {
  MockVendorPaymentsRepository();

  final List<VendorPaymentMethod> _methods = const [
    VendorPaymentMethod(id: 'cash', label: 'Cash', icon: 'cash'),
    VendorPaymentMethod(
      id: 'bank_transfer',
      label: 'Bank Transfer',
      icon: 'account_balance',
    ),
    VendorPaymentMethod(id: 'check', label: 'Check', icon: 'receipt_long'),
    VendorPaymentMethod(
      id: 'credit_card',
      label: 'Credit Card',
      icon: 'credit_card',
    ),
  ];

  final List<VendorPaymentStatus> _statuses = const [
    VendorPaymentStatus(id: 'pending', label: 'Pending', color: 'amber'),
    VendorPaymentStatus(id: 'partial', label: 'Partial', color: 'blue'),
    VendorPaymentStatus(id: 'paid', label: 'Paid', color: 'green'),
  ];

  final List<VendorPayment> _payments = [
    VendorPayment(
      id: 'VP-1001',
      vendorId: 'V-1001',
      vendorName: 'Northwind Supplies',
      reference: 'VP-1001',
      notes: 'Initial settlement against office supplies bill',
      paymentDate: DateTime(2024, 1, 12),
      createdAt: DateTime(2024, 1, 12),
      amount: 240000,
      method: const VendorPaymentMethod(
        id: 'bank_transfer',
        label: 'Bank Transfer',
        icon: 'account_balance',
      ),
      status: const VendorPaymentStatus(
        id: 'partial',
        label: 'Partial',
        color: 'blue',
      ),
      allocations: const [
        VendorPaymentAllocation(
          billId: 'VB-1001',
          billReference: 'VB-1001',
          amount: 240000,
        ),
      ],
    ),
  ];

  final List<VendorBill> _vendorBills = [
    VendorBill(
      id: 'VB-1001',
      vendorId: 'V-1001',
      purchaseOrderId: 'PO-1001',
      goodsReceiptId: 'GR-1001',
      reference: 'VB-1001',
      title: 'Office Supplies Bill',
      notes: 'Linked to initial delivery',
      billDate: DateTime(2024, 1, 10),
      dueDate: DateTime(2024, 1, 25),
      status: const VendorBillStatus(
        id: 'pending',
        label: 'Pending',
        color: 'amber',
      ),
      lines: const [],
    ),
  ];

  @override
  Future<AppResult<List<VendorPayment>>> fetchVendorPayments() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_payments));
  }

  @override
  Future<AppResult<VendorPayment>> createVendorPayment(
    VendorPayment payment,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _payments.add(payment);
    return AppResult.success(payment);
  }

  @override
  Future<AppResult<VendorPayment>> updateVendorPayment(
    VendorPayment payment,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _payments.indexWhere((item) => item.id == payment.id);
    if (index >= 0) {
      _payments[index] = payment;
      return AppResult.success(payment);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Vendor payment not found'),
    );
  }

  @override
  Future<AppResult<void>> deleteVendorPayment(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final index = _payments.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _payments.removeAt(index);
      return AppResult.success(null);
    }
    return AppResult.failure(
      const UnknownFailure(message: 'Vendor payment not found'),
    );
  }

  @override
  Future<AppResult<List<VendorBill>>> fetchVendorBills() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AppResult.success(List.unmodifiable(_vendorBills));
  }

  List<VendorPaymentMethod> get methods => List.unmodifiable(_methods);
  List<VendorPaymentStatus> get statuses => List.unmodifiable(_statuses);
}
