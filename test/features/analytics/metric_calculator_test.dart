import 'package:accounting_app/features/analytics/domain/kpi_definition.dart';
import 'package:accounting_app/features/analytics/domain/time_period.dart';
import 'package:accounting_app/features/analytics/services/metric_calculator.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice.dart';
import 'package:accounting_app/features/sales_invoices/domain/sales_invoice_status.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill_status.dart';
import 'package:accounting_app/features/vendor_bills/domain/vendor_bill_line.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_method.dart';
import 'package:accounting_app/features/customer_payments/domain/customer_payment_status.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_method.dart';
import 'package:accounting_app/features/vendor_payments/domain/vendor_payment_status.dart';
import 'package:accounting_app/features/expenses/domain/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MetricCalculator calc;
  late MetricSourceData data;
  late TimePeriod jan2026;
  late TimePeriod feb2026;

  setUp(() {
    calc = const MetricCalculator();
    jan2026 = const TimePeriod(year: 2026, month: 1);
    feb2026 = const TimePeriod(year: 2026, month: 2);

    data = MetricSourceData(
      invoices: [
        SalesInvoice(
          id: 'si-1', customerId: 'c1', customerName: 'C1',
          reference: 'INV-001', title: '', notes: '',
          invoiceDate: DateTime(2026, 1, 15), dueDate: DateTime(2026, 2, 14),
          status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [], subtotal: 5000, tax: 500, total: 5500,
        ),
        SalesInvoice(
          id: 'si-2', customerId: 'c2', customerName: 'C2',
          reference: 'INV-002', title: '', notes: '',
          invoiceDate: DateTime(2026, 2, 1), dueDate: DateTime(2026, 3, 1),
          status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [], subtotal: 12000, tax: 1200, total: 13200,
        ),
        SalesInvoice(
          id: 'si-3', customerId: 'c1', customerName: 'C1',
          reference: 'INV-003', title: '', notes: '',
          invoiceDate: DateTime(2026, 2, 20), dueDate: DateTime(2026, 3, 20),
          status: SalesInvoiceStatus(id: 'paid', label: 'Paid', color: 'green'),
          lines: [], subtotal: 3000, tax: 300, total: 3300,
        ),
        SalesInvoice(
          id: 'si-4', customerId: 'c3', customerName: 'C3',
          reference: 'INV-004', title: '', notes: '',
          invoiceDate: DateTime(2025, 12, 1), dueDate: DateTime(2025, 12, 31),
          status: SalesInvoiceStatus(id: 'overdue', label: 'Overdue', color: 'red'),
          lines: [], subtotal: 8000, tax: 800, total: 8800,
        ),
        SalesInvoice(
          id: 'si-5', customerId: 'c2', customerName: 'C2',
          reference: 'INV-005', title: '', notes: '',
          invoiceDate: DateTime(2026, 3, 10), dueDate: DateTime(2026, 4, 9),
          status: SalesInvoiceStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [], subtotal: 7000, tax: 700, total: 7700,
        ),
      ],
      vendorBills: [
        VendorBill(
          id: 'vb-1', vendorId: 'v1', purchaseOrderId: 'po-1',
          goodsReceiptId: 'gr-1', reference: 'BILL-001', title: '', notes: '',
          billDate: DateTime(2026, 1, 20), dueDate: DateTime(2026, 2, 19),
          status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [
            VendorBillLine(id: 'l1', description: 'Paper', quantity: 10, unitPrice: 25),
            VendorBillLine(id: 'l2', description: 'Toner', quantity: 5, unitPrice: 80),
          ],
        ),
        VendorBill(
          id: 'vb-2', vendorId: 'v2', purchaseOrderId: 'po-2',
          goodsReceiptId: 'gr-2', reference: 'BILL-002', title: '', notes: '',
          billDate: DateTime(2026, 2, 5), dueDate: DateTime(2026, 3, 5),
          status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [
            VendorBillLine(id: 'l3', description: 'Hosting', quantity: 1, unitPrice: 1200),
          ],
        ),
        VendorBill(
          id: 'vb-3', vendorId: 'v1', purchaseOrderId: 'po-3',
          goodsReceiptId: 'gr-3', reference: 'BILL-003', title: '', notes: '',
          billDate: DateTime(2026, 3, 1), dueDate: DateTime(2026, 3, 31),
          status: VendorBillStatus(id: 'open', label: 'Open', color: 'blue'),
          lines: [
            VendorBillLine(id: 'l4', description: 'Monitor', quantity: 3, unitPrice: 350),
          ],
        ),
      ],
      customerPayments: [
        CustomerPayment(
          id: 'cp-1', customerId: 'c1', customerName: 'C1',
          reference: 'RCPT-001', notes: '',
          paymentDate: DateTime(2026, 1, 25), receivedAt: DateTime(2026, 1, 25),
          amount: 5500,
          method: CustomerPaymentMethod(id: 'chk', label: 'Check', icon: 'check'),
          status: CustomerPaymentStatus(id: 'cleared', label: 'Cleared', color: 'green'),
          allocations: [],
        ),
        CustomerPayment(
          id: 'cp-2', customerId: 'c2', customerName: 'C2',
          reference: 'RCPT-002', notes: '',
          paymentDate: DateTime(2026, 2, 28), receivedAt: DateTime(2026, 2, 28),
          amount: 13200,
          method: CustomerPaymentMethod(id: 'wire', label: 'Wire', icon: 'account_balance'),
          status: CustomerPaymentStatus(id: 'cleared', label: 'Cleared', color: 'green'),
          allocations: [],
        ),
      ],
      vendorPayments: [
        VendorPayment(
          id: 'vp-1', vendorId: 'v1', vendorName: 'OfficeMax',
          reference: 'PMT-001', notes: '',
          paymentDate: DateTime(2026, 2, 10), createdAt: DateTime(2026, 2, 8),
          amount: 650,
          method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'bank'),
          status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
          allocations: [],
        ),
        VendorPayment(
          id: 'vp-2', vendorId: 'v2', vendorName: 'AWS Inc',
          reference: 'PMT-002', notes: '',
          paymentDate: DateTime(2026, 3, 5), createdAt: DateTime(2026, 3, 3),
          amount: 1200,
          method: VendorPaymentMethod(id: 'ach', label: 'ACH', icon: 'bank'),
          status: VendorPaymentStatus(id: 'sent', label: 'Sent', color: 'blue'),
          allocations: [],
        ),
      ],
      expenses: [
        Expense(
          id: 'exp-1', merchant: 'WeWork', amount: 2000, categoryId: 'rent',
          paymentMethodId: 'ach', occurredAt: DateTime(2026, 1, 5),
          description: 'Rent Jan', attachmentIds: [],
          status: ExpenseStatus.approved,
          businessId: 'b1', createdAt: DateTime(2026, 1, 5),
          updatedAt: DateTime(2026, 1, 5), createdBy: 'admin',
          updatedBy: 'admin', isDeleted: false,
        ),
        Expense(
          id: 'exp-2', merchant: 'Telco', amount: 500, categoryId: 'utilities',
          paymentMethodId: 'ach', occurredAt: DateTime(2026, 2, 3),
          description: 'Internet Feb', attachmentIds: [],
          status: ExpenseStatus.approved,
          businessId: 'b1', createdAt: DateTime(2026, 2, 3),
          updatedAt: DateTime(2026, 2, 3), createdBy: 'admin',
          updatedBy: 'admin', isDeleted: false,
        ),
      ],
    );
  });

  group('revenueInPeriod', () {
    test('returns sum of invoice totals in period', () {
      final result = calc.revenueInPeriod(data.invoices, feb2026);
      // si-2 (Feb 1, 13200) + si-3 (Feb 20, 3300) = 16500
      expect(result, 16500);
    });

    test('returns 0 when no invoices in period', () {
      final result = calc.revenueInPeriod(data.invoices, const TimePeriod(year: 2026, month: 4));
      expect(result, 0);
    });
  });

  group('expensesInPeriod', () {
    test('sums bill line totals and expense amounts', () {
      final result = calc.expensesInPeriod(
        bills: data.vendorBills,
        expenses: data.expenses,
        period: feb2026,
      );
      // vb-2 (Feb 5, qty 1 x 1200 = 1200) + exp-2 (Feb 3, 500) = 1700
      expect(result, 1700);
    });
  });

  group('calculateRevenue', () {
    test('returns KpiValue with revenue for period', () {
      final kpi = calc.calculateRevenue(data, feb2026, previousPeriod: jan2026);
      expect(kpi.definition.id, KpiDefinition.revenue.id);
      expect(kpi.value, 16500);
      expect(kpi.period, feb2026);
    });

    test('includes previous period value', () {
      final kpi = calc.calculateRevenue(data, feb2026, previousPeriod: jan2026);
      expect(kpi.previousValue, 5500); // si-1 in Jan
    });

    test('no previous period returns null previous', () {
      final kpi = calc.calculateRevenue(data, feb2026);
      expect(kpi.previousValue, isNull);
    });
  });

  group('calculateExpenses', () {
    test('returns total expenses for period', () {
      final kpi = calc.calculateExpenses(data, feb2026, previousPeriod: jan2026);
      expect(kpi.definition.id, KpiDefinition.expenses.id);
      expect(kpi.value, 1700);
      expect(kpi.previousValue, 2650); // vb-1 (650) + exp-1 (2000) = 2650 for Jan
    });
  });

  group('calculateGrossProfit', () {
    test('revenue minus expenses', () {
      final kpi = calc.calculateGrossProfit(data, feb2026, previousPeriod: jan2026);
      // revenue Feb = 16500, expenses Feb = 1700, gross = 14800
      expect(kpi.value, 14800);
      // previous: rev Jan = 5500, exp Jan = 2650, gross = 2850
      expect(kpi.previousValue, 2850);
    });
  });

  group('calculateNetProfit', () {
    test('same as gross profit for current data', () {
      final kpi = calc.calculateNetProfit(data, feb2026);
      expect(kpi.value, 14800);
    });
  });

  group('calculateGrossMargin', () {
    test('returns percentage', () {
      final kpi = calc.calculateGrossMargin(data, feb2026);
      expect(kpi.definition.isPercentage, isTrue);
      // (16500 - 1700) / 16500 * 100 = 14800 / 16500 * 100 ≈ 89.70
      expect(kpi.value, closeTo(89.70, 0.01));
    });

    test('returns 0 when revenue is 0', () {
      final emptyData = MetricSourceData();
      final kpi = calc.calculateGrossMargin(emptyData, feb2026);
      expect(kpi.value, 0);
    });
  });

  group('calculateNetProfitMargin', () {
    test('returns percentage', () {
      final kpi = calc.calculateNetProfitMargin(data, feb2026);
      expect(kpi.definition.isPercentage, isTrue);
      expect(kpi.value, closeTo(89.70, 0.01));
    });
  });

  group('calculateAccountsReceivable', () {
    test('sums unpaid, non-cancelled invoices', () {
      final kpi = calc.calculateAccountsReceivable(data, feb2026);
      // si-1 (5500, open), si-2 (13200, open), si-4 (8800, overdue), si-5 (7700, open)
      // si-3 is paid, excluded
      // Wait si-5 is March, but AR is all unpaid invoices regardless of period
      expect(kpi.value, 5500 + 13200 + 8800 + 7700); // 35200
    });
  });

  group('calculateAccountsPayable', () {
    test('sums unpaid, non-cancelled bill totals', () {
      final kpi = calc.calculateAccountsPayable(data, feb2026);
      // vb-1 (650, open), vb-2 (1200, open), vb-3 (1050, open)
      expect(kpi.value, 650 + 1200 + 1050); // 2900
    });
  });

  group('calculateCashPosition', () {
    test('received minus sent in period', () {
      final kpi = calc.calculateCashPosition(data, feb2026);
      // received: cp-2 (Feb 28, 13200)
      // sent: vp-1 (Feb 10, 650)
      // value = 13200 - 650 = 12550
      expect(kpi.value, 12550);
    });

    test('includes previous period', () {
      final kpi = calc.calculateCashPosition(data, feb2026, previousPeriod: jan2026);
      // previous: received: cp-1 (Jan 25, 5500), sent: none in Jan, prev = 5500
      expect(kpi.previousValue, 5500);
    });
  });

  group('calculateCurrentRatio', () {
    test('(AR + positive cash) / AP', () {
      final kpi = calc.calculateCurrentRatio(data, feb2026);
      // AR = 35200, cash = 13200 - 650 = 12550, currentAssets = 35200 + 12550 = 47750
      // AP = 2900, value = 47750 / 2900 ≈ 16.47
      expect(kpi.value, closeTo(47750 / 2900, 0.01));
    });
  });

  group('calculateAverageInvoiceValue', () {
    test('total / count in period', () {
      final kpi = calc.calculateAverageInvoiceValue(data, feb2026);
      // invoices in Feb: si-2 (13200), si-3 (3300), total = 16500, count = 2, avg = 8250
      expect(kpi.value, 8250);
    });

    test('returns 0 when no invoices in period', () {
      final empty = MetricSourceData(invoices: []);
      final kpi = calc.calculateAverageInvoiceValue(empty, feb2026);
      expect(kpi.value, 0);
    });
  });

  group('calculateInvoiceAging', () {
    test('average days overdue for unpaid overdue invoices', () {
      // si-4 is overdue (due Dec 31, 2025, unpaid)
      // The result depends on DateTime.now() so we can only verify it's > 0
      final kpi = calc.calculateInvoiceAging(data, feb2026);
      expect(kpi.value, greaterThan(0));
    });

    test('returns 0 when no overdue invoices', () {
      final paidData = MetricSourceData(
        invoices: [
          SalesInvoice(
            id: 'si-paid', customerId: 'c1', customerName: 'C1',
            reference: 'INV', title: '', notes: '',
            invoiceDate: DateTime(2026, 1, 1), dueDate: DateTime(2026, 1, 31),
            status: SalesInvoiceStatus(id: 'paid', label: 'Paid', color: 'green'),
            lines: [], subtotal: 100, tax: 0, total: 100,
          ),
        ],
      );
      final kpi = calc.calculateInvoiceAging(paidData, feb2026);
      expect(kpi.value, 0);
    });
  });

  group('calculateRevenueGrowthRate', () {
    test('returns growth rate between periods', () {
      final kpi = calc.calculateRevenueGrowthRate(data, feb2026, previousPeriod: jan2026);
      expect(kpi.definition.id, 'revenueGrowthRate');
      // Feb rev = 16500, Jan rev = 5500, growth = (16500-5500)/5500*100 = 200
      expect(kpi.value, 200);
    });

    test('returns 0 when no previous period', () {
      final kpi = calc.calculateRevenueGrowthRate(data, feb2026);
      expect(kpi.value, 0);
    });
  });

  group('calculateExpenseGrowthRate', () {
    test('returns growth rate between periods', () {
      final kpi = calc.calculateExpenseGrowthRate(data, feb2026, previousPeriod: jan2026);
      expect(kpi.definition.id, 'expenseGrowthRate');
      // Feb exp = 1700, Jan exp = 2650, growth = (1700-2650)/2650*100 = -35.85
      expect(kpi.value, closeTo(-35.85, 0.01));
    });
  });

  group('calculateAll', () {
    test('returns all 14 KPIs', () {
      final results = calc.calculateAll(data: data, period: feb2026, previousPeriod: jan2026);
      expect(results.length, 14);
      expect(results.map((k) => k.definition.id), containsAll([
        'revenue', 'expenses', 'grossProfit', 'netProfit',
        'grossMargin', 'netProfitMargin', 'accountsReceivable',
        'accountsPayable', 'cashPosition', 'currentRatio',
        'averageInvoiceValue', 'invoiceAging',
        'revenueGrowthRate', 'expenseGrowthRate',
      ]));
    });
  });
}
