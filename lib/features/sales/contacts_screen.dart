import 'package:flutter/material.dart';

import '../../core/data/mock_sales_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Contacts', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New contact', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search contacts by name, email, company…', onChanged: (_) {}),
        const SizedBox(height: 16),
        if (mobile) _mobile(context) else _table(context, p),
      ]),
    );
  }

  TextStyle _h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);

  Widget _table(BuildContext c, AppPalette p) {
    return Container(
      decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
          Expanded(flex: 3, child: Text('CONTACT', style: _h())),
          Expanded(flex: 3, child: Text('COMPANY', style: _h())),
          Expanded(flex: 3, child: Text('EMAIL', style: _h())),
          Expanded(flex: 2, child: Text('PHONE', style: _h())),
          Expanded(flex: 3, child: Text('TAGS', style: _h())),
          Expanded(flex: 2, child: Text('OWNER', style: _h())),
          Expanded(flex: 2, child: Text('LAST CONTACT', style: _h())),
        ])),
        for (final ct in kContacts) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 3, child: Row(children: [
              Container(width: 32, height: 32, alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                  child: Text(ct.name.split(' ').map((w) => w[0]).take(2).join(), style: const TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(ct.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(ct.jobTitle, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
              ])),
            ])),
            Expanded(flex: 3, child: Text(ct.company, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 3, child: Text(ct.email, style: const TextStyle(fontSize: 12, color: AppColors.primary), overflow: TextOverflow.ellipsis)),
            Expanded(flex: 2, child: Text(ct.phone, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 3, child: Wrap(spacing: 4, runSpacing: 4, children: [
              for (final t in ct.tags) Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(4)),
                child: Text(t, style: const TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
              ),
            ])),
            Expanded(flex: 2, child: Text(ct.owner, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(ct.lastContacted, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground))),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final ct in kContacts) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 40, height: 40, alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColors.primarySoft, shape: BoxShape.circle),
                child: Text(ct.name.split(' ').map((w) => w[0]).take(2).join(), style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(ct.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              Text('${ct.jobTitle} · ${ct.company}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const SizedBox(height: 4),
              Text(ct.email, style: const TextStyle(fontSize: 12, color: AppColors.primary)),
              Text(ct.phone, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const SizedBox(height: 6),
              Text('Last contact: ${ct.lastContacted}', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
            ])),
          ]),
        )),
      ]);
}
