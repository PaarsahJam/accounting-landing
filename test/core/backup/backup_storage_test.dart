import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/backup/backup_manifest.dart';
import 'package:accounting_app/core/backup/backup_package.dart';
import 'package:accounting_app/core/backup/backup_repository.dart';

void main() {
  group('MemoryBackupStorage', () {
    late MemoryBackupStorage storage;

    setUp(() {
      storage = MemoryBackupStorage();
    });

    test('save and load round-trip', () async {
      final pkg = BackupPackage(
        manifest: BackupManifest.current(sections: ['settings']),
        data: {'settings': {'theme': 'dark'}},
      );
      final saveResult = await storage.saveBackup('test.json', pkg);
      expect(saveResult.isSuccess, true);

      final loadResult = await storage.loadBackup('test.json');
      expect(loadResult.isSuccess, true);
      expect(loadResult.data, isNotNull);
      expect(loadResult.data!.manifest.version, 1);
      expect(loadResult.data!.hasSection('settings'), true);
    });

    test('load returns null for missing file', () async {
      final result = await storage.loadBackup('nonexistent.json');
      expect(result.isSuccess, true);
      expect(result.data, isNull);
    });

    test('listBackups returns saved file names', () async {
      await storage.saveBackup(
        'backup1.json',
        BackupPackage(
          manifest: BackupManifest.current(sections: []),
          data: {},
        ),
      );
      await storage.saveBackup(
        'backup2.json',
        BackupPackage(
          manifest: BackupManifest.current(sections: []),
          data: {},
        ),
      );
      final result = await storage.listBackups();
      expect(result.data, containsAll(['backup1.json', 'backup2.json']));
    });

    test('delete removes backup', () async {
      await storage.saveBackup(
        'temp.json',
        BackupPackage(
          manifest: BackupManifest.current(sections: []),
          data: {},
        ),
      );
      await storage.deleteBackup('temp.json');
      final result = await storage.loadBackup('temp.json');
      expect(result.data, isNull);
    });

    test('save with same filename overwrites', () async {
      await storage.saveBackup(
        'same.json',
        BackupPackage(
          manifest: BackupManifest.current(
            sections: ['settings'],
            description: 'first',
          ),
          data: {},
        ),
      );
      await storage.saveBackup(
        'same.json',
        BackupPackage(
          manifest: BackupManifest.current(
            sections: ['settings'],
            description: 'second',
          ),
          data: {},
        ),
      );
      final result = await storage.loadBackup('same.json');
      expect(result.data!.manifest.description, 'second');
    });
  });
}
