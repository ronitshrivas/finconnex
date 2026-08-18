import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          const Text('Analytics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Spacer(),
          if (!mobile) ...[
            SecondaryButton(label: 'Compare periods', icon: Icons.compare_arrows, onPressed: () {}),
            const SizedBox(width: 8),
            SecondaryButton(label: 'Benchmarks', icon: Icons.flag_outlined, onPressed: () {}),
            const SizedBox(width: 8),
            SecondaryButton(label: 'Export data', icon: Icons.file_download_outlined, onPressed: () {}),
            const SizedBox(width: 8),
            SecondaryButton(label: 'Export chart', icon: Icons.image_outlined, onPressed: () {}),
            const SizedBox(width: 8),
          ],
          PrimaryButton(label: 'Share', icon: Icons.share_outlined, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'Last 7 days', selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Last 30 days', selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'This quarter', selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'This year', selected: false, onTap: () {}), const SizedBox(width: 8),
          _drop(context, 'Team: All'), const SizedBox(width: 8), _drop(context, 'Owner: All'),
          const SizedBox(width: 12),
          const Text('Click a KPI to drill down', style: TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
        ])),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : (cn.maxWidth < 1024 ? 2 : 4);
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final k in kAnalyticsKpis) SizedBox(width: w, child: _kpiCard(context, k)),
          ]);
        }),
        const SizedBox(height: 16),
        if (mobile) ...[_revChart(context), const SizedBox(height: 12), _sources(context)]
        else Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 2, child: _revChart(context)),
          const SizedBox(width: 16),
          Expanded(flex: 1, child: _sources(context)),
        ]),
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

  Widget _kpiCard(BuildContext c, AnalyticsKpi k) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(k.label, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6)),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(k.value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          Padding(padding: const EdgeInsets.only(bottom: 3),
              child: Text(k.delta, style: TextStyle(fontSize: 11.5, color: k.deltaColor, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 4),
        Row(children: [
          Text(k.target, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
          const SizedBox(width: 4),
          Text('· ${k.onTrack ? 'On track' : 'Below'}', style: TextStyle(fontSize: 11, color: k.onTrack ? AppColors.successFg : AppColors.dangerFg, fontWeight: FontWeight.w500)),
        ]),
      ]),
    );
  }

  Widget _revChart(BuildContext c) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Text('Revenue by month', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          Text('Solid = actual · Dashed = benchmark', style: TextStyle(fontSize: 11, color: p.mutedForeground)),
        ]),
        const SizedBox(height: 12),
        SizedBox(height: 220, child: CustomPaint(painter: _AnalyticsLine(), size: Size.infinite)),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _legend(AppColors.mutedForeground, 'Benchmark'), const SizedBox(width: 16),
          _legend(AppColors.primary, 'Revenue'),
        ]),
      ]),
    );
  }

  Widget _sources(BuildContext c) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Revenue by source', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        for (final s in kRevenueSources) Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: s.$3, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Expanded(child: Text(s.$1, style: const TextStyle(fontSize: 12.5))),
            Text('${s.$2}%', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 4),
          ClipRRect(borderRadius: BorderRadius.circular(999), child: LinearProgressIndicator(value: s.$2 / 40, minHeight: 4, backgroundColor: p.muted, valueColor: AlwaysStoppedAnimation(s.$3))),
        ])),
      ]),
    );
  }

  Widget _legend(Color c, String s) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(s, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      ]);
}

class _AnalyticsLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const padL = 40.0, padR = 8.0, padT = 8.0, padB = 24.0;
    final w = size.width - padL - padR;
    final h = size.height - padT - padB;
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    final actual = [80.0, 110.0, 130.0, 170.0, 220.0, 250.0, 280.0];
    final bench = [90.0, 115.0, 140.0, 175.0, 210.0, 240.0, 270.0];
    const maxV = 300.0;
    final label = const TextStyle(fontSize: 10, color: AppColors.mutedForeground);
    for (int i = 0; i <= 4; i++) {
      final y = padT + h * i / 4;
      canvas.drawLine(Offset(padL, y), Offset(size.width - padR, y), Paint()..color = AppColors.border..strokeWidth = 0.5);
      final v = (maxV * (1 - i / 4)).round();
      final tp = TextPainter(text: TextSpan(text: '${v}k', style: label), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }
    // Benchmark dashed
    final benchPaint = Paint()
      ..color = AppColors.mutedForeground
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < months.length - 1; i++) {
      final x1 = padL + w * i / (months.length - 1);
      final y1 = padT + h * (1 - bench[i] / maxV);
      final x2 = padL + w * (i + 1) / (months.length - 1);
      final y2 = padT + h * (1 - bench[i + 1] / maxV);
      final dx = x2 - x1, dy = y2 - y1;
      const steps = 8;
      for (int s = 0; s < steps; s++) {
        if (s.isEven) {
          final t1 = s / steps, t2 = (s + 1) / steps;
          canvas.drawLine(
            Offset(x1 + dx * t1, y1 + dy * t1),
            Offset(x1 + dx * t2, y1 + dy * t2),
            benchPaint,
          );
        }
      }
    }
    // Actual solid
    final path = Path();
    for (int i = 0; i < months.length; i++) {
      final x = padL + w * i / (months.length - 1);
      final y = padT + h * (1 - actual[i] / maxV);
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    canvas.drawPath(path, Paint()..color = AppColors.primary..strokeWidth = 2..style = PaintingStyle.stroke);
    for (int i = 0; i < months.length; i++) {
      final x = padL + w * i / (months.length - 1);
      final tp = TextPainter(text: TextSpan(text: months[i], style: label), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, padT + h + 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
