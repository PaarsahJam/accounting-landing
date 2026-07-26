import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_token_storage.dart';

part 'auth_token_storage_provider.g.dart';

/// Provides the singleton [AuthTokenStorage] used by both [AuthNotifier]
/// (to clear tokens on logout) and [ApiClient] (to attach tokens to requests).
///
/// Declared `keepAlive: true` because token storage is a long-lived,
/// process-wide resource that should never be auto-disposed.
@Riverpod(keepAlive: true)
AuthTokenStorage authTokenStorage(Ref ref) => const AuthTokenStorage();
