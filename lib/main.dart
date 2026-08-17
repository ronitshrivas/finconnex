import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/activities/activities_screen.dart';
import 'features/booking/booking_screen.dart';
import 'features/client_portal/client_portal_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/documents/library_screen.dart';
import 'features/documents/requests_screen.dart';
import 'features/login/login_screen.dart';
import 'features/sales/sales_screen.dart';
import 'features/shell/app_shell.dart';
import 'features/shell/nav_items.dart';
import 'features/shell/placeholder_screen.dart';
import 'features/work_queue/work_queue_screen.dart';

void main() {
  runApp(const FinConnexApp());
}

class FinConnexApp extends StatelessWidget {
  const FinConnexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinConnex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  bool _signedIn = false;
  String _route = '/dashboard';

  void _navigate(String route) => setState(() => _route = route);

  Widget _pageFor(String route) {
    switch (route) {
      case '/dashboard':
        return const DashboardScreen();
      case '/work-queue':
        return const WorkQueueScreen();
      case '/sales':
      case '/sales/deals':
        return const SalesScreen();
      case '/activities':
      case '/activities/tasks':
        return const ActivitiesScreen();
      case '/booking':
        return const BookingScreen();
      case '/documents/library':
        return const LibraryScreen();
      case '/documents/requests':
        return const DocumentRequestsScreen();
      case '/portals':
        return const ClientPortalScreen();
      default:
        return PlaceholderScreen(title: _labelForRoute(route));
    }
  }

  String _labelForRoute(String route) {
    for (final item in kNavItems) {
      if (item.route == route) return item.label;
      for (final child in item.children) {
        if (child.route == route) return child.label;
      }
    }
    return 'FinConnex';
  }

  @override
  Widget build(BuildContext context) {
    if (!_signedIn) {
      return LoginScreen(onSignedIn: () => setState(() => _signedIn = true));
    }
    return AppShell(
      currentRoute: _route,
      onNavigate: _navigate,
      child: _pageFor(_route),
    );
  }
}
