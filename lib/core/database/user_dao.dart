import 'package:drift/drift.dart';
import 'app_database.dart';

class UserDao extends DatabaseAccessor<AppDatabase> {
  UserDao(super.db);

  $UsersTableTable get _users => db.usersTable;
  $UserSessionTableTable get _sessions => db.userSessionTable;

  Future<UsersTableData?> getUserByEmail(String email) =>
      (select(_users)..where((t) => t.email.equals(email))).getSingleOrNull();

  Future<UsersTableData?> getUserById(String id) =>
      (select(_users)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertUser(UsersTableCompanion user) =>
      into(_users).insert(user);

  Future<UserSessionTableData?> getActiveSession(String token) =>
      (select(_sessions)
            ..where((t) => t.token.equals(token) & t.expiresAt.isBiggerThan(Constant(DateTime.now()))))
          .getSingleOrNull();

  Future<UserSessionTableData?> getSessionByUserId(String userId) =>
      (select(_sessions)..where((t) => t.userId.equals(userId)))
          .getSingleOrNull();

  Future<int> insertSession(UserSessionTableCompanion session) =>
      into(_sessions).insert(session);

  Future<int> deleteSession(String token) =>
      (delete(_sessions)..where((t) => t.token.equals(token))).go();

  Future<int> deleteSessionsByUserId(String userId) =>
      (delete(_sessions)..where((t) => t.userId.equals(userId))).go();
}
