import '../../features/attachments/data/attachments_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import '../company/company_repository.dart';
import '../errors/app_result.dart';
import 'backup_exporter.dart';
import 'backup_importer.dart';
import 'backup_package.dart';
import 'backup_repository.dart';
import 'backup_validator.dart';

class BackupService {
  BackupService({
    required BackupStorage storage,
    CompanyRepository? companyRepository,
    SettingsRepository? settingsRepository,
    AttachmentsRepository? attachmentsRepository,
    ImportConflictStrategy conflictStrategy = ImportConflictStrategy.overwrite,
  })  : _storage = storage,
        _companies = companyRepository ?? MockCompanyRepository(),
        _settings = settingsRepository ?? SettingsRepository(),
        _attachments = attachmentsRepository ?? MockAttachmentsRepository(),
        _conflictStrategy = conflictStrategy;

  final BackupStorage _storage;
  final CompanyRepository _companies;
  final SettingsRepository _settings;
  final AttachmentsRepository _attachments;
  final ImportConflictStrategy _conflictStrategy;

  static const String defaultBackupFilename = 'accounting_backup.json';

  BackupValidator get validator => const BackupValidator();

  BackupExporter get exporter => BackupExporter(
        companyRepository: _companies,
        settingsRepository: _settings,
        attachmentsRepository: _attachments,
      );

  BackupImporter get importer => BackupImporter(
        companyRepository: _companies,
        settingsRepository: _settings,
        conflictStrategy: _conflictStrategy,
      );

  Future<BackupPackage> exportFull({String? description}) async {
    final backup = await exporter.exportFull(description: description);
    final validation = validator.validate(backup);
    if (!validation.isValid) {
      throw BackupException(
          message: 'Export validation failed: ${validation.errors.join("; ")}');
    }
    return backup;
  }

  Future<ImportReport> restore(
    BackupPackage backup, {
    ImportConflictStrategy? strategy,
  }) async {
    final validation = validator.validate(backup);
    if (!validation.isValid) {
      throw BackupException(
          message: 'Restore validation failed: ${validation.errors.join("; ")}');
    }
    final actualStrategy = strategy ?? _conflictStrategy;
    final importer = BackupImporter(
      companyRepository: _companies,
      settingsRepository: _settings,
      conflictStrategy: actualStrategy,
    );
    return importer.restore(backup);
  }

  Future<AppResult<void>> saveBackup(
    BackupPackage backup, [
    String filename = defaultBackupFilename,
  ]) =>
      _storage.saveBackup(filename, backup);

  Future<AppResult<BackupPackage?>> loadBackup([
    String filename = defaultBackupFilename,
  ]) =>
      _storage.loadBackup(filename);

  Future<AppResult<List<String>>> listBackups() => _storage.listBackups();
}
