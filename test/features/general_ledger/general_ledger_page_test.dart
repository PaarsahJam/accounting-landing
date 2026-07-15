import 'package:accounting_app/features/general_ledger/presentation/general_ledger_page.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository_provider.dart';
import 'package:accounting_app/features/general_ledger/data/general_ledger_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GeneralLedgerPage renders account list', (tester) async {
    final container = ProviderContainer(
      overrides: [
        generalLedgerRepositoryProvider.overrideWithValue(
          MockGeneralLedgerRepository(),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: GeneralLedgerPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Cash'), findsWidgets);
    container.dispose();
  });
}
