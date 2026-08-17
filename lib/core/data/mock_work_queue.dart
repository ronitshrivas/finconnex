import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum WorkPriority { high, medium, low }

enum WorkStatus { todo, inProgress, blocked, done }

class WorkItem {
  final String id;
  final String title;
  final String client;
  final WorkPriority priority;
  final WorkStatus status;
  final String assignee;
  final String assigneeInitials;
  final String due;
  const WorkItem({
    required this.id,
    required this.title,
    required this.client,
    required this.priority,
    required this.status,
    required this.assignee,
    required this.assigneeInitials,
    required this.due,
  });
}

extension WorkPriorityX on WorkPriority {
  String get label => switch (this) {
        WorkPriority.high => 'High',
        WorkPriority.medium => 'Medium',
        WorkPriority.low => 'Low',
      };
  Color get bg => switch (this) {
        WorkPriority.high => AppColors.dangerBg,
        WorkPriority.medium => AppColors.warningBg,
        WorkPriority.low => AppColors.neutralBg,
      };
  Color get fg => switch (this) {
        WorkPriority.high => AppColors.dangerFg,
        WorkPriority.medium => AppColors.warningFg,
        WorkPriority.low => AppColors.neutralFg,
      };
}

extension WorkStatusX on WorkStatus {
  String get label => switch (this) {
        WorkStatus.todo => 'To do',
        WorkStatus.inProgress => 'In progress',
        WorkStatus.blocked => 'Blocked',
        WorkStatus.done => 'Done',
      };
  Color get bg => switch (this) {
        WorkStatus.todo => AppColors.neutralBg,
        WorkStatus.inProgress => AppColors.infoBg,
        WorkStatus.blocked => AppColors.dangerBg,
        WorkStatus.done => AppColors.successBg,
      };
  Color get fg => switch (this) {
        WorkStatus.todo => AppColors.neutralFg,
        WorkStatus.inProgress => AppColors.infoFg,
        WorkStatus.blocked => AppColors.dangerFg,
        WorkStatus.done => AppColors.successFg,
      };
}

const kMockWorkItems = <WorkItem>[
  WorkItem(
    id: 'WQ-2041',
    title: 'Renew Greystone service agreement',
    client: 'Greystone Realty',
    priority: WorkPriority.high,
    status: WorkStatus.inProgress,
    assignee: 'Priya Mehta',
    assigneeInitials: 'PM',
    due: 'Aug 22',
  ),
  WorkItem(
    id: 'WQ-2042',
    title: 'Onboarding call with Harbour Loans',
    client: 'Harbour Loans',
    priority: WorkPriority.medium,
    status: WorkStatus.todo,
    assignee: 'Marcus Chen',
    assigneeInitials: 'MC',
    due: 'Aug 23',
  ),
  WorkItem(
    id: 'WQ-2043',
    title: 'Follow up on Apex suspension review',
    client: 'Apex Property Group',
    priority: WorkPriority.high,
    status: WorkStatus.blocked,
    assignee: 'Daniel Rossi',
    assigneeInitials: 'DR',
    due: 'Aug 19',
  ),
  WorkItem(
    id: 'WQ-2044',
    title: 'Prepare quarterly compliance report',
    client: 'Internal',
    priority: WorkPriority.medium,
    status: WorkStatus.inProgress,
    assignee: 'John Smith',
    assigneeInitials: 'JS',
    due: 'Aug 30',
  ),
  WorkItem(
    id: 'WQ-2045',
    title: 'Update pricing sheet for Q4',
    client: 'Internal',
    priority: WorkPriority.low,
    status: WorkStatus.todo,
    assignee: 'Sarah Kim',
    assigneeInitials: 'SK',
    due: 'Sep 5',
  ),
  WorkItem(
    id: 'WQ-2046',
    title: 'Send renewal reminder to Northside',
    client: 'Northside Holdings',
    priority: WorkPriority.medium,
    status: WorkStatus.done,
    assignee: 'Priya Mehta',
    assigneeInitials: 'PM',
    due: 'Aug 15',
  ),
];
