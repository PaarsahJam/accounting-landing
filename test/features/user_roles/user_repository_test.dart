import 'package:accounting_app/features/user_roles/data/user_repository.dart';
import 'package:accounting_app/features/user_roles/domain/app_user.dart';
import 'package:accounting_app/features/user_roles/domain/permission.dart';
import 'package:flutter_test/flutter_test.dart';

MockUserRepository _makeRepo() => MockUserRepository();

void main() {
  group('MockUserRepository — roles', () {
    test('fetchRoles returns all three built-in roles', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRoles();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(3));
      final names = result.data!.map((r) => r.name).toList();
      expect(names, containsAll(['Administrator', 'Manager', 'Accountant']));
    });

    test('Administrator role has all permissions', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRoles();
      final admin = result.data!.firstWhere((r) => r.id == 'role-admin');
      for (final p in Permission.values) {
        expect(admin.has(p), isTrue, reason: '$p should be in admin');
      }
    });

    test('Accountant role does not have manageUsers', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRoles();
      final accountant = result.data!.firstWhere(
        (r) => r.id == 'role-accountant',
      );
      expect(accountant.has(Permission.manageUsers), isFalse);
    });

    test('Manager role does not have closeFiscalPeriod', () async {
      final repo = _makeRepo();
      final result = await repo.fetchRoles();
      final manager = result.data!.firstWhere((r) => r.id == 'role-manager');
      expect(manager.has(Permission.closeFiscalPeriod), isFalse);
    });
  });

  group('MockUserRepository — users', () {
    test('fetchUsers returns 4 seeded users', () async {
      final repo = _makeRepo();
      final result = await repo.fetchUsers();
      expect(result.isSuccess, isTrue);
      expect(result.data!.length, equals(4));
    });

    test('currentUser returns alice (admin)', () async {
      final repo = _makeRepo();
      final result = await repo.currentUser();
      expect(result.isSuccess, isTrue);
      expect(result.data!.name, equals('Alice Admin'));
      expect(result.data!.roleId, equals('role-admin'));
    });

    test('createUser generates id and stores user', () async {
      final repo = _makeRepo();
      final result = await repo.createUser(
        const AppUser(
          id: '',
          name: 'New User',
          email: 'new@example.com',
          roleId: 'role-accountant',
        ),
      );
      expect(result.isSuccess, isTrue);
      expect(result.data!.id, isNotEmpty);

      final all = (await repo.fetchUsers()).data!;
      expect(all.any((u) => u.name == 'New User'), isTrue);
    });

    test('createUser fails for unknown roleId', () async {
      final repo = _makeRepo();
      final result = await repo.createUser(
        const AppUser(
          id: '',
          name: 'X',
          email: 'x@example.com',
          roleId: 'role-nonexistent',
        ),
      );
      expect(result.isSuccess, isFalse);
    });

    test('assignRole changes user role', () async {
      final repo = _makeRepo();
      final result = await repo.assignRole('USR-0003', 'role-manager');
      expect(result.isSuccess, isTrue);
      expect(result.data!.roleId, equals('role-manager'));

      final all = (await repo.fetchUsers()).data!;
      final carol = all.firstWhere((u) => u.id == 'USR-0003');
      expect(carol.roleId, equals('role-manager'));
    });

    test('assignRole fails for unknown userId', () async {
      final repo = _makeRepo();
      final result = await repo.assignRole('NO-SUCH', 'role-admin');
      expect(result.isSuccess, isFalse);
      expect(result.error!.message, contains('not found'));
    });

    test('assignRole fails for unknown roleId', () async {
      final repo = _makeRepo();
      final result = await repo.assignRole('USR-0001', 'role-nonexistent');
      expect(result.isSuccess, isFalse);
    });

    test('deactivateUser sets isActive = false', () async {
      final repo = _makeRepo();
      final result = await repo.deactivateUser('USR-0002');
      expect(result.isSuccess, isTrue);

      final all = (await repo.fetchUsers()).data!;
      final bob = all.firstWhere((u) => u.id == 'USR-0002');
      expect(bob.isActive, isFalse);
    });

    test('deactivateUser fails for unknown userId', () async {
      final repo = _makeRepo();
      final result = await repo.deactivateUser('NO-SUCH');
      expect(result.isSuccess, isFalse);
    });

    test('updateUser updates details', () async {
      final repo = _makeRepo();
      final original = (await repo.currentUser()).data!;
      final updated = original.copyWith(name: 'Alice Updated');
      final result = await repo.updateUser(updated);
      expect(result.isSuccess, isTrue);
      expect(result.data!.name, equals('Alice Updated'));
    });
  });

  group('AppRole model', () {
    test('BuiltInRoles.all contains three roles', () {
      expect(BuiltInRoles.all.length, equals(3));
    });

    test('AppRole.has returns true for included permission', () {
      expect(BuiltInRoles.administrator.has(Permission.manageUsers), isTrue);
    });

    test('AppRole.has returns false for excluded permission', () {
      expect(BuiltInRoles.accountant.has(Permission.deleteCustomers), isFalse);
    });

    test('AppRole equality is by id', () {
      const r1 = AppRole(id: 'X', name: 'A', description: '', permissions: {});
      const r2 = AppRole(
        id: 'X',
        name: 'B',
        description: 'Different',
        permissions: {},
      );
      expect(r1, equals(r2));
      expect(r1.hashCode, equals(r2.hashCode));
    });

    test('copyWith preserves unchanged fields', () {
      final original = BuiltInRoles.accountant;
      final copy = original.copyWith(name: 'Senior Accountant');
      expect(copy.name, equals('Senior Accountant'));
      expect(copy.id, equals(original.id));
      expect(copy.permissions, equals(original.permissions));
    });
  });

  group('AppUser model', () {
    test('isActive defaults to true', () {
      const u = AppUser(
        id: 'U1',
        name: 'Alice',
        email: 'a@b.com',
        roleId: 'r1',
      );
      expect(u.isActive, isTrue);
    });

    test('equality is by id', () {
      const u1 = AppUser(
        id: 'U1',
        name: 'Alice',
        email: 'a@b.com',
        roleId: 'r1',
      );
      const u2 = AppUser(
        id: 'U1',
        name: 'Different',
        email: 'x@y.com',
        roleId: 'r2',
      );
      expect(u1, equals(u2));
    });

    test('copyWith preserves unchanged fields', () {
      const u = AppUser(
        id: 'U1',
        name: 'Alice',
        email: 'a@b.com',
        roleId: 'r1',
      );
      final copy = u.copyWith(roleId: 'r2');
      expect(copy.roleId, equals('r2'));
      expect(copy.name, equals('Alice'));
    });
  });
}
