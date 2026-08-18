import 'package:flutter/material.dart';

import '../../core/data/mock_sales_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

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
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              FilterTab(label: 'All', count: kLeads.length, selected: true, onTap: () {}),
              const SizedBox(width: 8),
              FilterTab(label: 'New', selected: false, onTap: () {}),
              const SizedBox(width: 8),
              FilterTab(label: 'Contacted', selected: false, onTap: () {}),
              const SizedBox(width: 8),
              FilterTab(label: 'Qualified', selected: false, onTap: () {}),
              const SizedBox(width: 8),
              FilterTab(label: 'Converted', selected: false, onTap: () {}),
            ])),
        const SizedBox(height: 12),
        SearchField(hint: 'Search leads…', onChanged: (_) {}),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context, p),
      ]),
    );
  }

  Widget _header(bool m) {
    if (m) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Leads', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: PrimaryButton(label: 'New lead', icon: Icons.add, onPressed: () {})),
          const SizedBox(width: 8),
          Expanded(child: SecondaryButton(label: 'Import', icon: Icons.upload_outlined, onPressed: () {})),
        ]),
      ]);
    }
    return Row(children: [
      const Text('Leads', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      const Spacer(),
      SecondaryButton(label: 'Import', icon: Icons.upload_outlined, onPressed: () {}),
      const SizedBox(width: 10),
      PrimaryButton(label: 'New lead', icon: Icons.add, onPressed: () {}),
    ]);
  }

  TextStyle _h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);

  Widget _table(BuildContext c, AppPalette p) {
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          Expanded(flex: 3, child: Text('NAME', style: _h())),
          Expanded(flex: 3, child: Text('COMPANY', style: _h())),
          Expanded(flex: 3, child: Text('EMAIL', style: _h())),
          Expanded(flex: 2, child: Text('SOURCE', style: _h())),
          Expanded(flex: 2, child: Text('SCORE', style: _h())),
          Expanded(flex: 2, child: Text('STATUS', style: _h())),
          Expanded(flex: 2, child: Text('OWNER', style: _h())),
        ])),
        for (final l in kLeads) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(l.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text(l.id, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            ])),
            Expanded(flex: 3, child: Text(l.company, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 3, child: Text(l.email, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), overflow: TextOverflow.ellipsis)),
            Expanded(flex: 2, child: Text(l.source, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: _scoreBar(l.score)),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: l.status.label, background: l.status.bg, foreground: l.status.fg))),
            Expanded(flex: 2, child: Text(l.owner, style: const TextStyle(fontSize: 12.5))),
          ])),
        ],
      ]),
    );
  }

  Widget _scoreBar(int s) => Row(children: [
        SizedBox(width: 36, child: Text('$s', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700))),
        const SizedBox(width: 6),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: s / 100, minHeight: 4,
              backgroundColor: AppColors.muted,
              valueColor: AlwaysStoppedAnimation(s >= 70 ? AppColors.successFg : s >= 40 ? AppColors.warningFg : AppColors.dangerFg),
            ),
          ),
        ),
      ]);

  Widget _mobile(BuildContext c) => Column(children: [
        for (final l in kLeads) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(l.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
              StatusPill(label: l.status.label, background: l.status.bg, foreground: l.status.fg),
            ]),
            const SizedBox(height: 4),
            Text('${l.company} · ${l.source}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 4),
            Text(l.email, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 8),
            Row(children: [
              const Text('Score', style: TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
              const SizedBox(width: 6),
              SizedBox(width: 100, child: _scoreBar(l.score)),
              const Spacer(),
              Text(l.owner, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
            ]),
          ]),
        )),
      ]);
}
