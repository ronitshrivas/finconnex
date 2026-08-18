import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum SigStatus { draft, sent, inProgress, signed, expired }

extension SigStatusX on SigStatus {
  String get label => switch (this) {
        SigStatus.draft => 'Draft',
        SigStatus.sent => 'Sent',
        SigStatus.inProgress => 'In Progress',
        SigStatus.signed => 'Signed',
        SigStatus.expired => 'Expired',
      };
  Color get bg => switch (this) {
        SigStatus.draft => AppColors.neutralBg,
        SigStatus.sent => AppColors.warningBg,
        SigStatus.inProgress => AppColors.primarySoft,
        SigStatus.signed => AppColors.successBg,
        SigStatus.expired => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        SigStatus.draft => AppColors.neutralFg,
        SigStatus.sent => AppColors.warningFg,
        SigStatus.inProgress => AppColors.primary,
        SigStatus.signed => AppColors.successFg,
        SigStatus.expired => AppColors.dangerFg,
      };
}

class SigStat {
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String count;
  final String label;
  final String? sub;
  const SigStat({
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.count,
    required this.label,
    this.sub,
  });
}

const kSigOverviewStats = <SigStat>[
  SigStat(
    icon: Icons.description_outlined,
    iconBg: AppColors.primarySoft,
    iconFg: AppColors.primary,
    count: '4',
    label: 'All Documents',
    sub: 'View all documents',
  ),
  SigStat(
    icon: Icons.edit_outlined,
    iconBg: AppColors.dangerBg,
    iconFg: AppColors.dangerFg,
    count: '1',
    label: 'Draft',
    sub: 'View draft documents',
  ),
  SigStat(
    icon: Icons.schedule,
    iconBg: AppColors.warningBg,
    iconFg: AppColors.warningFg,
    count: '2',
    label: 'In Progress',
    sub: 'Awaiting signatures',
  ),
  SigStat(
    icon: Icons.check_circle_outline,
    iconBg: AppColors.successBg,
    iconFg: AppColors.successFg,
    count: '1',
    label: 'Signed',
    sub: 'Successfully signed',
  ),
  SigStat(
    icon: Icons.event_busy_outlined,
    iconBg: AppColors.neutralBg,
    iconFg: AppColors.neutralFg,
    count: '0',
    label: 'Expired',
    sub: 'Expired documents',
  ),
];

class SigDoc {
  final String id;
  final String name;
  final SigStatus status;
  final List<String> recipientInitials;
  final String recipientPrimary;
  final String? recipientEmail;
  final String owner;
  final String ownerInitials;
  final String relatedTo;
  final String sent;
  final String lastActivity;
  const SigDoc({
    required this.id,
    required this.name,
    required this.status,
    required this.recipientInitials,
    required this.recipientPrimary,
    this.recipientEmail,
    required this.owner,
    required this.ownerInitials,
    required this.relatedTo,
    required this.sent,
    required this.lastActivity,
  });
}

const kSigRecent = <SigDoc>[
  SigDoc(
    id: 'ES-2001',
    name: 'Engagement Letter: Anderson',
    status: SigStatus.sent,
    recipientInitials: ['JS', 'SL'],
    recipientPrimary: 'William Anderson',
    recipientEmail: 'william@example.com',
    owner: 'Finconnex',
    ownerInitials: 'F',
    relatedTo: 'Lead: William Anderson',
    sent: '12 Aug 2025',
    lastActivity: '2 hours ago',
  ),
  SigDoc(
    id: 'ES-2002',
    name: 'Greystone Proposal Acceptance',
    status: SigStatus.signed,
    recipientInitials: ['JS', 'SL'],
    recipientPrimary: 'Olivia Bennett',
    recipientEmail: 'olivia@northwind.com, james…',
    owner: 'Finconnex',
    ownerInitials: 'F',
    relatedTo: 'Deal: Greystone Realty',
    sent: '12 Aug 2025',
    lastActivity: '2 hours ago',
  ),
  SigDoc(
    id: 'ES-2004',
    name: 'Engagement: Harbour packaging quotation',
    status: SigStatus.sent,
    recipientInitials: ['JS', 'SL'],
    recipientPrimary: 'Marcus Chen',
    recipientEmail: 'marcus@harbour.example',
    owner: 'Finconnex',
    ownerInitials: 'F',
    relatedTo: 'Quotation: QUO-3102',
    sent: '12 Aug 2025',
    lastActivity: '2 hours ago',
  ),
  SigDoc(
    id: 'ES-2003',
    name: 'NDA: Fabrikam',
    status: SigStatus.draft,
    recipientInitials: ['JS', 'SL'],
    recipientPrimary: 'Marcus Lin',
    owner: 'Finconnex',
    ownerInitials: 'F',
    relatedTo: 'Company: Fabrikam Inc.',
    sent: '12 Aug 2025',
    lastActivity: '2 hours ago',
  ),
];

const kSigDocuments = <SigDoc>[
  SigDoc(
    id: 'ES-2001',
    name: 'Engagement Letter: Anderson',
    status: SigStatus.inProgress,
    recipientInitials: ['WA'],
    recipientPrimary: 'William Anderson',
    recipientEmail: 'william@example.com',
    owner: 'John Smith',
    ownerInitials: 'J',
    relatedTo: 'Lead: William Anderson',
    sent: '18/07/2026',
    lastActivity: '18/07/2026 09:05',
  ),
  SigDoc(
    id: 'ES-2002',
    name: 'Greystone Proposal Acceptan…',
    status: SigStatus.signed,
    recipientInitials: ['OB', 'JG'],
    recipientPrimary: 'olivia@northwind.com, james…',
    owner: 'Tejas Gokhe',
    ownerInitials: 'T',
    relatedTo: 'Deal: Greystone Realty',
    sent: '10/07/2026',
    lastActivity: '12/07/2026 16:20',
  ),
  SigDoc(
    id: 'ES-2004',
    name: 'Engagement: Harbour packa…',
    status: SigStatus.inProgress,
    recipientInitials: ['MC'],
    recipientPrimary: 'marcus@harbour.example',
    owner: 'Tejas Gokhe',
    ownerInitials: 'T',
    relatedTo: 'Quotation: QUO-3102',
    sent: '19/07/2026',
    lastActivity: '19/07/2026 11:05',
  ),
  SigDoc(
    id: 'ES-2003',
    name: 'NDA: Fabrikam',
    status: SigStatus.draft,
    recipientInitials: ['ML', 'PS'],
    recipientPrimary: 'marcus@fabrikam.com, priya…',
    owner: 'Roshna Abraham',
    ownerInitials: 'R',
    relatedTo: 'Company: Fabrikam Inc.',
    sent: '—',
    lastActivity: '20/07/2026 16:00',
  ),
];

class SigTemplate {
  final String name;
  final String description;
  final String lastUpdated;
  final String createdBy;
  final String createdByInitials;
  const SigTemplate({
    required this.name,
    required this.description,
    required this.lastUpdated,
    required this.createdBy,
    required this.createdByInitials,
  });
}

const kSigTemplates = <SigTemplate>[
  SigTemplate(
    name: 'Loan Application Form',
    description: 'Standard loan application form for residential home loan a…',
    lastUpdated: '12 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'Privacy Consent Form',
    description: 'Consent form to collect and use personal information.',
    lastUpdated: '11 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'Broker Authority Form',
    description: 'Authority form to act on behalf of the client for loan proce…',
    lastUpdated: '10 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'ID Verification Form',
    description: 'Form to verify identity and address documents.',
    lastUpdated: '10 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'Financial Disclosure',
    description: 'Client financial information and disclosure form.',
    lastUpdated: '9 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'Employment Verification Form',
    description: 'Form to verify income and employment status for applican…',
    lastUpdated: '05 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
  SigTemplate(
    name: 'Property Appraisal Waiver',
    description: 'Client consent form to waive standard physical property a…',
    lastUpdated: '02 Aug 2025',
    createdBy: 'Mohit Chapagain',
    createdByInitials: 'MC',
  ),
];
