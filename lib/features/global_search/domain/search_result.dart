import 'package:flutter/material.dart';

/// The entity type a [SearchResult] belongs to.
enum SearchEntityType {
  customer,
  vendor,
  product,
  salesInvoice,
  vendorBill,
  purchaseOrder,
  goodsReceipt,
  bankAccount,
  journalEntry,
  fiscalPeriod,
}

/// A single item returned by the global search.
class SearchResult {
  const SearchResult({
    required this.id,
    required this.entityType,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.icon,
  });

  /// The underlying entity id.
  final String id;

  /// The entity type (used to group results).
  final SearchEntityType entityType;

  /// Primary display label (e.g. invoice number, customer name).
  final String title;

  /// Secondary label (e.g. customer name for an invoice, SKU for a product).
  final String subtitle;

  /// Named GoRouter route (e.g. `'sales-invoices'`).
  final String route;

  /// Icon shown in the list tile.
  final IconData icon;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          entityType == other.entityType;

  @override
  int get hashCode => Object.hash(id, entityType);

  @override
  String toString() =>
      'SearchResult(id: $id, type: $entityType, title: $title)';
}
