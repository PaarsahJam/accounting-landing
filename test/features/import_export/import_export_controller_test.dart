// test/features/import_export/import_export_controller_test.dart

import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository.dart';
import 'package:accounting_app/features/audit_trail/data/audit_trail_repository_provider.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository.dart';
import 'package:accounting_app/features/import_export/data/import_export_repository_provider.dart';
import 'package:accounting_app/features/import_export/domain/import_export_controller.dart';
import 'package:accounting_app/features/import_export/domain/import_export_job.dart';
import 'package:accounting_app/features/user_roles/data/user_repository.dart';
import 'package:accounting_app/features/user_roles/data/user_repository_provider.dart';
import 'package:accounting_app/features/user_roles/domain/app_user.dart';
import 'package:accounting_app/features/user_roles/domain/user_roles_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// An administrator caller — holds every permission, including manageSettings
/// which gates export/import.
const _admin = AppUser(
  id: 'USR-0001',
  name: 'Alice Admin',
  email: 'alice@example.com',
  roleId: 'role-admin',
);

/// A caller that lacks manageSettings (accountant curated role).
const _accountant = AppUser(
  id: 'USR-0003',
  name: 'Carol Accountant',
  email: 'carol@example.com',
  roleId: 'role-accountant',
);

/// [MockUserRepository] variant whose [currentUser] always resolves to
/// [_current]; role list is inherited from the mock so permissions resolve.
class _SingleCurrentUserRepo extends MockUserRepository {
  _SingleCurrentUserRepo(this._current);

  final AppUser _current;

  @override
  Future<AppResult<AppUser?>> currentUser() async =>
      AppResult.success(_current);
}

ProviderContainer _makeContainer({AppUser caller = _admin}) => ProviderContainer(
  overrides: [
    auditTrailRepositoryProvider.overrideWithValue(MockAuditTrailRepository()),
    importExportRepositoryProvider.overrideWithValue(
      MockImportExportRepository(auditRepository: MockAuditTrailRepository()),
    ),
    userRepositoryProvider.overrideWithValue(_SingleCurrentUserRepo(caller)),
  ],
);

/// Resolves the async providers that [hasPermissionProvider] depends on so
/// permission checks see the configured caller rather than AsyncLoading.
Future<void> _warmUp(ProviderContainer container) async {
  container.listen(currentUserControllerProvider, (_, _) {});
  container.listen(rolesControllerProvider, (_, _) {});
  await container.read(currentUserControllerProvider.future);
  await container.read(rolesControllerProvider.future);
}

void main() {
  group('ImportExportController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('initial state is empty list', () async {
      container.listen(importExportControllerProvider, (_, _) {});
      final jobs = await container.read(importExportControllerProvider.future);
      expect(jobs, isEmpty);
    });

    test('exportCsv adds job to state', () async {
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.exportCsv(ExportEntityType.customers);
      expect(result!.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.export));

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(1));
      expect(state.first.entityType, equals(ExportEntityType.customers));
    });

    test('importCsv adds job to state', () async {
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.importCsv(ExportEntityType.vendors);
      expect(result!.isSuccess, isTrue);
      expect(result.data!.direction, equals(JobDirection.import));

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(1));
    });

    test('multiple operations accumulate in state newest-first', () async {
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      await notifier.exportCsv(ExportEntityType.customers);
      await notifier.importCsv(ExportEntityType.vendors);
      await notifier.exportCsv(ExportEntityType.products);

      final state = container.read(importExportControllerProvider).value!;
      expect(state.length, equals(3));
      // newest first
      expect(state.first.entityType, equals(ExportEntityType.products));
    });

    test('exportCsv result has csvPreview', () async {
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.exportCsv(ExportEntityType.salesInvoices);
      expect(result!.data!.csvPreview, isNotNull);
      expect(result.data!.csvPreview, contains('id,reference'));
    });
  });

  group('ImportExportController authorization', () {
    test('exportCsv is denied for a caller without manageSettings', () async {
      final container = _makeContainer(caller: _accountant);
      addTearDown(container.dispose);
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.exportCsv(ExportEntityType.customers);

      expect(result, isNotNull);
      expect(result!.isSuccess, isFalse);
      expect(result.error, isA<AuthorizationFailure>());
      // State must not be mutated when the action is denied.
      expect(container.read(importExportControllerProvider).value, isEmpty);
    });

    test('importCsv is denied for a caller without manageSettings', () async {
      final container = _makeContainer(caller: _accountant);
      addTearDown(container.dispose);
      await _warmUp(container);
      container.listen(importExportControllerProvider, (_, _) {});
      final notifier = container.read(importExportControllerProvider.notifier);
      await notifier.future;

      final result = await notifier.importCsv(ExportEntityType.vendors);

      expect(result, isNotNull);
      expect(result!.isSuccess, isFalse);
      expect(result.error, isA<AuthorizationFailure>());
      expect(container.read(importExportControllerProvider).value, isEmpty);
    });
  });
}
