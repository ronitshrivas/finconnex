import 'package:flutter/material.dart';

import '../../core/data/mock_dashboard.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(mobile: mobile),
          SizedBox(height: mobile ? 16 : 20),
          _KpiGrid(mobile: mobile),
          SizedBox(height: mobile ? 16 : 20),
          if (mobile) ...[
            const _RevenueChartCard(),
            const SizedBox(height: 12),
            const _PipelineCard(),
            const SizedBox(height: 12),
            const _ActivityCard(),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(flex: 2, child: _RevenueChartCard()),
                SizedBox(width: 16),
                Expanded(flex: 1, child: _PipelineCard()),
              ],
            ),
          if (!mobile) ...[
            const SizedBox(height: 20),
            const _ActivityCard(),
          ],
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool mobile;
  const _Header({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dashboard',
            style: TextStyle(
                fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text(
          'Welcome back, John. Here\'s what\'s happening today.',
          style: TextStyle(fontSize: 13.5, color: AppColors.mutedForeground),
        ),
      ],
    );
  }
}

class _KpiGrid extends StatelessWidget {
  final bool mobile;
  const _KpiGrid({required this.mobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = w < 640 ? 1 : (w < 1024 ? 2 : 4);
        const gap = 12.0;
        final cardW = (w - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final k in kMockKpis)
              SizedBox(width: cardW, child: _KpiCard(stat: k)),
          ],
        );
      },
    );
  }
}

class _KpiCard extends StatelessWidget {
  final KpiStat stat;
  const _KpiCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: stat.iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(stat.icon, size: 18, color: stat.iconFg),
              ),
              const Spacer(),
              Icon(
                stat.positive ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color:
                    stat.positive ? AppColors.successFg : AppColors.dangerFg,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(stat.value,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(stat.label,
              style: const TextStyle(
                  fontSize: 12.5, color: AppColors.mutedForeground)),
          const SizedBox(height: 6),
          Text(
            stat.delta,
            style: TextStyle(
              fontSize: 11.5,
              color:
                  stat.positive ? AppColors.successFg : AppColors.dangerFg,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RevenueChartCard extends StatelessWidget {
  const _RevenueChartCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Revenue trend',
      subtitle: 'Last 8 months',
      child: SizedBox(
        height: 220,
        child: CustomPaint(
          painter: _RevenueChartPainter(),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _RevenueChartPainter extends CustomPainter {
  static const _values = [42.0, 55.0, 48.0, 68.0, 74.0, 62.0, 88.0, 95.0];
  static const _labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];

  @override
  void paint(Canvas canvas, Size size) {
    const chartPadLeft = 32.0;
    const chartPadRight = 8.0;
    const chartPadTop = 8.0;
    const chartPadBottom = 28.0;

    final chartW = size.width - chartPadLeft - chartPadRight;
    final chartH = size.height - chartPadTop - chartPadBottom;

    final maxV = _values.reduce((a, b) => a > b ? a : b);
    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;

    final labelStyle = const TextStyle(
      fontSize: 10,
      color: AppColors.mutedForeground,
    );

    // Horizontal gridlines with y labels
    for (var i = 0; i <= 4; i++) {
      final y = chartPadTop + chartH * i / 4;
      canvas.drawLine(
        Offset(chartPadLeft, y),
        Offset(size.width - chartPadRight, y),
        gridPaint,
      );
      final v = (maxV * (1 - i / 4)).round();
      final tp = TextPainter(
        text: TextSpan(text: '\$${v}k', style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }

    // Line path
    final points = <Offset>[];
    for (var i = 0; i < _values.length; i++) {
      final x = chartPadLeft + chartW * i / (_values.length - 1);
      final y = chartPadTop + chartH * (1 - _values[i] / maxV);
      points.add(Offset(x, y));
    }

    // Filled area under the line
    final areaPath = Path()..moveTo(points.first.dx, chartPadTop + chartH);
    for (final p in points) {
      areaPath.lineTo(p.dx, p.dy);
    }
    areaPath.lineTo(points.last.dx, chartPadTop + chartH);
    areaPath.close();
    final areaPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withAlpha(60),
          AppColors.primary.withAlpha(0),
        ],
      ).createShader(Rect.fromLTWH(0, chartPadTop, size.width, chartH));
    canvas.drawPath(areaPath, areaPaint);

    // Line
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(linePath, linePaint);

    // Dots
    final dotFill = Paint()..color = Colors.white;
    final dotStroke = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (final p in points) {
      canvas.drawCircle(p, 3.5, dotFill);
      canvas.drawCircle(p, 3.5, dotStroke);
    }

    // X-axis labels
    for (var i = 0; i < _labels.length; i++) {
      final tp = TextPainter(
        text: TextSpan(text: _labels[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(points[i].dx - tp.width / 2, chartPadTop + chartH + 8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PipelineCard extends StatelessWidget {
  const _PipelineCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Sales pipeline',
      subtitle: 'By stage',
      child: Column(
        children: [
          for (int i = 0; i < kPipeline.length; i++) ...[
            if (i > 0) const SizedBox(height: 14),
            _pipelineRow(kPipeline[i]),
          ],
        ],
      ),
    );
  }

  Widget _pipelineRow(PipelineStage s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(s.name,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500)),
            ),
            Text('${s.count}',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            Text(s.value,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.mutedForeground)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: s.pct,
            minHeight: 6,
            backgroundColor: AppColors.muted,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Recent activity',
      trailing: TextButton(
        onPressed: () {},
        child: const Text('View all',
            style: TextStyle(color: AppColors.primary, fontSize: 13)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < kActivities.length; i++) ...[
            if (i > 0) const Divider(height: 20),
            _row(kActivities[i]),
          ],
        ],
      ),
    );
  }

  Widget _row(ActivityItem a) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: a.iconBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(a.icon, size: 18, color: a.iconFg),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(a.title,
                  style: const TextStyle(
                      fontSize: 13.5, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(a.subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.mutedForeground)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(a.time,
            style: const TextStyle(
                fontSize: 11.5, color: AppColors.mutedForeground)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.mutedForeground)),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
