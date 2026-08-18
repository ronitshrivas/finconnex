import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ─── Team ─────────────────────────────────────────────────────────
class TeamStat {
  final String label;
  final String value;
  final String? delta;
  final String? sub;
  const TeamStat({required this.label, required this.value, this.delta, this.sub});
}

const kTeamStats = <TeamStat>[
  TeamStat(label: 'Total Team Members', value: '12,354', delta: '+12.1%', sub: 'Vs last month: 8,554'),
  TeamStat(label: 'New Team Members', value: '4,544', delta: '+18.6%'),
  TeamStat(label: 'Customer Satisfaction', value: '94%', delta: '+12.1%', sub: 'Vs last month: 20%'),
];

// ─── Support ──────────────────────────────────────────────────────
enum TicketPriority { high, medium, low, critical }
enum TicketStatus { newT, open, inProgress, pending, resolved, closed, reopened }

extension TicketPriorityX on TicketPriority {
  String get label => switch (this) {
        TicketPriority.high => 'High',
        TicketPriority.medium => 'Medium',
        TicketPriority.low => 'Low',
        TicketPriority.critical => 'Critical',
      };
  Color get color => switch (this) {
        TicketPriority.high => AppColors.dangerFg,
        TicketPriority.medium => AppColors.warningFg,
        TicketPriority.low => AppColors.mutedForeground,
        TicketPriority.critical => AppColors.dangerFg,
      };
}

extension TicketStatusX on TicketStatus {
  String get label => switch (this) {
        TicketStatus.newT => 'New',
        TicketStatus.open => 'Open',
        TicketStatus.inProgress => 'In Progress',
        TicketStatus.pending => 'Pending',
        TicketStatus.resolved => 'Resolved',
        TicketStatus.closed => 'Closed',
        TicketStatus.reopened => 'Reopened',
      };
  Color get bg => switch (this) {
        TicketStatus.newT => AppColors.primarySoft,
        TicketStatus.open => AppColors.infoBg,
        TicketStatus.inProgress => AppColors.warningBg,
        TicketStatus.pending => AppColors.warningBg,
        TicketStatus.resolved => AppColors.successBg,
        TicketStatus.closed => AppColors.neutralBg,
        TicketStatus.reopened => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        TicketStatus.newT => AppColors.primary,
        TicketStatus.open => AppColors.infoFg,
        TicketStatus.inProgress => AppColors.primary,
        TicketStatus.pending => AppColors.warningFg,
        TicketStatus.resolved => AppColors.successFg,
        TicketStatus.closed => AppColors.mutedForeground,
        TicketStatus.reopened => AppColors.dangerFg,
      };
}

class Ticket {
  final String id;
  final String subject;
  final String requester;
  final String requesterCompany;
  final TicketPriority priority;
  final TicketStatus status;
  final String assignee;
  final String category;
  final int? rating;
  const Ticket({
    required this.id, required this.subject, required this.requester, required this.requesterCompany,
    required this.priority, required this.status, required this.assignee, required this.category, this.rating,
  });
}

const kTickets = <Ticket>[
  Ticket(id: 'TKT-5001', subject: 'Portal login fails after refinance close', requester: 'Priya Mehta', requesterCompany: 'Greystone Realty', priority: TicketPriority.high, status: TicketStatus.inProgress, assignee: 'John Smith', category: 'Technical'),
  Ticket(id: 'TKT-5002', subject: 'Invoice PDF missing line-item tax', requester: 'Marcus Chen', requesterCompany: 'Harbour Loans', priority: TicketPriority.medium, status: TicketStatus.pending, assignee: 'Tejas Gokhe', category: 'Billing'),
  Ticket(id: 'TKT-5003', subject: 'Request: WhatsApp template for settlement day', requester: 'Aisha Khan', requesterCompany: 'Northside Mortgage', priority: TicketPriority.low, status: TicketStatus.newT, assignee: '', category: 'Feature Request'),
  Ticket(id: 'TKT-5004', subject: 'E-signature link expired for engagement letter', requester: 'Daniel Rossi', requesterCompany: 'Apex Property Group', priority: TicketPriority.critical, status: TicketStatus.resolved, assignee: 'Shiva Kadhka', category: 'Bug', rating: 4),
  Ticket(id: 'TKT-5005', subject: 'Document request reminder emails bouncing', requester: 'Olivia Bennett', requesterCompany: 'Northwind Traders', priority: TicketPriority.high, status: TicketStatus.closed, assignee: 'Roshna Abraham', category: 'Technical', rating: 5),
  Ticket(id: 'TKT-5006', subject: 'General: how to export campaign report', requester: 'Marcus Chen', requesterCompany: 'Harbour Loans', priority: TicketPriority.low, status: TicketStatus.open, assignee: 'John Smith', category: 'General'),
];

// ─── Time Tracking ────────────────────────────────────────────────
enum TimeStatus { draft, running, logged, submitted, approved, invoiced, rejected }

extension TimeStatusX on TimeStatus {
  String get label => switch (this) {
        TimeStatus.draft => 'Draft',
        TimeStatus.running => 'Running',
        TimeStatus.logged => 'Logged',
        TimeStatus.submitted => 'Submitted',
        TimeStatus.approved => 'Approved',
        TimeStatus.invoiced => 'Invoiced',
        TimeStatus.rejected => 'Rejected',
      };
  Color get bg => switch (this) {
        TimeStatus.draft => AppColors.neutralBg,
        TimeStatus.running => AppColors.warningBg,
        TimeStatus.logged => AppColors.infoBg,
        TimeStatus.submitted => AppColors.warningBg,
        TimeStatus.approved => AppColors.successBg,
        TimeStatus.invoiced => AppColors.primarySoft,
        TimeStatus.rejected => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        TimeStatus.draft => AppColors.mutedForeground,
        TimeStatus.running => AppColors.warningFg,
        TimeStatus.logged => AppColors.infoFg,
        TimeStatus.submitted => AppColors.warningFg,
        TimeStatus.approved => AppColors.successFg,
        TimeStatus.invoiced => AppColors.primary,
        TimeStatus.rejected => AppColors.dangerFg,
      };
}

class TimeEntry {
  final String id;
  final String relatedType;
  final String relatedTitle;
  final String user;
  final String date;
  final String duration;
  final bool billable;
  final String rate;
  final String amount;
  final TimeStatus status;
  final String description;
  const TimeEntry({
    required this.id, required this.relatedType, required this.relatedTitle,
    required this.user, required this.date, required this.duration, required this.billable,
    required this.rate, required this.amount, required this.status, required this.description,
  });
}

const kTimeEntries = <TimeEntry>[
  TimeEntry(id: 'TE-7001', relatedType: 'Deal', relatedTitle: 'Greystone refinance package', user: 'John Smith', date: '18/07/2026', duration: '2h 30m', billable: true, rate: '\$280.00/h', amount: '\$700.00', status: TimeStatus.approved, description: 'Client discovery call and file re…'),
  TimeEntry(id: 'TE-7002', relatedType: 'Matter', relatedTitle: 'Anderson: refinance matter', user: 'Roshna Abraham', date: '19/07/2026', duration: '1h 15m', billable: true, rate: '\$220.00/h', amount: '\$275.00', status: TimeStatus.submitted, description: 'Draft engagement letter and co…'),
  TimeEntry(id: 'TE-7003', relatedType: 'Ticket', relatedTitle: 'TKT-5001: Portal login issue', user: 'Tejas Gokhe', date: '20/07/2026', duration: '45m', billable: false, rate: '\$250.00/h', amount: '', status: TimeStatus.logged, description: 'Internal triage: non-billable sup…'),
  TimeEntry(id: 'TE-7004', relatedType: 'Project', relatedTitle: 'Agency retainer: Apex', user: 'Shiva Kadhka', date: '21/07/2026', duration: '3h', billable: true, rate: '\$200.00/h', amount: '\$600.00', status: TimeStatus.approved, description: 'Agency retainer: weekly creati…'),
  TimeEntry(id: 'TE-7005', relatedType: 'Deal', relatedTitle: 'Harbour first-home buyer', user: 'John Smith', date: '22/07/2026', duration: '1h', billable: true, rate: '\$280.00/h', amount: '\$280.00', status: TimeStatus.invoiced, description: 'Lender application packaging'),
  TimeEntry(id: 'TE-7006', relatedType: 'Project', relatedTitle: 'Q3 broker enablement', user: 'Tejas Gokhe', date: '18/08/2026', duration: '0m', billable: true, rate: '\$250.00/h', amount: '\$0.00', status: TimeStatus.draft, description: 'Enablement workshop prep'),
];

// ─── Reports ──────────────────────────────────────────────────────
enum ReportType { lead, revenue, pipeline, custom, activity }
enum ReportStatus { ready, scheduled, draft, running }

extension ReportTypeX on ReportType {
  String get label => switch (this) {
        ReportType.lead => 'Lead',
        ReportType.revenue => 'Revenue',
        ReportType.pipeline => 'Pipeline',
        ReportType.custom => 'Custom',
        ReportType.activity => 'Activity',
      };
  Color get bg => switch (this) {
        ReportType.lead => AppColors.primarySoft,
        ReportType.revenue => AppColors.successBg,
        ReportType.pipeline => AppColors.warningBg,
        ReportType.custom => AppColors.neutralBg,
        ReportType.activity => AppColors.warningBg,
      };
  Color get fg => switch (this) {
        ReportType.lead => AppColors.primary,
        ReportType.revenue => AppColors.successFg,
        ReportType.pipeline => AppColors.warningFg,
        ReportType.custom => AppColors.neutralFg,
        ReportType.activity => AppColors.warningFg,
      };
}

extension ReportStatusX on ReportStatus {
  String get label => switch (this) {
        ReportStatus.ready => 'Ready',
        ReportStatus.scheduled => 'Scheduled',
        ReportStatus.draft => 'Draft',
        ReportStatus.running => 'Running',
      };
  Color get bg => switch (this) {
        ReportStatus.ready => AppColors.successBg,
        ReportStatus.scheduled => AppColors.infoBg,
        ReportStatus.draft => AppColors.neutralBg,
        ReportStatus.running => AppColors.warningBg,
      };
  Color get fg => switch (this) {
        ReportStatus.ready => AppColors.successFg,
        ReportStatus.scheduled => AppColors.infoFg,
        ReportStatus.draft => AppColors.mutedForeground,
        ReportStatus.running => AppColors.warningFg,
      };
}

class ReportEntry {
  final String id;
  final String name;
  final ReportType type;
  final String source;
  final String range;
  final String schedule;
  final ReportStatus status;
  final String createdBy;
  final String? lastRun;
  const ReportEntry({
    required this.id, required this.name, required this.type, required this.source,
    required this.range, required this.schedule, required this.status,
    required this.createdBy, this.lastRun,
  });
}

const kReports = <ReportEntry>[
  ReportEntry(id: 'RPT-6001', name: 'Monthly lead funnel', type: ReportType.lead, source: 'Leads', range: 'Last 30 days', schedule: 'Monthly', status: ReportStatus.ready, createdBy: 'John Smith', lastRun: '20/07/2026 08:00'),
  ReportEntry(id: 'RPT-6002', name: 'Q3 revenue collected', type: ReportType.revenue, source: 'Invoices', range: 'This quarter', schedule: 'Weekly', status: ReportStatus.scheduled, createdBy: 'Tejas Gokhe', lastRun: '19/07/2026 09:00'),
  ReportEntry(id: 'RPT-6003', name: 'Pipeline by stage', type: ReportType.pipeline, source: 'Deals', range: 'This year', schedule: 'None', status: ReportStatus.ready, createdBy: 'Roshna Abraham', lastRun: '18/07/2026 14:30'),
  ReportEntry(id: 'RPT-6004', name: 'Support resolution draft', type: ReportType.custom, source: 'Support Tickets', range: 'Last 30 days', schedule: 'None', status: ReportStatus.draft, createdBy: 'Shiva Kadhka'),
  ReportEntry(id: 'RPT-6005', name: 'Activity load by owner', type: ReportType.activity, source: 'Activities', range: 'Last 7 days', schedule: 'Daily', status: ReportStatus.ready, createdBy: 'John Smith', lastRun: '21/07/2026 07:00'),
];

// ─── Analytics ────────────────────────────────────────────────────
class AnalyticsKpi {
  final String label;
  final String value;
  final String delta;
  final Color deltaColor;
  final String target;
  final bool onTrack;
  const AnalyticsKpi({
    required this.label, required this.value, required this.delta, required this.deltaColor,
    required this.target, required this.onTrack,
  });
}

const kAnalyticsKpis = <AnalyticsKpi>[
  AnalyticsKpi(label: 'LEAD CONVERSION RATE', value: '21%', delta: '+2.4%', deltaColor: AppColors.successFg, target: 'Target 20%', onTrack: true),
  AnalyticsKpi(label: 'DEAL WIN RATE', value: '28%', delta: '+1.1%', deltaColor: AppColors.successFg, target: 'Target 25%', onTrack: true),
  AnalyticsKpi(label: 'AVERAGE DEAL SIZE', value: '\$86,400', delta: '-3.2%', deltaColor: AppColors.dangerFg, target: 'Target \$80,000', onTrack: true),
  AnalyticsKpi(label: 'SALES CYCLE LENGTH', value: '34 days', delta: '-2 days', deltaColor: AppColors.successFg, target: 'Target 40 days', onTrack: true),
  AnalyticsKpi(label: 'PIPELINE VELOCITY', value: '\$6,000/wk', delta: '+8%', deltaColor: AppColors.successFg, target: 'Target \$35,000', onTrack: false),
  AnalyticsKpi(label: 'ACTIVITIES COMPLETED', value: '178', delta: '+12%', deltaColor: AppColors.successFg, target: 'Target 150', onTrack: true),
  AnalyticsKpi(label: 'TASKS OVERDUE RATE', value: '9%', delta: '-1.5%', deltaColor: AppColors.successFg, target: 'Target 12%', onTrack: true),
  AnalyticsKpi(label: 'EMAIL OPEN RATE', value: '38%', delta: '+0.8%', deltaColor: AppColors.successFg, target: 'Target 35%', onTrack: true),
  AnalyticsKpi(label: 'CAMPAIGN ROI', value: '2.4x', delta: '+0.3x', deltaColor: AppColors.successFg, target: 'Target 2x', onTrack: true),
  AnalyticsKpi(label: 'SUPPORT TICKET RESOLUTION TIME', value: '17 hrs', delta: '-2.1 hrs', deltaColor: AppColors.successFg, target: 'Target 24 hrs', onTrack: true),
  AnalyticsKpi(label: 'CUSTOMER SATISFACTION SCORE', value: '4.5 / 5', delta: '+0.2', deltaColor: AppColors.successFg, target: 'Target 4.2 / 5', onTrack: true),
];

const kRevenueSources = [
  ('Referral', 32, AppColors.primary),
  ('Website', 28, AppColors.successFg),
  ('Campaign', 22, AppColors.warningFg),
  ('Partner', 12, AppColors.infoFg),
  ('Other', 6, AppColors.mutedForeground),
];

// ─── Resources ────────────────────────────────────────────────────
enum ResType { document, guide, video, template, image, faq, link }
enum ResAccess { internal, restricted, public }

extension ResTypeX on ResType {
  String get label => switch (this) {
        ResType.document => 'Document', ResType.guide => 'Guide', ResType.video => 'Video',
        ResType.template => 'Template', ResType.image => 'Image', ResType.faq => 'FAQ', ResType.link => 'Link',
      };
  Color get bg => switch (this) {
        ResType.document => AppColors.primarySoft, ResType.guide => AppColors.dangerBg,
        ResType.video => AppColors.neutralBg, ResType.template => AppColors.infoBg,
        ResType.image => AppColors.warningBg, ResType.faq => AppColors.successBg, ResType.link => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        ResType.document => AppColors.primary, ResType.guide => AppColors.dangerFg,
        ResType.video => AppColors.neutralFg, ResType.template => AppColors.infoFg,
        ResType.image => AppColors.warningFg, ResType.faq => AppColors.successFg, ResType.link => AppColors.neutralFg,
      };
}

extension ResAccessX on ResAccess {
  String get label => switch (this) { ResAccess.internal => 'Internal', ResAccess.restricted => 'Restricted', ResAccess.public => 'Public' };
  Color get bg => switch (this) { ResAccess.internal => AppColors.primarySoft, ResAccess.restricted => AppColors.dangerBg, ResAccess.public => AppColors.successBg };
  Color get fg => switch (this) { ResAccess.internal => AppColors.primary, ResAccess.restricted => AppColors.dangerFg, ResAccess.public => AppColors.successFg };
}

class Resource {
  final String id;
  final String name;
  final String description;
  final List<String> tags;
  final ResType type;
  final String category;
  final ResAccess access;
  final String uploadedBy;
  final String date;
  final int downloads;
  const Resource({
    required this.id, required this.name, required this.description, required this.tags,
    required this.type, required this.category, required this.access, required this.uploadedBy,
    required this.date, required this.downloads,
  });
}

const kResources = <Resource>[
  Resource(id: 'RES-4001', name: 'Home loan pitch deck (Jul 2026)', description: '', tags: ['pitch', 'home-loan', 'collateral'], type: ResType.document, category: 'Sales', access: ResAccess.internal, uploadedBy: 'John Smith', date: '01/07/2026', downloads: 48),
  Resource(id: 'RES-4002', name: 'First-home buyer playbook', description: '', tags: ['playbook', 'first-home', 'training'], type: ResType.guide, category: 'Training', access: ResAccess.internal, uploadedBy: 'Roshna Abraham', date: '08/07/2026', downloads: 31),
  Resource(id: 'RES-4003', name: 'Product overview video', description: '', tags: ['video', 'onboarding'], type: ResType.video, category: 'Product', access: ResAccess.internal, uploadedBy: 'Tejas Gokhe', date: '12/07/2026', downloads: 19),
  Resource(id: 'RES-4004', name: 'Engagement letter template', description: '', tags: ['template', 'legal', 'engagement'], type: ResType.template, category: 'Legal', access: ResAccess.restricted, uploadedBy: 'Shiva Kadhka', date: '15/07/2026', downloads: 12),
  Resource(id: 'RES-4005', name: 'Marketing brand kit', description: '', tags: ['brand', 'assets'], type: ResType.image, category: 'Marketing', access: ResAccess.internal, uploadedBy: 'Tejas Gokhe', date: '18/07/2026', downloads: 22),
  Resource(id: 'RES-4006', name: 'Refinance FAQ for clients', description: '', tags: ['faq', 'refinance', 'client'], type: ResType.faq, category: 'Support', access: ResAccess.public, uploadedBy: 'John Smith', date: '20/07/2026', downloads: 67),
  Resource(id: 'RES-4007', name: 'Compliance checklist link', description: '', tags: ['compliance', 'checklist'], type: ResType.link, category: 'Legal', access: ResAccess.restricted, uploadedBy: 'Shiva Kadhka', date: '21/07/2026', downloads: 8),
];
