import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          const Text('Support Tickets', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Spacer(),
          SecondaryButton(label: 'Export', icon: Icons.file_download_outlined, onPressed: () {}),
          const SizedBox(width: 10),
          PrimaryButton(label: 'New ticket', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'All', count: 6, selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'New', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Open', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'In Progress', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Pending', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Resolved', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Closed', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Reopened', count: 0, selected: false, onTap: () {}),
        ])),
        const SizedBox(height: 12),
        Row(children: [
          Container(
            height: 40, padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
            child: Row(children: [const Text('All priorities', style: TextStyle(fontSize: 12.5)), const SizedBox(width: 6), Icon(Icons.expand_more, size: 14, color: p.mutedForeground)]),
          ),
          const Spacer(),
          SearchField(hint: 'Search tickets...', width: mobile ? null : 240, onChanged: (_) {}),
        ]),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
      ]),
    );
  }

  Widget _table(BuildContext c) {
    final p = AppPalette.of(c);
    TextStyle h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          Expanded(flex: 4, child: Text('TICKET', style: h())),
          Expanded(flex: 3, child: Text('REQUESTER', style: h())),
          Expanded(flex: 2, child: Text('PRIORITY', style: h())),
          Expanded(flex: 2, child: Text('STATUS', style: h())),
          Expanded(flex: 2, child: Text('ASSIGNEE', style: h())),
          Expanded(flex: 2, child: Text('CATEGORY', style: h())),
        ])),
        for (final t in kTickets) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.id, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(t.subject, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            ])),
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.requester, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(t.requesterCompany, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            ])),
            Expanded(flex: 2, child: Text(t.priority.label, style: TextStyle(fontSize: 13, color: t.priority.color, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Row(children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: t.status.fg, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Flexible(child: Text(t.status.label, style: TextStyle(fontSize: 12.5, color: t.status.fg, fontWeight: FontWeight.w500))),
            ])),
            Expanded(flex: 2, child: Text(t.assignee, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Row(children: [
              Flexible(child: Text(t.category, style: const TextStyle(fontSize: 12.5))),
              if (t.rating != null) ...[
                const SizedBox(width: 6),
                const Icon(Icons.star, size: 12, color: AppColors.warningFg),
                const SizedBox(width: 2),
                Text('${t.rating}', style: const TextStyle(fontSize: 11, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
              ],
            ])),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final t in kTickets) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(t.id, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
              const Spacer(),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: t.status.fg, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                Text(t.status.label, style: TextStyle(fontSize: 11.5, color: t.status.fg, fontWeight: FontWeight.w600)),
              ]),
            ]),
            const SizedBox(height: 6),
            Text(t.subject, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('${t.requester} · ${t.requesterCompany}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 8),
            Row(children: [
              Text(t.priority.label, style: TextStyle(fontSize: 12, color: t.priority.color, fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),
              Text(t.category, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const Spacer(),
              if (t.assignee.isNotEmpty) Text(t.assignee, style: const TextStyle(fontSize: 12)),
            ]),
          ]),
        )),
      ]);
}
