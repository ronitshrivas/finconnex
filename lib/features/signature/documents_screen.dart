import 'package:flutter/material.dart';

import '../../core/data/mock_signature.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class SignatureDocumentsScreen extends StatefulWidget {
  const SignatureDocumentsScreen({super.key});

  @override
  State<SignatureDocumentsScreen> createState() => _SignatureDocumentsScreenState();
}

class _SignatureDocumentsScreenState extends State<SignatureDocumentsScreen> {
  String _query = '';

  List<SigDoc> get _filtered {
    if (_query.isEmpty) return kSigDocuments;
    final q = _query.toLowerCase();
    return kSigDocuments.where((d) => d.name.toLowerCase().contains(q) || d.recipientPrimary.toLowerCase().contains(q)).toList();
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
          Text('Signature Documents',
              style: TextStyle(fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SearchField(
                  hint: 'Search by document name, signer, or reference...',
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppPalette.of(context).border),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text('Status:',
                        style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                    const SizedBox(width: 4),
                    const Text('All',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 4),
                    Icon(Icons.expand_more, size: 14, color: AppPalette.of(context).mutedForeground),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (mobile)
            _mobileList()
          else
            _table(),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text('Document Name', style: head())),
                Expanded(flex: 3, child: Text('Recipients', style: head())),
                Expanded(flex: 2, child: Text('Owner', style: head())),
                Expanded(flex: 3, child: Text('Related To', style: head())),
                Expanded(flex: 2, child: Text('Status', style: head())),
                Expanded(flex: 2, child: Text('Sent', style: head())),
                Expanded(flex: 3, child: Text('Last Activity', style: head())),
                const SizedBox(width: 80),
              ],
            ),
          ),
          for (int i = 0; i < _filtered.length; i++) ...[
            Divider(height: 1, color: AppPalette.of(context).border),
            _row(_filtered[i]),
          ],
        ],
      ),
    );
  }

  Widget _row(SigDoc d) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppPalette.of(context).muted, borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.description_outlined, size: 16, color: AppColors.mutedForeground),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(d.id, style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < d.recipientInitials.length; i++) ...[
                      if (i > 0) const SizedBox(width: 4),
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i.isEven ? AppColors.primarySoft : AppColors.warningBg,
                          shape: BoxShape.circle,
                        ),
                        child: Text(d.recipientInitials[i],
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: i.isEven ? AppColors.primary : AppColors.warningFg,
                            )),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(d.recipientEmail ?? d.recipientPrimary,
                    style: const TextStyle(fontSize: 11.5, color: AppColors.mutedForeground),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                  child: Text(d.ownerInitials, style: const TextStyle(fontSize: 9, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 6),
                Flexible(child: Text(d.owner, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(d.relatedTo, style: const TextStyle(fontSize: 12.5)),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _statusPill(d.status),
            ),
          ),
          Expanded(flex: 2, child: Text(d.sent, style: const TextStyle(fontSize: 12.5))),
          Expanded(flex: 3, child: Text(d.lastActivity, style: const TextStyle(fontSize: 12.5))),
          SizedBox(
            width: 80,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined, size: 14),
              label: const Text('View', style: TextStyle(fontSize: 12)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: const Size(0, 28),
                side: const BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusPill(SigStatus s) {
    final icon = switch (s) {
      SigStatus.inProgress => Icons.schedule,
      SigStatus.signed => Icons.check_circle_outline,
      SigStatus.draft => Icons.edit_outlined,
      _ => Icons.circle,
    };
    return StatusPill(label: s.label, background: s.bg, foreground: s.fg, icon: icon);
  }

  Widget _mobileList() {
    return Column(
      children: [
        for (final d in _filtered)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppPalette.of(context).card,
                border: Border.all(color: AppPalette.of(context).border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 32, height: 32, alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppPalette.of(context).muted, borderRadius: BorderRadius.circular(6)),
                      child: const Icon(Icons.description_outlined, size: 16, color: AppColors.mutedForeground),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        Text(d.id, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                      ],
                    )),
                    _statusPill(d.status),
                  ]),
                  const SizedBox(height: 10),
                  Text(d.relatedTo, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                  const SizedBox(height: 8),
                  Text('Sent ${d.sent}  ·  ${d.lastActivity}',
                      style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
