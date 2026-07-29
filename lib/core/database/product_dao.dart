import 'package:drift/drift.dart';

import 'app_database.dart';

/// Tenant-scoped data access for products. See [CustomerDao] for the scoping
/// contract: every query is filtered by [companyId] and the repository fails
/// closed when no company is active.
class ProductDao extends DatabaseAccessor<AppDatabase> {
  ProductDao(super.db);

  $ProductsTableTable get _products => db.productsTable;

  Future<List<ProductsTableData>> getAllProducts(String companyId) =>
      (select(_products)..where((t) => t.companyId.equals(companyId))).get();

  Future<ProductsTableData?> getProductById(String id, String companyId) =>
      (select(_products)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .getSingleOrNull();

  Future<int> insertProduct(ProductsTableCompanion product) =>
      into(_products).insert(product);

  /// Updates only when id AND companyId both match, preventing cross-tenant
  /// overwrites via a foreign id.
  Future<int> updateProduct(ProductsTableCompanion product, String companyId) {
    final id = product.id.value;
    return (update(_products)
          ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
        .write(product);
  }

  Future<int> deleteProduct(String id, String companyId) =>
      (delete(_products)
            ..where((t) => t.id.equals(id) & t.companyId.equals(companyId)))
          .go();

  /// Searches within the active company only — the companyId filter is ANDed
  /// with the text match so results never span tenants.
  Future<List<ProductsTableData>> searchProducts(
    String query,
    String companyId,
  ) {
    final pattern = '%$query%';
    return (select(_products)
          ..where((t) =>
              t.companyId.equals(companyId) &
              (t.name.like(pattern) |
                  t.sku.like(pattern) |
                  t.id.like(pattern))))
        .get();
  }
}
