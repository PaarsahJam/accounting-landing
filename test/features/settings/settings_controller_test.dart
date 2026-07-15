import 'package:accounting_app/features/settings/domain/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('settings controller loads settings map', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final value = await container.read(settingsControllerProvider.future);

    expect(value, containsPair('Theme', 'System'));
  });
}
