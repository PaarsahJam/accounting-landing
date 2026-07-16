import 'package:flutter/material.dart';

import '../../../core/errors/app_result.dart';
import '../../../features/banking/data/banking_repository.dart';
import '../../../features/customers/data/customer_repository.dart';
import '../../../features/fiscal_periods/domain/fiscal_period.dart';
import '../../../features/inventory/data/inventory_repository.dart';
import '../../../features/journal_explorer/data/journal_explorer_repository.dart';
import '../../../features/purchase_orders/data/purchase_orders_repository.dart';
import '../../../features/sales_invoices/data/sales_invoices_repository.dart';
import '../../../features/vendor_bills/data/vendor_bills_repository.dart';
import '../../../features/vendors/data/vendor_repository.dart';
import '../domain/search_result.dart';

abstract class GlobalSearchRepository {
  /// Search across all entities with the given [query].
  ///
  /// Returns [SearchResult] items matching the query. The query is matched
  /// case-insensitively against document numbers, names, references, SKUs,
  /// and account codes.
  Future<AppResult<List<SearchResult>>> search(
    String query, {
    List<FiscalPeriod> fiscalPeriods = const [],
  });

  /// Returns the last [limit] recent searches (mock storage).
  Future<AppResult<List<String>>> fetchRecentSearches({int limit = 8});

  /// Saves a query to recent searches history.
  Future<void> saveRecentSearch(String query);

  /// Clears all recent searches.
  Future<void> clearRecentSearches();
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

class MockGlobalSearchRepository implements GlobalSearchRepository {
  MockGlobalSearchRepository({
    CustomerRepository? customerRepo,
    VendorRepository? vendorRepo,
    InventoryRepository? inventoryRepo,
    SalesInvoicesRepository? salesInvoicesRepo,
    VendorBillsRepository? vendorBillsRepo,
    PurchaseOrdersRepository? purchaseOrdersRepo,
    BankingRepository? bankingRepo,
    JournalExplorerRepository? journalRepo,
  }) : _customerRepo = customerRepo ?? MockCustomerRepository(),
       _vendorRepo = vendorRepo ?? MockVendorRepository(),
       _inventoryRepo = inventoryRepo ?? MockInventoryRepository(),
       _salesInvoicesRepo = salesInvoicesRepo ?? MockSalesInvoicesRepository(),
       _vendorBillsRepo = vendorBillsRepo ?? MockVendorBillsRepository(),
       _purchaseOrdersRepo =
           purchaseOrdersRepo ?? MockPurchaseOrdersRepository(),
       _bankingRepo = bankingRepo ?? MockBankingRepository(),
       _journalRepo = journalRepo ?? MockJournalExplorerRepository();

  final CustomerRepository _customerRepo;
  final VendorRepository _vendorRepo;
  final InventoryRepository _inventoryRepo;
  final SalesInvoicesRepository _salesInvoicesRepo;
  final VendorBillsRepository _vendorBillsRepo;
  final PurchaseOrdersRepository _purchaseOrdersRepo;
  final BankingRepository _bankingRepo;
  final JournalExplorerRepository _journalRepo;

  final List<String> _recentSearches = [];

  @override
  Future<AppResult<List<SearchResult>>> search(
    String query, {
    List<FiscalPeriod> fiscalPeriods = const [],
  }) async {
    if (query.trim().isEmpty) {
      return AppResult.success(const []);
    }

    final q = query.toLowerCase().trim();
    final results = <SearchResult>[];

    // ── Customers ──────────────────────────────────────────────────────────
    final customersResult = await _customerRepo.fetchCustomers();
    if (customersResult.isSuccess) {
      for (final c in customersResult.data ?? const []) {
        if (_matches(q, [c.name, c.company, c.email])) {
          results.add(
            SearchResult(
              id: c.id,
              entityType: SearchEntityType.customer,
              title: c.name,
              subtitle: c.company.isNotEmpty ? c.company : c.email,
              route: 'customers',
              icon: Icons.person_outline,
            ),
          );
        }
      }
    }

    // ── Vendors ────────────────────────────────────────────────────────────
    final vendorsResult = await _vendorRepo.fetchVendors();
    if (vendorsResult.isSuccess) {
      for (final v in vendorsResult.data ?? const []) {
        if (_matches(q, [v.companyName, v.contactName, v.email])) {
          results.add(
            SearchResult(
              id: v.id,
              entityType: SearchEntityType.vendor,
              title: v.companyName,
              subtitle: v.contactName,
              route: 'vendors',
              icon: Icons.business_outlined,
            ),
          );
        }
      }
    }

    // ── Products ───────────────────────────────────────────────────────────
    final productsResult = await _inventoryRepo.fetchProducts();
    if (productsResult.isSuccess) {
      for (final p in productsResult.data ?? const []) {
        if (_matches(q, [p.sku, p.name, p.description])) {
          results.add(
            SearchResult(
              id: p.id,
              entityType: SearchEntityType.product,
              title: p.name,
              subtitle: p.sku,
              route: 'inventory',
              icon: Icons.inventory_2_outlined,
            ),
          );
        }
      }
    }

    // ── Sales Invoices ─────────────────────────────────────────────────────
    final siResult = await _salesInvoicesRepo.fetchSalesInvoices();
    if (siResult.isSuccess) {
      for (final si in siResult.data ?? const []) {
        if (_matches(q, [si.id, si.customerName, si.reference, si.title])) {
          results.add(
            SearchResult(
              id: si.id,
              entityType: SearchEntityType.salesInvoice,
              title: si.id,
              subtitle: si.customerName,
              route: 'sales-invoices',
              icon: Icons.receipt_long_outlined,
            ),
          );
        }
      }
    }

    // ── Vendor Bills ───────────────────────────────────────────────────────
    final vbResult = await _vendorBillsRepo.fetchVendorBills();
    if (vbResult.isSuccess) {
      for (final vb in vbResult.data ?? const []) {
        if (_matches(q, [vb.id, vb.reference, vb.title])) {
          results.add(
            SearchResult(
              id: vb.id,
              entityType: SearchEntityType.vendorBill,
              title: vb.id,
              subtitle: vb.reference.isNotEmpty ? vb.reference : vb.title,
              route: 'vendor-bills',
              icon: Icons.description_outlined,
            ),
          );
        }
      }
    }

    // ── Purchase Orders ────────────────────────────────────────────────────
    final poResult = await _purchaseOrdersRepo.fetchPurchaseOrders();
    if (poResult.isSuccess) {
      for (final po in poResult.data ?? const []) {
        if (_matches(q, [po.id, po.reference, po.title])) {
          results.add(
            SearchResult(
              id: po.id,
              entityType: SearchEntityType.purchaseOrder,
              title: po.id,
              subtitle: po.reference.isNotEmpty ? po.reference : po.title,
              route: 'purchase-orders',
              icon: Icons.shopping_cart_outlined,
            ),
          );
        }
      }
    }

    // ── Goods Receipts ─────────────────────────────────────────────────────
    final grResult = await _purchaseOrdersRepo.fetchGoodsReceipts();
    if (grResult.isSuccess) {
      for (final gr in grResult.data ?? const []) {
        if (_matches(q, [gr.id, gr.reference, gr.title])) {
          results.add(
            SearchResult(
              id: gr.id,
              entityType: SearchEntityType.goodsReceipt,
              title: gr.id,
              subtitle: gr.reference.isNotEmpty ? gr.reference : gr.title,
              route: 'purchase-orders',
              icon: Icons.local_shipping_outlined,
            ),
          );
        }
      }
    }

    // ── Bank Accounts ──────────────────────────────────────────────────────
    final bankResult = await _bankingRepo.fetchAccounts();
    if (bankResult.isSuccess) {
      for (final ba in bankResult.data ?? const []) {
        if (_matches(q, [ba.id, ba.name, ba.accountNumber])) {
          results.add(
            SearchResult(
              id: ba.id,
              entityType: SearchEntityType.bankAccount,
              title: ba.name,
              subtitle: ba.accountNumber,
              route: 'bank-accounts',
              icon: Icons.account_balance_outlined,
            ),
          );
        }
      }
    }

    // ── Journal Entries ────────────────────────────────────────────────────
    final jeResult = await _journalRepo.fetchJournalEntries();
    if (jeResult.isSuccess) {
      for (final je in jeResult.data ?? const []) {
        if (_matches(q, [je.journalNumber, je.sourceReference, je.narration])) {
          results.add(
            SearchResult(
              id: je.journalNumber,
              entityType: SearchEntityType.journalEntry,
              title: je.journalNumber,
              subtitle: je.narration.isNotEmpty
                  ? je.narration
                  : je.sourceReference,
              route: 'journal-explorer',
              icon: Icons.menu_book_outlined,
            ),
          );
        }
      }
    }

    // ── Fiscal Periods ─────────────────────────────────────────────────────
    for (final fp in fiscalPeriods) {
      final label = 'Period ${fp.periodNumber} / FY${fp.fiscalYearId}';
      final dateStr =
          '${fp.startDate.year}-${fp.startDate.month.toString().padLeft(2, '0')}'
          ' – '
          '${fp.endDate.year}-${fp.endDate.month.toString().padLeft(2, '0')}';
      if (_matches(q, [label, dateStr, fp.status.name])) {
        results.add(
          SearchResult(
            id: fp.id.toString(),
            entityType: SearchEntityType.fiscalPeriod,
            title: label,
            subtitle: dateStr,
            route: 'settings',
            icon: Icons.calendar_today_outlined,
          ),
        );
      }
    }

    return AppResult.success(List.unmodifiable(results));
  }

  @override
  Future<AppResult<List<String>>> fetchRecentSearches({int limit = 8}) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final recent = _recentSearches.reversed.take(limit).toList();
    return AppResult.success(List.unmodifiable(recent));
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;
    _recentSearches.remove(q); // deduplicate
    _recentSearches.add(q);
    if (_recentSearches.length > 20) {
      _recentSearches.removeAt(0);
    }
  }

  @override
  Future<void> clearRecentSearches() async {
    _recentSearches.clear();
  }

  bool _matches(String query, List<String> fields) {
    return fields.any((f) => f.toLowerCase().contains(query));
  }
}
