import 'dart:convert';

import 'backup_manifest.dart';
import 'backup_section.dart';

class BackupPackage {
  const BackupPackage({
    required this.manifest,
    this.data = const {},
  });

  /// Describes what is in this backup.
  final BackupManifest manifest;

  /// Map of section key → JSON-encodable data.
  /// Keys should match [BackupSections] constants.
  final Map<String, dynamic> data;

  bool get isEmpty => data.isEmpty;

  bool hasSection(String section) => data.containsKey(section);

  T? sectionData<T>(String section) => data[section] as T?;

  Map<String, dynamic> toJson() => {
        'manifest': manifest.toJson(),
        'data': data,
      };

  factory BackupPackage.fromJson(Map<String, dynamic> json) => BackupPackage(
        manifest:
            BackupManifest.fromJson(json['manifest'] as Map<String, dynamic>),
        data: Map<String, dynamic>.from(json['data'] as Map? ?? {}),
      );

  String toJsonString() => jsonEncode(toJson());

  static BackupPackage fromJsonString(String source) =>
      BackupPackage.fromJson(
          jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BackupPackage($manifest, ${data.length} sections)';
}
