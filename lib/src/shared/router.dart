import 'package:draperweb/src/features/budgets/view/budget_screen.dart';
import 'package:draperweb/src/features/dashboard/view/dashboard_screen.dart';
import 'package:draperweb/src/features/login/view/login_screen.dart';
import 'package:draperweb/src/features/settings/view/settings_screen.dart';
import 'package:draperweb/src/shared/providers/auth.dart';
import 'package:draperweb/src/shared/views/navigation_wrapper.dart';
import 'package:draperweb/src/shared/views/root_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/login/login.dart';

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

final nonProtectedRoutes = [
  '/handle-login',
];

final appRouter = GoRouter(
    restorationScopeId: 'app',
    urlPathStrategy: UrlPathStrategy.path,
    navigatorBuilder: (context, state, child) =>
        NavigationWrapper(child: child),
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const MaterialPage<void>(
          key: _pageKey,
          child: LoginScreen(),
        ),
      ),
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
      GoRoute(
        path: '/handle-login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: _pageKey,
          child: HandleLoginComplete(uri: state.extra as Uri),
        ),
      )
    ],
    redirect: (state) {
      final loggedIn = AuthProvider().loggedIn;
      final loggingIn = state.subloc == '/login';
      if (!loggedIn && !nonProtectedRoutes.contains(state.subloc)) return loggingIn ? null : '/login';
      if (loggingIn) return '/';
      return null;
    });
