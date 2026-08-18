import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    final p = AppPalette.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Team Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final wide = cn.maxWidth >= 900;
          return Wrap(spacing: 12, runSpacing: 12, children: [
            SizedBox(width: wide ? (cn.maxWidth - 24) / 3 : cn.maxWidth, child: _totalCard(context, kTeamStats[0])),
            SizedBox(width: wide ? (cn.maxWidth - 24) / 3 : cn.maxWidth, child: _newCard(context, kTeamStats[1])),
            SizedBox(width: wide ? (cn.maxWidth - 24) / 3 : cn.maxWidth, child: _perfCard(context)),
            SizedBox(width: wide ? (cn.maxWidth - 24) / 3 : cn.maxWidth, child: _satCard(context, kTeamStats[2])),
          ]);
        }),
      ]),
    );
  }

  Widget _totalCard(BuildContext c, TeamStat s) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(s.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          _deltaPill(s.delta ?? ''),
        ]),
        const SizedBox(height: 16),
        Text(s.value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        Container(height: 1, color: p.border),
        const SizedBox(height: 10),
        Text(s.sub ?? '', style: TextStyle(fontSize: 12, color: p.mutedForeground)),
      ]),
    );
  }

  Widget _newCard(BuildContext c, TeamStat s) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(s.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          _deltaPill(s.delta ?? ''),
        ]),
        const SizedBox(height: 16),
        Text(s.value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        SizedBox(height: 40, child: CustomPaint(painter: _MiniBars(), size: Size.infinite)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Text('248', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(width: 6), _deltaPillSmall('+12.1%')]),
            const SizedBox(height: 4),
            Text('Active Leads', style: TextStyle(fontSize: 11, color: p.mutedForeground)),
          ])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Text('192', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)), const SizedBox(width: 6), _deltaPillSmall('+9.1%')]),
            const SizedBox(height: 4),
            Text('Converted Leads', style: TextStyle(fontSize: 11, color: p.mutedForeground)),
          ])),
        ]),
      ]),
    );
  }

  Widget _perfCard(BuildContext c) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Text('Team Performances', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
          Icon(Icons.more_horiz, size: 18, color: p.mutedForeground),
        ]),
        const SizedBox(height: 16),
        SizedBox(height: 180, child: CustomPaint(painter: _GroupedBars(), size: Size.infinite)),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _legend(const Color(0xFF5B4EF3), 'Team 1'), const SizedBox(width: 16),
          _legend(const Color(0xFF10B981), 'Team 2'), const SizedBox(width: 16),
          _legend(const Color(0xFFF59E0B), 'Team 3'),
        ]),
      ]),
    );
  }

  Widget _satCard(BuildContext c, TeamStat s) {
    final p = AppPalette.of(c);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(s.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
          _deltaPill(s.delta ?? ''),
        ]),
        const SizedBox(height: 16),
        Text(s.value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        Container(height: 1, color: p.border),
        const SizedBox(height: 10),
        Text(s.sub ?? '', style: TextStyle(fontSize: 12, color: p.mutedForeground)),
      ]),
    );
  }

  Widget _deltaPill(String s) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(999)),
        child: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.successFg, fontWeight: FontWeight.w600)),
      );

  Widget _deltaPillSmall(String s) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(999)),
        child: Text(s, style: const TextStyle(fontSize: 9, color: AppColors.successFg, fontWeight: FontWeight.w600)),
      );

  Widget _legend(Color c, String s) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(s, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
      ]);
}

class _MiniBars extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final vals = [0.4, 0.55, 0.35, 0.6, 0.85, 0.5];
    final w = size.width / vals.length * 0.7;
    for (int i = 0; i < vals.length; i++) {
      final x = size.width * (i + 0.5) / vals.length - w / 2;
      final h = size.height * vals[i];
      canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(x, size.height - h, w, h),
          topLeft: const Radius.circular(2), topRight: const Radius.circular(2)),
          Paint()..color = const Color(0xFF334155));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GroupedBars extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const padL = 30.0, padB = 20.0;
    final chartW = size.width - padL;
    final chartH = size.height - padB;
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    final data = [[0.55, 0.4, 0.35], [0.7, 0.6, 0.55], [0.6, 0.5, 0.4], [0.5, 0.65, 0.45], [0.4, 0.7, 0.5], [0.55, 0.5, 0.6]];
    final colors = [const Color(0xFF5B4EF3), const Color(0xFF10B981), const Color(0xFFF59E0B)];
    final label = const TextStyle(fontSize: 9, color: AppColors.mutedForeground);
    for (int i = 0; i <= 5; i++) {
      final y = i * chartH / 5;
      canvas.drawLine(Offset(padL, y), Offset(size.width, y), Paint()..color = AppColors.border..strokeWidth = 0.5);
      final tp = TextPainter(text: TextSpan(text: '${(100 - i * 20)}%', style: label), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }
    final groupW = chartW / months.length;
    final barW = groupW / 4;
    for (int i = 0; i < months.length; i++) {
      final gx = padL + i * groupW;
      for (int j = 0; j < 3; j++) {
        final h = chartH * data[i][j];
        canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(gx + groupW * 0.15 + j * barW, chartH - h, barW * 0.9, h),
            topLeft: const Radius.circular(2), topRight: const Radius.circular(2)), Paint()..color = colors[j]);
      }
      final tp = TextPainter(text: TextSpan(text: months[i], style: label), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(gx + groupW / 2 - tp.width / 2, chartH + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
