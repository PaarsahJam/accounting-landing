import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';

class SettingsRepository {
  final Map<String, String> _settings = {
    'Theme': 'System',
    'Language': 'Persian',
    'Currency': 'IRR',
  };

  Future<AppResult<Map<String, String>>> fetchSettings() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return AppResult.success(Map<String, String>.from(_settings));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  Future<AppResult<void>> updateSetting(String key, String value) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      _settings[key] = value;
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
