import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum BookingStatus { confirmed, pending, cancelled }

class Booking {
  final String id;
  final String title;
  final String client;
  final String room;
  final String date;
  final String startTime;
  final String endTime;
  final BookingStatus status;
  final String host;
  final String hostInitials;
  const Booking({
    required this.id,
    required this.title,
    required this.client,
    required this.room,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.host,
    required this.hostInitials,
  });
}

extension BookingStatusX on BookingStatus {
  String get label => switch (this) {
        BookingStatus.confirmed => 'Confirmed',
        BookingStatus.pending => 'Pending',
        BookingStatus.cancelled => 'Cancelled',
      };
  Color get bg => switch (this) {
        BookingStatus.confirmed => AppColors.successBg,
        BookingStatus.pending => AppColors.warningBg,
        BookingStatus.cancelled => AppColors.dangerBg,
      };
  Color get fg => switch (this) {
        BookingStatus.confirmed => AppColors.successFg,
        BookingStatus.pending => AppColors.warningFg,
        BookingStatus.cancelled => AppColors.dangerFg,
      };
}

const kMockBookings = <Booking>[
  Booking(
    id: 'BKG-3301',
    title: 'Greystone quarterly review',
    client: 'Greystone Realty',
    room: 'Boardroom A',
    date: 'Mon, Aug 18',
    startTime: '10:00',
    endTime: '11:30',
    status: BookingStatus.confirmed,
    host: 'Priya Mehta',
    hostInitials: 'PM',
  ),
  Booking(
    id: 'BKG-3302',
    title: 'Harbour onboarding kickoff',
    client: 'Harbour Loans',
    room: 'Meeting Room 3',
    date: 'Tue, Aug 19',
    startTime: '14:00',
    endTime: '15:00',
    status: BookingStatus.confirmed,
    host: 'Marcus Chen',
    hostInitials: 'MC',
  ),
  Booking(
    id: 'BKG-3303',
    title: 'Apex reinstatement discussion',
    client: 'Apex Property Group',
    room: 'Zoom',
    date: 'Wed, Aug 20',
    startTime: '11:00',
    endTime: '11:45',
    status: BookingStatus.pending,
    host: 'Daniel Rossi',
    hostInitials: 'DR',
  ),
  Booking(
    id: 'BKG-3304',
    title: 'Internal ops sync',
    client: 'Internal',
    room: 'Meeting Room 1',
    date: 'Thu, Aug 21',
    startTime: '09:30',
    endTime: '10:00',
    status: BookingStatus.confirmed,
    host: 'John Smith',
    hostInitials: 'JS',
  ),
  Booking(
    id: 'BKG-3305',
    title: 'Meridian pilot retrospective',
    client: 'Meridian Partners',
    room: 'Boardroom B',
    date: 'Fri, Aug 22',
    startTime: '15:00',
    endTime: '16:00',
    status: BookingStatus.cancelled,
    host: 'Sarah Kim',
    hostInitials: 'SK',
  ),
];
