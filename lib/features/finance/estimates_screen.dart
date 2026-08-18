import 'package:flutter/material.dart';

import '../../core/data/mock_finance.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class EstimatesScreen extends StatelessWidget {
  const EstimatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    final p = AppPalette.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Estimates', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Manage and track your active project estimates.', style: TextStyle(fontSize: 13, color: p.mutedForeground)),
          ])),
          PrimaryButton(label: 'Create Estimate', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        _statsRow(context, [
          ('PENDING VALUE', '\$5,005', '📈 Active pipeline value', AppColors.primary),
          ('ACCEPTED ESTIMATES', '1', '🎯 Ready for conversion', AppColors.successFg),
          ('TOTAL ESTIMATES', '4', '🗓 Tracked in system', AppColors.mutedForeground),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: SearchField(hint: 'Search...', onChanged: (_) {})),
          const SizedBox(width: 10),
          _dropChip(context, 'Status: All'), const SizedBox(width: 8), _dropChip(context, '🗓 Last 30 Days'),
        ]),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
      ]),
    );
  }

  Widget _statsRow(BuildContext c, List<(String, String, String, Color)> stats) {
    return LayoutBuilder(builder: (ctx, cn) {
      final cols = cn.maxWidth < 640 ? 1 : 3;
      const gap = 12.0;
      final w = (cn.maxWidth - gap * (cols - 1)) / cols;
      return Wrap(spacing: gap, runSpacing: gap, children: [
        for (final s in stats)
          SizedBox(width: w, child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.$1, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6)),
              const SizedBox(height: 10),
              Text(s.$2, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(s.$3, style: TextStyle(fontSize: 11.5, color: s.$4, fontWeight: FontWeight.w500)),
            ]),
          )),
      ]);
    });
  }

  Widget _dropChip(BuildContext c, String s) {
    final p = AppPalette.of(c);
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Text(s, style: const TextStyle(fontSize: 12.5)),
        const SizedBox(width: 6),
        Icon(Icons.expand_more, size: 14, color: p.mutedForeground),
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
          Expanded(flex: 2, child: Text('ESTIMATE ID', style: h())),
          Expanded(flex: 4, child: Text('CLIENT NAME', style: h())),
          Expanded(flex: 2, child: Text('VALID UNTIL', style: h())),
          Expanded(flex: 2, child: Text('TOTAL VALUE', style: h())),
          Expanded(flex: 2, child: Text('EXPIRY DATE', style: h())),
          Expanded(flex: 2, child: Text('STATUS', style: h())),
          const SizedBox(width: 40),
        ])),
        for (final e in kEstimates) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 2, child: Text(e.id, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
            Expanded(flex: 4, child: Row(children: [
              Container(width: 26, height: 26, alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                  child: Text(e.clientInitials, style: const TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600))),
              const SizedBox(width: 8),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(e.client, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(e.email, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
              ])),
            ])),
            Expanded(flex: 2, child: Text(e.validUntil, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(e.totalValue, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text(e.expiry, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: e.status.label, background: e.status.bg, foreground: e.status.fg))),
            const SizedBox(width: 40, child: Icon(Icons.more_vert, size: 16, color: AppColors.mutedForeground)),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) {
    return Column(children: [
      for (final e in kEstimates) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(e.id, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
            const Spacer(),
            StatusPill(label: e.status.label, background: e.status.bg, foreground: e.status.fg),
          ]),
          const SizedBox(height: 8),
          Text(e.client, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(e.email, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
          const SizedBox(height: 8),
          Row(children: [
            Text(e.totalValue, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const Spacer(),
            Text('Expires ${e.expiry}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
          ]),
        ]),
      )),
    ]);
  }
}
