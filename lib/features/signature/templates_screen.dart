import 'package:flutter/material.dart';

import '../../core/data/mock_signature.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class SignatureTemplatesScreen extends StatefulWidget {
  const SignatureTemplatesScreen({super.key});

  @override
  State<SignatureTemplatesScreen> createState() => _SignatureTemplatesScreenState();
}

class _SignatureTemplatesScreenState extends State<SignatureTemplatesScreen> {
  String _query = '';

  List<SigTemplate> get _filtered {
    if (_query.isEmpty) return kSigTemplates;
    final q = _query.toLowerCase();
    return kSigTemplates.where((t) => t.name.toLowerCase().contains(q) || t.description.toLowerCase().contains(q)).toList();
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
          mobile
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Signature Templates', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  SearchField(hint: 'Search templates...', onChanged: (v) => setState(() => _query = v)),
                  const SizedBox(height: 8),
                  PrimaryButton(label: 'New Template', icon: Icons.add, onPressed: () {}),
                ])
              : Row(children: [
                  const Text('Signature Templates', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  SearchField(hint: 'Search templates...', width: 240, onChanged: (v) => setState(() => _query = v)),
                  const SizedBox(width: 10),
                  PrimaryButton(label: 'New Template', icon: Icons.add, onPressed: () {}),
                ]),
          const SizedBox(height: 16),
          if (mobile) _mobileList() else _table(),
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
                Expanded(flex: 3, child: Text('TEMPLATE NAME', style: head())),
                Expanded(flex: 5, child: Text('DESCRIPTION', style: head())),
                Expanded(flex: 2, child: Text('LAST UPDATED', style: head())),
                Expanded(flex: 3, child: Text('CREATED BY', style: head())),
                const SizedBox(width: 80),
              ],
            ),
          ),
          for (final t in _filtered) ...[
            Divider(height: 1, color: AppPalette.of(context).border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(6)),
                          child: const Icon(Icons.description_outlined, size: 15, color: AppColors.primary),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(child: Text(t.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(color: AppColors.neutralBg, borderRadius: BorderRadius.circular(4)),
                                child: const Text('Draft', style: TextStyle(fontSize: 10, color: AppColors.neutralFg, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 5, child: Text(t.description, style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
                  Expanded(flex: 2, child: Text(t.lastUpdated, style: const TextStyle(fontSize: 12.5))),
                  Expanded(
                    flex: 3,
                    child: Row(children: [
                      Container(
                        width: 22, height: 22, alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                        child: Text(t.createdByInitials, style: const TextStyle(fontSize: 9, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 6),
                      Flexible(child: Text(t.createdBy, style: const TextStyle(fontSize: 12.5))),
                    ]),
                  ),
                  SizedBox(
                    width: 80,
                    child: Row(children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          minimumSize: const Size(0, 28),
                        ),
                        child: const Text('Use', style: TextStyle(fontSize: 12)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.more_vert, size: 16, color: AppColors.mutedForeground),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _mobileList() {
    return Column(children: [
      for (final t in _filtered)
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
                    decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(6)),
                    child: const Icon(Icons.description_outlined, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(t.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: AppColors.neutralBg, borderRadius: BorderRadius.circular(4)),
                    child: const Text('Draft', style: TextStyle(fontSize: 10, color: AppColors.neutralFg, fontWeight: FontWeight.w600)),
                  ),
                ]),
                const SizedBox(height: 8),
                Text(t.description, style: const TextStyle(fontSize: 12.5, color: AppColors.mutedForeground)),
                const SizedBox(height: 10),
                Row(children: [
                  Container(
                    width: 20, height: 20, alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.warningBg, shape: BoxShape.circle),
                    child: Text(t.createdByInitials, style: const TextStyle(fontSize: 9, color: AppColors.warningFg, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(child: Text(t.createdBy, style: const TextStyle(fontSize: 12))),
                  Text(t.lastUpdated, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                ]),
              ],
            ),
          ),
        ),
    ]);
  }
}
