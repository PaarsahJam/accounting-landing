import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/app_failure.dart';
import 'company.dart';
import 'company_controller.dart';

/// Extension on [Ref] to obtain the current company context.
extension CompanyContext on Ref {
  /// Returns the current company from the nearest provider ancestor.
  /// Can return `null` if the company has not been loaded yet.
  Company? get currentCompany {
    final asyncCompany = read(currentCompanyProvider);
    return asyncCompany.asData?.value;
  }

  /// Returns the current company ID, or `null` when no company is loaded.
  /// Callers must treat a `null` result as fail-closed — do NOT fall back to
  /// an empty string or default tenant.
  String? get companyId => currentCompany?.id;

  /// Returns the non-blank company ID, or throws [TenantContextFailure] when
  /// no company is active. Use in repository / data-layer code that must
  /// never proceed without a tenant context.
  String get requireCompanyId {
    final id = companyId;
    if (id == null || id.isEmpty) {
      throw const TenantContextFailure();
    }
    return id;
  }
}

/// Mixin for repositories that need company-scoped data.
///
/// Usage:
/// ```dart
/// class MyRepository with CompanyScopeMixin {
///   Future<AppResult<List<Item>>> fetchItems() async {
///     return withCompany((companyId) => _doFetch(companyId));
///   }
/// }
/// ```
///
/// **Important:** [withCompany] throws [TenantContextFailure] when no company
/// ID has been set — it never falls back to an empty string or default tenant.
mixin CompanyScopeMixin {
  String? _companyId;

  void setCompanyId(String id) => _companyId = id;

  String? get companyId => _companyId;

  /// Returns the resolved company ID or throws [TenantContextFailure] when no
  /// company is set. Use in repository methods that must never leak across
  /// tenants.
  String get requireCompanyId {
    final id = _companyId;
    if (id == null || id.isEmpty) {
      throw const TenantContextFailure();
    }
    return id;
  }

  /// Executes [callback] with the current company ID.
  ///
  /// Throws [TenantContextFailure] when no company ID is configured — the
  /// callback is never invoked with an empty string or null.
  Future<T> withCompany<T>(Future<T> Function(String companyId) callback,
      {String? fallbackCompanyId}) async {
    final id = _companyId ?? fallbackCompanyId;
    if (id == null || id.isEmpty) {
      throw const TenantContextFailure();
    }
    return callback(id);
  }
}

/// Provider that returns whether the app has any companies configured.
bool hasCompaniesProvider(Ref ref) {
  final companies = ref.watch(companyListProvider);
  return companies.when(
    loading: () => false,
    error: (_, _) => false,
    data: (list) => list.isNotEmpty,
  );
}
