import 'dart:convert';

const int _kCurrentVersion = 1;

class BackupManifest {
  const BackupManifest({
    required this.version,
    required this.createdAt,
    required this.appVersion,
    this.companyIds = const [],
    this.sections = const [],
    this.description,
  });

  factory BackupManifest.current({
    List<String> companyIds = const [],
    List<String> sections = const [],
    String? description,
    String appVersion = '1.0.0',
  }) =>
      BackupManifest(
        version: _kCurrentVersion,
        createdAt: DateTime.now().toUtc(),
        appVersion: appVersion,
        companyIds: companyIds,
        sections: sections,
        description: description,
      );

  final int version;
  final DateTime createdAt;
  final String appVersion;
  final List<String> companyIds;
  final List<String> sections;
  final String? description;

  bool get isValid => version >= 1 && version <= _kCurrentVersion;

  bool containsSection(String section) => sections.contains(section);

  Map<String, dynamic> toJson() => {
        'version': version,
        'created_at': createdAt.toIso8601String(),
        'app_version': appVersion,
        'company_ids': companyIds,
        'sections': sections,
        if (description != null) 'description': description,
      };

  factory BackupManifest.fromJson(Map<String, dynamic> json) =>
      BackupManifest(
        version: json['version'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        appVersion: json['app_version'] as String? ?? 'unknown',
        companyIds: (json['company_ids'] as List<dynamic>?)
                ?.cast<String>() ??
            [],
        sections: (json['sections'] as List<dynamic>?)?.cast<String>() ?? [],
        description: json['description'] as String?,
      );

  String toJsonString() => jsonEncode(toJson());

  static BackupManifest fromJsonString(String source) =>
      BackupManifest.fromJson(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BackupManifest(v$version, ${sections.length} sections, '
      '${companyIds.length} companies)';
}
