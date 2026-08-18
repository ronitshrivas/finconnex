import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NotificationItem {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String body;
  final String time;
  final bool unread;
  const NotificationItem({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.body,
    required this.time,
    required this.unread,
  });
}

const kMockNotifications = <NotificationItem>[
  NotificationItem(
    icon: Icons.check_circle_outline,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
    title: 'Deal closed',
    body: 'Greystone Realty renewal — \$48,200',
    time: '2m',
    unread: true,
  ),
  NotificationItem(
    icon: Icons.person_add_alt,
    iconBg: AppColors.infoBg,
    iconFg: AppColors.infoFg,
    title: 'New lead assigned',
    body: 'Marcus Chen from Harbour Loans',
    time: '1h',
    unread: true,
  ),
  NotificationItem(
    icon: Icons.warning_amber_outlined,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
    title: 'Document request expiring',
    body: 'DR-1006 · ASIC company extract',
    time: '3h',
    unread: true,
  ),
  NotificationItem(
    icon: Icons.mail_outline,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
    title: 'Proposal opened',
    body: 'Apex Property Group viewed your proposal',
    time: 'Yesterday',
    unread: true,
  ),
  NotificationItem(
    icon: Icons.event_available_outlined,
    iconBg: AppColors.neutralBg,
    iconFg: AppColors.neutralFg,
    title: 'Meeting confirmed',
    body: 'Harbour onboarding kickoff · Tue 2pm',
    time: '2d',
    unread: false,
  ),
];
