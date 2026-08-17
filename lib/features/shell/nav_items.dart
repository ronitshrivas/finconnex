import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;
  final String? route;
  final List<NavItem> children;

  const NavItem({
    required this.label,
    required this.icon,
    this.route,
    this.children = const [],
  });

  bool get expandable => children.isNotEmpty;
}

const kSidebarSection = 'DASHBOARD';

const kNavItems = <NavItem>[
  NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, route: '/dashboard'),
  NavItem(label: 'Work Queue', icon: Icons.list_alt_outlined, route: '/work-queue'),
  NavItem(
    label: 'Sales',
    icon: Icons.trending_up_outlined,
    route: '/sales',
    children: [
      NavItem(label: 'Leads', icon: Icons.person_outline, route: '/sales/leads'),
      NavItem(label: 'Contacts', icon: Icons.contacts_outlined, route: '/sales/contacts'),
      NavItem(label: 'Companies', icon: Icons.business_outlined, route: '/sales/companies'),
      NavItem(label: 'Deals', icon: Icons.handshake_outlined, route: '/sales/deals'),
      NavItem(label: 'Forecasting', icon: Icons.query_stats, route: '/sales/forecasting'),
    ],
  ),
  NavItem(
    label: 'Activities',
    icon: Icons.event_note_outlined,
    route: '/activities',
    children: [
      NavItem(label: 'Tasks', icon: Icons.check_circle_outline, route: '/activities/tasks'),
      NavItem(label: 'Calls', icon: Icons.phone_outlined, route: '/activities/calls'),
      NavItem(label: 'Messages', icon: Icons.chat_bubble_outline, route: '/marketing/inbox'),
      NavItem(label: 'Emails', icon: Icons.mail_outline, route: '/activities/emails'),
      NavItem(label: 'Meetings', icon: Icons.groups_outlined, route: '/activities/meetings'),
      NavItem(label: 'Notes', icon: Icons.sticky_note_2_outlined, route: '/activities/notes'),
      NavItem(label: 'Attachments', icon: Icons.attach_file, route: '/activities/attachments'),
      NavItem(label: 'Reminders', icon: Icons.notifications_none, route: '/activities/reminders'),
    ],
  ),
  NavItem(
    label: 'Booking',
    icon: Icons.schedule_outlined,
    route: '/booking',
    children: [
      NavItem(label: 'Home', icon: Icons.home_outlined, route: '/booking'),
      NavItem(label: 'Consultations', icon: Icons.event_available_outlined, route: '/booking/consultations'),
      NavItem(label: 'Schedules', icon: Icons.calendar_today_outlined, route: '/booking/schedules'),
      NavItem(label: 'Consultants', icon: Icons.person_pin_outlined, route: '/booking/consultants'),
    ],
  ),
  NavItem(
    label: 'Documents',
    icon: Icons.folder_outlined,
    route: '/documents/library',
    children: [
      NavItem(label: 'Library', icon: Icons.folder_outlined, route: '/documents/library'),
      NavItem(label: 'Document Requests', icon: Icons.description_outlined, route: '/documents/requests'),
    ],
  ),
  NavItem(
    label: 'E-Signature',
    icon: Icons.draw_outlined,
    route: '/signature',
    children: [
      NavItem(label: 'Overview', icon: Icons.dashboard_outlined, route: '/signature'),
      NavItem(label: 'Documents', icon: Icons.description_outlined, route: '/signature/documents'),
      NavItem(label: 'Templates', icon: Icons.article_outlined, route: '/signature/templates'),
    ],
  ),
  NavItem(
    label: 'Marketing',
    icon: Icons.campaign_outlined,
    route: '/marketing/email',
    children: [
      NavItem(label: 'Email Campaigns', icon: Icons.mail_outline, route: '/marketing/email'),
      NavItem(label: 'SMS Campaigns', icon: Icons.sms_outlined, route: '/marketing/sms'),
      NavItem(label: 'WhatsApp Campaigns', icon: Icons.chat_outlined, route: '/marketing/whatsapp'),
      NavItem(label: 'Forms', icon: Icons.dynamic_form_outlined, route: '/marketing/forms'),
      NavItem(label: 'Broker pages', icon: Icons.link, route: '/marketing/linktree'),
    ],
  ),
  NavItem(
    label: 'Sales Ops',
    icon: Icons.bar_chart_outlined,
    route: '/finance',
    children: [
      NavItem(label: 'Hub', icon: Icons.hub_outlined, route: '/finance'),
      NavItem(label: 'Estimates', icon: Icons.receipt_long_outlined, route: '/finance/estimates'),
      NavItem(label: 'Quotations', icon: Icons.request_quote_outlined, route: '/finance/quotations'),
      NavItem(label: 'Invoices', icon: Icons.receipt_outlined, route: '/finance/invoices'),
      NavItem(label: 'Payments', icon: Icons.payments_outlined, route: '/finance/payments'),
      NavItem(label: 'Items / Services', icon: Icons.inventory_2_outlined, route: '/finance/products'),
    ],
  ),
  NavItem(label: 'Team Management', icon: Icons.people_alt_outlined, route: '/team'),
  NavItem(label: 'Support', icon: Icons.help_outline, route: '/support'),
  NavItem(label: 'Time Tracking', icon: Icons.timer_outlined, route: '/time-tracking'),
  NavItem(label: 'Client Portal', icon: Icons.public_outlined, route: '/portals'),
  NavItem(label: 'Reports', icon: Icons.stacked_line_chart_outlined, route: '/reports'),
  NavItem(label: 'Analytics', icon: Icons.insights_outlined, route: '/analytics'),
  NavItem(label: 'Resources', icon: Icons.book_outlined, route: '/resources'),
  NavItem(label: 'Calculator', icon: Icons.calculate_outlined, route: '/calculator'),
  NavItem(label: 'Journeys', icon: Icons.route_outlined, route: '/journeys'),
  NavItem(label: 'Rules', icon: Icons.rule_outlined, route: '/rules'),
  NavItem(label: 'Settings', icon: Icons.settings_outlined, route: '/settings'),
];
