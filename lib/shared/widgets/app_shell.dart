import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/locale_setting_provider.dart';
import '../../features/notifications/presentation/notification_bell.dart';
import '../../l10n/app_localizations.dart';
import '../extensions/responsive_breakpoint.dart';
import 'offline_banner.dart';

class NavDestination {
  const NavDestination({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
    this.subRoutes = const [],
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
  final List<String> subRoutes;

  bool matches(String location) {
    if (location == route) return true;
    return subRoutes.any((sr) => location.startsWith(sr));
  }
}

class DrawerSection {
  const DrawerSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<NavDestination> items;
}

const _primaryDestinations = [
  NavDestination(
    label: 'Dashboard',
    icon: Icons.dashboard_outlined,
    activeIcon: Icons.dashboard,
    route: '/dashboard',
  ),
  NavDestination(
    label: 'Calendar',
    icon: Icons.calendar_month_outlined,
    activeIcon: Icons.calendar_month,
    route: '/calendar',
  ),
  NavDestination(
    label: 'Sales',
    icon: Icons.receipt_long_outlined,
    activeIcon: Icons.receipt_long,
    route: '/sales-invoices',
    subRoutes: [
      '/sales-invoices',
      '/customer-payments',
      '/customer-statements',
    ],
  ),
  NavDestination(
    label: 'Purchasing',
    icon: Icons.shopping_cart_outlined,
    activeIcon: Icons.shopping_cart,
    route: '/purchase-orders',
    subRoutes: ['/purchase-orders', '/vendor-bills', '/vendor-payments', '/vendor-statements'],
  ),
  NavDestination(
    label: 'Banking',
    icon: Icons.account_balance_outlined,
    activeIcon: Icons.account_balance,
    route: '/bank-accounts',
    subRoutes: ['/bank-accounts', '/bank-reconciliation', '/bank-statements'],
  ),
  NavDestination(
    label: 'Reports',
    icon: Icons.bar_chart_outlined,
    activeIcon: Icons.bar_chart,
    route: '/reports',
    subRoutes: ['/reports', '/general-ledger', '/journal-explorer'],
  ),
  NavDestination(
    label: 'Analytics',
    icon: Icons.analytics_outlined,
    activeIcon: Icons.analytics,
    route: '/analytics',
  ),
  NavDestination(
    label: 'Notifications',
    icon: Icons.notifications_outlined,
    activeIcon: Icons.notifications,
    route: '/notifications',
  ),
];

const _drawerSections = [
  DrawerSection(
    title: 'Financial',
    items: [
      NavDestination(label: 'Expenses', icon: Icons.money_off_outlined, activeIcon: Icons.money_off, route: '/expenses'),
      NavDestination(label: 'General Ledger', icon: Icons.book_outlined, activeIcon: Icons.book, route: '/general-ledger'),
      NavDestination(label: 'Journal Explorer', icon: Icons.article_outlined, activeIcon: Icons.article, route: '/journal-explorer'),
    ],
  ),
  DrawerSection(
    title: 'Inventory',
    items: [
      NavDestination(label: 'Inventory', icon: Icons.inventory_2_outlined, activeIcon: Icons.inventory_2, route: '/inventory', subRoutes: ['/inventory']),
      NavDestination(label: 'Stock Transfers', icon: Icons.swap_horiz_outlined, activeIcon: Icons.swap_horiz, route: '/stock-transfers'),
    ],
  ),
  DrawerSection(
    title: 'CRM',
    items: [
      NavDestination(label: 'CRM Dashboard', icon: Icons.people_outline, activeIcon: Icons.people, route: '/crm/dashboard'),
      NavDestination(label: 'Pipeline', icon: Icons.trending_up_outlined, activeIcon: Icons.trending_up, route: '/crm/pipeline'),
      NavDestination(label: 'Tasks', icon: Icons.checklist_outlined, activeIcon: Icons.checklist, route: '/crm/tasks'),
    ],
  ),
  DrawerSection(
    title: 'System',
    items: [
      NavDestination(label: 'Settings', icon: Icons.settings_outlined, activeIcon: Icons.settings, route: '/settings'),
      NavDestination(label: 'Fiscal Periods', icon: Icons.calendar_month_outlined, activeIcon: Icons.calendar_month, route: '/fiscal-years'),
      NavDestination(label: 'Audit Trail', icon: Icons.history_outlined, activeIcon: Icons.history, route: '/audit-trail'),
      NavDestination(label: 'Analytics', icon: Icons.analytics_outlined, activeIcon: Icons.analytics, route: '/analytics'),
      NavDestination(label: 'Approvals', icon: Icons.assignment_turned_in_outlined, activeIcon: Icons.assignment_turned_in, route: '/approvals'),
      NavDestination(label: 'Goods Receipts', icon: Icons.inventory_2_outlined, activeIcon: Icons.inventory_2, route: '/goods-receipts'),
      NavDestination(label: 'Backup', icon: Icons.backup_outlined, activeIcon: Icons.backup, route: '/backup'),
      NavDestination(label: 'Email', icon: Icons.email_outlined, activeIcon: Icons.email, route: '/email'),
      NavDestination(label: 'AI Assistant', icon: Icons.smart_toy_outlined, activeIcon: Icons.smart_toy, route: '/ai-assistant'),
      NavDestination(label: 'Sync Status', icon: Icons.sync_outlined, activeIcon: Icons.sync, route: '/sync-status'),
      NavDestination(label: 'Tags', icon: Icons.label_outline, activeIcon: Icons.label, route: '/tags'),
      NavDestination(label: 'User Roles', icon: Icons.shield_outlined, activeIcon: Icons.shield, route: '/user-roles'),
      NavDestination(label: 'Currencies', icon: Icons.attach_money_outlined, activeIcon: Icons.attach_money, route: '/currencies'),
      NavDestination(label: 'Fixed Assets', icon: Icons.business_outlined, activeIcon: Icons.business, route: '/fixed-assets'),
      NavDestination(label: 'Import/Export', icon: Icons.file_upload_outlined, activeIcon: Icons.file_upload, route: '/import-export'),
      NavDestination(label: 'Recurring', icon: Icons.repeat_outlined, activeIcon: Icons.repeat, route: '/recurring-transactions'),
    ],
  ),
];

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  static void openDrawer(BuildContext context) {
    context.findAncestorStateOfType<_AppShellState>()?.openDrawer();
  }

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() => _scaffoldKey.currentState?.openDrawer();

  int _activeIndex(String location) {
    for (var i = 0; i < _primaryDestinations.length; i++) {
      if (_primaryDestinations[i].matches(location)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final activeIndex = _activeIndex(location);
    final useRail = ResponsiveBreakpoint(context).useNavigationRail;

    return Scaffold(
      key: _scaffoldKey,
      drawer: useRail ? null : _AppDrawer(
        primaryDestinations: _primaryDestinations,
        sections: _drawerSections,
        activeIndex: activeIndex,
      ),
      appBar: useRail ? _GlobalAppBar() : null,
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: Row(
              children: [
                if (useRail)
                  _NavigationRail(
                    destinations: _primaryDestinations,
                    activeIndex: activeIndex,
                  ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: useRail ? null : _BottomNavBar(
        destinations: _primaryDestinations,
        activeIndex: activeIndex,
      ),
    );
  }
}

class _NavigationRail extends StatelessWidget {
  const _NavigationRail({required this.destinations, required this.activeIndex});

  final List<NavDestination> destinations;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      selectedIndex: activeIndex,
      backgroundColor: cs.surfaceContainerLow,
      onDestinationSelected: (i) {
        final dest = destinations[i];
        if (GoRouterState.of(context).matchedLocation != dest.route) {
          context.go(dest.route);
        }
      },
      destinations: destinations.map((d) {
        final sel = destinations.indexOf(d) == activeIndex;
        return NavigationRailDestination(
          icon: Icon(d.icon),
          selectedIcon: Icon(d.activeIcon),
          label: Text(d.label),
          indicatorColor: sel ? cs.primaryContainer : null,
        );
      }).toList(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.destinations, required this.activeIndex});

  final List<NavDestination> destinations;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: activeIndex,
      onDestinationSelected: (i) {
        final dest = destinations[i];
        if (GoRouterState.of(context).matchedLocation != dest.route) {
          context.go(dest.route);
        }
      },
      destinations: destinations.map((d) {
        return NavigationDestination(
          icon: Icon(d.icon),
          selectedIcon: Icon(d.activeIcon),
          label: d.label,
        );
      }).toList(),
    );
  }
}

class _AppDrawer extends ConsumerWidget {
  const _AppDrawer({
    required this.primaryDestinations,
    required this.sections,
    required this.activeIndex,
  });

  final List<NavDestination> primaryDestinations;
  final List<DrawerSection> sections;
  final int activeIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeSettingProvider);
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: cs.primaryContainer),
              child: Text(
                'Accounting',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n?.language ?? 'Language'),
              trailing: DropdownButton<Locale>(
                value: locale,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: Locale('fa'),
                    child: Text('فارسی'),
                  ),
                  DropdownMenuItem(
                    value: Locale('hy'),
                    child: Text('Հայերեն'),
                  ),
                ],
                onChanged: (loc) {
                  if (loc != null) {
                    ref.read(localeSettingProvider.notifier).setLocale(loc);
                  }
                },
              ),
            ),
            const Divider(),
            for (final dest in primaryDestinations)
              ListTile(
                leading: Icon(
                  primaryDestinations.indexOf(dest) == activeIndex
                      ? dest.activeIcon
                      : dest.icon,
                  color: primaryDestinations.indexOf(dest) == activeIndex
                      ? cs.primary
                      : null,
                ),
                title: Text(
                  dest.label,
                  style: TextStyle(
                    fontWeight: primaryDestinations.indexOf(dest) == activeIndex
                        ? FontWeight.bold
                        : null,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  context.go(dest.route);
                },
              ),
            const Divider(),
            for (final section in sections) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  section.title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              for (final item in section.items)
                ListTile(
                  dense: true,
                  leading: Icon(item.icon, size: 20),
                  title: Text(item.label),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go(item.route);
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GlobalAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeSettingProvider);
    final l10n = AppLocalizations.of(context);
    return AppBar(
      title: const Text('Accounting'),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        PopupMenuButton<Locale>(
          icon: const Icon(Icons.language),
          tooltip: l10n?.language ?? 'Language',
          initialValue: locale,
          onSelected: (loc) {
            ref.read(localeSettingProvider.notifier).setLocale(loc);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: Locale('en'), child: Text('English')),
            PopupMenuItem(value: Locale('fa'), child: Text('فارسی')),
            PopupMenuItem(value: Locale('hy'), child: Text('Հայերեն')),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.push('/search'),
        ),
        const NotificationBell(),
      ],
    );
  }
}
