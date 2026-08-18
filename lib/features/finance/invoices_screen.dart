import 'package:flutter/material.dart';

import '../../core/data/mock_finance.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class InvoicesScreen extends StatelessWidget {
  const InvoicesScreen({super.key});

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
            const Text('Sales invoices', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Manage and track your active sales invoices.', style: TextStyle(fontSize: 13, color: p.mutedForeground)),
          ])),
          PrimaryButton(label: 'New invoice', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : 3;
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          final stats = [
            ('OUTSTANDING BALANCE', '\$5,650.00', '📈 Total unpaid receivable', AppColors.primary),
            ('PAID INVOICES', '0', '🎯 Successfully settled', AppColors.successFg),
            ('TOTAL INVOICES', '4', '🗓 Tracked in system', AppColors.mutedForeground),
          ];
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final s in stats) SizedBox(width: w, child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.$1, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6)),
                const SizedBox(height: 10),
                Text(s.$2, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(s.$3, style: TextStyle(fontSize: 11.5, color: s.$4, fontWeight: FontWeight.w500)),
              ]),
            )),
          ]);
        }),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: SearchField(hint: 'Search...', onChanged: (_) {})),
          const SizedBox(width: 10),
          _drop(context, 'Status: All'), const SizedBox(width: 8), _drop(context, '🗓 Last 30 Days'),
        ]),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
      ]),
    );
  }

  Widget _drop(BuildContext c, String s) {
    final p = AppPalette.of(c);
    return Container(
      height: 40, padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
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
          Expanded(flex: 3, child: Text('INVOICE', style: h())),
          Expanded(flex: 3, child: Text('CLIENT', style: h())),
          Expanded(flex: 2, child: Text('DUE', style: h())),
          Expanded(flex: 2, child: Text('STATUS', style: h())),
          Expanded(flex: 2, child: Text('PAID', style: h())),
          Expanded(flex: 2, child: Text('BALANCE', style: h())),
          const SizedBox(width: 40),
        ])),
        for (final i in kInvoices) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(i.id, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
              Text(i.subtitle, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            ])),
            Expanded(flex: 3, child: Text(i.client, style: const TextStyle(fontSize: 13))),
            Expanded(flex: 2, child: Text(i.due, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: i.status.label, background: i.status.bg, foreground: i.status.fg))),
            Expanded(flex: 2, child: Text(i.paid, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(i.balance, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
            const SizedBox(width: 40, child: Icon(Icons.more_vert, size: 16, color: AppColors.mutedForeground)),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final i in kInvoices) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(i.id, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusPill(label: i.status.label, background: i.status.bg, foreground: i.status.fg),
            ]),
            const SizedBox(height: 4),
            Text(i.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
            const SizedBox(height: 4),
            Text(i.client, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(children: [
              Text('Balance ${i.balance}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('Due ${i.due}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
            ]),
          ]),
        )),
      ]);
}
