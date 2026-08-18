import 'package:flutter/material.dart';

import '../../core/data/mock_activities_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class AttachmentsScreen extends StatelessWidget {
  const AttachmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Attachments', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'Upload' : 'Upload file', icon: Icons.upload_outlined, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search files…', onChanged: (_) {}),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            for (int i = 0; i < kAttachments.length; i++) ...[
              if (i > 0) Divider(height: 1, color: p.border),
              _row(kAttachments[i]),
            ],
          ]),
        ),
      ]),
    );
  }

  Widget _row(Attachment a) {
    final color = switch (a.ext) {
      'pdf' => AppColors.dangerFg,
      'docx' => AppColors.infoFg,
      'xlsx' => AppColors.successFg,
      'png' || 'jpg' => AppColors.warningFg,
      _ => AppColors.mutedForeground,
    };
    final bg = switch (a.ext) {
      'pdf' => AppColors.dangerBg,
      'docx' => AppColors.infoBg,
      'xlsx' => AppColors.successBg,
      'png' || 'jpg' => AppColors.warningBg,
      _ => AppColors.neutralBg,
    };
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(children: [
      Container(width: 40, height: 40, alignment: Alignment.center,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Text(a.ext.toUpperCase(), style: TextStyle(fontSize: 10.5, color: color, fontWeight: FontWeight.w700))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(a.filename, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
        const SizedBox(height: 2),
        Text('${a.size} · ${a.related}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      ])),
      Text(a.when, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      const SizedBox(width: 8),
      const Icon(Icons.download, size: 16, color: AppColors.mutedForeground),
    ]));
  }
}

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});
  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late List<bool> _done = kReminders.map((r) => r.completed).toList();

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Reminders', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New reminder', icon: Icons.notifications_none, onPressed: () {}),
        ]),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            for (int i = 0; i < kReminders.length; i++) ...[
              if (i > 0) Divider(height: 1, color: p.border),
              _row(i, kReminders[i]),
            ],
          ]),
        ),
      ]),
    );
  }

  Widget _row(int i, Reminder r) {
    final done = _done[i];
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [
      Checkbox(value: done, onChanged: (v) => setState(() => _done[i] = v ?? false), activeColor: AppColors.primary),
      const SizedBox(width: 4),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(r.title, style: TextStyle(
          fontSize: 13.5, fontWeight: FontWeight.w600,
          decoration: done ? TextDecoration.lineThrough : null,
          color: done ? AppColors.mutedForeground : AppColors.foreground,
        )),
        const SizedBox(height: 2),
        Text(r.related, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(r.dueDate, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: r.priority.color)),
        Text(r.dueTime, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
      ]),
      const SizedBox(width: 8),
      Container(width: 6, height: 40, decoration: BoxDecoration(color: r.priority.color, borderRadius: BorderRadius.circular(3))),
    ]));
  }
}
