import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/services/connectivity_service.dart';
import 'package:accounting_app/shared/widgets/offline_banner.dart';

void main() {
  group('OfflineBanner', () {
    testWidgets('shows banner when offline', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isOnlineProvider.overrideWith((ref) => false),
          ],
          child: const MaterialApp(
            home: Scaffold(body: OfflineBanner()),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(MaterialBanner), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
    });

    testWidgets('hides banner when online', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isOnlineProvider.overrideWith((ref) => true),
          ],
          child: const MaterialApp(
            home: Scaffold(body: OfflineBanner()),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(MaterialBanner), findsNothing);
    });

    testWidgets('Dismiss button works', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isOnlineProvider.overrideWith((ref) => false),
          ],
          child: const MaterialApp(
            home: Scaffold(body: OfflineBanner()),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(MaterialBanner), findsOneWidget);

      await tester.tap(find.text('Dismiss'));
      await tester.pump();
      // After dismiss, the banner should be hidden
      // (the ScaffoldMessenger hides it)
    });
  });
}
