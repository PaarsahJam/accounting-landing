import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository.dart';
import 'package:accounting_app/features/inventory/data/inventory_repository_provider.dart';
import 'package:accounting_app/features/stock_transfers/data/stock_transfer_repository.dart';
import 'package:accounting_app/features/stock_transfers/data/stock_transfer_repository_provider.dart';
import 'package:accounting_app/features/stock_transfers/presentation/stock_transfers_page.dart';
import 'package:accounting_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildApp() {
  return UncontrolledProviderScope(
    container: ProviderContainer(
      overrides: [
        inventoryRepositoryProvider.overrideWithValue(
          MockInventoryRepository(),
        ),
        auditTrailRepositoryProvider.overrideWithValue(
          MockAuditTrailRepository(),
        ),
        stockTransferRepositoryProvider.overrideWithValue(
          MockStockTransferRepository(
            inventoryRepository: MockInventoryRepository(),
            auditTrailRepository: MockAuditTrailRepository(),
          ),
        ),
      ],
    ),
    child: const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en')],
      home: StockTransfersPage(),
    ),
  );
}

void main() {
  testWidgets('StockTransfersPage shows transfer list after load', (
    tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    // Seeded transfers reference prefix
    expect(find.textContaining('TRF'), findsWidgets);
  });

  testWidgets('StockTransfersPage shows FAB', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('StockTransfersPage has AppBar with title', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.textContaining('Transfer'), findsWidgets);
  });

  testWidgets('StockTransfersPage has refresh icon button', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
