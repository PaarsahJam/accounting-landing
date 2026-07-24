import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/backup/backup_repository.dart';
import '../core/backup/backup_service.dart';
import '../core/company/company_controller.dart';
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
    WidgetsFlutterBinding.ensureInitialized();
    // Trigger company loading before the app tree mounts
    // so the router redirect guard has data on first frame.
    final container = ProviderContainer();
    container.read(companyListProvider);
    container.dispose();
    // Check for pending restore on startup
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
          _restoreMessage =
              'Restored ${report.restoredSections} section(s)';
        }
        await storage.deleteBackup(
            BackupService.defaultBackupFilename);
      }
    } catch (_) {
      // Silently skip restore failures on startup
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
