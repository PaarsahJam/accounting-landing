import 'package:accounting_app/features/user_roles/data/user_repository.dart';
import 'package:accounting_app/features/user_roles/data/user_repository_provider.dart';
import 'package:accounting_app/features/user_roles/domain/app_user.dart';
import 'package:accounting_app/features/user_roles/domain/permission.dart';
import 'package:accounting_app/features/user_roles/domain/permission_service.dart';
import 'package:accounting_app/features/user_roles/domain/user_roles_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer _makeContainer() => ProviderContainer(
  overrides: [userRepositoryProvider.overrideWithValue(MockUserRepository())],
);

/// Loads the signed-in user and built-in roles so the controller-level
/// permission checks in [UsersController] pass.
Future<void> loadAuthContext(ProviderContainer container) async {
  container.listen(currentUserControllerProvider, (_, _) {});
  container.listen(rolesControllerProvider, (_, _) {});
  await container.read(currentUserControllerProvider.future);
  await container.read(rolesControllerProvider.future);
}

void main() {
  group('PermissionService', () {
    const svc = PermissionService();
    final roles = BuiltInRoles.all;
    const adminUser = AppUser(
      id: 'USR-0001',
      name: 'Alice',
      email: 'alice@example.com',
      roleId: 'role-admin',
    );
    const managerUser = AppUser(
      id: 'USR-0002',
      name: 'Bob',
      email: 'bob@example.com',
      roleId: 'role-manager',
    );
    const accountantUser = AppUser(
      id: 'USR-0003',
      name: 'Carol',
      email: 'carol@example.com',
      roleId: 'role-accountant',
    );
    const inactiveUser = AppUser(
      id: 'USR-0004',
      name: 'Dave',
      email: 'dave@example.com',
      roleId: 'role-admin',
      isActive: false,
    );

    test('admin can do everything', () {
      for (final p in Permission.values) {
        expect(svc.can(adminUser, roles, p), isTrue, reason: '$p');
      }
    });

    test('null user is denied', () {
      expect(svc.can(null, roles, Permission.viewCustomers), isFalse);
    });

    test('inactive user is denied', () {
      expect(svc.can(inactiveUser, roles, Permission.viewCustomers), isFalse);
    });

    test('user with unknown roleId is denied', () {
      const orphan = AppUser(
        id: 'X',
        name: 'Orphan',
        email: 'x@x.com',
        roleId: 'role-nonexistent',
      );
      expect(svc.can(orphan, roles, Permission.viewCustomers), isFalse);
    });

    test('manager can postJournal', () {
      expect(svc.can(managerUser, roles, Permission.postJournal), isTrue);
    });

    test('manager cannot manageUsers', () {
      expect(svc.can(managerUser, roles, Permission.manageUsers), isFalse);
    });

    test('accountant can closeFiscalPeriod', () {
      expect(
        svc.can(accountantUser, roles, Permission.closeFiscalPeriod),
        isTrue,
      );
    });

    test('accountant cannot deleteCustomers', () {
      expect(
        svc.can(accountantUser, roles, Permission.deleteCustomers),
        isFalse,
      );
    });

    test('canAll returns true when user has all listed permissions', () {
      expect(
        svc.canAll(accountantUser, roles, {
          Permission.viewCustomers,
          Permission.viewJournal,
        }),
        isTrue,
      );
    });

    test('canAll returns false when user lacks one permission', () {
      expect(
        svc.canAll(accountantUser, roles, {
          Permission.viewCustomers,
          Permission.deleteCustomers, // accountant lacks this
        }),
        isFalse,
      );
    });

    test('canAny returns true when user has at least one permission', () {
      expect(
        svc.canAny(accountantUser, roles, {
          Permission.deleteCustomers,
          Permission.viewCustomers, // accountant has this
        }),
        isTrue,
      );
    });

    test('canAny returns false when user has none', () {
      expect(
        svc.canAny(accountantUser, roles, {
          Permission.deleteCustomers,
          Permission.manageUsers,
        }),
        isFalse,
      );
    });

    test('roleFor returns correct role', () {
      final role = svc.roleFor(accountantUser, roles);
      expect(role?.name, equals('Accountant'));
    });

    test('roleFor returns null for null user', () {
      expect(svc.roleFor(null, roles), isNull);
    });
  });

  group('RolesController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads all three built-in roles', () async {
      container.listen(rolesControllerProvider, (_, _) {});
      final roles = await container.read(rolesControllerProvider.future);
      expect(roles.length, equals(3));
    });
  });

  group('UsersController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('loads seeded users', () async {
      container.listen(usersControllerProvider, (_, _) {});
      final users = await container.read(usersControllerProvider.future);
      expect(users.length, equals(4));
    });

    test('createUser appends user to state', () async {
      container.listen(usersControllerProvider, (_, _) {});
      await loadAuthContext(container);
      final notifier = container.read(usersControllerProvider.notifier);
      final initial = await notifier.future;
      final before = initial.length;

      final result = await notifier.createUser(
        const AppUser(
          id: '',
          name: 'New User',
          email: 'new@x.com',
          roleId: 'role-accountant',
        ),
      );

      expect(result!.isSuccess, isTrue);
      final state = container.read(usersControllerProvider).value!;
      expect(state.length, equals(before + 1));
    });

    test('assignRole updates role in state', () async {
      container.listen(usersControllerProvider, (_, _) {});
      await loadAuthContext(container);
      final notifier = container.read(usersControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.assignRole('USR-0003', 'role-manager');
      expect(success, isTrue);

      final state = container.read(usersControllerProvider).value!;
      final carol = state.firstWhere((u) => u.id == 'USR-0003');
      expect(carol.roleId, equals('role-manager'));
    });

    test('deactivateUser marks user inactive in state', () async {
      container.listen(usersControllerProvider, (_, _) {});
      await loadAuthContext(container);
      final notifier = container.read(usersControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.deactivateUser('USR-0002');
      expect(success, isTrue);

      final state = container.read(usersControllerProvider).value!;
      final bob = state.firstWhere((u) => u.id == 'USR-0002');
      expect(bob.isActive, isFalse);
    });

    test('assignRole returns false for unknown user', () async {
      container.listen(usersControllerProvider, (_, _) {});
      final notifier = container.read(usersControllerProvider.notifier);
      await notifier.future;

      final success = await notifier.assignRole('NO-SUCH', 'role-admin');
      expect(success, isFalse);
    });
  });

  group('CurrentUserController', () {
    late ProviderContainer container;
    setUp(() => container = _makeContainer());
    tearDown(() => container.dispose());

    test('returns alice as current user', () async {
      container.listen(currentUserControllerProvider, (_, _) {});
      final user = await container.read(currentUserControllerProvider.future);
      expect(user?.name, equals('Alice Admin'));
      expect(user?.roleId, equals('role-admin'));
    });
  });

  group('hasPermissionProvider', () {
    test(
      'returns true when current user (alice/admin) has permission',
      () async {
        final container = _makeContainer();
        container.listen(currentUserControllerProvider, (_, _) {});
        container.listen(rolesControllerProvider, (_, _) {});
        // Wait for both to load
        await container.read(currentUserControllerProvider.future);
        await container.read(rolesControllerProvider.future);

        final canManage = container.read(
          hasPermissionProvider(Permission.manageUsers),
        );
        expect(canManage, isTrue);
        container.dispose();
      },
    );
  });
}
