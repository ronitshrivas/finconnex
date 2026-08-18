import 'package:flutter/material.dart';

import '../../core/data/mock_ops.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          const Text('Resources', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Spacer(),
          SecondaryButton(label: 'Export list', icon: Icons.file_download_outlined, onPressed: () {}),
          const SizedBox(width: 10),
          PrimaryButton(label: 'Upload resource', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'All', count: 7, selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Document', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Video', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Image', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Link', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Template', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Guide', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'FAQ', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          _drop(context, 'All categories'), const SizedBox(width: 8), _drop(context, 'All access'),
        ])),
        const SizedBox(height: 12),
        SearchField(hint: 'Search name, tags, description...', width: mobile ? null : 280, onChanged: (_) {}),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context),
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

  Widget _table(BuildContext c) {
    final p = AppPalette.of(c);
    TextStyle h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          Expanded(flex: 5, child: Text('RESOURCE', style: h())),
          Expanded(flex: 2, child: Text('TYPE', style: h())),
          Expanded(flex: 2, child: Text('CATEGORY', style: h())),
          Expanded(flex: 2, child: Text('ACCESS', style: h())),
          Expanded(flex: 3, child: Text('UPLOADED BY', style: h())),
          Expanded(flex: 2, child: Text('DATE', style: h())),
          Expanded(flex: 2, child: Text('DOWNLOADS', style: h())),
        ])),
        for (final r in kResources) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 5, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(r.id, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
              Text(r.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Wrap(spacing: 4, runSpacing: 4, children: [
                for (final t in r.tags) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: p.muted, borderRadius: BorderRadius.circular(4)),
                  child: Text(t, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
                ),
              ]),
            ])),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: r.type.label, background: r.type.bg, foreground: r.type.fg))),
            Expanded(flex: 2, child: Text(r.category, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: r.access.label, background: r.access.bg, foreground: r.access.fg))),
            Expanded(flex: 3, child: Text(r.uploadedBy, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(r.date, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text('${r.downloads}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final r in kResources) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(r.id, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusPill(label: r.access.label, background: r.access.bg, foreground: r.access.fg),
            ]),
            const SizedBox(height: 4),
            Text(r.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Wrap(spacing: 4, runSpacing: 4, children: [
              StatusPill(label: r.type.label, background: r.type.bg, foreground: r.type.fg),
              for (final t in r.tags) Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppPalette.of(c).muted, borderRadius: BorderRadius.circular(4)),
                child: Text(t, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
              ),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Text(r.uploadedBy, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const Spacer(),
              const Icon(Icons.download, size: 12, color: AppColors.mutedForeground),
              const SizedBox(width: 4),
              Text('${r.downloads}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ]),
        )),
      ]);
}
