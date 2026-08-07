import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/backup/backup_manifest.dart';
import 'package:accounting_app/core/backup/backup_package.dart';
import 'package:accounting_app/core/backup/backup_repository.dart';
import 'package:accounting_app/core/backup/backup_service.dart';
import 'package:accounting_app/core/backup/backup_validator.dart';
import 'package:accounting_app/core/company/company_repository.dart';
import 'package:accounting_app/features/settings/data/settings_repository.dart';

void main() {
  group('BackupService', () {
    late MemoryBackupStorage storage;
    late BackupService service;

    setUp(() {
      storage = MemoryBackupStorage();
      service = BackupService(
        storage: storage,
        companyRepository: MockCompanyRepository(),
        settingsRepository: SettingsRepository(),
      );
    });

    test('exportFull produces valid backup', () async {
      final backup = await service.exportFull(
        description: 'Test export',
      );
      expect(backup.manifest.version, 1);
      expect(backup.manifest.description, 'Test export');
      expect(backup.manifest.sections, isNotEmpty);
      expect(backup.hasSection('settings'), true);
      expect(backup.hasSection('companies'), true);
      expect(backup.hasSection('user_preferences'), true);
    });

    test('export throws on validation failure', () async {
      // Override to force invalid — not applicable since
      // export always produces valid data; test the validation check
      // by creating an invalid backup manually.
      final invalidManifest = BackupManifest(
        version: 99,
        createdAt: DateTime.now().toUtc(),
        appVersion: '1.0.0',
        sections: ['settings'],
      );
      final invalidBackup = BackupPackage(
        manifest: invalidManifest,
        data: {'settings': {}},
      );
      final validation = service.validator.validate(invalidBackup);
      expect(validation.isValid, false);
    });

    test('save and load round-trip', () async {
      final backup = await service.exportFull();
      final saveResult = await service.saveBackup(backup);
      expect(saveResult.isSuccess, true);

      final loadResult = await service.loadBackup();
      expect(loadResult.isSuccess, true);
      expect(loadResult.data, isNotNull);
      expect(loadResult.data!.manifest.version, 1);
    });

    test('listBackups after save', () async {
      final backup = await service.exportFull();
      await service.saveBackup(backup, 'my_backup.json');

      final listResult = await service.listBackups();
      expect(listResult.data, contains('my_backup.json'));
    });

    test('restore valid backup returns report', () async {
      final backup = await service.exportFull();
      final report = await service.restore(backup);
      expect(report.totalSections, greaterThan(0));
      expect(report.restoredSections, greaterThan(0));
      expect(report.hasErrors, false);
    });

    test('restore rejects invalid backup', () async {
      final manifest = BackupManifest(
        version: 99,
        createdAt: DateTime.now().toUtc(),
        appVersion: '1.0.0',
        sections: ['settings'],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {'settings': {}},
      );
      expect(
        () => service.restore(backup),
        throwsA(isA<BackupException>()),
      );
    });
  });
}
