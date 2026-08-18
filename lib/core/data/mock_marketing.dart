import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum CampaignStatus { completed, scheduled, draft, paused, running, pendingMeta, live }

extension CampaignStatusX on CampaignStatus {
  String get label => switch (this) {
        CampaignStatus.completed => 'Completed',
        CampaignStatus.scheduled => 'Scheduled',
        CampaignStatus.draft => 'Draft',
        CampaignStatus.paused => 'Paused',
        CampaignStatus.running => 'Running',
        CampaignStatus.pendingMeta => 'Pending Meta',
        CampaignStatus.live => 'Live',
      };
  Color get bg => switch (this) {
        CampaignStatus.completed => AppColors.successBg,
        CampaignStatus.scheduled => AppColors.infoBg,
        CampaignStatus.draft => AppColors.neutralBg,
        CampaignStatus.paused => AppColors.warningBg,
        CampaignStatus.running => AppColors.dangerBg,
        CampaignStatus.pendingMeta => AppColors.warningBg,
        CampaignStatus.live => AppColors.successBg,
      };
  Color get fg => switch (this) {
        CampaignStatus.completed => AppColors.successFg,
        CampaignStatus.scheduled => AppColors.infoFg,
        CampaignStatus.draft => AppColors.neutralFg,
        CampaignStatus.paused => AppColors.warningFg,
        CampaignStatus.running => AppColors.dangerFg,
        CampaignStatus.pendingMeta => AppColors.warningFg,
        CampaignStatus.live => AppColors.successFg,
      };
}

class EmailCampaign {
  final String name;
  final String type;
  final String subject;
  final String audience;
  final CampaignStatus status;
  final int sent;
  final String? open;
  final String? click;
  final String createdBy;
  final String createdByInitials;
  const EmailCampaign({
    required this.name,
    required this.type,
    required this.subject,
    required this.audience,
    required this.status,
    required this.sent,
    this.open,
    this.click,
    required this.createdBy,
    required this.createdByInitials,
  });
}

const kEmailCampaigns = <EmailCampaign>[
  EmailCampaign(
    name: 'July rate-lock nurture',
    type: 'Promotional',
    subject: 'Lock in today\'s home loan rate',
    audience: 'Leads · Mortgage · Warm',
    status: CampaignStatus.completed,
    sent: 428,
    open: '42%',
    click: '11%',
    createdBy: 'John Smith',
    createdByInitials: 'JS',
  ),
  EmailCampaign(
    name: 'Greystone proposal follow-up',
    type: 'One-time',
    subject: 'Your proposal is ready to review',
    audience: 'Deal: Greystone Realty',
    status: CampaignStatus.scheduled,
    sent: 0,
    createdBy: 'Tejas Gokhe',
    createdByInitials: 'TG',
  ),
  EmailCampaign(
    name: 'Document request reminder …',
    type: 'Automated',
    subject: 'We\'re still waiting on your docu…',
    audience: 'Document Requests · Pe…',
    status: CampaignStatus.draft,
    sent: 0,
    createdBy: 'Roshna Abraham',
    createdByInitials: 'RA',
  ),
  EmailCampaign(
    name: 'Q3 newsletter',
    type: 'Newsletter',
    subject: 'FinConnex insights: this quarter',
    audience: 'Contacts · Active',
    status: CampaignStatus.paused,
    sent: 210,
    open: '42%',
    click: '9%',
    createdBy: 'Shiva Kadhka',
    createdByInitials: 'SK',
  ),
  EmailCampaign(
    name: 'Drip: warm lead week 1',
    type: 'Drip',
    subject: 'Day 3: still exploring rates?',
    audience: 'Leads · Mortgage · Warm',
    status: CampaignStatus.running,
    sent: 96,
    open: '43%',
    click: '13%',
    createdBy: 'John Smith',
    createdByInitials: 'JS',
  ),
];

class SmsCampaign {
  final String name;
  final String type;
  final String message;
  final String audience;
  final CampaignStatus status;
  final int sent;
  final String? deliveredPct;
  final String? replies;
  final String createdBy;
  final String createdByInitials;
  const SmsCampaign({
    required this.name,
    required this.type,
    required this.message,
    required this.audience,
    required this.status,
    required this.sent,
    this.deliveredPct,
    this.replies,
    required this.createdBy,
    required this.createdByInitials,
  });
}

const kSmsCampaigns = <SmsCampaign>[
  SmsCampaign(
    name: 'Appointment reminder: tom…',
    type: 'Reminder',
    message: 'Hi {{first_name}}, reminder: your Fi…',
    audience: 'Meetings · Tomorrow',
    status: CampaignStatus.completed,
    sent: 18,
    deliveredPct: '94%',
    replies: '4 replies',
    createdBy: 'John Smith',
    createdByInitials: 'JS',
  ),
  SmsCampaign(
    name: 'Missing docs nudge',
    type: 'Transactional',
    message: 'Quick nudge: please upload your l…',
    audience: 'Document Requests · Pe…',
    status: CampaignStatus.draft,
    sent: 0,
    replies: '0 replies',
    createdBy: 'Shiva Kadhka',
    createdByInitials: 'SK',
  ),
  SmsCampaign(
    name: 'Open house weekend',
    type: 'Promotional',
    message: 'This weekend: Greystone open hou…',
    audience: 'Leads · Real Estate',
    status: CampaignStatus.scheduled,
    sent: 0,
    replies: '0 replies',
    createdBy: 'Tejas Gokhe',
    createdByInitials: 'TG',
  ),
  SmsCampaign(
    name: 'Warm lead drip SMS',
    type: 'Automated',
    message: 'Hi {{first_name}}, still exploring opti…',
    audience: 'Leads · Mortgage · Warm',
    status: CampaignStatus.running,
    sent: 64,
    deliveredPct: '95%',
    replies: '9 replies',
    createdBy: 'John Smith',
    createdByInitials: 'JS',
  ),
];

class WaCampaign {
  final String name;
  final String template;
  final String approvalLabel;
  final Color approvalBg;
  final Color approvalFg;
  final String audience;
  final CampaignStatus status;
  final String sentRead;
  final String createdBy;
  final String createdByInitials;
  const WaCampaign({
    required this.name,
    required this.template,
    required this.approvalLabel,
    required this.approvalBg,
    required this.approvalFg,
    required this.audience,
    required this.status,
    required this.sentRead,
    required this.createdBy,
    required this.createdByInitials,
  });
}

const kWaCampaigns = <WaCampaign>[
  WaCampaign(
    name: 'Appointment reminders: this w…',
    template: 'appointment_reminder_v1',
    approvalLabel: 'Approved',
    approvalBg: AppColors.successBg,
    approvalFg: AppColors.successFg,
    audience: 'Meetings · Tomorrow',
    status: CampaignStatus.completed,
    sentRead: '18 / 14 (78%)',
    createdBy: 'John Smith',
    createdByInitials: 'JS',
  ),
  WaCampaign(
    name: 'Rate window promo',
    template: 'promo_rate_alert_v1',
    approvalLabel: 'Pending Meta',
    approvalBg: AppColors.warningBg,
    approvalFg: AppColors.warningFg,
    audience: 'Leads · Mortgage · Warm',
    status: CampaignStatus.draft,
    sentRead: '0 / 0 ()',
    createdBy: 'Tejas Gokhe',
    createdByInitials: 'TG',
  ),
  WaCampaign(
    name: 'Document request nudge',
    template: 'doc_request_v1',
    approvalLabel: 'Draft',
    approvalBg: AppColors.neutralBg,
    approvalFg: AppColors.neutralFg,
    audience: 'Document Requests · Pen…',
    status: CampaignStatus.draft,
    sentRead: '0 / 0 ()',
    createdBy: 'Roshna Abraham',
    createdByInitials: 'RA',
  ),
];

class FormEntry {
  final String name;
  final String url;
  final String routesTo;
  final Color routesBg;
  final Color routesFg;
  final bool journey;
  final CampaignStatus status;
  final int fields;
  final int submissions;
  final String updated;
  const FormEntry({
    required this.name,
    required this.url,
    required this.routesTo,
    required this.routesBg,
    required this.routesFg,
    required this.journey,
    required this.status,
    required this.fields,
    required this.submissions,
    required this.updated,
  });
}

const kForms = <FormEntry>[
  FormEntry(
    name: 'Lead capture: home loan',
    url: '/f/home-loan-lead',
    routesTo: 'Lead',
    routesBg: AppColors.primarySoft,
    routesFg: AppColors.primary,
    journey: true,
    status: CampaignStatus.live,
    fields: 9,
    submissions: 312,
    updated: '18/07/2026',
  ),
  FormEntry(
    name: 'Support intake: document issue',
    url: '/f/doc-intake',
    routesTo: 'Ticket',
    routesBg: AppColors.dangerBg,
    routesFg: AppColors.dangerFg,
    journey: false,
    status: CampaignStatus.live,
    fields: 5,
    submissions: 94,
    updated: '15/07/2026',
  ),
  FormEntry(
    name: 'Event RSVP: broker breakfast',
    url: '/f/broker-breakfast',
    routesTo: 'Contact',
    routesBg: AppColors.warningBg,
    routesFg: AppColors.warningFg,
    journey: false,
    status: CampaignStatus.draft,
    fields: 6,
    submissions: 0,
    updated: '20/07/2026',
  ),
];

class BrokerPage {
  final String name;
  final String url;
  final CampaignStatus status;
  final int links;
  final int views;
  final String owner;
  const BrokerPage({
    required this.name,
    required this.url,
    required this.status,
    required this.links,
    required this.views,
    required this.owner,
  });
}

const kBrokerPages = <BrokerPage>[
  BrokerPage(
    name: 'John Smith',
    url: '/l/john-smith',
    status: CampaignStatus.live,
    links: 3,
    views: 1840,
    owner: 'John Smith',
  ),
  BrokerPage(
    name: 'FinConnex Sydney',
    url: '/l/sydney',
    status: CampaignStatus.live,
    links: 2,
    views: 620,
    owner: 'Roshna Abraham',
  ),
  BrokerPage(
    name: 'Greystone campaign',
    url: '/l/greystone',
    status: CampaignStatus.draft,
    links: 2,
    views: 0,
    owner: 'Tejas Gokhe',
  ),
];
