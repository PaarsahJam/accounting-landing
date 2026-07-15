import 'package:accounting_app/features/auth/domain/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() => container.dispose());

    test('returns a null user initially from the mock repository', () async {
      final notifier = container.read(authProvider.notifier);
      final user = await notifier.future;

      expect(user, isNull);
    });
  });
}
