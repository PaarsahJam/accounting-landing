import 'package:accounting_app/features/calendar/presentation/calendar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return const ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: CalendarPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('CalendarPage renders title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Calendar'), findsOneWidget);
  });

  testWidgets('CalendarPage shows empty state when no events', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('No upcoming events'), findsOneWidget);
  });
}
