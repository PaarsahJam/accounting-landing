import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';
import '../data/settings_repository.dart';
import '../data/settings_repository_provider.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  late final SettingsRepository _repository;

  @override
  FutureOr<Map<String, String>> build() async {
    _repository = ref.watch(settingsRepositoryProvider);
    final result = await _repository.fetchSettings();
    if (result.isSuccess) {
      return result.data ?? const <String, String>{};
    }
    AppLogger.warning('Failed to load settings', error: result.error);
    throw result.error ?? const UnknownFailure(message: 'Unknown error');
  }
}
