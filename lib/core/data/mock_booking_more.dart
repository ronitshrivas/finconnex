import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

// ─── Consultations ─────────────────────────────────
enum ConsultStatus { upcoming, completed, cancelled, noShow }

extension ConsultStatusX on ConsultStatus {
  String get label => switch (this) {
        ConsultStatus.upcoming => 'Upcoming',
        ConsultStatus.completed => 'Completed',
        ConsultStatus.cancelled => 'Cancelled',
        ConsultStatus.noShow => 'No-show',
      };
  Color get bg => switch (this) {
        ConsultStatus.upcoming => AppColors.infoBg,
        ConsultStatus.completed => AppColors.successBg,
        ConsultStatus.cancelled => AppColors.neutralBg,
        ConsultStatus.noShow => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        ConsultStatus.upcoming => AppColors.infoFg,
        ConsultStatus.completed => AppColors.successFg,
        ConsultStatus.cancelled => AppColors.mutedForeground,
        ConsultStatus.noShow => AppColors.dangerFg,
      };
}

class Consultation {
  final String id, client, service, consultant, when, duration, mode;
  final ConsultStatus status;
  const Consultation({required this.id, required this.client, required this.service, required this.consultant, required this.when, required this.duration, required this.mode, required this.status});
}

const kConsultations = <Consultation>[
  Consultation(id: 'CNS-4001', client: 'William Anderson', service: 'First-home buyer consult', consultant: 'John Smith', when: 'Today · 15:00', duration: '45m', mode: 'Zoom', status: ConsultStatus.upcoming),
  Consultation(id: 'CNS-4002', client: 'Marcus Chen', service: 'Refinance strategy', consultant: 'Tejas Gokhe', when: 'Tomorrow · 10:00', duration: '30m', mode: 'In-person', status: ConsultStatus.upcoming),
  Consultation(id: 'CNS-4003', client: 'Priya Mehta', service: 'Renewal deep-dive', consultant: 'Roshna Abraham', when: 'Yesterday · 14:00', duration: '1h', mode: 'Zoom', status: ConsultStatus.completed),
  Consultation(id: 'CNS-4004', client: 'Daniel Rossi', service: 'Property investment review', consultant: 'Daniel Rossi', when: 'Aug 14', duration: '45m', mode: 'Phone', status: ConsultStatus.noShow),
  Consultation(id: 'CNS-4005', client: 'Sarah Kim', service: 'Broker onboarding', consultant: 'Sarah Kim', when: 'Aug 12', duration: '30m', mode: 'In-person', status: ConsultStatus.cancelled),
];

// ─── Schedules ─────────────────────────────────────
class ScheduleEntry {
  final String name;
  final String description;
  final String duration;
  final String bufferBefore;
  final String bufferAfter;
  final int bookingsThisWeek;
  final bool active;
  const ScheduleEntry({required this.name, required this.description, required this.duration, required this.bufferBefore, required this.bufferAfter, required this.bookingsThisWeek, required this.active});
}

const kSchedules = <ScheduleEntry>[
  ScheduleEntry(name: 'Discovery call · 30 min', description: 'Initial call with warm leads', duration: '30 min', bufferBefore: '5 min', bufferAfter: '5 min', bookingsThisWeek: 12, active: true),
  ScheduleEntry(name: 'Strategy consult · 45 min', description: 'Deeper needs analysis + proposal shape', duration: '45 min', bufferBefore: '10 min', bufferAfter: '10 min', bookingsThisWeek: 6, active: true),
  ScheduleEntry(name: 'Renewal review · 60 min', description: 'Yearly renewal walkthrough', duration: '60 min', bufferBefore: '10 min', bufferAfter: '15 min', bookingsThisWeek: 3, active: true),
  ScheduleEntry(name: 'Broker demo · 20 min', description: 'Quick demo for referral partners', duration: '20 min', bufferBefore: '5 min', bufferAfter: '5 min', bookingsThisWeek: 0, active: false),
];

// ─── Consultants ───────────────────────────────────
class Consultant {
  final String id, name, initials, role, email, timezone;
  final Color avatarBg, avatarFg;
  final int upcomingBookings;
  final int weeklyCapacity;
  final bool online;
  const Consultant({required this.id, required this.name, required this.initials, required this.role, required this.email, required this.timezone, required this.avatarBg, required this.avatarFg, required this.upcomingBookings, required this.weeklyCapacity, required this.online});
}

const kConsultants = <Consultant>[
  Consultant(id: 'CST-2001', name: 'John Smith', initials: 'JS', role: 'Manager · Advisor', email: 'john@finconnex.example', timezone: 'Asia/Kathmandu', avatarBg: AppColors.primarySoft, avatarFg: AppColors.primary, upcomingBookings: 8, weeklyCapacity: 20, online: true),
  Consultant(id: 'CST-2002', name: 'Tejas Gokhe', initials: 'TG', role: 'Senior consultant', email: 'tejas@finconnex.example', timezone: 'Asia/Kolkata', avatarBg: AppColors.infoBg, avatarFg: AppColors.infoFg, upcomingBookings: 5, weeklyCapacity: 15, online: true),
  Consultant(id: 'CST-2003', name: 'Roshna Abraham', initials: 'RA', role: 'Compliance lead', email: 'roshna@finconnex.example', timezone: 'Asia/Kolkata', avatarBg: AppColors.successBg, avatarFg: AppColors.successFg, upcomingBookings: 3, weeklyCapacity: 10, online: false),
  Consultant(id: 'CST-2004', name: 'Shiva Kadhka', initials: 'SK', role: 'Broker enablement', email: 'shiva@finconnex.example', timezone: 'Asia/Kathmandu', avatarBg: AppColors.warningBg, avatarFg: AppColors.warningFg, upcomingBookings: 4, weeklyCapacity: 12, online: true),
];
