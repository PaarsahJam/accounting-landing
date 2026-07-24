import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';
import 'auth_token_storage.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) => ApiClient(tokenStorage: const AuthTokenStorage());
