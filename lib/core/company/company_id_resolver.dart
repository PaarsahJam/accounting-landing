// Tenant-context plumbing shared by the tenant-scoped data layer.
//
// Kept dependency-free (no Riverpod/Flutter imports) so repositories and DAOs
// can depend on it without pulling in the provider layer.

/// Resolves the active company (tenant) id, or `null` when no company context
/// is available yet. Repositories treat a `null`/blank result as "fail closed"
/// and refuse the operation rather than reading or mutating across tenants.
typedef CompanyIdResolver = String? Function();

/// Returns [id] when it identifies a tenant, or `null` when it is missing or
/// blank. Lets callers collapse "unset" and "empty string" into a single
/// fail-closed check.
String? normalizeCompanyId(String? id) =>
    (id == null || id.isEmpty) ? null : id;
