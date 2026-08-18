import 'package:flutter/material.dart';

import '../../core/data/mock_activities_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class MeetingsScreen extends StatelessWidget {
  const MeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Meetings', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New meeting', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search meetings…', onChanged: (_) {}),
        const SizedBox(height: 16),
        Column(children: [
          for (final m in kMeetings) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 44, height: 44, alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.groups_outlined, size: 20, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(m.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                  StatusPill(label: m.status.label, background: m.status.bg, foreground: m.status.fg),
                ]),
                const SizedBox(height: 4),
                Text(m.related, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.schedule, size: 12, color: AppColors.mutedForeground),
                  const SizedBox(width: 4),
                  Text('${m.when} · ${m.duration}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  const SizedBox(width: 12),
                  const Icon(Icons.place_outlined, size: 12, color: AppColors.mutedForeground),
                  const SizedBox(width: 4),
                  Flexible(child: Text(m.location, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), overflow: TextOverflow.ellipsis)),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.person_outline, size: 12, color: AppColors.mutedForeground),
                  const SizedBox(width: 4),
                  Text('${m.host} · ${m.attendees}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                ]),
              ])),
            ]),
          )),
        ]),
      ]),
    );
  }
}

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Notes', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New note', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search notes…', onChanged: (_) {}),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : (cn.maxWidth < 1024 ? 2 : 3);
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final n in kNotes) SizedBox(width: w, child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: p.card,
                border: Border.all(color: p.border),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(n.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(n.snippet, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, height: 1.5), maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Wrap(spacing: 4, runSpacing: 4, children: [
                  for (final t in n.tags) Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(4)),
                    child: Text(t, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
                  ),
                ]),
                const SizedBox(height: 10),
                Divider(height: 1, color: p.border),
                const SizedBox(height: 10),
                Row(children: [
                  Text(n.related, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground), overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Text('${n.author} · ${n.when}', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                ]),
              ]),
            )),
          ]);
        }),
      ]),
    );
  }
}
