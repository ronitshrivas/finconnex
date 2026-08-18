import 'package:flutter/material.dart';

import '../../core/data/mock_sales_more.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(child: Text('Companies', style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700))),
          PrimaryButton(label: mobile ? 'New' : 'New company', icon: Icons.add, onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SearchField(hint: 'Search companies…', onChanged: (_) {}),
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
          Expanded(flex: 3, child: Text('COMPANY', style: _h())),
          Expanded(flex: 2, child: Text('INDUSTRY', style: _h())),
          Expanded(flex: 2, child: Text('SIZE', style: _h())),
          Expanded(flex: 1, child: Text('DEALS', style: _h())),
          Expanded(flex: 1, child: Text('CONTACTS', style: _h())),
          Expanded(flex: 2, child: Text('REVENUE', style: _h())),
          Expanded(flex: 2, child: Text('OWNER', style: _h())),
        ])),
        for (final co in kCompanies) ...[
          Divider(height: 1, color: p.border),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
            Expanded(flex: 3, child: Row(children: [
              Container(width: 32, height: 32, alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.warningBg, borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.business_outlined, size: 16, color: AppColors.warningFg)),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(co.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(co.website, style: const TextStyle(fontSize: 11.5, color: AppColors.primary)),
              ])),
            ])),
            Expanded(flex: 2, child: Text(co.industry, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 2, child: Text(co.size, style: const TextStyle(fontSize: 12.5))),
            Expanded(flex: 1, child: Text('${co.deals}', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
            Expanded(flex: 1, child: Text('${co.contacts}', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600))),
            Expanded(flex: 2, child: Text(co.revenue, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
            Expanded(flex: 2, child: Text(co.owner, style: const TextStyle(fontSize: 12.5))),
          ])),
        ],
      ]),
    );
  }

  Widget _mobile(BuildContext c) => Column(children: [
        for (final co in kCompanies) Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppPalette.of(c).card, border: Border.all(color: AppPalette.of(c).border), borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 40, height: 40, alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColors.warningBg, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.business_outlined, size: 18, color: AppColors.warningFg)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(co.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text('${co.industry} · ${co.size}', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              ])),
              Text(co.revenue, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              _stat('${co.deals}', 'Deals'),
              const SizedBox(width: 20),
              _stat('${co.contacts}', 'Contacts'),
              const Spacer(),
              Text(co.website, style: const TextStyle(fontSize: 12, color: AppColors.primary)),
            ]),
          ]),
        )),
      ]);

  Widget _stat(String v, String l) => Row(children: [
        Text(v, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
        const SizedBox(width: 4),
        Text(l, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
      ]);
}
