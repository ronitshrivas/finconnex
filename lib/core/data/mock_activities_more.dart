import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ─── Calls ──────────────────────────────────────────
enum CallDirection { inbound, outbound }
enum CallOutcome { connected, voicemail, noAnswer, busy }

extension CallOutcomeX on CallOutcome {
  String get label => switch (this) {
        CallOutcome.connected => 'Connected',
        CallOutcome.voicemail => 'Voicemail',
        CallOutcome.noAnswer => 'No answer',
        CallOutcome.busy => 'Busy',
      };
  Color get bg => switch (this) {
        CallOutcome.connected => AppColors.successBg,
        CallOutcome.voicemail => AppColors.warningBg,
        CallOutcome.noAnswer => AppColors.dangerBg,
        CallOutcome.busy => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        CallOutcome.connected => AppColors.successFg,
        CallOutcome.voicemail => AppColors.warningFg,
        CallOutcome.noAnswer => AppColors.dangerFg,
        CallOutcome.busy => AppColors.neutralFg,
      };
}

class CallLog {
  final String id, contact, contactInitials, number, related, owner, when;
  final CallDirection direction;
  final CallOutcome outcome;
  final String duration;
  const CallLog({required this.id, required this.contact, required this.contactInitials, required this.number, required this.related, required this.owner, required this.when, required this.direction, required this.outcome, required this.duration});
}

const kCalls = <CallLog>[
  CallLog(id: 'CAL-3001', contact: 'Priya Mehta', contactInitials: 'PM', number: '+61 400 555 666', related: 'Deal: Greystone renewal', owner: 'Tejas Gokhe', when: 'Today · 10:20', direction: CallDirection.outbound, outcome: CallOutcome.connected, duration: '12m'),
  CallLog(id: 'CAL-3002', contact: 'Marcus Chen', contactInitials: 'MC', number: '+61 400 444 555', related: 'Lead: Harbour Loans', owner: 'John Smith', when: 'Today · 09:15', direction: CallDirection.inbound, outcome: CallOutcome.connected, duration: '6m'),
  CallLog(id: 'CAL-3003', contact: 'Daniel Rossi', contactInitials: 'DR', number: '+61 400 666 777', related: 'Deal: Apex reinstatement', owner: 'Daniel Rossi', when: 'Yesterday · 15:40', direction: CallDirection.outbound, outcome: CallOutcome.voicemail, duration: '1m'),
  CallLog(id: 'CAL-3004', contact: 'Aisha Khan', contactInitials: 'AK', number: '+61 400 333 444', related: 'Lead: Northside', owner: 'Roshna Abraham', when: 'Yesterday · 11:00', direction: CallDirection.outbound, outcome: CallOutcome.noAnswer, duration: '0m'),
  CallLog(id: 'CAL-3005', contact: 'Olivia Bennett', contactInitials: 'OB', number: '+61 400 777 888', related: 'Ticket: Northwind', owner: 'Shiva Kadhka', when: '2 days ago', direction: CallDirection.inbound, outcome: CallOutcome.connected, duration: '18m'),
];

// ─── Emails ─────────────────────────────────────────
enum EmailStatus { sent, opened, clicked, bounced, replied }

extension EmailStatusX on EmailStatus {
  String get label => switch (this) {
        EmailStatus.sent => 'Sent',
        EmailStatus.opened => 'Opened',
        EmailStatus.clicked => 'Clicked',
        EmailStatus.bounced => 'Bounced',
        EmailStatus.replied => 'Replied',
      };
  Color get bg => switch (this) {
        EmailStatus.sent => AppColors.neutralBg,
        EmailStatus.opened => AppColors.infoBg,
        EmailStatus.clicked => AppColors.primarySoft,
        EmailStatus.bounced => AppColors.dangerBg,
        EmailStatus.replied => AppColors.successBg,
      };
  Color get fg => switch (this) {
        EmailStatus.sent => AppColors.mutedForeground,
        EmailStatus.opened => AppColors.infoFg,
        EmailStatus.clicked => AppColors.primary,
        EmailStatus.bounced => AppColors.dangerFg,
        EmailStatus.replied => AppColors.successFg,
      };
}

class EmailLog {
  final String id, subject, to, related, owner, when;
  final EmailStatus status;
  const EmailLog({required this.id, required this.subject, required this.to, required this.related, required this.owner, required this.when, required this.status});
}

const kEmails = <EmailLog>[
  EmailLog(id: 'EMA-4001', subject: 'Greystone renewal — updated proposal', to: 'priya@greystone.example', related: 'Deal: Greystone renewal', owner: 'Tejas Gokhe', when: 'Today · 09:04', status: EmailStatus.replied),
  EmailLog(id: 'EMA-4002', subject: 'Follow-up: your Harbour discovery notes', to: 'marcus@harbour.example', related: 'Lead: Harbour Loans', owner: 'John Smith', when: 'Yesterday · 17:20', status: EmailStatus.opened),
  EmailLog(id: 'EMA-4003', subject: 'Apex reinstatement paperwork', to: 'daniel@apex.example', related: 'Deal: Apex reinstatement', owner: 'Daniel Rossi', when: 'Yesterday · 14:00', status: EmailStatus.clicked),
  EmailLog(id: 'EMA-4004', subject: 'Northside — new mortgage rates', to: 'aisha@northside.example', related: 'Lead: Northside', owner: 'Roshna Abraham', when: '2 days ago', status: EmailStatus.sent),
  EmailLog(id: 'EMA-4005', subject: 'Northwind quote', to: 'olivia@northwind.com', related: 'Deal: Northwind', owner: 'Shiva Kadhka', when: '3 days ago', status: EmailStatus.bounced),
];

// ─── Meetings ───────────────────────────────────────
enum MeetingStatus { scheduled, completed, cancelled, noShow }

extension MeetingStatusX on MeetingStatus {
  String get label => switch (this) {
        MeetingStatus.scheduled => 'Scheduled',
        MeetingStatus.completed => 'Completed',
        MeetingStatus.cancelled => 'Cancelled',
        MeetingStatus.noShow => 'No-show',
      };
  Color get bg => switch (this) {
        MeetingStatus.scheduled => AppColors.infoBg,
        MeetingStatus.completed => AppColors.successBg,
        MeetingStatus.cancelled => AppColors.neutralBg,
        MeetingStatus.noShow => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        MeetingStatus.scheduled => AppColors.infoFg,
        MeetingStatus.completed => AppColors.successFg,
        MeetingStatus.cancelled => AppColors.mutedForeground,
        MeetingStatus.noShow => AppColors.dangerFg,
      };
}

class MeetingLog {
  final String id, title, related, location, when, duration, host, attendees;
  final MeetingStatus status;
  const MeetingLog({required this.id, required this.title, required this.related, required this.location, required this.when, required this.duration, required this.host, required this.attendees, required this.status});
}

const kMeetings = <MeetingLog>[
  MeetingLog(id: 'MTG-2001', title: 'Greystone renewal presentation', related: 'Deal: Greystone renewal', location: 'Boardroom A', when: 'Today · 14:00', duration: '1h', host: 'Tejas Gokhe', attendees: 'Priya Mehta + 2', status: MeetingStatus.scheduled),
  MeetingLog(id: 'MTG-2002', title: 'Harbour discovery call', related: 'Lead: Harbour', location: 'Zoom', when: 'Today · 10:30', duration: '30m', host: 'John Smith', attendees: 'Marcus Chen', status: MeetingStatus.completed),
  MeetingLog(id: 'MTG-2003', title: 'Apex reinstatement discussion', related: 'Deal: Apex reinstatement', location: 'Zoom', when: 'Tomorrow · 09:00', duration: '45m', host: 'Daniel Rossi', attendees: 'Daniel Rossi', status: MeetingStatus.scheduled),
  MeetingLog(id: 'MTG-2004', title: 'Meridian pilot retrospective', related: 'Deal: Meridian pilot', location: 'Boardroom B', when: 'Aug 22 · 15:00', duration: '1h', host: 'Sarah Kim', attendees: 'Team', status: MeetingStatus.cancelled),
];

// ─── Notes ──────────────────────────────────────────
class NoteEntry {
  final String id, title, snippet, related, author, when;
  final List<String> tags;
  const NoteEntry({required this.id, required this.title, required this.snippet, required this.related, required this.author, required this.when, required this.tags});
}

const kNotes = <NoteEntry>[
  NoteEntry(id: 'NOT-1001', title: 'Greystone: hesitant on 24-month term', snippet: 'CFO prefers 12-month with easier exit. Willing to bump price 8% for flexibility.', related: 'Deal: Greystone renewal', author: 'Tejas Gokhe', when: '1h ago', tags: ['pricing', 'objection']),
  NoteEntry(id: 'NOT-1002', title: 'Harbour: mentioned Xero integration', snippet: 'They asked for Xero data sync — flagged as future roadmap item, not current.', related: 'Lead: Harbour Loans', author: 'John Smith', when: 'Today', tags: ['integration']),
  NoteEntry(id: 'NOT-1003', title: 'Northside compliance notes', snippet: 'AFCA registration confirmed. Need broker authority form countersigned.', related: 'Lead: Northside', author: 'Roshna Abraham', when: 'Yesterday', tags: ['compliance', 'docs']),
  NoteEntry(id: 'NOT-1004', title: 'Apex — key stakeholder change', snippet: 'Daniel replaced by his COO as decision-maker. Restart discovery.', related: 'Deal: Apex reinstatement', author: 'Daniel Rossi', when: '2d ago', tags: ['stakeholder']),
];

// ─── Attachments ────────────────────────────────────
class Attachment {
  final String id, filename, size, ext, related, uploadedBy, when;
  const Attachment({required this.id, required this.filename, required this.size, required this.ext, required this.related, required this.uploadedBy, required this.when});
}

const kAttachments = <Attachment>[
  Attachment(id: 'ATT-6001', filename: 'Greystone_Proposal_v2.pdf', size: '1.4 MB', ext: 'pdf', related: 'Deal: Greystone renewal', uploadedBy: 'Tejas Gokhe', when: 'Today'),
  Attachment(id: 'ATT-6002', filename: 'Harbour_discovery_notes.docx', size: '86 KB', ext: 'docx', related: 'Lead: Harbour Loans', uploadedBy: 'John Smith', when: 'Today'),
  Attachment(id: 'ATT-6003', filename: 'Northside_broker_form.pdf', size: '420 KB', ext: 'pdf', related: 'Lead: Northside', uploadedBy: 'Roshna Abraham', when: 'Yesterday'),
  Attachment(id: 'ATT-6004', filename: 'Apex_org_chart.png', size: '210 KB', ext: 'png', related: 'Deal: Apex reinstatement', uploadedBy: 'Daniel Rossi', when: '2d ago'),
  Attachment(id: 'ATT-6005', filename: 'Meridian_pilot_final.xlsx', size: '92 KB', ext: 'xlsx', related: 'Deal: Meridian pilot', uploadedBy: 'Sarah Kim', when: '4d ago'),
];

// ─── Reminders ──────────────────────────────────────
enum ReminderPriority { high, normal, low }

extension ReminderPriorityX on ReminderPriority {
  String get label => switch (this) {
        ReminderPriority.high => 'High',
        ReminderPriority.normal => 'Normal',
        ReminderPriority.low => 'Low',
      };
  Color get color => switch (this) {
        ReminderPriority.high => AppColors.dangerFg,
        ReminderPriority.normal => AppColors.warningFg,
        ReminderPriority.low => AppColors.mutedForeground,
      };
}

class Reminder {
  final String id, title, related, owner, dueDate, dueTime;
  final ReminderPriority priority;
  final bool completed;
  const Reminder({required this.id, required this.title, required this.related, required this.owner, required this.dueDate, required this.dueTime, required this.priority, required this.completed});
}

const kReminders = <Reminder>[
  Reminder(id: 'REM-7001', title: 'Follow up on Greystone renewal', related: 'Deal: Greystone renewal', owner: 'Tejas Gokhe', dueDate: 'Today', dueTime: '16:00', priority: ReminderPriority.high, completed: false),
  Reminder(id: 'REM-7002', title: 'Send Harbour final quote', related: 'Lead: Harbour Loans', owner: 'John Smith', dueDate: 'Today', dueTime: '17:30', priority: ReminderPriority.high, completed: false),
  Reminder(id: 'REM-7003', title: 'Review Northside compliance forms', related: 'Lead: Northside', owner: 'Roshna Abraham', dueDate: 'Tomorrow', dueTime: '10:00', priority: ReminderPriority.normal, completed: false),
  Reminder(id: 'REM-7004', title: 'Apex kickoff prep', related: 'Deal: Apex reinstatement', owner: 'Daniel Rossi', dueDate: 'Aug 20', dueTime: '09:00', priority: ReminderPriority.normal, completed: false),
  Reminder(id: 'REM-7005', title: 'Confirm Meridian invoice paid', related: 'Deal: Meridian pilot', owner: 'Sarah Kim', dueDate: 'Aug 15', dueTime: '—', priority: ReminderPriority.low, completed: true),
];
