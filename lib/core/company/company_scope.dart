import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  /// Returns the current company ID. Returns empty string if not loaded.
  String get companyId => currentCompany?.id ?? '';
}

/// Mixin for repositories that need company-scoped data.
///
/// Usage:
/// ```dart
/// class MyRepository with CompanyScopeMixin {
///   Future<AppResult<List<Item>>> fetchItems() async {
///     return _fetchWithCompany(
///       (companyId) => _doFetch(companyId),
///     );
///   }
/// }
/// ```
mixin CompanyScopeMixin {
  String? _companyId;

  void setCompanyId(String id) => _companyId = id;

  String? get companyId => _companyId;

  /// Wraps a fetch call with company ID context.
  /// If [_companyId] is null, the call is made without company scoping.
  Future<T> withCompany<T>(Future<T> Function(String companyId) callback,
      {String? fallbackCompanyId}) async {
    final id = _companyId ?? fallbackCompanyId;
    if (id == null) {
      return callback('');
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
