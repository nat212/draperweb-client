import 'package:draperweb/src/features/budgets/view/budget_screen.dart';
import 'package:draperweb/src/features/dashboard/view/dashboard_screen.dart';
import 'package:draperweb/src/features/settings/view/settings_screen.dart';
import 'package:draperweb/src/shared/views/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _pageKey = ValueKey('_pageKey');
const _scaffoldKey = ValueKey('_scaffoldKey');

class NavigationDestination {
  const NavigationDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.child,
  });

  final String route;
  final String label;
  final Icon icon;
  final Widget? child;
}

const List<NavigationDestination> destinations = [
  NavigationDestination(
    label: 'Dashboard',
    icon: Icon(Icons.dashboard),
    route: '/',
  ),
  NavigationDestination(
    label: 'Budgets',
    icon: Icon(Icons.savings),
    route: '/budgets',
  ),
  NavigationDestination(
    label: 'Settings',
    icon: Icon(Icons.settings),
    route: '/settings',
  ),
];

final appRouter = GoRouter(
  restorationScopeId: 'app',
  urlPathStrategy: UrlPathStrategy.path,
  navigatorBuilder: (context, state, child) => child,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 0,
          child: DashboardScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/budgets',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 1,
          child: BudgetScreen(),
        ),
      ),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) => const MaterialPage<void>(
        key: _pageKey,
        child: RootLayout(
          key: _scaffoldKey,
          currentIndex: 2,
          child: SettingsScreen(),
        ),
      ),
    ),
  ],
);
