import 'package:flutter/material.dart';

import '../../core/data/mock_booking_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class ConsultationsScreen extends StatelessWidget {
  const ConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Consultations', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New consultation', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search consultations…', onChanged: (_) {}),
        const SizedBox(height: 16),
        for (final ct in kConsultations) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 4, height: 56, decoration: BoxDecoration(color: ct.status.fg, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(ct.service, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                StatusPill(label: ct.status.label, background: ct.status.bg, foreground: ct.status.fg),
              ]),
              const SizedBox(height: 4),
              Text('Client: ${ct.client}', style: const TextStyle(fontSize: 12.5)),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.schedule, size: 12, color: AppColors.mutedForeground),
                const SizedBox(width: 4),
                Text('${ct.when} · ${ct.duration}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                const SizedBox(width: 12),
                Icon(ct.mode == 'Zoom' ? Icons.videocam_outlined : ct.mode == 'Phone' ? Icons.phone_outlined : Icons.place_outlined, size: 12, color: AppColors.mutedForeground),
                const SizedBox(width: 4),
                Text(ct.mode, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                const Spacer(),
                Text(ct.consultant, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
              ]),
            ])),
          ]),
        )),
      ]),
    );
  }
}

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Schedules', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New schedule type', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 4),
        Text('Bookable slots for consultants — customize duration, buffer, and availability.',
            style: TextStyle(fontSize: 13, color: p.mutedForeground)),
        const SizedBox(height: 16),
        for (final s in kSchedules) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 42, height: 42, alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.event_available_outlined, size: 20, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.name, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600)),
                Text(s.description, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ])),
              Switch(value: s.active, onChanged: (_) {}, activeColor: AppColors.primary),
            ]),
            const SizedBox(height: 12),
            Wrap(spacing: 16, runSpacing: 8, children: [
              _pair('Duration', s.duration),
              _pair('Buffer before', s.bufferBefore),
              _pair('Buffer after', s.bufferAfter),
              _pair('This week', '${s.bookingsThisWeek} bookings'),
            ]),
          ]),
        )),
      ]),
    );
  }

  Widget _pair(String l, String v) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.4)),
        const SizedBox(height: 2),
        Text(v, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      ]);
}

class ConsultantsScreen extends StatelessWidget {
  const ConsultantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Consultants', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'Invite' : 'Invite consultant', icon: Icons.person_add_alt, onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : (cn.maxWidth < 1024 ? 2 : 3);
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final ct in kConsultants) SizedBox(width: w, child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Stack(children: [
                    Container(width: 48, height: 48, alignment: Alignment.center,
                        decoration: BoxDecoration(color: ct.avatarBg, shape: BoxShape.circle),
                        child: Text(ct.initials, style: TextStyle(fontSize: 15, color: ct.avatarFg, fontWeight: FontWeight.w700))),
                    if (ct.online) Positioned(right: 0, bottom: 0, child: Container(width: 12, height: 12,
                      decoration: BoxDecoration(color: AppColors.online, shape: BoxShape.circle, border: Border.all(color: p.card, width: 2)))),
                  ]),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ct.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(ct.role, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                  ])),
                ]),
                const SizedBox(height: 12),
                Text(ct.email, style: const TextStyle(fontSize: 12, color: AppColors.primary)),
                const SizedBox(height: 2),
                Text(ct.timezone, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                const SizedBox(height: 12),
                Container(height: 1, color: p.border),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${ct.upcomingBookings}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const Text('Upcoming', style: TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                  ])),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('${ct.weeklyCapacity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const Text('Weekly cap', style: TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                  ])),
                ]),
                const SizedBox(height: 10),
                ClipRRect(borderRadius: BorderRadius.circular(999), child: LinearProgressIndicator(
                  value: ct.upcomingBookings / ct.weeklyCapacity, minHeight: 6,
                  backgroundColor: AppColors.muted, valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                )),
              ]),
            )),
          ]);
        }),
      ]),
    );
  }
}
