import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ChatThread {
  final String id;
  final String name;
  final String initials;
  final Color avatarBg;
  final Color avatarFg;
  final String preview;
  final String time;
  final int unread;
  final bool online;
  const ChatThread({
    required this.id,
    required this.name,
    required this.initials,
    required this.avatarBg,
    required this.avatarFg,
    required this.preview,
    required this.time,
    required this.unread,
    required this.online,
  });
}

const kChatThreads = <ChatThread>[
  ChatThread(id: 't1', name: 'Priya Mehta', initials: 'PM', avatarBg: AppColors.primarySoft, avatarFg: AppColors.primary, preview: 'Just sent the Greystone updates — ready when you are.', time: '2m', unread: 2, online: true),
  ChatThread(id: 't2', name: 'Marcus Chen', initials: 'MC', avatarBg: AppColors.warningBg, avatarFg: AppColors.warningFg, preview: 'Harbour proposal reviewed. A couple of notes inside.', time: '18m', unread: 1, online: true),
  ChatThread(id: 't3', name: 'Tejas Gokhe', initials: 'TG', avatarBg: AppColors.infoBg, avatarFg: AppColors.infoFg, preview: 'Signed engagement letter came back — filed under Deals.', time: '1h', unread: 0, online: false),
  ChatThread(id: 't4', name: 'Roshna Abraham', initials: 'RA', avatarBg: AppColors.successBg, avatarFg: AppColors.successFg, preview: 'Compliance report draft attached, take a look.', time: '3h', unread: 0, online: true),
  ChatThread(id: 't5', name: 'Team · Sales floor', initials: 'SF', avatarBg: AppColors.neutralBg, avatarFg: AppColors.neutralFg, preview: 'Sarah: standup rescheduled to 10:15', time: 'Yesterday', unread: 0, online: false),
];

class ChatMsg {
  final String author;
  final String? initials;
  final String body;
  final String time;
  final bool mine;
  const ChatMsg({required this.author, this.initials, required this.body, required this.time, required this.mine});
}

const kActiveChat = <ChatMsg>[
  ChatMsg(author: 'Priya Mehta', initials: 'PM', body: 'Hey — I pushed the Greystone renewal changes we discussed.', time: '10:04 AM', mine: false),
  ChatMsg(author: 'You', body: 'Nice, thanks. Value went up a bit — did they confirm?', time: '10:06 AM', mine: true),
  ChatMsg(author: 'Priya Mehta', initials: 'PM', body: 'Yes, they signed off this morning. Final \$48,200.', time: '10:09 AM', mine: false),
  ChatMsg(author: 'Priya Mehta', initials: 'PM', body: 'Just sent the Greystone updates — ready when you are.', time: '10:11 AM', mine: false),
];

// ─── Calendar ─────────────────────────────────────────────────────

class CalEvent {
  final String time;
  final String title;
  final String subtitle;
  final Color color;
  const CalEvent({required this.time, required this.title, required this.subtitle, required this.color});
}

const kTodayEvents = <CalEvent>[
  CalEvent(time: '09:00', title: 'Standup — sales floor', subtitle: 'Boardroom A · 30m', color: AppColors.primary),
  CalEvent(time: '10:30', title: 'Discovery call: Harbour Loans', subtitle: 'Marcus Chen · Zoom', color: AppColors.infoFg),
  CalEvent(time: '14:00', title: 'Greystone renewal presentation', subtitle: 'Priya Mehta · Boardroom B', color: AppColors.successFg),
  CalEvent(time: '16:15', title: 'Compliance review', subtitle: 'Roshna Abraham · Meeting Room 1', color: AppColors.warningFg),
];

const kUpcomingDays = <(String, List<CalEvent>)>[
  ('Tomorrow · Aug 19', [
    CalEvent(time: '09:00', title: 'Apex reinstatement discussion', subtitle: 'Daniel Rossi · Zoom', color: AppColors.warningFg),
    CalEvent(time: '14:00', title: 'Harbour onboarding kickoff', subtitle: 'Marcus Chen · Meeting Room 3', color: AppColors.successFg),
  ]),
  ('Wed · Aug 20', [
    CalEvent(time: '11:00', title: 'Internal ops sync', subtitle: 'John Smith · Meeting Room 1', color: AppColors.primary),
  ]),
];
