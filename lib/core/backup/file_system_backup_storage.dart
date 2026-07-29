import 'dart:io';

import 'package:path/path.dart' as p;

import '../../core/errors/app_failure.dart';
import '../../core/errors/app_result.dart';
import 'backup_package.dart';
import 'backup_repository.dart';

class FileSystemBackupStorage implements BackupStorage {
  FileSystemBackupStorage({required this.directoryPath});

  final String directoryPath;

  Directory get _dir => Directory(directoryPath);

  String _filePath(String filename) => p.join(directoryPath, filename);

  @override
  Future<AppResult<void>> saveBackup(
    String filename,
    BackupPackage backup,
  ) async {
    try {
      if (!await _dir.exists()) {
        await _dir.create(recursive: true);
      }
      final file = File(_filePath(filename));
      await file.writeAsString(backup.toJsonString());
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<BackupPackage?>> loadBackup(String filename) async {
    try {
      final file = File(_filePath(filename));
      if (!await file.exists()) {
        return AppResult.success(null);
      }
      final source = await file.readAsString();
      return AppResult.success(BackupPackage.fromJsonString(source));
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<List<String>>> listBackups() async {
    try {
      if (!await _dir.exists()) {
        return AppResult.success([]);
      }
      final files = await _dir
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.json'))
          .map((entity) => p.basename(entity.path))
          .toList();
      return AppResult.success(files);
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteBackup(String filename) async {
    try {
      final file = File(_filePath(filename));
      if (await file.exists()) {
        await file.delete();
      }
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(UnknownFailure(message: e.toString()));
    }
  }
}
