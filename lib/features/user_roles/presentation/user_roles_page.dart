import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../domain/app_user.dart';
import '../domain/permission.dart';
import '../domain/user_roles_controller.dart';

/// Settings page for managing users and viewing role assignments.
class UserRolesPage extends ConsumerWidget {
  const UserRolesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final usersAsync = ref.watch(usersControllerProvider);
    final rolesAsync = ref.watch(rolesControllerProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.userRolesPageTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.userRolesTabUsers),
              Tab(text: l10n.userRolesTabRoles),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _UsersTab(
              usersAsync: usersAsync,
              rolesAsync: rolesAsync,
              l10n: l10n,
              ref: ref,
            ),
            _RolesTab(rolesAsync: rolesAsync, l10n: l10n),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Users Tab
// ─────────────────────────────────────────────────────────────────────────────

class _UsersTab extends StatelessWidget {
  const _UsersTab({
    required this.usersAsync,
    required this.rolesAsync,
    required this.l10n,
    required this.ref,
  });

  final AsyncValue<List<AppUser>> usersAsync;
  final AsyncValue<List<AppRole>> rolesAsync;
  final AppLocalizations l10n;
  final WidgetRef ref;

  Future<void> _showAssignRoleDialog(
    BuildContext context,
    AppUser user,
    List<AppRole> roles,
  ) async {
    String selectedRoleId = user.roleId;

    final confirmed = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              title: Text(l10n.userRolesAssignTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: roles.map((role) {
                  final isSelected = selectedRoleId == role.id;
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: isSelected
                          ? Theme.of(ctx).colorScheme.primary
                          : null,
                      size: 20,
                    ),
                    title: Text(role.name),
                    subtitle: Text(
                      role.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11),
                    ),
                    onTap: () => setDialogState(() => selectedRoleId = role.id),
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(null),
                  child: Text(l10n.invoiceCancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(ctx).pop(selectedRoleId),
                  child: Text(l10n.invoiceSave),
                ),
              ],
            );
          },
        );
      },
    );

    if (confirmed != null && confirmed != user.roleId) {
      await ref
          .read(usersControllerProvider.notifier)
          .assignRole(user.id, confirmed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return usersAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, _) => AppErrorState(message: '${l10n.userRolesLoadError} $e'),
      data: (users) {
        if (users.isEmpty) {
          return AppEmptyState(
            title: l10n.userRolesEmptyTitle,
            message: l10n.userRolesEmptyMessage,
          );
        }
        final roles = rolesAsync.value ?? const [];
        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final user = users[i];
            final role = roles.firstWhere(
              (r) => r.id == user.roleId,
              orElse: () => AppRole(
                id: '',
                name: l10n.userRolesUnknownRole,
                description: '',
                permissions: const {},
              ),
            );
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: user.isActive
                    ? Theme.of(ctx).colorScheme.primaryContainer
                    : Theme.of(ctx).colorScheme.surfaceContainerHighest,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: user.isActive
                        ? Theme.of(ctx).colorScheme.onPrimaryContainer
                        : Theme.of(ctx).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              title: Text(
                user.name,
                style: TextStyle(
                  color: user.isActive
                      ? null
                      : Theme.of(ctx).colorScheme.onSurfaceVariant,
                  decoration: user.isActive ? null : TextDecoration.lineThrough,
                ),
              ),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Chip(
                    label: Text(
                      role.name,
                      style: const TextStyle(fontSize: 11),
                    ),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  if (user.isActive)
                    PopupMenuButton<_UserAction>(
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: _UserAction.assignRole,
                          child: Text(l10n.userRolesAssignTitle),
                        ),
                        PopupMenuItem(
                          value: _UserAction.deactivate,
                          child: Text(
                            l10n.userRolesDeactivate,
                            style: TextStyle(
                              color: Theme.of(ctx).colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                      onSelected: (action) async {
                        switch (action) {
                          case _UserAction.assignRole:
                            await _showAssignRoleDialog(context, user, roles);
                          case _UserAction.deactivate:
                            await ref
                                .read(usersControllerProvider.notifier)
                                .deactivateUser(user.id);
                        }
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

enum _UserAction { assignRole, deactivate }

// ─────────────────────────────────────────────────────────────────────────────
// Roles Tab
// ─────────────────────────────────────────────────────────────────────────────

class _RolesTab extends StatelessWidget {
  const _RolesTab({required this.rolesAsync, required this.l10n});

  final AsyncValue<List<AppRole>> rolesAsync;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return rolesAsync.when(
      loading: () => const AppLoadingState(),
      error: (e, _) => AppErrorState(message: '${l10n.userRolesLoadError} $e'),
      data: (roles) {
        if (roles.isEmpty) {
          return AppEmptyState(
            title: l10n.userRolesEmptyTitle,
            message: l10n.userRolesEmptyMessage,
          );
        }
        return ListView.builder(
          itemCount: roles.length,
          itemBuilder: (ctx, i) {
            final role = roles[i];
            return ExpansionTile(
              title: Text(
                role.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                role.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: role.permissions.map((p) {
                        return Chip(
                          label: Text(
                            _permissionLabel(p),
                            style: const TextStyle(fontSize: 11),
                          ),
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _permissionLabel(Permission p) {
    switch (p) {
      case Permission.viewCustomers:
        return 'View Customers';
      case Permission.editCustomers:
        return 'Edit Customers';
      case Permission.deleteCustomers:
        return 'Delete Customers';
      case Permission.viewVendors:
        return 'View Vendors';
      case Permission.editVendors:
        return 'Edit Vendors';
      case Permission.deleteVendors:
        return 'Delete Vendors';
      case Permission.viewSalesInvoices:
        return 'View Sales Invoices';
      case Permission.editSalesInvoices:
        return 'Edit Sales Invoices';
      case Permission.deleteSalesInvoices:
        return 'Delete Sales Invoices';
      case Permission.viewVendorBills:
        return 'View Vendor Bills';
      case Permission.editVendorBills:
        return 'Edit Vendor Bills';
      case Permission.deleteVendorBills:
        return 'Delete Vendor Bills';
      case Permission.viewPurchaseOrders:
        return 'View Purchase Orders';
      case Permission.editPurchaseOrders:
        return 'Edit Purchase Orders';
      case Permission.deletePurchaseOrders:
        return 'Delete Purchase Orders';
      case Permission.viewInventory:
        return 'View Inventory';
      case Permission.editInventory:
        return 'Edit Inventory';
      case Permission.adjustStock:
        return 'Adjust Stock';
      case Permission.viewPayments:
        return 'View Payments';
      case Permission.editPayments:
        return 'Edit Payments';
      case Permission.viewJournal:
        return 'View Journal';
      case Permission.postJournal:
        return 'Post Journal';
      case Permission.viewFinancialReports:
        return 'View Financial Reports';
      case Permission.viewFiscalPeriods:
        return 'View Fiscal Periods';
      case Permission.closeFiscalPeriod:
        return 'Close Fiscal Period';
      case Permission.viewBankAccounts:
        return 'View Bank Accounts';
      case Permission.editBankAccounts:
        return 'Edit Bank Accounts';
      case Permission.manageUsers:
        return 'Manage Users';
      case Permission.manageRoles:
        return 'Manage Roles';
      case Permission.viewAuditTrail:
        return 'View Audit Trail';
      case Permission.manageSettings:
        return 'Manage Settings';
    }
  }
}
