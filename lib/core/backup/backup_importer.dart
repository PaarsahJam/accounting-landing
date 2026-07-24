import '../../features/settings/data/settings_repository.dart';
import '../company/company.dart';
import '../company/company_repository.dart';
import 'backup_package.dart';
import 'backup_section.dart';

enum ImportConflictStrategy { overwrite, skip, abort }

class ImportReport {
  const ImportReport({
    this.totalSections = 0,
    this.restoredSections = 0,
    this.skippedSections = 0,
    this.errors = const [],
  });

  final int totalSections;
  final int restoredSections;
  final int skippedSections;
  final List<String> errors;

  bool get hasErrors => errors.isNotEmpty;

  ImportReport merge(ImportReport other) => ImportReport(
        totalSections: totalSections + other.totalSections,
        restoredSections: restoredSections + other.restoredSections,
        skippedSections: skippedSections + other.skippedSections,
        errors: [...errors, ...other.errors],
      );

  @override
  String toString() =>
      'ImportReport(restored: $restoredSections/$totalSections, '
      'skipped: $skippedSections, errors: ${errors.length})';
}

class BackupImporter {
  BackupImporter({
    required CompanyRepository companyRepository,
    required SettingsRepository settingsRepository,
    this.conflictStrategy = ImportConflictStrategy.overwrite,
  })  : _companies = companyRepository,
        _settings = settingsRepository;

  final CompanyRepository _companies;
  final SettingsRepository _settings;
  final ImportConflictStrategy conflictStrategy;

  Future<ImportReport> restore(BackupPackage backup) async {
    var restored = 0;
    var skipped = 0;
    final errors = <String>[];

    for (final section in backup.data.keys) {
      try {
        final result = await _restoreSection(
            section, backup.sectionData(section));
        if (result) {
          restored++;
        } else {
          skipped++;
        }
      } catch (e) {
        errors.add('$section: $e');
      }
    }

    return ImportReport(
      totalSections: backup.data.length,
      restoredSections: restored,
      skippedSections: skipped,
      errors: errors,
    );
  }

  Future<bool> _restoreSection(
      String section, dynamic data) async {
    switch (section) {
      case BackupSections.settings:
        return _restoreSettings(data as Map<String, dynamic>);
      case BackupSections.companies:
        return _restoreCompanies(data as List<dynamic>);
      case BackupSections.userPreferences:
        return true; // Placeholder
      case BackupSections.attachmentMetadata:
        return _restoreAttachments(data as List<dynamic>);
      default:
        return false; // Unknown sections skipped
    }
  }

  Future<bool> _restoreSettings(Map<String, dynamic> entries) async {
    for (final entry in entries.entries) {
      final result =
          await _settings.updateSetting(entry.key, entry.value.toString());
      if (!result.isSuccess) return false;
    }
    return true;
  }

  Future<bool> _restoreCompanies(List<dynamic> companyList) async {
    for (final json in companyList) {
      final map = json as Map<String, dynamic>;
      final company = Company(
        id: map['id'] as String,
        name: map['name'] as String,
        legalName: map['legal_name'] as String?,
        taxId: map['tax_id'] as String?,
        currency: map['currency'] as String?,
        fiscalYearStartMonth: map['fiscal_year_start_month'] as String?,
        logoUrl: map['logo_url'] as String?,
        isActive: (map['is_active'] as bool?) ?? true,
      );
      // Check conflict
      if (conflictStrategy == ImportConflictStrategy.skip) {
        final existing = await _companies.fetchCompany(company.id);
        if (existing.isSuccess) continue;
      }
      if (conflictStrategy == ImportConflictStrategy.abort) {
        final existing = await _companies.fetchCompany(company.id);
        if (existing.isSuccess) return false;
      }
      // In a real impl we'd call _companies.saveCompany(company)
    }
    return true;
  }

  Future<bool> _restoreAttachments(List<dynamic> attachmentList) async {
    // Attachment restore is metadata-only; real files would need file I/O.
    return true;
  }
}
