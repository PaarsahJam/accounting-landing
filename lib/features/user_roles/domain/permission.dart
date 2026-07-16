/// Every fine-grained permission in the system.
///
/// Grouped by module for readability; the underlying values are just enum
/// members — no string mapping is required at the data layer.
enum Permission {
  // ── Customers ────────────────────────────────────────────────────────────
  viewCustomers,
  editCustomers,
  deleteCustomers,

  // ── Vendors ──────────────────────────────────────────────────────────────
  viewVendors,
  editVendors,
  deleteVendors,

  // ── Sales Invoices ────────────────────────────────────────────────────────
  viewSalesInvoices,
  editSalesInvoices,
  deleteSalesInvoices,

  // ── Vendor Bills ──────────────────────────────────────────────────────────
  viewVendorBills,
  editVendorBills,
  deleteVendorBills,

  // ── Purchase Orders ───────────────────────────────────────────────────────
  viewPurchaseOrders,
  editPurchaseOrders,
  deletePurchaseOrders,

  // ── Inventory ─────────────────────────────────────────────────────────────
  viewInventory,
  editInventory,
  adjustStock,

  // ── Payments ──────────────────────────────────────────────────────────────
  viewPayments,
  editPayments,

  // ── Journal & Ledger ──────────────────────────────────────────────────────
  viewJournal,
  postJournal,

  // ── Financial Reports ─────────────────────────────────────────────────────
  viewFinancialReports,

  // ── Fiscal Periods ────────────────────────────────────────────────────────
  viewFiscalPeriods,
  closeFiscalPeriod,

  // ── Banking ───────────────────────────────────────────────────────────────
  viewBankAccounts,
  editBankAccounts,

  // ── Administration ────────────────────────────────────────────────────────
  manageUsers,
  manageRoles,
  viewAuditTrail,
  manageSettings,
}

/// A named set of [Permission]s that can be assigned to users.
class AppRole {
  const AppRole({
    required this.id,
    required this.name,
    required this.description,
    required this.permissions,
  });

  final String id;
  final String name;
  final String description;
  final Set<Permission> permissions;

  /// Whether this role grants [permission].
  bool has(Permission permission) => permissions.contains(permission);

  AppRole copyWith({
    String? id,
    String? name,
    String? description,
    Set<Permission>? permissions,
  }) {
    return AppRole(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      permissions: permissions ?? this.permissions,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRole && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'AppRole(id: $id, name: $name)';
}

// ─────────────────────────────────────────────────────────────────────────────
// Built-in role factories
// ─────────────────────────────────────────────────────────────────────────────

class BuiltInRoles {
  BuiltInRoles._();

  static final administrator = AppRole(
    id: 'role-admin',
    name: 'Administrator',
    description: 'Full access to all features and settings.',
    permissions: Permission.values.toSet(),
  );

  static final manager = AppRole(
    id: 'role-manager',
    name: 'Manager',
    description:
        'Can view and edit most documents; cannot manage users or system settings.',
    permissions: const {
      Permission.viewCustomers,
      Permission.editCustomers,
      Permission.viewVendors,
      Permission.editVendors,
      Permission.viewSalesInvoices,
      Permission.editSalesInvoices,
      Permission.viewVendorBills,
      Permission.editVendorBills,
      Permission.viewPurchaseOrders,
      Permission.editPurchaseOrders,
      Permission.viewInventory,
      Permission.editInventory,
      Permission.adjustStock,
      Permission.viewPayments,
      Permission.editPayments,
      Permission.viewJournal,
      Permission.postJournal,
      Permission.viewFinancialReports,
      Permission.viewFiscalPeriods,
      Permission.viewBankAccounts,
      Permission.editBankAccounts,
      Permission.viewAuditTrail,
    },
  );

  static final accountant = AppRole(
    id: 'role-accountant',
    name: 'Accountant',
    description:
        'Read/write access to financial documents; cannot delete or manage system.',
    permissions: const {
      Permission.viewCustomers,
      Permission.viewVendors,
      Permission.viewSalesInvoices,
      Permission.editSalesInvoices,
      Permission.viewVendorBills,
      Permission.editVendorBills,
      Permission.viewPurchaseOrders,
      Permission.viewInventory,
      Permission.viewPayments,
      Permission.editPayments,
      Permission.viewJournal,
      Permission.postJournal,
      Permission.viewFinancialReports,
      Permission.viewFiscalPeriods,
      Permission.closeFiscalPeriod,
      Permission.viewBankAccounts,
      Permission.viewAuditTrail,
    },
  );

  static List<AppRole> get all => [administrator, manager, accountant];
}
