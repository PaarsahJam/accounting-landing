import 'package:accounting_app/features/guidance/guidance_tips_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('encode/decode dismissed tips', () {
    test('encode sorts ids into a comma-separated string', () {
      expect(
        encodeDismissedTips({'bank_reconciliation', 'invoice', 'profit'}),
        'bank_reconciliation,invoice,profit',
      );
    });

    test('decode round-trips an encoded string', () {
      const raw = 'bank_reconciliation,invoice,profit';
      expect(decodeDismissedTips(raw), {'bank_reconciliation', 'invoice', 'profit'});
    });

    test('decode tolerates null, empty and ragged input', () {
      expect(decodeDismissedTips(null), isEmpty);
      expect(decodeDismissedTips(''), isEmpty);
      expect(decodeDismissedTips('  '), isEmpty);
      expect(decodeDismissedTips('a,, b ,c'), {'a', 'b', 'c'});
    });
  });

  group('DismissedTips notifier', () {
    test('starts empty and dismiss adds ids to the state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(dismissedTipsProvider.notifier);
      expect(container.read(dismissedTipsProvider), isEmpty);

      notifier.dismiss('invoice');
      expect(container.read(dismissedTipsProvider), contains('invoice'));
      expect(notifier.isDismissed('invoice'), isTrue);
      expect(notifier.isDismissed('profit'), isFalse);
    });

    test('dismissing an already dismissed id is a no-op', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(dismissedTipsProvider.notifier);
      notifier.dismiss('payment');
      final snapshot = container.read(dismissedTipsProvider);
      await notifier.dismiss('payment');
      expect(container.read(dismissedTipsProvider), snapshot);
    });

    test('reset clears all dismissals', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(dismissedTipsProvider.notifier);
      notifier.dismiss('invoice');
      notifier.dismiss('profit');
      expect(container.read(dismissedTipsProvider).length, 2);

      notifier.reset();
      expect(container.read(dismissedTipsProvider), isEmpty);
    });
  });
}
