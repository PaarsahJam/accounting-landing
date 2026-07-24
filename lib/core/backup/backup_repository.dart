import '../../core/errors/app_failure.dart';
import '../../core/errors/app_result.dart';
import 'backup_package.dart';

/// Abstract storage for backup files.
///
/// Override with platform-specific implementations (file system,
/// cloud, share sheet).
abstract class BackupStorage {
  Future<AppResult<void>> saveBackup(
    String filename,
    BackupPackage backup,
  );

  Future<AppResult<BackupPackage?>> loadBackup(String filename);

  Future<AppResult<List<String>>> listBackups();

  Future<AppResult<void>> deleteBackup(String filename);
}

/// In-memory implementation for testing and offline use.
class MemoryBackupStorage implements BackupStorage {
  final Map<String, String> _store = {};

  @override
  Future<AppResult<void>> saveBackup(
    String filename,
    BackupPackage backup,
  ) async {
    try {
      _store[filename] = backup.toJsonString();
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<BackupPackage?>> loadBackup(String filename) async {
    try {
      final source = _store[filename];
      if (source == null) {
        return AppResult.success(null);
      }
      return AppResult.success(BackupPackage.fromJsonString(source));
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<List<String>>> listBackups() async {
    try {
      return AppResult.success(_store.keys.toList());
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteBackup(String filename) async {
    try {
      _store.remove(filename);
      return AppResult.success(null);
    } catch (e) {
      return AppResult.failure(
          UnknownFailure(message: e.toString()));
    }
  }
}
