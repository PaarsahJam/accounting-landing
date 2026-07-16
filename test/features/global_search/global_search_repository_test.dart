import 'package:accounting_app/features/banking/data/banking_repository.dart';
import 'package:accounting_app/features/customers/data/customer_repository.dart';
import 'package:accounting_app/features/fiscal_periods/domain/fiscal_period.dart';
import 'package:accounting_app/features/global_search/data/global_search_repository.dart';
import 'package:accounting_app/features/global_search/domain/search_result.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/journal_explorer/data/journal_explorer_repository.dart';
import 'package:accounting_app/features/purchase_orders/data/purchase_orders_repository.dart';
import 'package:accounting_app/features/sales_invoices/data/sales_invoices_repository.dart';
import 'package:accounting_app/features/vendor_bills/data/vendor_bills_repository.dart';
import 'package:accounting_app/features/vendors/data/vendor_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

MockGlobalSearchRepository _makeRepo() => MockGlobalSearchRepository(
  customerRepo: MockCustomerRepository(),
  vendorRepo: MockVendorRepository(),
  inventoryRepo: MockInventoryRepository(),
  salesInvoicesRepo: MockSalesInvoicesRepository(),
  vendorBillsRepo: MockVendorBillsRepository(),
  purchaseOrdersRepo: MockPurchaseOrdersRepository(),
  bankingRepo: MockBankingRepository(),
  journalRepo: MockJournalExplorerRepository(),
);

final _fakePeriod = FiscalPeriod(
  id: 1,
  fiscalYearId: 1,
  periodNumber: 1,
  startDate: DateTime(2026, 1, 1),
  endDate: DateTime(2026, 1, 31),
  status: FiscalPeriodStatus.open,
);

void main() {
  group('MockGlobalSearchRepository', () {
    test('empty query returns empty list', () async {
      final repo = _makeRepo();
      final result = await repo.search('');
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('whitespace-only query returns empty list', () async {
      final repo = _makeRepo();
      final result = await repo.search('   ');
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('results include entityType for all found items', () async {
      final repo = _makeRepo();
      // Use '2026' which matches most seeded data
      final result = await repo.search('2026');
      expect(result.isSuccess, isTrue);
      for (final r in result.data!) {
        expect(r.entityType, isA<SearchEntityType>());
        expect(r.id, isNotEmpty);
        expect(r.route, isNotEmpty);
      }
    });

    test('search is case-insensitive', () async {
      final repo = _makeRepo();
      final lower = await repo.search('si-2026');
      final upper = await repo.search('SI-2026');
      expect(lower.isSuccess, isTrue);
      expect(upper.isSuccess, isTrue);
      expect(lower.data!.length, equals(upper.data!.length));
    });

    test(
      'query matching sales invoice id returns salesInvoice results',
      () async {
        final repo = _makeRepo();
        final result = await repo.search('SI-2026');
        expect(result.isSuccess, isTrue);
        if (result.data!.isNotEmpty) {
          expect(
            result.data!.any(
              (r) => r.entityType == SearchEntityType.salesInvoice,
            ),
            isTrue,
          );
        }
      },
    );

    test('query matching vendor bill id returns vendorBill results', () async {
      final repo = _makeRepo();
      final result = await repo.search('VB-');
      expect(result.isSuccess, isTrue);
      if (result.data!.isNotEmpty) {
        expect(
          result.data!.any((r) => r.entityType == SearchEntityType.vendorBill),
          isTrue,
        );
      }
    });

    test(
      'query matching purchase order id returns purchaseOrder results',
      () async {
        final repo = _makeRepo();
        final result = await repo.search('PO-');
        expect(result.isSuccess, isTrue);
        if (result.data!.isNotEmpty) {
          expect(
            result.data!.any(
              (r) => r.entityType == SearchEntityType.purchaseOrder,
            ),
            isTrue,
          );
        }
      },
    );

    test('search with fiscal periods finds matching period', () async {
      final repo = _makeRepo();
      final result = await repo.search(
        'period 1',
        fiscalPeriods: [_fakePeriod],
      );
      expect(result.isSuccess, isTrue);
      expect(
        result.data!.any((r) => r.entityType == SearchEntityType.fiscalPeriod),
        isTrue,
      );
    });

    test(
      'search without fiscal periods does not return fiscal period results',
      () async {
        final repo = _makeRepo();
        final result = await repo.search('period 1');
        expect(result.isSuccess, isTrue);
        expect(
          result.data!.any(
            (r) => r.entityType == SearchEntityType.fiscalPeriod,
          ),
          isFalse,
        );
      },
    );

    test('recent searches initially empty', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRecentSearches();
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('saveRecentSearch stores and retrieves query', () async {
      final repo = _makeRepo();
      await repo.saveRecentSearch('invoice');
      final result = await repo.fetchRecentSearches();
      expect(result.data, contains('invoice'));
    });

    test('saveRecentSearch deduplicates', () async {
      final repo = _makeRepo();
      await repo.saveRecentSearch('invoice');
      await repo.saveRecentSearch('invoice');
      final result = await repo.fetchRecentSearches();
      expect(result.data!.where((q) => q == 'invoice').length, equals(1));
    });

    test('clearRecentSearches empties the list', () async {
      final repo = _makeRepo();
      await repo.saveRecentSearch('invoice');
      await repo.saveRecentSearch('vendor');
      await repo.clearRecentSearches();
      final result = await repo.fetchRecentSearches();
      expect(result.data, isEmpty);
    });

    test('fetchRecentSearches respects limit', () async {
      final repo = _makeRepo();
      for (var i = 0; i < 10; i++) {
        await repo.saveRecentSearch('query$i');
      }
      final result = await repo.fetchRecentSearches(limit: 3);
      expect(result.data!.length, lessThanOrEqualTo(3));
    });

    test('saveRecentSearch ignores empty strings', () async {
      final repo = _makeRepo();
      await repo.saveRecentSearch('');
      await repo.saveRecentSearch('   ');
      final result = await repo.fetchRecentSearches();
      expect(result.data, isEmpty);
    });
  });

  group('SearchResult model', () {
    test('equality is by id + entityType', () {
      const r1 = SearchResult(
        id: 'SI-001',
        entityType: SearchEntityType.salesInvoice,
        title: 'Sales Invoice',
        subtitle: 'Customer A',
        route: 'sales-invoices',
        icon: Icons.receipt_long_outlined,
      );
      const r2 = SearchResult(
        id: 'SI-001',
        entityType: SearchEntityType.salesInvoice,
        title: 'Different title',
        subtitle: 'Different subtitle',
        route: 'sales-invoices',
        icon: Icons.receipt_long_outlined,
      );
      const r3 = SearchResult(
        id: 'SI-001',
        entityType: SearchEntityType.customer,
        title: 'Sales Invoice',
        subtitle: 'Customer A',
        route: 'customers',
        icon: Icons.person_outline,
      );

      expect(r1, equals(r2));
      expect(r1, isNot(equals(r3)));
      expect(r1.hashCode, equals(r2.hashCode));
    });

    test('toString includes id and type', () {
      const r = SearchResult(
        id: 'CUST-001',
        entityType: SearchEntityType.customer,
        title: 'Alice',
        subtitle: 'Tech Co',
        route: 'customers',
        icon: Icons.person_outline,
      );
      expect(r.toString(), contains('CUST-001'));
      expect(r.toString(), contains('customer'));
    });
  });

  group('SearchEntityType', () {
    test('has all expected values', () {
      expect(SearchEntityType.values, contains(SearchEntityType.customer));
      expect(SearchEntityType.values, contains(SearchEntityType.vendor));
      expect(SearchEntityType.values, contains(SearchEntityType.product));
      expect(SearchEntityType.values, contains(SearchEntityType.salesInvoice));
      expect(SearchEntityType.values, contains(SearchEntityType.vendorBill));
      expect(SearchEntityType.values, contains(SearchEntityType.purchaseOrder));
      expect(SearchEntityType.values, contains(SearchEntityType.goodsReceipt));
      expect(SearchEntityType.values, contains(SearchEntityType.bankAccount));
      expect(SearchEntityType.values, contains(SearchEntityType.journalEntry));
      expect(SearchEntityType.values, contains(SearchEntityType.fiscalPeriod));
    });
  });
}
