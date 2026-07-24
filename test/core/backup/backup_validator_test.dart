import 'package:flutter_test/flutter_test.dart';
import 'package:accounting_app/core/backup/backup_manifest.dart';
import 'package:accounting_app/core/backup/backup_package.dart';
import 'package:accounting_app/core/backup/backup_validator.dart';

void main() {
  group('BackupValidator', () {
    late BackupValidator validator;

    setUp(() {
      validator = const BackupValidator();
    });

    test('valid backup passes validation', () {
      final manifest = BackupManifest.current(
        sections: ['settings'],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {'settings': {'theme': 'dark'}},
      );
      final result = validator.validate(backup);
      expect(result.isValid, true);
      expect(result.errors, isEmpty);
    });

    test('rejects future-dated backup', () {
      final manifest = BackupManifest(
        version: 1,
        createdAt: DateTime.now().toUtc().add(const Duration(days: 1)),
        appVersion: '1.0.0',
        sections: ['settings'],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {'settings': {}},
      );
      final result = validator.validate(backup);
      expect(result.isValid, false);
      expect(result.errors.first,
          contains('future'));
    });

    test('rejects unsupported version', () {
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
      final result = validator.validate(backup);
      expect(result.isValid, false);
    });

    test('rejects backup with no sections', () {
      final manifest = BackupManifest.current(
        sections: [],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {},
      );
      final result = validator.validate(backup);
      expect(result.isValid, false);
      expect(result.errors.first,
          contains('no sections'));
    });

    test('rejects when manifest declares section but data is missing', () {
      final manifest = BackupManifest.current(
        sections: ['settings', 'companies'],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {'settings': {}},
      );
      final result = validator.validate(backup);
      expect(result.isValid, false);
    });

    test('rejects old version', () {
      final manifest = BackupManifest(
        version: 0,
        createdAt: DateTime.now().toUtc(),
        appVersion: '1.0.0',
        sections: ['settings'],
      );
      final backup = BackupPackage(
        manifest: manifest,
        data: {'settings': {}},
      );
      final result = validator.validate(backup);
      expect(result.isValid, false);
      expect(result.errors.first,
          contains('too old'));
    });
  });
}
