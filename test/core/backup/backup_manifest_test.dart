import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/backup/backup_manifest.dart';
import 'package:accounting_app/core/backup/backup_package.dart';
import 'package:accounting_app/core/backup/backup_section.dart';

void main() {
  group('BackupManifest', () {
    test('current creates valid manifest', () {
      final manifest = BackupManifest.current(
        companyIds: ['c1', 'c2'],
        sections: [BackupSections.settings, BackupSections.companies],
      );
      expect(manifest.isValid, true);
      expect(manifest.version, 1);
      expect(manifest.companyIds, ['c1', 'c2']);
      expect(manifest.sections.length, 2);
    });

    test('isValid returns true for version 1', () {
      final manifest = BackupManifest(
        version: 1,
        createdAt: DateTime.now().toUtc(),
        appVersion: '1.0.0',
        sections: [BackupSections.settings],
      );
      expect(manifest.isValid, true);
    });

    test('isValid returns false for unknown version', () {
      final manifest = BackupManifest(
        version: 99,
        createdAt: DateTime.now().toUtc(),
        appVersion: '1.0.0',
        sections: [BackupSections.settings],
      );
      expect(manifest.isValid, false);
    });

    test('toJson / fromJson round-trip', () {
      final original = BackupManifest.current(
        companyIds: ['comp-1'],
        sections: [BackupSections.settings, BackupSections.companies],
        description: 'Test backup',
      );
      final json = original.toJson();
      final restored = BackupManifest.fromJson(json);
      expect(restored.version, original.version);
      expect(restored.createdAt.toIso8601String(),
          original.createdAt.toIso8601String());
      expect(restored.companyIds, original.companyIds);
      expect(restored.sections, original.sections);
      expect(restored.description, original.description);
    });

    test('fromJsonString round-trip', () {
      final original = BackupManifest.current(
        companyIds: ['comp-1'],
        sections: [BackupSections.settings],
      );
      final jsonStr = original.toJsonString();
      final restored = BackupManifest.fromJsonString(jsonStr);
      expect(restored.version, original.version);
      expect(restored.companyIds, original.companyIds);
    });

    test('containsSection', () {
      final manifest = BackupManifest.current(
        sections: [BackupSections.settings, BackupSections.companies],
      );
      expect(manifest.containsSection(BackupSections.settings), true);
      expect(manifest.containsSection(BackupSections.auditTrail), false);
    });
  });

  group('BackupPackage', () {
    test('fromJson / toJson round-trip', () {
      final manifest = BackupManifest.current(
        sections: [BackupSections.settings],
      );
      final original = BackupPackage(
        manifest: manifest,
        data: {
          BackupSections.settings: {'theme': 'dark'},
        },
      );
      final json = original.toJson();
      final restored = BackupPackage.fromJson(json);
      expect(restored.manifest.version, original.manifest.version);
      expect(restored.hasSection(BackupSections.settings), true);
      final data = restored.sectionData<Map>(BackupSections.settings);
      expect(data, isNotNull);
      expect(data!['theme'], 'dark');
    });

    test('isEmpty returns true for empty data', () {
      final pkg = BackupPackage(
        manifest: BackupManifest.current(),
        data: {},
      );
      expect(pkg.isEmpty, true);
    });

    test('isEmpty returns false when data present', () {
      final pkg = BackupPackage(
        manifest: BackupManifest.current(),
        data: {BackupSections.settings: {}},
      );
      expect(pkg.isEmpty, false);
    });

    test('hasSection', () {
      final pkg = BackupPackage(
        manifest: BackupManifest.current(),
        data: {BackupSections.settings: {}},
      );
      expect(pkg.hasSection(BackupSections.settings), true);
      expect(pkg.hasSection(BackupSections.companies), false);
    });
  });
}
