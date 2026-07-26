import 'package:flutter/material.dart';
import '../core/backup/backup_repository.dart';
import '../core/backup/backup_service.dart';
import '../core/logging/app_logger.dart';
import '../app/app.dart';

class Bootstrap extends StatefulWidget {
  const Bootstrap({super.key});

  @override
  State<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<Bootstrap> {
  bool _ready = false;
  String? _restoreMessage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // WidgetsFlutterBinding.ensureInitialized() is now in main() where it
    // belongs. Calling it here was a no-op at best and architecturally wrong.
    //
    // The previous ProviderContainer warm-up call was also removed: it created
    // a throwaway container independent of the app's ProviderScope, discarded
    // the result immediately on dispose, and achieved nothing.  The router's
    // redirect guard handles loading states correctly without pre-warming.
    await _checkRestore();
    if (!mounted) return;
    setState(() => _ready = true);
  }

  Future<void> _checkRestore() async {
    try {
      final storage = MemoryBackupStorage();
      final backup = await storage.loadBackup(
        BackupService.defaultBackupFilename,
      );
      if (backup.isSuccess && backup.data != null) {
        final service = BackupService(storage: storage);
        final report = await service.restore(backup.data!);
        if (report.hasErrors) {
          _restoreMessage =
              'Restore completed with ${report.errors.length} error(s)';
        } else {
          _restoreMessage = 'Restored ${report.restoredSections} section(s)';
        }
        await storage.deleteBackup(BackupService.defaultBackupFilename);
      }
    } catch (e) {
      // Log the failure so it appears in debug output / crash reporters.
      // Do not rethrow — a restore failure must not prevent app startup.
      AppLogger.warning('Restore check failed on startup', error: e);
      _restoreMessage = 'Startup restore check failed';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator.adaptive(),
                if (_restoreMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(_restoreMessage!),
                ],
              ],
            ),
          ),
        ),
      );
    }
    return const App();
  }
}
