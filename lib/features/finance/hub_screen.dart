import 'package:flutter/material.dart';

import '../../core/data/mock_finance.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class FinanceHubScreen extends StatelessWidget {
  const FinanceHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(builder: (ctx, c) {
            final cols = c.maxWidth < 640 ? 1 : (c.maxWidth < 1024 ? 2 : 4);
            const gap = 12.0;
            final cardW = (c.maxWidth - gap * (cols - 1)) / cols;
            return Wrap(spacing: gap, runSpacing: gap, children: [
              for (final s in kHubStats) SizedBox(width: cardW, child: _statCard(context, s)),
            ]);
          }),
          const SizedBox(height: 16),
          if (mobile) ...[_chartCard(context), const SizedBox(height: 12), _activityCard(context)]
          else Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: _chartCard(context)),
            const SizedBox(width: 16),
            Expanded(flex: 1, child: _activityCard(context)),
          ]),
        ],
      ),
    );
  }

  Widget _statCard(BuildContext c, HubStat s) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(s.label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6))),
          Container(width: 36, height: 36, decoration: BoxDecoration(color: s.iconBg, borderRadius: BorderRadius.circular(8)),
              child: Icon(s.icon, size: 18, color: s.iconFg)),
        ]),
        const SizedBox(height: 10),
        Text(s.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: s.valueDanger ? AppColors.dangerFg : p.foreground)),
        const SizedBox(height: 4),
        Text(s.sub, style: TextStyle(fontSize: 11.5, color: s.subColor, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  Widget _chartCard(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Revenue vs Expenses', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text('Track your financial performance over time', style: TextStyle(fontSize: 11.5, color: p.mutedForeground)),
          ])),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: p.muted, borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(color: p.background, borderRadius: BorderRadius.circular(4)),
                  child: const Text('Bar', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
              const SizedBox(width: 4),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Text('Line', style: TextStyle(fontSize: 11, color: p.mutedForeground))),
            ]),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              const Text('Last 6 Months', style: TextStyle(fontSize: 11)),
              const SizedBox(width: 4),
              Icon(Icons.expand_more, size: 14, color: p.mutedForeground),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        SizedBox(height: 240, child: CustomPaint(painter: _BarPainter(), size: Size.infinite)),
        const SizedBox(height: 8),
        Row(children: [
          const SizedBox(width: 24),
          _legend(AppColors.infoFg, 'Revenue'),
          const SizedBox(width: 16),
          _legend(AppColors.dangerFg, 'Expenses'),
        ]),
      ]),
    );
  }

  Widget _legend(Color c, String s) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(s, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      ]);

  Widget _activityCard(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Recent Activity', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        Text('Updates on quotes, invoices, and payments.', style: TextStyle(fontSize: 11.5, color: p.mutedForeground)),
        const SizedBox(height: 14),
        for (int i = 0; i < kHubActivity.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 32, height: 32, decoration: BoxDecoration(color: kHubActivity[i].iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(kHubActivity[i].icon, size: 16, color: kHubActivity[i].iconFg)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(kHubActivity[i].title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(kHubActivity[i].subtitle, style: TextStyle(fontSize: 11.5, color: p.mutedForeground)),
              const SizedBox(height: 2),
              Text(kHubActivity[i].time, style: TextStyle(fontSize: 10.5, color: p.subtleText)),
            ])),
          ]),
        ],
      ]),
    );
  }
}

class _BarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const padL = 40.0, padR = 8.0, padT = 8.0, padB = 28.0;
    final chartW = size.width - padL - padR;
    final chartH = size.height - padT - padB;
    var maxV = 0.0;
    for (final r in kRevenueSeries) {
      for (final v in r) if (v > maxV) maxV = v;
    }
    maxV *= 1.2;
    final gridPaint = Paint()..color = AppColors.border..strokeWidth = 1;
    final labelStyle = const TextStyle(fontSize: 10, color: AppColors.mutedForeground);
    for (int i = 0; i <= 4; i++) {
      final y = padT + chartH * i / 4;
      canvas.drawLine(Offset(padL, y), Offset(size.width - padR, y), gridPaint);
      final v = (maxV * (1 - i / 4)).round();
      final tp = TextPainter(text: TextSpan(text: '${v}000', style: labelStyle), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(padL - tp.width - 4, y - tp.height / 2));
    }
    final barW = chartW / kRevenueSeries.length * 0.6 / 2;
    for (int i = 0; i < kRevenueSeries.length; i++) {
      final cx = padL + chartW * (i + 0.5) / kRevenueSeries.length;
      final rev = kRevenueSeries[i][0], exp = kRevenueSeries[i][1];
      final revH = chartH * (rev / maxV), expH = chartH * (exp / maxV);
      final revRect = Rect.fromLTWH(cx - barW - 1, padT + chartH - revH, barW, revH);
      final expRect = Rect.fromLTWH(cx + 1, padT + chartH - expH, barW, expH);
      canvas.drawRRect(RRect.fromRectAndCorners(revRect, topLeft: const Radius.circular(2), topRight: const Radius.circular(2)), Paint()..color = AppColors.infoFg);
      canvas.drawRRect(RRect.fromRectAndCorners(expRect, topLeft: const Radius.circular(2), topRight: const Radius.circular(2)), Paint()..color = AppColors.dangerFg);
      final tp = TextPainter(text: TextSpan(text: kRevenueMonths[i], style: labelStyle), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, padT + chartH + 8));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
