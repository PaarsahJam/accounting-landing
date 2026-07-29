import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Company (tenant) id assigned to rows that existed before multi-tenancy was
/// introduced. Legacy single-tenant data is backfilled to this company on
/// upgrade so it stays visible under one tenant rather than being orphaned.
const String kLegacyCompanyId = 'comp-1';

class CustomersTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get name => text()();
  TextColumn get company => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  RealColumn get outstandingBalance => real()();
  TextColumn get status => text()();
  TextColumn get notes => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class VendorsTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get companyName => text()();
  TextColumn get contactName => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get address => text()();
  TextColumn get taxIdentifier => text()();
  TextColumn get notes => text()();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProductsTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get sku => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get categoryId => text()();
  TextColumn get unitId => text()();
  RealColumn get price => real()();
  RealColumn get stockOnHand => real()();
  BoolColumn get active => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CustomersTable, VendorsTable, ProductsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Additive: create any tables introduced since the installed version.
        await m.createAll();
        if (from < 4) {
          // Multi-tenancy: add company_id to the tenant-scoped tables and
          // backfill pre-existing (single-tenant) rows to the legacy company so
          // that data stays visible under one tenant instead of being orphaned.
          // Fresh installs get the column from createAll (NOT NULL, no default),
          // which forces every new write to stamp company_id explicitly.
          for (final table in const [
            'customers_table',
            'vendors_table',
            'products_table',
          ]) {
            await customStatement(
              "ALTER TABLE $table ADD COLUMN company_id TEXT NOT NULL "
              "DEFAULT '$kLegacyCompanyId'",
            );
          }
        }
      },
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'accounting.db'));
      return NativeDatabase(file);
    });
  }
}
