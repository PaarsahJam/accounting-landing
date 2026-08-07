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

// ── Sales Invoices ──────────────────────────────────────────────────────────

class SalesInvoiceTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get customerId => text()();
  TextColumn get customerName => text()();
  TextColumn get reference => text()();
  TextColumn get title => text()();
  TextColumn get notes => text()();
  DateTimeColumn get invoiceDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get statusId => text()();
  TextColumn get statusLabel => text()();
  TextColumn get statusColor => text()();
  RealColumn get subtotal => real()();
  RealColumn get tax => real()();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class SalesInvoiceLineTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get invoiceId => text()();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Vendor Bills ────────────────────────────────────────────────────────────

class VendorBillTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get vendorId => text()();
  TextColumn get purchaseOrderId => text()();
  TextColumn get goodsReceiptId => text()();
  TextColumn get reference => text()();
  TextColumn get title => text()();
  TextColumn get notes => text()();
  DateTimeColumn get billDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get statusId => text()();
  TextColumn get statusLabel => text()();
  TextColumn get statusColor => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class VendorBillLineTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get billId => text()();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Purchase Orders ─────────────────────────────────────────────────────────

class PurchaseOrderTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get vendorId => text()();
  TextColumn get reference => text()();
  TextColumn get title => text()();
  TextColumn get notes => text()();
  DateTimeColumn get orderDate => dateTime()();
  DateTimeColumn get expectedDate => dateTime()();
  TextColumn get statusId => text()();
  TextColumn get statusLabel => text()();
  TextColumn get statusColor => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class PurchaseOrderLineTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get purchaseOrderId => text()();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Expenses ────────────────────────────────────────────────────────────────

class ExpenseTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get merchant => text()();
  RealColumn get amount => real()();
  TextColumn get categoryId => text()();
  TextColumn get paymentMethodId => text()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get description => text()();
  TextColumn get attachmentIds => text()();
  TextColumn get status => text()();
  TextColumn get businessId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get createdBy => text()();
  TextColumn get updatedBy => text()();
  BoolColumn get isDeleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Banking ─────────────────────────────────────────────────────────────────

class BankAccountTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get name => text()();
  TextColumn get accountNumber => text()();
  TextColumn get accountType => text()();
  TextColumn get currency => text()();
  RealColumn get currentBalance => real()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class BankTransactionTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get accountId => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get transactionType => text()();
  TextColumn get reference => text()();
  TextColumn get description => text()();
  RealColumn get runningBalance => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Bank Statements ─────────────────────────────────────────────────────────

class BankStatementTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get bankAccountId => text()();
  TextColumn get bankAccountName => text()();
  DateTimeColumn get periodStart => dateTime()();
  DateTimeColumn get periodEnd => dateTime()();
  RealColumn get openingBalance => real()();
  RealColumn get closingBalance => real()();
  TextColumn get status => text()();
  DateTimeColumn get importedAt => dateTime()();
  DateTimeColumn? get reconciledAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BankStatementTransactionTable extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get statementId => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get description => text()();
  TextColumn get reference => text()();
  BoolColumn get isMatched => boolean()();
  TextColumn? get matchedErpEntryId => text().nullable()();
  TextColumn? get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Users (local auth) ──────────────────────────────────────────────────────

class UsersTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class UserSessionTable extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get token => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Companies (local persistence) ───────────────────────────────────────────

class CompaniesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn? get legalName => text().nullable()();
  TextColumn? get taxId => text().nullable()();
  TextColumn? get currency => text().nullable()();
  TextColumn? get fiscalYearStartMonth => text().nullable()();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  CustomersTable,
  VendorsTable,
  ProductsTable,
  SalesInvoiceTable,
  SalesInvoiceLineTable,
  VendorBillTable,
  VendorBillLineTable,
  PurchaseOrderTable,
  PurchaseOrderLineTable,
  ExpenseTable,
  BankAccountTable,
  BankTransactionTable,
  BankStatementTable,
  BankStatementTransactionTable,
  UsersTable,
  UserSessionTable,
  CompaniesTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static AppDatabase? _instance;

  factory AppDatabase() => _instance ??= AppDatabase._();

  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Additive: create any tables introduced since the installed version.
        await m.createAll();
        if (from < 4 && from >= 1) {
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
