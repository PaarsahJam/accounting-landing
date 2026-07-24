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

@DriftDatabase(tables: [CustomersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.withExecutor(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'accounting.db'));
      return NativeDatabase(file);
    });
  }
}
