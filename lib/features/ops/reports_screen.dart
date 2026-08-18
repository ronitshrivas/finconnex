import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          const Text('Reports', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Spacer(),
          SecondaryButton(label: 'Export', icon: Icons.file_download_outlined, onPressed: () {}),
          const SizedBox(width: 10),
          PrimaryButton(label: 'New report', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'All', count: 5, selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Draft', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Ready', count: 3, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Scheduled', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Running', count: 0, selected: false, onTap: () {}), const SizedBox(width: 8),
          _drop(context, 'All types'), const SizedBox(width: 8), _drop(context, 'All schedules'),
        ])),
        const SizedBox(height: 12),
        SearchField(hint: 'Search reports...', width: mobile ? null : 260, onChanged: (_) {}),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
      ]),
    );
  }

  Widget _drop(BuildContext c, String s) {
    final p = AppPalette.of(c);
    return Container(
      height: 36, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Text(s, style: const TextStyle(fontSize: 12.5)), const SizedBox(width: 6), Icon(Icons.expand_more, size: 14, color: p.mutedForeground)]),
    );
  }

  Widget _table(BuildContext c) {
    final p = AppPalette.of(c);
    TextStyle h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          Expanded(flex: 3, child: Text('REPORT', style: h())),
          Expanded(flex: 2, child: Text('TYPE', style: h())),
          Expanded(flex: 3, child: Text('SOURCE', style: h())),
          Expanded(flex: 2, child: Text('RANGE', style: h())),
          Expanded(flex: 2, child: Text('SCHEDULE', style: h())),
          Expanded(flex: 2, child: Text('STATUS', style: h())),
          Expanded(flex: 3, child: Text('CREATED BY', style: h())),
          Expanded(flex: 3, child: Text('LAST RUN', style: h())),
        ])),
        for (final r in kReports) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.id, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(r.name, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            ])),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: r.type.label, background: r.type.bg, foreground: r.type.fg))),
            Expanded(flex: 3, child: Text(r.source, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(r.range, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(r.schedule, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: r.status.label, background: r.status.bg, foreground: r.status.fg))),
            Expanded(flex: 3, child: Text(r.createdBy, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 3, child: Text(r.lastRun ?? '', style: const TextStyle(fontSize: 12.5))),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final r in kReports) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(r.id, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              StatusPill(label: r.type.label, background: r.type.bg, foreground: r.type.fg),
              const Spacer(),
              StatusPill(label: r.status.label, background: r.status.bg, foreground: r.status.fg),
            ]),
            const SizedBox(height: 6),
            Text(r.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('${r.source} · ${r.range} · ${r.schedule}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            const SizedBox(height: 6),
            if (r.lastRun != null) Text('Last run ${r.lastRun}', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
          ]),
        )),
      ]);
}
