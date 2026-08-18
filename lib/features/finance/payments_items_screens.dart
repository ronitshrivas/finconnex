import 'package:flutter/material.dart';

import '../../core/data/mock_finance.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        mobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Payments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(
                      child: PrimaryButton(
                          label: 'Record',
                          icon: Icons.add,
                          onPressed: () {})),
                  const SizedBox(width: 8),
                  Expanded(
                      child: SecondaryButton(
                          label: 'Export',
                          icon: Icons.file_download_outlined,
                          onPressed: () {})),
                ]),
              ])
            : Row(children: [
                const Text('Payments',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const Spacer(),
                SecondaryButton(
                    label: 'Export',
                    icon: Icons.file_download_outlined,
                    onPressed: () {}),
                const SizedBox(width: 10),
                PrimaryButton(
                    label: 'Record payment', icon: Icons.add, onPressed: () {}),
              ]),
        const SizedBox(height: 12),
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
          FilterTab(label: 'All', count: 3, selected: true, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Pending', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Completed', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Failed', count: 1, selected: false, onTap: () {}), const SizedBox(width: 8),
          FilterTab(label: 'Refunded', count: 0, selected: false, onTap: () {}),
        ])),
        const SizedBox(height: 12),
        SearchField(hint: 'Search payments...', width: mobile ? null : 260, onChanged: (_) {}),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
              Expanded(flex: 3, child: Text('PAYMENT', style: _h())),
              Expanded(flex: 2, child: Text('INVOICE', style: _h())),
              Expanded(flex: 3, child: Text('CLIENT', style: _h())),
              Expanded(flex: 2, child: Text('METHOD', style: _h())),
              Expanded(flex: 2, child: Text('STATUS', style: _h())),
              Expanded(flex: 2, child: Text('AMOUNT', style: _h())),
            ])),
            for (final pay in kPayments) ...[
              Divider(height: 1, color: p.border),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(pay.id, style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  Text(pay.date, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                ])),
                Expanded(flex: 2, child: Text(pay.invoice, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 3, child: Text(pay.client, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 2, child: Text(pay.method, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: pay.status.label, background: pay.status.bg, foreground: pay.status.fg))),
                Expanded(flex: 2, child: Text(pay.amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700), textAlign: TextAlign.right)),
              ])),
            ],
          ]),
        ),
      ]),
    );
  }

  TextStyle _h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
}

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: Text(mobile ? 'Items' : 'Items / Services',
                style: TextStyle(
                    fontSize: mobile ? 20 : 22,
                    fontWeight: FontWeight.w700)),
          ),
          PrimaryButton(
              label: mobile ? 'Add' : 'Add item',
              icon: Icons.add,
              onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            FilterTab(label: 'All', count: 5, selected: true, onTap: () {}),
            const SizedBox(width: 8),
            FilterTab(label: 'Active', selected: false, onTap: () {}),
            const SizedBox(width: 8),
            FilterTab(label: 'Inactive', selected: false, onTap: () {}),
          ]),
        ),
        const SizedBox(height: 12),
        SearchField(
            hint: 'Search catalogue...',
            width: mobile ? null : 240,
            onChanged: (_) {}),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(color: p.card, border: Border.all(color: p.border), borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
              Expanded(flex: 4, child: Text('ITEM', style: _h())),
              Expanded(flex: 2, child: Text('TYPE', style: _h())),
              Expanded(flex: 2, child: Text('UNIT', style: _h())),
              Expanded(flex: 1, child: Text('TAX', style: _h())),
              Expanded(flex: 2, child: Text('STATUS', style: _h())),
              Expanded(flex: 2, child: Text('PRICE', style: _h())),
            ])),
            for (final it in kItems) ...[
              Divider(height: 1, color: p.border),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(it.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(it.sku, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                ])),
                Expanded(flex: 2, child: Text(it.type, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 2, child: Text(it.unit, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 1, child: Text(it.tax, style: const TextStyle(fontSize: 12.5))),
                Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: it.status.label, background: it.status.bg, foreground: it.status.fg))),
                Expanded(flex: 2, child: Text(it.price, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700), textAlign: TextAlign.right)),
              ])),
            ],
          ]),
        ),
      ]),
    );
  }

  TextStyle _h() => const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
}
