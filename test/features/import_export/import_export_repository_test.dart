// test/features/import_export/import_export_repository_test.dart

import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository.dart';
import 'package:accounting_app/features/import_export/domain/import_export_job.dart';
import 'package:flutter_test/flutter_test.dart';

MockImportExportRepository _makeRepo() =>
    MockImportExportRepository(auditRepository: MockAuditTrailRepository());

void main() {
  group('MockImportExportRepository', () {
    test('listJobs starts empty', () async {
      final repo = _makeRepo();
      final result = await repo.listJobs();
      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('exportCsv returns success job with csvPreview', () async {
      final repo = _makeRepo();
      final result = await repo.exportCsv(ExportEntityType.customers);
      expect(result.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.export));
      expect(result.data!.status, equals(JobStatus.success));
      expect(result.data!.csvPreview, isNotNull);
      expect(result.data!.csvPreview, contains('id,name'));
    });

    test('exportCsv rowCount matches data rows', () async {
      final repo = _makeRepo();
      final result = await repo.exportCsv(ExportEntityType.customers);
      // customers mock has 3 data rows
      expect(result.data!.rowCount, equals(3));
    });

    test('importCsv returns success job without csvPreview', () async {
      final repo = _makeRepo();
      final result = await repo.importCsv(ExportEntityType.vendors);
      expect(result.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.import));
      expect(result.data!.status, equals(JobStatus.success));
      expect(result.data!.csvPreview, isNull);
    });

    test('jobs appear in listJobs after operations', () async {
      final repo = _makeRepo();
      await repo.exportCsv(ExportEntityType.customers);
      await repo.importCsv(ExportEntityType.vendors);

      final jobs = (await repo.listJobs()).data!;
      expect(jobs.length, equals(2));
    });

    test('jobs are returned newest first', () async {
      final repo = _makeRepo();
      await repo.exportCsv(ExportEntityType.customers);
      await repo.importCsv(ExportEntityType.vendors);

      final jobs = (await repo.listJobs()).data!;
      // most recent (import) should be first
      expect(jobs.first.entityType, equals(ExportEntityType.vendors));
    });

    test('all ExportEntityTypes can be exported', () async {
      final repo = _makeRepo();
      for (final type in ExportEntityType.values) {
        final result = await repo.exportCsv(type);
        expect(result.isSuccess, isTrue, reason: '${type.label} failed');
        expect(result.data!.csvPreview, isNotNull);
      }
    });
  });

  group('ExportEntityType', () {
    test('all values have non-empty labels', () {
      for (final t in ExportEntityType.values) {
        expect(t.label, isNotEmpty);
      }
    });

    test('csvFilename contains .csv', () {
      for (final t in ExportEntityType.values) {
        expect(t.csvFilename, endsWith('.csv'));
      }
    });
  });

  group('ImportExportJob', () {
    test('equality is by id', () {
      const a = ImportExportJob(
        id: 'EXP-1',
        entityType: ExportEntityType.customers,
        direction: JobDirection.export,
        status: JobStatus.success,
        performedAt: _epoch,
        rowCount: 3,
      );
      const b = ImportExportJob(
        id: 'EXP-1',
        entityType: ExportEntityType.vendors,
        direction: JobDirection.import,
        status: JobStatus.failure,
        performedAt: _epoch,
        rowCount: 0,
      );
      expect(a, equals(b));
    });
  });
}

// Constant DateTime workaround — use a fixed value that is compile-time constant
// for the model test only.
const _epoch = _ConstDate();

class _ConstDate implements DateTime {
  const _ConstDate();
  @override
  int get year => 2026;
  @override
  int get month => 1;
  @override
  int get day => 1;
  @override
  int get hour => 0;
  @override
  int get minute => 0;
  @override
  int get second => 0;
  @override
  int get millisecond => 0;
  @override
  int get microsecond => 0;
  @override
  bool get isUtc => false;
  @override
  int get weekday => DateTime(2026).weekday;
  @override
  int get millisecondsSinceEpoch => DateTime(2026).millisecondsSinceEpoch;
  @override
  int get microsecondsSinceEpoch => DateTime(2026).microsecondsSinceEpoch;
  @override
  String get timeZoneName => DateTime(2026).timeZoneName;
  @override
  Duration get timeZoneOffset => DateTime(2026).timeZoneOffset;
  @override
  DateTime add(Duration d) => DateTime(2026).add(d);
  @override
  DateTime subtract(Duration d) => DateTime(2026).subtract(d);
  @override
  bool isAfter(DateTime other) => DateTime(2026).isAfter(other);
  @override
  bool isBefore(DateTime other) => DateTime(2026).isBefore(other);
  @override
  bool isAtSameMomentAs(DateTime other) =>
      DateTime(2026).isAtSameMomentAs(other);
  @override
  int compareTo(DateTime other) => DateTime(2026).compareTo(other);
  @override
  Duration difference(DateTime other) => DateTime(2026).difference(other);
  @override
  DateTime toLocal() => DateTime(2026).toLocal();
  @override
  DateTime toUtc() => DateTime(2026).toUtc();
  @override
  String toIso8601String() => DateTime(2026).toIso8601String();
  @override
  String toString() => DateTime(2026).toString();
}
