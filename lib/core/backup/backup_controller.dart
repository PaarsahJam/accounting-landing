import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backup_importer.dart';
import 'backup_package.dart';
import 'backup_service.dart';
import 'file_system_backup_storage.dart';

part 'backup_controller.g.dart';

@riverpod
BackupService backupService(Ref ref) {
  final storage = FileSystemBackupStorage(
    directoryPath: '${Directory.systemTemp.path}/accounting_backups',
  );
  return BackupService(storage: storage);
}

@riverpod
class BackupController extends _$BackupController {
  @override
  FutureOr<void> build() {}

  Future<ImportReport> restoreFrom(BackupPackage backup) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(backupServiceProvider);
      final report = await service.restore(backup);
      state = const AsyncValue.data(null);
      return report;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<BackupPackage> createFullBackup({String? description}) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(backupServiceProvider);
      final backup = await service.exportFull(description: description);
      state = const AsyncValue.data(null);
      return backup;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
