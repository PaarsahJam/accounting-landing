import '../../core/errors/app_failure.dart';
import 'backup_manifest.dart';
import 'backup_package.dart';

class BackupValidationResult {
  const BackupValidationResult({
    this.isValid = false,
    this.errors = const [],
  });

  final bool isValid;
  final List<String> errors;

  @override
  String toString() =>
      isValid ? 'Valid' : 'Invalid: ${errors.join("; ")}';
}

class BackupValidator {
  const BackupValidator();

  static const int minSupportedVersion = 1;
  static const int maxSupportedVersion = 1;

  BackupValidationResult validate(BackupPackage backup) {
    final errors = <String>[];
    _validateManifest(backup.manifest, errors);
    if (errors.isEmpty) {
      _validateData(backup, errors);
    }
    return BackupValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  void _validateManifest(BackupManifest manifest, List<String> errors) {
    if (manifest.version < minSupportedVersion) {
      errors.add(
          'Backup version ${manifest.version} is too old (min: $minSupportedVersion)');
    }
    if (manifest.version > maxSupportedVersion) {
      errors.add(
          'Backup version ${manifest.version} requires a newer app version');
    }
    if (manifest.createdAt.isAfter(DateTime.now().toUtc().add(
        const Duration(hours: 1)))) {
      errors.add('Backup creation date is in the future');
    }
    if (manifest.sections.isEmpty) {
      errors.add('Backup contains no sections');
    }
  }

  void _validateData(BackupPackage backup, List<String> errors) {
    for (final section in backup.manifest.sections) {
      if (!backup.hasSection(section)) {
        errors.add(
            'Manifest declares section "$section" but no data found');
      }
    }
  }
}

class BackupException extends AppFailure {
  const BackupException({required String message}) : super(message);
}
