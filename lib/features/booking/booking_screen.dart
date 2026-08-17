import 'package:flutter/material.dart';

import '../../core/data/mock_bookings.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _tab = 0;
  String _query = '';

  List<Booking> get _filtered {
    Iterable<Booking> list = kMockBookings;
    switch (_tab) {
      case 1:
        list = list.where((b) => b.status == BookingStatus.confirmed);
      case 2:
        list = list.where((b) => b.status == BookingStatus.pending);
      case 3:
        list = list.where((b) => b.status == BookingStatus.cancelled);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((b) =>
          b.title.toLowerCase().contains(q) ||
          b.client.toLowerCase().contains(q) ||
          b.room.toLowerCase().contains(q));
    }
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    final rows = _filtered;
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(mobile: mobile),
          SizedBox(height: mobile ? 16 : 20),
          _FilterBar(
            tab: _tab,
            onTab: (i) => setState(() => _tab = i),
            onSearch: (v) => setState(() => _query = v),
            mobile: mobile,
          ),
          SizedBox(height: mobile ? 12 : 16),
          if (rows.isEmpty)
            _empty()
          else
            Column(
              children: [
                for (final b in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _BookingCard(booking: b),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _empty() => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('No bookings match your filters',
              style: TextStyle(color: AppColors.mutedForeground)),
        ),
      );
}

class _Header extends StatelessWidget {
  final bool mobile;
  const _Header({required this.mobile});

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Booking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Meeting rooms, client sessions, and calls.',
              style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          PrimaryButton(label: 'New booking', icon: Icons.add, onPressed: () {}),
        ],
      );
    }
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Meeting rooms, client sessions, and calls.',
                style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          ],
        ),
        const Spacer(),
        PrimaryButton(label: 'New booking', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int tab;
  final ValueChanged<int> onTab;
  final ValueChanged<String> onSearch;
  final bool mobile;

  const _FilterBar({
    required this.tab,
    required this.onTab,
    required this.onSearch,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterTab(label: 'All', selected: tab == 0, onTap: () => onTab(0)),
          const SizedBox(width: 8),
          FilterTab(label: 'Confirmed', selected: tab == 1, onTap: () => onTab(1)),
          const SizedBox(width: 8),
          FilterTab(label: 'Pending', selected: tab == 2, onTap: () => onTab(2)),
          const SizedBox(width: 8),
          FilterTab(label: 'Cancelled', selected: tab == 3, onTap: () => onTab(3)),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search bookings…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search bookings…', width: 260, onChanged: onSearch),
      ],
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;
  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(booking.startTime,
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('→ ${booking.endTime}',
                    style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(booking.title,
                          style: const TextStyle(
                              fontSize: 14.5, fontWeight: FontWeight.w600)),
                    ),
                    StatusPill(
                        label: booking.status.label,
                        background: booking.status.bg,
                        foreground: booking.status.fg),
                  ],
                ),
                const SizedBox(height: 4),
                Text(booking.client,
                    style: const TextStyle(
                        fontSize: 12.5, color: AppColors.mutedForeground)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.event_outlined,
                        size: 13, color: AppColors.mutedForeground),
                    const SizedBox(width: 4),
                    Text(booking.date,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.mutedForeground)),
                    const SizedBox(width: 12),
                    const Icon(Icons.meeting_room_outlined,
                        size: 13, color: AppColors.mutedForeground),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(booking.room,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.mutedForeground),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primarySoft,
                        shape: BoxShape.circle,
                      ),
                      child: Text(booking.hostInitials,
                          style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 6),
                    Text(booking.host,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.mutedForeground)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
