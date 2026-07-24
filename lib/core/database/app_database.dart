import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CustomersTable extends Table {
  TextColumn get id => text()();
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

@DriftDatabase(tables: [CustomersTable, VendorsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.withExecutor(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createAll();
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
