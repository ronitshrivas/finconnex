import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class KpiStat {
  final String label;
  final String value;
  final String delta;
  final bool positive;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;

  const KpiStat({
    required this.label,
    required this.value,
    required this.delta,
    required this.positive,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
  });
}

const kMockKpis = <KpiStat>[
  KpiStat(
    label: 'Total revenue',
    value: '\$248,530',
    delta: '+12.4% vs last month',
    positive: true,
    icon: Icons.attach_money,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
  ),
  KpiStat(
    label: 'Active deals',
    value: '184',
    delta: '+8 this week',
    positive: true,
    icon: Icons.trending_up,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
  ),
  KpiStat(
    label: 'New leads',
    value: '52',
    delta: '+16% conversion',
    positive: true,
    icon: Icons.person_add_alt,
    iconBg: AppColors.infoBg,
    iconFg: AppColors.infoFg,
  ),
  KpiStat(
    label: 'Open tickets',
    value: '9',
    delta: '-3 since yesterday',
    positive: true,
    icon: Icons.support_agent,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
  ),
];

class PipelineStage {
  final String name;
  final int count;
  final String value;
  final double pct;
  const PipelineStage(this.name, this.count, this.value, this.pct);
}

const kPipeline = <PipelineStage>[
  PipelineStage('Prospecting', 42, '\$186k', 0.9),
  PipelineStage('Qualification', 31, '\$142k', 0.72),
  PipelineStage('Proposal', 24, '\$118k', 0.6),
  PipelineStage('Negotiation', 18, '\$96k', 0.48),
  PipelineStage('Closed won', 12, '\$74k', 0.35),
];

class ActivityItem {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String subtitle;
  final String time;
  const ActivityItem({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

const kActivities = <ActivityItem>[
  ActivityItem(
    icon: Icons.check_circle_outline,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
    title: 'Deal closed with Greystone Realty',
    subtitle: 'Priya Mehta · \$48,200',
    time: '2h ago',
  ),
  ActivityItem(
    icon: Icons.person_add_alt,
    iconBg: AppColors.infoBg,
    iconFg: AppColors.infoFg,
    title: 'New lead added',
    subtitle: 'Marcus Chen from Harbour Loans',
    time: '4h ago',
  ),
  ActivityItem(
    icon: Icons.mail_outline,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
    title: 'Proposal sent',
    subtitle: 'Apex Property Group — Q4 renewal',
    time: 'Yesterday',
  ),
  ActivityItem(
    icon: Icons.warning_amber_outlined,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
    title: 'Contract expires soon',
    subtitle: 'Northside Holdings — 7 days',
    time: '2d ago',
  ),
];
