import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ledger_repository.dart';
import 'ledger_service.dart';

part 'ledger_service_provider.g.dart';

@riverpod
LedgerRepository ledgerRepository(Ref ref) => MockLedgerRepository();

@riverpod
LedgerService ledgerService(Ref ref) =>
    LedgerService(ref.watch(ledgerRepositoryProvider));
