// test/remediation/production_blockers_test.dart
//
// Focused regression tests for the four production-blocker findings:
//   C-1  Mock repository injection (provider override pattern)
//   C-2  Auth logout clears tokens and resets company state
//   C-3  Permission guards in UsersController mutations
//   C-4  Workflow approval deduplication and role enforcement
//
// Follows the project's established test pattern:
//   • ProviderContainer + overrideWithValue (no widget tree)
//   • Fake helpers defined locally — no production-mock import
//   • tearDown/addTearDown disposes every container

import 'dart:async';

import 'package:accounting_app/core/api/auth_token_storage.dart';
import 'package:accounting_app/core/api/auth_token_storage_provider.dart';
import 'package:accounting_app/core/company/company_controller.dart';
import 'package:accounting_app/core/company/company_provider.dart';
import 'package:accounting_app/core/company/company_repository.dart';
import 'package:accounting_app/core/errors/app_failure.dart';
import 'package:accounting_app/core/errors/app_result.dart';
import 'package:accounting_app/features/audit_trail/domain/audit_entity_type.dart';
import 'package:accounting_app/features/auth/data/auth_repository.dart';
import 'package:accounting_app/features/auth/data/auth_repository_provider.dart';
import 'package:accounting_app/features/auth/domain/auth_notifier.dart';
import 'package:accounting_app/features/user_roles/data/user_repository.dart';
import 'package:accounting_app/features/user_roles/data/user_repository_provider.dart';
import 'package:accounting_app/features/user_roles/domain/app_user.dart';
import 'package:accounting_app/features/user_roles/domain/permission.dart';
import 'package:accounting_app/features/user_roles/domain/user_roles_controller.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_approval.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_definition.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_engine.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_instance.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_registry.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_state.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_transition.dart';
import 'package:accounting_app/features/workflow_engine/domain/workflow_trigger.dart';
import 'package:accounting_app/shared/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Test fakes
// ─────────────────────────────────────────────────────────────────────────────

/// Purely in-memory [FlutterSecureStorage] so tests never touch the platform
/// channel.  Each instance shares the same backing store, which is cleared
/// via [deleteAll].
class _InMemorySecureStorage extends FlutterSecureStorage {
  const _InMemorySecureStorage();

  static final Map<String, String> _store = {};

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    WindowsOptions? wOptions,
    MacOsOptions? mOptions,
  }) async =>
      value == null ? _store.remove(key) : _store[key] = value;

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    WindowsOptions? wOptions,
    MacOsOptions? mOptions,
  }) async =>
      _store[key];

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    WindowsOptions? wOptions,
    MacOsOptions? mOptions,
  }) async =>
      _store.remove(key);

  @override
  Future<void> deleteAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    WindowsOptions? wOptions,
    MacOsOptions? mOptions,
  }) async =>
      _store.clear();
}

/// [AuthTokenStorage] subclass that records [clearAll] calls so tests can
/// assert the method was invoked without touching the real secure storage.
class _RecordingTokenStorage extends AuthTokenStorage {
  _RecordingTokenStorage()
      : super(storage: const _InMemorySecureStorage());

  bool clearAllCalled = false;

  @override
  Future<void> clearAll() async {
    clearAllCalled = true;
    // Delegate so underlying keys are actually wiped.
    await super.clearAll();
  }
}

/// [MockAuthRepository] variant that allows a pre-seeded [User] to be
/// returned by [currentUser].  Used in C-1 to verify the notifier reads from
/// the injected repository and not from a hardcoded internal instance.
extension _SeedableRepo on MockAuthRepository {
  // ignore: invalid_use_of_visible_for_testing_member — test helper only
  void seedUser(User user) => _internalSeed(user);
}

/// Package-private extension target on [MockAuthRepository].  Dart does not
/// support overriding instance fields externally, so we subclass instead.
class _SeededAuthRepository extends MockAuthRepository {
  _SeededAuthRepository(this._seed);

  final User _seed;

  @override
  Future<AppResult<User?>> currentUser() async =>
      AppResult.success(_seed);
}

/// [MockUserRepository] variant whose [currentUser] always returns [_current].
/// Used to simulate a non-admin caller without changing the full user list.
class _SingleCurrentUserRepo extends MockUserRepository {
  _SingleCurrentUserRepo(this._current);

  final AppUser _current;

  @override
  Future<AppResult<AppUser?>> currentUser() async =>
      AppResult.success(_current);
}

// ─────────────────────────────────────────────────────────────────────────────
// Container factory
// ─────────────────────────────────────────────────────────────────────────────

ProviderContainer _makeContainer({List<Override> overrides = const []}) {
  return ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(MockAuthRepository()),
      companyRepositoryProvider.overrideWithValue(MockCompanyRepository()),
      userRepositoryProvider.overrideWithValue(MockUserRepository()),
      ...overrides,
    ],
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Minimal workflow fixture
// ─────────────────────────────────────────────────────────────────────────────

WorkflowRegistry _buildTestRegistry({
  String definitionId = 'test_wf',
  int requiredApprovals = 2,
  List<String> approverRoles = const ['manager'],
}) {
  final registry = WorkflowRegistry();
  registry.clear();

  final draft = WorkflowState(
    id: 'draft',
    name: 'Draft',
    label: 'Draft',
    category: WorkflowStateCategory.initial,
  );
  final approved = WorkflowState(
    id: 'approved',
    name: 'Approved',
    label: 'Approved',
    category: WorkflowStateCategory.terminal,
  );

  registry.register(
    WorkflowDefinition(
      id: definitionId,
      name: 'Test Workflow',
      description: '',
      entityType: AuditEntityType.salesInvoice,
      initialState: draft,
      states: [draft, approved],
      transitions: [
        WorkflowTransition(
          id: 'approve',
          name: 'Approve',
          fromState: draft,
          toState: approved,
          trigger: WorkflowTrigger(type: WorkflowTriggerType.approve),
          approval: WorkflowApproval(
            requiredApprovalsCount: requiredApprovals,
            approverRoles: approverRoles,
          ),
        ),
      ],
    ),
  );
  return registry;
}

WorkflowInstance _buildInstance({
  required String definitionId,
  int requiredApprovals = 2,
  List<String> approverRoles = const ['manager'],
  List<WorkflowApprovalEntry> existingApprovals = const [],
}) {
  return WorkflowInstance(
    id: 'inst-test-1',
    definitionId: definitionId,
    entityType: AuditEntityType.salesInvoice,
    entityId: 'doc-001',
    currentStateId: 'draft',
    context: const {},
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    approval: WorkflowApproval(
      requiredApprovalsCount: requiredApprovals,
      approverRoles: approverRoles,
      currentApprovals: existingApprovals,
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// Tests
// ═════════════════════════════════════════════════════════════════════════════

void main() {
  // ──────────────────────────────────────────────────────────────────────────
  // C-1 · Repository injection
  // ──────────────────────────────────────────────────────────────────────────
  group('C-1 · Repository injection via ProviderScope overrides', () {
    test(
      'AuthNotifier reads repository from authRepositoryProvider, not a '
      'hardcoded mock — override is respected',
      () async {
        final sentinelUser = User(id: 'injected-sentinel', name: 'Sentinel');
        final container = ProviderContainer(
          overrides: [
            authRepositoryProvider
                .overrideWithValue(_SeededAuthRepository(sentinelUser)),
            companyRepositoryProvider
                .overrideWithValue(MockCompanyRepository()),
            userRepositoryProvider.overrideWithValue(MockUserRepository()),
          ],
        );
        addTearDown(container.dispose);

        container.listen(authProvider, (_, __) {});
        final user = await container.read(authProvider.future);

        expect(
          user?.id,
          equals('injected-sentinel'),
          reason: 'The notifier must obtain its repository from '
              'authRepositoryProvider so that test and production overrides '
              'take effect — not from a hardcoded internal instance.',
        );
      },
    );

    test(
      'companyRepositoryProvider override propagates into CurrentCompany',
      () async {
        final container = ProviderContainer(
          overrides: [
            companyRepositoryProvider
                .overrideWithValue(MockCompanyRepository()),
          ],
        );
        addTearDown(container.dispose);
        container.listen(currentCompanyProvider, (_, __) {});
        await expectLater(
          container.read(currentCompanyProvider.future),
          completes,
        );
      },
    );
  });

  // ──────────────────────────────────────────────────────────────────────────
  // C-2 · Logout: token clearance + company invalidation
  // ──────────────────────────────────────────────────────────────────────────
  group('C-2 · logout() clears tokens and invalidates company state', () {
    test('logout() calls clearAll() on AuthTokenStorage', () async {
      final tokenStorage = _RecordingTokenStorage();

      final container = _makeContainer(
        overrides: [
          authTokenStorageProvider.overrideWithValue(tokenStorage),
        ],
      );
      addTearDown(container.dispose);

      container.listen(authProvider, (_, __) {});
      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'u@example.com', password: 'pw');
      expect(
        container.read(authProvider).value,
        isNotNull,
        reason: 'Precondition: user must be set after login.',
      );

      await notifier.logout();

      expect(
        tokenStorage.clearAllCalled,
        isTrue,
        reason: 'logout() must invoke AuthTokenStorage.clearAll() so that '
            'persisted tokens cannot be reused by the next user.',
      );
    });

    test('logout() sets auth state to null', () async {
      final container = _makeContainer();
      addTearDown(container.dispose);

      container.listen(authProvider, (_, __) {});
      final notifier = container.read(authProvider.notifier);
      await notifier.login(email: 'u@example.com', password: 'pw');
      expect(container.read(authProvider).value, isNotNull);

      await notifier.logout();

      expect(
        container.read(authProvider).value,
        isNull,
      );
    });

    test(
      'logout() invalidates currentCompanyProvider — transitions to loading',
      () async {
        final container = _makeContainer();
        addTearDown(container.dispose);

        container.listen(authProvider, (_, __) {});
        container.listen(currentCompanyProvider, (_, __) {});

        final notifier = container.read(authProvider.notifier);
        await notifier.login(email: 'u@example.com', password: 'pw');

        // Let company provider resolve to data.
        await container.read(currentCompanyProvider.future);
        expect(
          container.read(currentCompanyProvider),
          isA<AsyncData<Object?>>(),
          reason: 'Precondition: company must be loaded before logout.',
        );

        await notifier.logout();

        // After ref.invalidate(currentCompanyProvider), the provider resets.
        expect(
          container.read(currentCompanyProvider),
          isA<AsyncLoading<Object?>>(),
          reason: 'currentCompanyProvider must be invalidated on logout so the '
              'next session does not inherit the previous company context.',
        );
      },
    );
  });

  // ──────────────────────────────────────────────────────────────────────────
  // C-3 · Permission guards in UsersController
  // ──────────────────────────────────────────────────────────────────────────
  group('C-3 · UsersController enforces manageUsers permission', () {
    const accountant = AppUser(
      id: 'USR-0003',
      name: 'Carol Accountant',
      email: 'carol@example.com',
      roleId: 'role-accountant',
    );
    const admin = AppUser(
      id: 'USR-0001',
      name: 'Alice Admin',
      email: 'alice@example.com',
      roleId: 'role-admin',
    );

    /// Builds a container where [currentUser] resolves to [caller].
    ProviderContainer _containerForCaller(AppUser caller) {
      return ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          companyRepositoryProvider.overrideWithValue(MockCompanyRepository()),
          userRepositoryProvider.overrideWithValue(
            _SingleCurrentUserRepo(caller),
          ),
        ],
      );
    }

    Future<void> _warmUp(ProviderContainer c) async {
      c.listen(usersControllerProvider, (_, __) {});
      c.listen(currentUserControllerProvider, (_, __) {});
      c.listen(rolesControllerProvider, (_, __) {});
      // Wait for all three async providers to resolve.
      await c.read(usersControllerProvider.future);
      await c.read(currentUserControllerProvider.future);
      await c.read(rolesControllerProvider.future);
    }

    test('assignRole returns false for Accountant (lacks manageUsers)',
        () async {
      final container = _containerForCaller(accountant);
      addTearDown(container.dispose);
      await _warmUp(container);

      final result = await container
          .read(usersControllerProvider.notifier)
          .assignRole('USR-0002', 'role-admin');

      expect(result, isFalse);
    });

    test('deactivateUser returns false for Accountant', () async {
      final container = _containerForCaller(accountant);
      addTearDown(container.dispose);
      await _warmUp(container);

      final result = await container
          .read(usersControllerProvider.notifier)
          .deactivateUser('USR-0002');

      expect(result, isFalse);
    });

    test('createUser returns a failure result for Accountant', () async {
      final container = _containerForCaller(accountant);
      addTearDown(container.dispose);
      await _warmUp(container);

      final result = await container
          .read(usersControllerProvider.notifier)
          .createUser(
            const AppUser(
              id: '',
              name: 'New',
              email: 'new@example.com',
              roleId: 'role-accountant',
            ),
          );

      expect(result, isNotNull);
      expect(
        result!.isSuccess,
        isFalse,
        reason: 'createUser must return a failure for a caller without '
            'manageUsers permission.',
      );
      expect(result.error, isA<ValidationFailure>());
    });

    test('assignRole succeeds for Administrator', () async {
      final container = _containerForCaller(admin);
      addTearDown(container.dispose);
      await _warmUp(container);

      final result = await container
          .read(usersControllerProvider.notifier)
          .assignRole('USR-0003', 'role-manager');

      expect(result, isTrue);
    });

    test('state is NOT mutated when assignRole is denied', () async {
      final container = _containerForCaller(accountant);
      addTearDown(container.dispose);
      await _warmUp(container);

      final before = List<AppUser>.from(
        container.read(usersControllerProvider).value!,
      );
      await container
          .read(usersControllerProvider.notifier)
          .assignRole('USR-0003', 'role-admin');
      final after = container.read(usersControllerProvider).value!;

      expect(
        after.firstWhere((u) => u.id == 'USR-0003').roleId,
        equals(before.firstWhere((u) => u.id == 'USR-0003').roleId),
        reason: 'State must not change when the mutation is denied.',
      );
    });
  });

  // ──────────────────────────────────────────────────────────────────────────
  // C-4 · Workflow approval deduplication + role enforcement
  // ──────────────────────────────────────────────────────────────────────────
  group('C-4 · WorkflowApproval — isFulfilled deduplication', () {
    test('two approved votes from the same approver do NOT satisfy count=2',
        () {
      final approval = WorkflowApproval(
        requiredApprovalsCount: 2,
        currentApprovals: [
          WorkflowApprovalEntry(
            approverId: 'mgr-1',
            approverName: 'Alice',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
          // Duplicate approver ID — must NOT count as a second distinct vote.
          WorkflowApprovalEntry(
            approverId: 'mgr-1',
            approverName: 'Alice',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
        ],
      );

      expect(
        approval.isFulfilled,
        isFalse,
        reason: 'Duplicate approver IDs must not satisfy a count of 2.',
      );
    });

    test('two approved votes from distinct approvers satisfy count=2', () {
      final approval = WorkflowApproval(
        requiredApprovalsCount: 2,
        currentApprovals: [
          WorkflowApprovalEntry(
            approverId: 'mgr-1',
            approverName: 'Alice',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
          WorkflowApprovalEntry(
            approverId: 'mgr-2',
            approverName: 'Bob',
            decision: ApprovalDecision.approved,
            decidedAt: DateTime.now(),
          ),
        ],
      );

      expect(approval.isFulfilled, isTrue);
    });

    test('isFulfilled ignores pending and rejected entries', () {
      final approval = WorkflowApproval(
        requiredApprovalsCount: 1,
        currentApprovals: [
          WorkflowApprovalEntry(
            approverId: 'mgr-1',
            approverName: 'Alice',
            decision: ApprovalDecision.pending,
            decidedAt: DateTime.now(),
          ),
          WorkflowApprovalEntry(
            approverId: 'mgr-2',
            approverName: 'Bob',
            decision: ApprovalDecision.rejected,
            decidedAt: DateTime.now(),
          ),
        ],
      );

      expect(
        approval.isFulfilled,
        isFalse,
        reason: 'Only ApprovalDecision.approved entries count.',
      );
    });

    test('isFulfilled is false with zero approvals', () {
      const approval = WorkflowApproval(requiredApprovalsCount: 1);
      expect(approval.isFulfilled, isFalse);
    });

    test('requiredApprovalsCount of 0 is always fulfilled', () {
      const approval = WorkflowApproval(requiredApprovalsCount: 0);
      expect(approval.isFulfilled, isTrue);
    });
  });

  group('C-4 · WorkflowEngine.addApproval guards', () {
    late WorkflowEngine engine;
    late WorkflowInstance baseInstance;

    setUp(() {
      final registry = _buildTestRegistry();
      engine = WorkflowEngine(registry: registry);
      baseInstance = _buildInstance(
        definitionId: 'test_wf',
        requiredApprovals: 2,
        approverRoles: ['manager'],
      );
    });

    test('returns failure when the same approverId votes twice', () async {
      // First vote — succeeds.
      final first = await engine.addApproval(
        instance: baseInstance,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );
      expect(first.isSuccess, isTrue);

      // Second vote by the same approver — must be rejected.
      final second = await engine.addApproval(
        instance: first.data!,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );

      expect(second.isSuccess, isFalse);
      expect(second.error, isA<ValidationFailure>());
      expect(
        second.error!.message,
        contains('mgr-1'),
        reason: 'Error must identify the duplicate approver ID.',
      );
    });

    test('original instance is not mutated when duplicate vote is rejected',
        () async {
      final first = await engine.addApproval(
        instance: baseInstance,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );
      await engine.addApproval(
        instance: first.data!,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );
      // The first result's approval list must still have exactly one entry.
      expect(first.data!.approval.currentApprovals.length, equals(1));
    });

    test('returns failure when caller role is not in approverRoles', () async {
      final result = await engine.addApproval(
        instance: baseInstance,
        approverId: 'acct-1',
        approverName: 'Carol',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['accountant'], // not in ['manager']
      );

      expect(result.isSuccess, isFalse);
      expect(result.error, isA<ValidationFailure>());
      expect(
        result.error!.message,
        contains('manager'),
        reason: 'Error message should name the required roles.',
      );
    });

    test('succeeds when caller holds a matching role', () async {
      final result = await engine.addApproval(
        instance: baseInstance,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );

      expect(result.isSuccess, isTrue);
      expect(result.data!.approval.currentApprovals, hasLength(1));
    });

    test('role check is skipped when callerRoleIds is empty '
        '(backwards-compat)', () async {
      // Legacy call sites pass no callerRoleIds — must not be broken.
      final result = await engine.addApproval(
        instance: baseInstance,
        approverId: 'anyone-1',
        approverName: 'Anyone',
        decision: ApprovalDecision.approved,
        // callerRoleIds defaults to const []
      );

      expect(
        result.isSuccess,
        isTrue,
        reason: 'Empty callerRoleIds bypasses role enforcement for '
            'call sites not yet updated.',
      );
    });

    test('two distinct approvers satisfy count=2 and isFulfilled becomes true',
        () async {
      final after1 = await engine.addApproval(
        instance: baseInstance,
        approverId: 'mgr-1',
        approverName: 'Alice',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );
      expect(after1.isSuccess, isTrue);
      expect(after1.data!.approval.isFulfilled, isFalse,
          reason: 'Only one of two required approvals have been submitted.');

      final after2 = await engine.addApproval(
        instance: after1.data!,
        approverId: 'mgr-2',
        approverName: 'Bob',
        decision: ApprovalDecision.approved,
        callerRoleIds: ['manager'],
      );
      expect(after2.isSuccess, isTrue);
      expect(
        after2.data!.approval.isFulfilled,
        isTrue,
        reason: 'Two distinct approvers with approved decisions should '
            'fulfill a count of 2.',
      );
    });
  });
}
