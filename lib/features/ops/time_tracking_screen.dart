import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class TimeTrackingScreen extends StatelessWidget {
  const TimeTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _header(mobile),
        const SizedBox(height: 12),
        LayoutBuilder(builder: (ctx, cn) {
          final wide = cn.maxWidth >= 900;
          return Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('USER', style: TextStyle(fontSize: 11, color: p.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.6)),
              const SizedBox(height: 6),
              _dropField(context, 'John Smith'),
            ])),
            if (wide) ...[
              const SizedBox(width: 12),
              Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('RELATED TO', style: TextStyle(fontSize: 11, color: p.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.6)),
                const SizedBox(height: 6),
                _dropField(context, 'Matter: Anderson: refinance matter'),
              ])),
              const SizedBox(width: 12),
              Padding(padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Start timer'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.successFg, minimumSize: const Size(0, 42)))),
            ],
          ]);
        }),
        const SizedBox(height: 12),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : 3;
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          final stats = [('HOURS (FILTERED)', '8h 30m'), ('BILLABLE HOURS', '7h 45m'), ('BILLABLE VALUE', '\$1,855.00')];
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final s in stats) SizedBox(width: w, child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.$1, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6)),
                const SizedBox(height: 6),
                Text(s.$2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ]),
            )),
          ]);
        }),
        const SizedBox(height: 16),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'All', count: 6, selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Draft', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Running', count: 0, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Logged', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Submitted', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Approved', count: 2, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Invoiced', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Rejected', count: 0, selected: false, onTap: () {}),
        ])),
        const SizedBox(height: 12),
        SearchField(hint: 'Search ID, description, related...', onChanged: (_) {}),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
      ]),
    );
  }

  Widget _header(bool mobile) {
    if (mobile) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Time Tracking',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(
              child: PrimaryButton(
                  label: 'Log time', icon: Icons.add, onPressed: () {})),
          const SizedBox(width: 8),
          Expanded(
              child: SecondaryButton(
                  label: 'Export',
                  icon: Icons.file_download_outlined,
                  onPressed: () {})),
        ]),
      ]);
    }
    return Row(children: [
      const Text('Time Tracking',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      const Spacer(),
      SecondaryButton(
          label: 'Export timesheet',
          icon: Icons.file_download_outlined,
          onPressed: () {}),
      const SizedBox(width: 10),
      PrimaryButton(label: 'Log time', icon: Icons.add, onPressed: () {}),
    ]);
  }

  Widget _dropField(BuildContext c, String s) {
    final p = AppPalette.of(c);
    return Container(
      height: 42, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [Expanded(child: Text(s, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)), Icon(Icons.expand_more, size: 16, color: p.mutedForeground)]),
    );
  }

  Widget _table(BuildContext c) {
    final p = AppPalette.of(c);
    TextStyle h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          const SizedBox(width: 24),
          Expanded(flex: 2, child: Text('ENTRY ID', style: h())),
          Expanded(flex: 4, child: Text('RELATED TO', style: h())),
          Expanded(flex: 3, child: Text('USER', style: h())),
          Expanded(flex: 2, child: Text('DATE', style: h())),
          Expanded(flex: 2, child: Text('DURATION', style: h())),
          Expanded(flex: 2, child: Text('BILLABLE', style: h())),
          Expanded(flex: 2, child: Text('RATE', style: h())),
          Expanded(flex: 2, child: Text('AMOUNT', style: h())),
          Expanded(flex: 2, child: Text('STATUS', style: h())),
          Expanded(flex: 4, child: Text('DESCRIPTION', style: h())),
        ])),
        for (final t in kTimeEntries) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            SizedBox(width: 24, child: Icon(Icons.check_box_outline_blank, size: 14, color: p.mutedForeground)),
            Expanded(flex: 2, child: Text(t.id, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
            Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.relatedType, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground, fontWeight: FontWeight.w600)),
              Text(t.relatedTitle, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis),
            ])),
            Expanded(flex: 3, child: Text(t.user, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(t.date, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(t.duration, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text(t.billable ? 'Yes' : 'No', style: TextStyle(fontSize: 12.5, color: t.billable ? AppColors.successFg : AppColors.mutedForeground, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text(t.rate, style: const TextStyle(fontSize: 12))),
            Expanded(flex: 2, child: Text(t.amount, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: t.status.label, background: t.status.bg, foreground: t.status.fg))),
            Expanded(flex: 4, child: Text(t.description, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final t in kTimeEntries) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(t.id, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusPill(label: t.status.label, background: t.status.bg, foreground: t.status.fg),
            ]),
            const SizedBox(height: 6),
            Text(t.relatedTitle, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
            Text('${t.relatedType} · ${t.user}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            const SizedBox(height: 6),
            Text(t.description, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 8),
            Row(children: [
              Text(t.duration, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              if (t.billable) const Text('billable', style: TextStyle(fontSize: 11, color: AppColors.successFg, fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(t.amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ]),
          ]),
        )),
      ]);
}
