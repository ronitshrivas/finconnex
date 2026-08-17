import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum ActivityType { call, meeting, email, task, note }

class ActivityEntry {
  final String id;
  final ActivityType type;
  final String title;
  final String related;
  final String owner;
  final String ownerInitials;
  final String date;
  final String time;
  final bool done;
  const ActivityEntry({
    required this.id,
    required this.type,
    required this.title,
    required this.related,
    required this.owner,
    required this.ownerInitials,
    required this.date,
    required this.time,
    required this.done,
  });
}

extension ActivityTypeX on ActivityType {
  String get label => switch (this) {
        ActivityType.call => 'Call',
        ActivityType.meeting => 'Meeting',
        ActivityType.email => 'Email',
        ActivityType.task => 'Task',
        ActivityType.note => 'Note',
      };
  IconData get icon => switch (this) {
        ActivityType.call => Icons.phone_outlined,
        ActivityType.meeting => Icons.groups_outlined,
        ActivityType.email => Icons.mail_outline,
        ActivityType.task => Icons.check_circle_outline,
        ActivityType.note => Icons.sticky_note_2_outlined,
      };
  Color get bg => switch (this) {
        ActivityType.call => AppColors.infoBg,
        ActivityType.meeting => AppColors.primarySoft,
        ActivityType.email => AppColors.warningBg,
        ActivityType.task => AppColors.successBg,
        ActivityType.note => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        ActivityType.call => AppColors.infoFg,
        ActivityType.meeting => AppColors.primary,
        ActivityType.email => AppColors.warningFg,
        ActivityType.task => AppColors.successFg,
        ActivityType.note => AppColors.neutralFg,
      };
}

const kMockActivities = <ActivityEntry>[
  ActivityEntry(
    id: 'ACT-4801',
    type: ActivityType.call,
    title: 'Discovery call with Harbour Loans',
    related: 'DEA-9022 · Marcus Chen',
    owner: 'John Smith',
    ownerInitials: 'JS',
    date: 'Today',
    time: '10:30 AM',
    done: false,
  ),
  ActivityEntry(
    id: 'ACT-4802',
    type: ActivityType.meeting,
    title: 'Greystone renewal presentation',
    related: 'DEA-9021 · Priya Mehta',
    owner: 'Priya Mehta',
    ownerInitials: 'PM',
    date: 'Today',
    time: '2:00 PM',
    done: false,
  ),
  ActivityEntry(
    id: 'ACT-4803',
    type: ActivityType.email,
    title: 'Send Apex reinstatement proposal',
    related: 'DEA-9024 · Daniel Rossi',
    owner: 'Daniel Rossi',
    ownerInitials: 'DR',
    date: 'Tomorrow',
    time: '9:00 AM',
    done: false,
  ),
  ActivityEntry(
    id: 'ACT-4804',
    type: ActivityType.task,
    title: 'Prepare compliance summary',
    related: 'WQ-2044',
    owner: 'John Smith',
    ownerInitials: 'JS',
    date: 'Aug 20',
    time: 'All day',
    done: false,
  ),
  ActivityEntry(
    id: 'ACT-4805',
    type: ActivityType.note,
    title: 'Meridian pilot debrief notes',
    related: 'DEA-9025 · Sarah Kim',
    owner: 'Sarah Kim',
    ownerInitials: 'SK',
    date: 'Aug 15',
    time: '4:15 PM',
    done: true,
  ),
];
