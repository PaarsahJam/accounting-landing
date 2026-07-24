import '../../features/attachments/data/attachments_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import '../company/company.dart';
import '../company/company_repository.dart';
import 'backup_manifest.dart';
import 'backup_package.dart';
import 'backup_section.dart';

class BackupExporter {
  BackupExporter({
    required CompanyRepository companyRepository,
    required SettingsRepository settingsRepository,
    required AttachmentsRepository attachmentsRepository,
  })  : _companies = companyRepository,
        _settings = settingsRepository,
        _attachments = attachmentsRepository;

  final CompanyRepository _companies;
  final SettingsRepository _settings;
  final AttachmentsRepository _attachments;

  Future<BackupPackage> exportFull({String? description}) async {
    final companiesResult = await _companies.fetchCompanies();
    final companyIds =
        companiesResult.data?.map((c) => c.id).toList() ?? [];

    final manifest = BackupManifest.current(
      companyIds: companyIds,
      sections: [
        ...BackupSections.coreSections,
        BackupSections.attachmentMetadata,
      ],
      description: description,
    );

    final data = <String, dynamic>{};

    // Settings
    final settingsResult = await _settings.fetchSettings();
    if (settingsResult.isSuccess && settingsResult.data != null) {
      data[BackupSections.settings] = settingsResult.data;
    }

    // Companies
    if (companiesResult.isSuccess && companiesResult.data != null) {
      data[BackupSections.companies] =
          companiesResult.data!.map(_companyToJson).toList();
    }

    // User preferences (placeholder for future)
    data[BackupSections.userPreferences] = <String, String>{};

    // Attachment metadata
    data[BackupSections.attachmentMetadata] =
        await _exportAllAttachments();

    return BackupPackage(manifest: manifest, data: data);
  }

  Future<List<Map<String, dynamic>>> _exportAllAttachments() async {
    final all = <Map<String, dynamic>>[];
    // Walk through all entity types — in a real impl this would iterate
    // known entity IDs; for now we export the mock seed data via a helper.
    final result = await _attachments.fetchAttachments(
      entityType: '',
      entityId: '',
    );
    if (result.isSuccess && result.data != null) {
      for (final a in result.data!) {
        all.add({
          'id': a.id,
          'entity_type': a.entityType,
          'entity_id': a.entityId,
          'filename': a.filename,
          'file_type': a.fileType.name,
          'file_size_bytes': a.fileSizeBytes,
          'uploaded_at': a.uploadedAt.toIso8601String(),
          'uploaded_by': a.uploadedBy,
          'notes': a.notes,
        });
      }
    }
    return all;
  }

  Map<String, dynamic> _companyToJson(Company c) => {
        'id': c.id,
        'name': c.name,
        if (c.legalName != null) 'legal_name': c.legalName,
        if (c.taxId != null) 'tax_id': c.taxId,
        if (c.currency != null) 'currency': c.currency,
        if (c.fiscalYearStartMonth != null)
          'fiscal_year_start_month': c.fiscalYearStartMonth,
        if (c.logoUrl != null) 'logo_url': c.logoUrl,
        'is_active': c.isActive,
      };
}
