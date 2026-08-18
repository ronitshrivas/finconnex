import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/activities/activities_screen.dart';
import 'features/booking/booking_screen.dart';
import 'features/calendar/calendar_screen.dart';
import 'features/client_portal/client_portal_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/documents/library_screen.dart';
import 'features/documents/requests_screen.dart';
import 'features/messages/messages_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/finance/estimates_screen.dart';
import 'features/finance/hub_screen.dart';
import 'features/finance/invoices_screen.dart';
import 'features/finance/payments_items_screens.dart';
import 'features/finance/quotations_screen.dart';
import 'features/login/login_screen.dart';
import 'features/marketing/broker_pages_screen.dart';
import 'features/marketing/email_campaigns_screen.dart';
import 'features/marketing/forms_screen.dart';
import 'features/marketing/sms_campaigns_screen.dart';
import 'features/marketing/whatsapp_campaigns_screen.dart';
import 'features/ops/analytics_screen.dart';
import 'features/ops/reports_screen.dart';
import 'features/ops/resources_screen.dart';
import 'features/ops/support_screen.dart';
import 'features/ops/team_screen.dart';
import 'features/ops/time_tracking_screen.dart';
import 'features/sales/sales_screen.dart';
import 'features/shell/app_shell.dart';
import 'features/shell/nav_items.dart';
import 'features/shell/placeholder_screen.dart';
import 'features/signature/documents_screen.dart';
import 'features/signature/overview_screen.dart';
import 'features/signature/templates_screen.dart';
import 'features/work_queue/work_queue_screen.dart';

void main() {
  runApp(const FinConnexApp());
}

class FinConnexApp extends StatefulWidget {
  const FinConnexApp({super.key});

  @override
  State<FinConnexApp> createState() => _FinConnexAppState();
}

class _FinConnexAppState extends State<FinConnexApp> {
  final _theme = ThemeController();

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: _theme,
      child: AnimatedBuilder(
        animation: _theme,
        builder: (_, __) => MaterialApp(
          title: 'FinConnex',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: _theme.mode,
          home: const _AppRoot(),
        ),
      ),
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
      case '/signature':
        return const SignatureOverviewScreen();
      case '/signature/documents':
        return const SignatureDocumentsScreen();
      case '/signature/templates':
        return const SignatureTemplatesScreen();
      case '/marketing/email':
        return const EmailCampaignsScreen();
      case '/marketing/sms':
        return const SmsCampaignsScreen();
      case '/marketing/whatsapp':
        return const WhatsAppCampaignsScreen();
      case '/marketing/forms':
        return const FormsScreen();
      case '/marketing/linktree':
        return const BrokerPagesScreen();
      case '/finance':
        return const FinanceHubScreen();
      case '/finance/estimates':
        return const EstimatesScreen();
      case '/finance/quotations':
        return const QuotationsScreen();
      case '/finance/invoices':
        return const InvoicesScreen();
      case '/finance/payments':
        return const PaymentsScreen();
      case '/finance/products':
        return const ItemsScreen();
      case '/portals':
        return const ClientPortalScreen();
      case '/team':
        return const TeamScreen();
      case '/support':
        return const SupportScreen();
      case '/time-tracking':
        return const TimeTrackingScreen();
      case '/reports':
        return const ReportsScreen();
      case '/analytics':
        return const AnalyticsScreen();
      case '/resources':
        return const ResourcesScreen();
      case '/activities/team-chat':
      case '/messages':
        return const MessagesScreen();
      case '/activities/calendar':
      case '/calendar':
        return const CalendarScreen();
      case '/settings':
        return const SettingsScreen();
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
      onSignOut: () => setState(() => _signedIn = false),
      child: _pageFor(_route),
    );
  }
}
