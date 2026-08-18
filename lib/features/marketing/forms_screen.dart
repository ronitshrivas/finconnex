import 'package:flutter/material.dart';

import '../../core/data/mock_marketing.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  State<FormsScreen> createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  String _query = '';
  List<FormEntry> get _rows {
    if (_query.isEmpty) return kForms;
    final q = _query.toLowerCase();
    return kForms.where((f) => f.name.toLowerCase().contains(q)).toList();
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
            const Text('Forms', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(999)),
              child: Text('${kForms.length}', style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            PrimaryButton(label: 'New form', icon: Icons.add, onPressed: () {}),
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
                  child: Text('${kForms.length}', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
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
            Expanded(flex: 3, child: Text('FORM', style: head())),
            Expanded(flex: 3, child: Text('PUBLIC URL', style: head())),
            Expanded(flex: 2, child: Text('ROUTES TO', style: head())),
            Expanded(flex: 2, child: Text('STATUS', style: head())),
            Expanded(flex: 1, child: Text('FIELDS', style: head())),
            Expanded(flex: 2, child: Text('SUBMISSIONS', style: head())),
            Expanded(flex: 2, child: Text('UPDATED', style: head())),
          ]),
        ),
        for (final f in _rows) ...[
          Divider(height: 1, color: AppPalette.of(context).border),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(children: [
              Expanded(flex: 3, child: Text(f.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
              Expanded(
                flex: 3,
                child: Row(children: [
                  Flexible(child: Text(f.url, style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: AppColors.primary), overflow: TextOverflow.ellipsis)),
                  const SizedBox(width: 4),
                  const Icon(Icons.open_in_new, size: 12, color: AppColors.primary),
                ]),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusPill(label: f.routesTo, background: f.routesBg, foreground: f.routesFg),
                    ),
                    if (f.journey) ...[
                      const SizedBox(height: 2),
                      const Text('+ journey', style: TextStyle(fontSize: 10.5, color: AppColors.mutedForeground)),
                    ],
                  ],
                ),
              ),
              Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusPill(label: f.status.label, background: f.status.bg, foreground: f.status.fg))),
              Expanded(flex: 1, child: Text('${f.fields}', style: const TextStyle(fontSize: 12.5))),
              Expanded(flex: 2, child: Text('${f.submissions}', style: const TextStyle(fontSize: 12.5))),
              Expanded(flex: 2, child: Text(f.updated, style: const TextStyle(fontSize: 12.5))),
            ]),
          ),
        ],
      ]),
    );
  }

  Widget _mobile() => Column(children: [
        for (final f in _rows)
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
                  Expanded(child: Text(f.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                  StatusPill(label: f.status.label, background: f.status.bg, foreground: f.status.fg),
                ]),
                const SizedBox(height: 6),
                Row(children: [
                  Flexible(child: Text(f.url, style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: AppColors.primary))),
                  const SizedBox(width: 4),
                  const Icon(Icons.open_in_new, size: 12, color: AppColors.primary),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  StatusPill(label: f.routesTo, background: f.routesBg, foreground: f.routesFg),
                  const Spacer(),
                  Text('${f.fields} fields', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  const SizedBox(width: 12),
                  Text('${f.submissions} submissions', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ]),
              ]),
            ),
          ),
      ]);
}
