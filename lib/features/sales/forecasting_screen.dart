import 'package:flutter/material.dart';

import '../../core/data/mock_sales_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';

class ForecastingScreen extends StatelessWidget {
  const ForecastingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Forecasting', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          SecondaryButton(label: 'Export', icon: Icons.file_download_outlined, onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (ctx, cn) {
          final cols = cn.maxWidth < 640 ? 1 : 4;
          const gap = 12.0;
          final w = (cn.maxWidth - gap * (cols - 1)) / cols;
          final totalCommit = kForecast.fold<double>(0, (s, e) => s + _parse(e.commit));
          final totalBest = kForecast.fold<double>(0, (s, e) => s + _parse(e.bestCase));
          final totalPipe = kForecast.fold<double>(0, (s, e) => s + _parse(e.pipeline));
          final totalQuota = kForecast.fold<double>(0, (s, e) => s + _parse(e.quota));
          final stats = [
            ('COMMIT', '\$${totalCommit.toStringAsFixed(0)}k', AppColors.successFg),
            ('BEST CASE', '\$${totalBest.toStringAsFixed(0)}k', AppColors.infoFg),
            ('PIPELINE', '\$${totalPipe.toStringAsFixed(0)}k', AppColors.primary),
            ('QUOTA', '\$${totalQuota.toStringAsFixed(0)}k', AppColors.mutedForeground),
          ];
          return Wrap(spacing: gap, runSpacing: gap, children: [
            for (final s in stats) SizedBox(width: w, child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.$1, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6)),
                const SizedBox(height: 10),
                Text(s.$2, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: s.$3)),
              ]),
            )),
          ]);
        }),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
              Expanded(flex: 3, child: Text('REP', style: _h())),
              Expanded(flex: 2, child: Text('COMMIT', style: _h())),
              Expanded(flex: 2, child: Text('BEST CASE', style: _h())),
              Expanded(flex: 2, child: Text('PIPELINE', style: _h())),
              Expanded(flex: 2, child: Text('QUOTA', style: _h())),
              Expanded(flex: 3, child: Text('ATTAINMENT', style: _h())),
            ])),
            for (final f in kForecast) ...[
              Divider(height: 1, color: p.border),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                Expanded(flex: 3, child: Row(children: [
                  Container(width: 28, height: 28, alignment: Alignment.center,
                      decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                      child: Text(f.initials, style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600))),
                  const SizedBox(width: 10),
                  Expanded(child: Text(f.owner, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                ])),
                Expanded(flex: 2, child: Text(f.commit, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.successFg))),
                Expanded(flex: 2, child: Text(f.bestCase, style: const TextStyle(fontSize: 13, color: AppColors.infoFg))),
                Expanded(flex: 2, child: Text(f.pipeline, style: const TextStyle(fontSize: 13))),
                Expanded(flex: 2, child: Text(f.quota, style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground))),
                Expanded(flex: 3, child: Row(children: [
                  SizedBox(width: 44, child: Text('${(f.attainment * 100).round()}%', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700))),
                  Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(999), child: LinearProgressIndicator(
                    value: f.attainment, minHeight: 6,
                    backgroundColor: AppColors.muted,
                    valueColor: AlwaysStoppedAnimation(f.attainment >= 0.7 ? AppColors.successFg : f.attainment >= 0.5 ? AppColors.warningFg : AppColors.dangerFg),
                  ))),
                ])),
              ])),
            ],
          ]),
        ),
      ]),
    );
  }

  TextStyle _h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
  double _parse(String s) => double.tryParse(s.replaceAll(RegExp(r'[\$k,]'), '')) ?? 0;
}
