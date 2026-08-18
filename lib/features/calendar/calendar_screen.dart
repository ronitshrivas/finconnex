import 'package:flutter/material.dart';

import '../../core/data/mock_messages.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const _todayDay = 18;
  static const _monthLabel = 'August 2026';
  static const _weekdayHeaders = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  int _selected = _todayDay;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Calendar',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const Spacer(),
              SecondaryButton(label: 'Today', icon: Icons.today, onPressed: () => setState(() => _selected = _todayDay)),
              const SizedBox(width: 8),
              PrimaryButton(label: 'New event', icon: Icons.add, onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          if (mobile) ...[
            _monthCard(p),
            const SizedBox(height: 16),
            _dayEventsCard(p, title: _titleFor(_selected)),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: _monthCard(p)),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _dayEventsCard(p, title: _titleFor(_selected)),
                      const SizedBox(height: 16),
                      _upcomingCard(p),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _titleFor(int day) => day == _todayDay ? 'Today · Aug $day' : 'Aug $day';

  Widget _monthCard(AppPalette p) {
    // Aug 2026: Aug 1 is a Saturday. 31 days.
    const daysInMonth = 31;
    const leadingBlanks = 6; // Sun=0, so Sat = 6 → offset for Aug 1
    final cells = <int?>[
      for (int i = 0; i < leadingBlanks; i++) null,
      for (int d = 1; d <= daysInMonth; d++) d,
    ];
    while (cells.length % 7 != 0) {
      cells.add(null);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.chevron_left, color: p.foreground),
                  onPressed: () {}),
              Expanded(
                child: Center(
                  child: Text(_monthLabel,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: p.foreground)),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.chevron_right, color: p.foreground),
                  onPressed: () {}),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (final w in _weekdayHeaders)
                Expanded(
                  child: Center(
                    child: Text(w,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: p.mutedForeground)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1,
            children: [
              for (final d in cells) _dayCell(p, d),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dayCell(AppPalette p, int? day) {
    if (day == null) return const SizedBox.shrink();
    final today = day == _todayDay;
    final selected = day == _selected;
    // Days with events (mock: today + 19, 20)
    final hasDots = day == _todayDay || day == 19 || day == 20;

    return InkWell(
      onTap: () => setState(() => _selected = day),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : (today ? AppColors.primarySoft : Colors.transparent),
          borderRadius: BorderRadius.circular(8),
          border: today && !selected
              ? Border.all(color: AppColors.primary, width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$day',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: selected || today ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? Colors.white
                      : (today ? AppColors.primary : p.foreground),
                )),
            if (hasDots) ...[
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < 3; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: selected ? Colors.white : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dayEventsCard(AppPalette p, {required String title}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: p.foreground)),
          const SizedBox(height: 4),
          Text('${kTodayEvents.length} events',
              style: TextStyle(fontSize: 12, color: p.mutedForeground)),
          const SizedBox(height: 14),
          for (int i = 0; i < kTodayEvents.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            _eventRow(kTodayEvents[i], p),
          ],
        ],
      ),
    );
  }

  Widget _upcomingCard(AppPalette p) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Upcoming',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: p.foreground)),
          const SizedBox(height: 14),
          for (final block in kUpcomingDays) ...[
            Text(block.$1,
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: p.mutedForeground,
                    letterSpacing: 0.4)),
            const SizedBox(height: 8),
            for (int i = 0; i < block.$2.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _eventRow(block.$2[i], p),
            ],
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }

  Widget _eventRow(CalEvent e, AppPalette p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 3,
          height: 42,
          decoration: BoxDecoration(
            color: e.color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 46,
          child: Text(e.time,
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: p.foreground)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.title,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: p.foreground)),
              const SizedBox(height: 2),
              Text(e.subtitle,
                  style: TextStyle(fontSize: 11.5, color: p.mutedForeground)),
            ],
          ),
        ),
      ],
    );
  }
}
