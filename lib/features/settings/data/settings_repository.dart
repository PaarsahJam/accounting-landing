import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';

class SettingsRepository {
  Future<AppResult<Map<String, String>>> fetchSettings() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success({
        'Theme': 'System',
        'Language': 'Persian',
        'Currency': 'IRR',
      });
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
