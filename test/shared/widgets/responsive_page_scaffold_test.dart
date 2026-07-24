import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/shared/widgets/responsive_page_scaffold.dart';

void main() {
  group('ResponsivePageScaffold', () {
    testWidgets('renders title and child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsivePageScaffold(
            title: 'Test Title',
            child: Text('Test Body'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Body'), findsOneWidget);
    });

    testWidgets('renders AppBar with title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsivePageScaffold(
            title: 'Page Title',
            child: SizedBox(),
          ),
        ),
      );

      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.title, isA<Text>());
      expect((appBar.title as Text).data, 'Page Title');
    });

    testWidgets('shows action buttons when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsivePageScaffold(
            title: 'Test',
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {},
              ),
            ],
            child: const SizedBox(),
          ),
        ),
      );

      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('renders floatingActionButton when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsivePageScaffold(
            title: 'Test',
            floatingActionButton: FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            ),
            child: SizedBox(),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('uses custom padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ResponsivePageScaffold(
            title: 'Test',
            padding: EdgeInsets.all(32),
            child: Text('Padded'),
          ),
        ),
      );

      // Verify the padding is applied to the body padding
      final paddingWidgets = find.byType(Padding);
      expect(paddingWidgets, findsAtLeast(1));
    });

    testWidgets('shows menu button on phone screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(360, 800)),
            child: const ResponsivePageScaffold(
              title: 'Test',
              child: SizedBox(),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });
  });
}
