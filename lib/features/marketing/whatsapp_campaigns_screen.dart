import 'package:flutter/material.dart';

import '../../core/data/mock_marketing.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class WhatsAppCampaignsScreen extends StatefulWidget {
  const WhatsAppCampaignsScreen({super.key});

  @override
  State<WhatsAppCampaignsScreen> createState() => _WhatsAppCampaignsScreenState();
}

class _WhatsAppCampaignsScreenState extends State<WhatsAppCampaignsScreen> {
  String _query = '';
  List<WaCampaign> get _rows {
    if (_query.isEmpty) return kWaCampaigns;
    final q = _query.toLowerCase();
    return kWaCampaigns.where((c) => c.name.toLowerCase().contains(q)).toList();
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
          Row(children: [
            const Text('WhatsApp Campaigns', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(999)),
              child: Text('${kWaCampaigns.length}', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            SecondaryButton(label: 'Export', icon: Icons.file_download_outlined, onPressed: () {}),
            const SizedBox(width: 10),
            PrimaryButton(label: 'New campaign', icon: Icons.add, onPressed: () {}),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('All', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: Colors.white.withAlpha(60), borderRadius: BorderRadius.circular(999)),
                  child: Text('${kWaCampaigns.length}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ]),
            ),
            const Spacer(),
            SearchField(hint: 'Search...', width: mobile ? null : 240, onChanged: (v) => setState(() => _query = v)),
          ]),
          const SizedBox(height: 16),
          if (mobile) _mobile() else _table(),
        ],
      ),
    );
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
            Expanded(flex: 3, child: Text('CAMPAIGN', style: head())),
            Expanded(flex: 3, child: Text('TEMPLATE', style: head())),
            Expanded(flex: 2, child: Text('APPROVAL', style: head())),
            Expanded(flex: 3, child: Text('AUDIENCE', style: head())),
            Expanded(flex: 2, child: Text('STATUS', style: head())),
            Expanded(flex: 2, child: Text('SENT / READ', style: head())),
            Expanded(flex: 3, child: Text('CREATED BY', style: head())),
          ]),
        ),
        for (final c in _rows) ...[
          Divider(height: 1, color: AppPalette.of(context).border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              Expanded(flex: 3, child: Text(c.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
              Expanded(
                flex: 3,
                child: Text(c.template,
                    style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: AppColors.mutedForeground),
                    overflow: TextOverflow.ellipsis),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: StatusPill(label: c.approvalLabel, background: c.approvalBg, foreground: c.approvalFg),
                ),
              ),
              Expanded(flex: 3, child: Text(c.audience, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: c.status.label, background: c.status.bg, foreground: c.status.fg))),
              Expanded(flex: 2, child: Text(c.sentRead, style: const TextStyle(fontSize: 12.5))),
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
                const SizedBox(height: 6),
                Text(c.template, style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace', color: AppColors.mutedForeground)),
                const SizedBox(height: 8),
                Row(children: [
                  StatusPill(label: c.approvalLabel, background: c.approvalBg, foreground: c.approvalFg),
                  const Spacer(),
                  Text(c.sentRead, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ]),
                const SizedBox(height: 8),
                Text(c.audience, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ]),
            ),
          ),
      ]);
}
