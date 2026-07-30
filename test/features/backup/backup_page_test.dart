import 'package:accounting_app/features/backup/presentation/backup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return const ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: BackupPage(),
      ),
    ),
  );
}

void main() {
  testWidgets('BackupPage renders title and sections', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Backup & Restore'), findsOneWidget);
    expect(find.text('Create Backup'), findsOneWidget);
    expect(find.text('Backup Information'), findsOneWidget);
    expect(find.text('Restore'), findsOneWidget);
  });
}
