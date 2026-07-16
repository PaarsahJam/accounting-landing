import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user_repository.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return MockUserRepository();
}
