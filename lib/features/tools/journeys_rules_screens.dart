import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/status_pill.dart';

class _Journey {
  final String id, name, trigger;
  final int contacts;
  final int steps;
  final bool active;
  const _Journey(this.id, this.name, this.trigger, this.contacts, this.steps, this.active);
}

const _journeys = <_Journey>[
  _Journey('JRN-1001', 'Warm mortgage lead drip', 'Lead form submitted · Mortgage', 96, 5, true),
  _Journey('JRN-1002', 'Renewal reminder cadence', 'Deal · closed won · anniversary', 42, 4, true),
  _Journey('JRN-1003', 'Post-close welcome', 'Deal · closed won', 24, 3, true),
  _Journey('JRN-1004', 'Cold reactivation', 'Contact · no touch 90 days', 138, 6, false),
];

class JourneysScreen extends StatelessWidget {
  const JourneysScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Journeys', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New journey', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 4),
        Text('Automated multi-step flows triggered by lifecycle events.',
            style: TextStyle(fontSize: 13, color: p.mutedForeground)),
        const SizedBox(height: 16),
        for (final j in _journeys) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 44, height: 44, alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.route_outlined, size: 20, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(j.name, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600)),
                Text(j.id, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
              ])),
              j.active
                  ? StatusPill.success('Active')
                  : StatusPill.neutral('Paused'),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.bolt, size: 13, color: AppColors.warningFg),
              const SizedBox(width: 4),
              Expanded(child: Text('Trigger: ${j.trigger}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground))),
            ]),
            const SizedBox(height: 12),
            Divider(height: 1, color: p.border),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _stat('${j.contacts}', 'In flow')),
              Expanded(child: _stat('${j.steps}', 'Steps')),
              const Icon(Icons.settings_outlined, size: 16, color: AppColors.mutedForeground),
            ]),
          ]),
        )),
      ]),
    );
  }

  Widget _stat(String v, String l) => Row(children: [
        Text(v, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(width: 4),
        Text(l, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      ]);
}

class _Rule {
  final String id, name, when, then;
  final int triggered;
  final bool active;
  const _Rule(this.id, this.name, this.when, this.then, this.triggered, this.active);
}

const _rules = <_Rule>[
  _Rule('RUL-1', 'Round-robin new leads', 'When a new lead is created', 'Assign to next rep in rotation', 312, true),
  _Rule('RUL-2', 'Escalate high-priority tickets', 'When ticket priority is Critical', 'Notify #support-oncall in Slack', 24, true),
  _Rule('RUL-3', 'Auto-mark cold leads', 'When a lead has 0 touches in 30 days', 'Set status to Unqualified', 46, true),
  _Rule('RUL-4', 'Deal-value threshold', 'When deal value > \$50k', 'Assign owner: Manager for review', 18, true),
  _Rule('RUL-5', 'Weekend office-hours reply', 'When email received Sat/Sun', 'Send auto-reply "Back Monday"', 0, false),
];

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Rules', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New rule', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 4),
        Text('If-this-then-that automations that run in the background.',
            style: TextStyle(fontSize: 13, color: p.mutedForeground)),
        const SizedBox(height: 16),
        for (final r in _rules) Padding(padding: const EdgeInsets.only(bottom: 10), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Container(width: 36, height: 36, alignment: Alignment.center,
                decoration: BoxDecoration(color: r.active ? AppColors.successBg : AppColors.neutralBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.rule_outlined, size: 18, color: r.active ? AppColors.successFg : AppColors.mutedForeground)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('When ${r.when.substring(5)} → ${r.then}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
              const SizedBox(height: 4),
              Text('Triggered ${r.triggered}× · ${r.id}', style: const TextStyle(fontSize: 11, color: AppColors.subtleText)),
            ])),
            Switch(value: r.active, onChanged: (_) {}, activeColor: AppColors.primary),
          ]),
        )),
      ]),
    );
  }
}
