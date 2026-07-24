import 'package:drift/drift.dart';

import 'app_database.dart';

class ProductDao extends DatabaseAccessor<AppDatabase> {
  ProductDao(super.db);

  $ProductsTableTable get _products => db.productsTable;

  Future<List<ProductsTableData>> getAllProducts() => select(_products).get();

  Future<ProductsTableData?> getProductById(String id) =>
      (select(_products)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertProduct(ProductsTableCompanion product) =>
      into(_products).insert(product);

  Future<bool> updateProduct(ProductsTableCompanion product) =>
      update(_products).replace(product);

  Future<int> deleteProduct(String id) =>
      (delete(_products)..where((t) => t.id.equals(id))).go();

  Future<List<ProductsTableData>> searchProducts(String query) {
    final pattern = '%$query%';
    return (select(_products)
          ..where((t) =>
              t.name.like(pattern) |
              t.sku.like(pattern) |
              t.id.like(pattern)))
        .get();
  }
}