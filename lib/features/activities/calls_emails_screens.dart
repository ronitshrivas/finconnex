import 'package:flutter/material.dart';

import '../../core/data/mock_activities_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Calls', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'Log' : 'Log call', icon: Icons.phone_outlined, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search calls…', onChanged: (_) {}),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            for (int i = 0; i < kCalls.length; i++) ...[
              if (i > 0) Divider(height: 1, color: p.border),
              _callRow(context, kCalls[i], mobile),
            ],
          ]),
        ),
      ]),
    );
  }

  Widget _callRow(BuildContext c, CallLog l, bool mobile) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 36, height: 36, alignment: Alignment.center,
          decoration: BoxDecoration(color: l.direction == CallDirection.inbound ? AppColors.successBg : AppColors.infoBg, borderRadius: BorderRadius.circular(8)),
          child: Icon(l.direction == CallDirection.inbound ? Icons.call_received : Icons.call_made, size: 16, color: l.direction == CallDirection.inbound ? AppColors.successFg : AppColors.infoFg)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(l.contact, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600))),
          if (!mobile) StatusPill(label: l.outcome.label, background: l.outcome.bg, foreground: l.outcome.fg),
        ]),
        const SizedBox(height: 2),
        Text(l.related, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.schedule, size: 12, color: AppColors.mutedForeground),
          const SizedBox(width: 4),
          Text(l.when, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
          const SizedBox(width: 12),
          Text(l.duration, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
          const Spacer(),
          if (mobile) StatusPill(label: l.outcome.label, background: l.outcome.bg, foreground: l.outcome.fg)
          else Text(l.owner, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
        ]),
      ])),
    ]));
  }
}

class EmailsScreen extends StatelessWidget {
  const EmailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Emails', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'Send' : 'Compose', icon: Icons.mail_outline, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search subject, recipient…', onChanged: (_) {}),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            for (int i = 0; i < kEmails.length; i++) ...[
              if (i > 0) Divider(height: 1, color: p.border),
              _emailRow(context, kEmails[i]),
            ],
          ]),
        ),
      ]),
    );
  }

  Widget _emailRow(BuildContext c, EmailLog e) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 36, height: 36, alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.mail_outline, size: 16, color: AppColors.primary)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(e.subject, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
          StatusPill(label: e.status.label, background: e.status.bg, foreground: e.status.fg),
        ]),
        const SizedBox(height: 2),
        Text('To: ${e.to}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
        const SizedBox(height: 2),
        Row(children: [
          Text(e.related, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
          const Spacer(),
          Text(e.when, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
        ]),
      ])),
    ]));
  }
}
