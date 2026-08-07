import 'package:accounting_app/features/auth/data/auth_repository.dart';
import 'package:accounting_app/features/auth/data/auth_repository_provider.dart';
import 'package:accounting_app/features/auth/domain/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('returns a null user initially from the mock repository', () async {
      // Keep the auto-dispose provider alive while the build is pending.
      final sub = container.listen(authProvider, (_, _) {});
      addTearDown(sub.close);

      final user = await container.read(authProvider.future);

      expect(user, isNull);
    });
  });
}
