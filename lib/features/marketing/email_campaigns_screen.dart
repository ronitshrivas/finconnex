import 'package:flutter/material.dart';

import '../../core/data/mock_marketing.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class EmailCampaignsScreen extends StatefulWidget {
  const EmailCampaignsScreen({super.key});

  @override
  State<EmailCampaignsScreen> createState() => _EmailCampaignsScreenState();
}

class _EmailCampaignsScreenState extends State<EmailCampaignsScreen> {
  String _query = '';
  List<EmailCampaign> get _rows {
    if (_query.isEmpty) return kEmailCampaigns;
    final q = _query.toLowerCase();
    return kEmailCampaigns.where((c) => c.name.toLowerCase().contains(q) || c.subject.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(mobile, 'Email Campaigns', kEmailCampaigns.length),
          const SizedBox(height: 16),
          _toolbar(mobile),
          const SizedBox(height: 16),
          if (mobile) _mobile() else _table(),
          const SizedBox(height: 12),
          _footer(_rows.length),
        ],
      ),
    );
  }

  Widget _header(bool mobile, String title, int count) {
    final btns = Row(mainAxisSize: MainAxisSize.min, children: [
      SecondaryButton(label: 'Export', icon: Icons.file_download_outlined, onPressed: () {}),
      const SizedBox(width: 10),
      PrimaryButton(label: 'New campaign', icon: Icons.add, onPressed: () {}),
    ]);
    if (mobile) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          _countChip(count),
        ]),
        const SizedBox(height: 12),
        btns,
      ]);
    }
    return Row(children: [
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
      const SizedBox(width: 8),
      _countChip(count),
      const Spacer(),
      btns,
    ]);
  }

  Widget _countChip(int c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(999)),
        child: Text('$c', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
      );

  Widget _toolbar(bool mobile) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Text('All', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(color: Colors.white.withAlpha(60), borderRadius: BorderRadius.circular(999)),
          child: Text('${kEmailCampaigns.length}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.expand_more, size: 14, color: Colors.white),
      ]),
    );
    final filterBtn = OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.tune, size: 14),
      label: const Text('Filter', style: TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(0, 34),
      ),
    );
    if (mobile) {
      return Column(children: [
        SearchField(hint: 'Search...', onChanged: (v) => setState(() => _query = v)),
        const SizedBox(height: 8),
        Row(children: [chip, const Spacer(), filterBtn]),
      ]);
    }
    return Row(children: [
      chip,
      const Spacer(),
      SearchField(hint: 'Search...', width: 240, onChanged: (v) => setState(() => _query = v)),
      const SizedBox(width: 8),
      filterBtn,
    ]);
  }

  Widget _table() {
    TextStyle head() => const TextStyle(
        fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Container(
      decoration: BoxDecoration(
        color: AppPalette.of(context).card,
        border: Border.all(color: AppPalette.of(context).border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(children: [
            Expanded(flex: 3, child: Text('TYPE', style: head())),
            Expanded(flex: 2, child: Text('CAMPAIGN', style: head())),
            Expanded(flex: 4, child: Text('SUBJECT', style: head())),
            Expanded(flex: 3, child: Text('AUDIENCE', style: head())),
            Expanded(flex: 2, child: Text('STATUS', style: head())),
            Expanded(flex: 1, child: Text('SENT', style: head())),
            Expanded(flex: 2, child: Text('OPEN / CLICK', style: head())),
            Expanded(flex: 3, child: Text('CREATED BY', style: head())),
          ]),
        ),
        for (final c in _rows) ...[
          Divider(height: 1, color: AppPalette.of(context).border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              Expanded(flex: 3, child: Text(c.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Text(c.type, style: const TextStyle(fontSize: 12.5))),
              Expanded(flex: 4, child: Text(c.subject, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 3, child: Text(c.audience, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: c.status.label, background: c.status.bg, foreground: c.status.fg))),
              Expanded(flex: 1, child: Text('${c.sent}', style: const TextStyle(fontSize: 12.5))),
              Expanded(
                flex: 2,
                child: Row(children: [
                  Text(c.open ?? '‒', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 6),
                  Text(c.click ?? '', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                ]),
              ),
              Expanded(flex: 3, child: Row(children: [
                Container(
                  width: 22, height: 22, alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                  child: Text(c.createdByInitials, style: const TextStyle(fontSize: 9, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 6),
                Flexible(child: Text(c.createdBy, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              ])),
            ]),
          ),
        ],
      ]),
    );
  }

  Widget _mobile() => Column(children: [
        for (final c in _rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppPalette.of(context).card,
                border: Border.all(color: AppPalette.of(context).border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(c.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                  StatusPill(label: c.status.label, background: c.status.bg, foreground: c.status.fg),
                ]),
                const SizedBox(height: 4),
                Text('${c.type}  ·  ${c.audience}', style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                const SizedBox(height: 8),
                Text(c.subject, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 10),
                Row(children: [
                  Text('${c.sent} sent', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  if (c.open != null) ...[
                    const SizedBox(width: 12),
                    Text('${c.open} open', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Text('${c.click} click', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  ],
                  const Spacer(),
                  Container(
                    width: 20, height: 20, alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                    child: Text(c.createdByInitials, style: const TextStyle(fontSize: 9, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 4),
                  Text(c.createdBy, style: const TextStyle(fontSize: 11)),
                ]),
              ]),
            ),
          ),
      ]);

  Widget _footer(int count) => Row(children: [
        Text('Showing 1–$count of $count', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
        const Spacer(),
        const Text('1 / 1', style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
      ]);
}
