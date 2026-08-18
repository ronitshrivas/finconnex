import 'package:flutter/material.dart';

import '../../core/data/mock_signature.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/status_pill.dart';

class SignatureOverviewScreen extends StatefulWidget {
  const SignatureOverviewScreen({super.key});

  @override
  State<SignatureOverviewScreen> createState() => _SignatureOverviewScreenState();
}

class _SignatureOverviewScreenState extends State<SignatureOverviewScreen> {
  int _tab = 0; // 0=Recent Documents, 1=Recent Templates

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(mobile: mobile),
          const SizedBox(height: 16),
          _StatsGrid(),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppPalette.of(context).card,
              border: Border.all(color: AppPalette.of(context).border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  child: Row(
                    children: [
                      _tabBtn('Recent Documents', 0),
                      const SizedBox(width: 24),
                      _tabBtn('Recent Templates', 1),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
                        label: const Text('View all',
                            style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppPalette.of(context).border),
                if (_tab == 0)
                  mobile ? _mobileList() : _table()
                else
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: Text('No recent templates', style: TextStyle(color: AppColors.mutedForeground))),
                  ),
                Divider(height: 1, color: AppPalette.of(context).border),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      const Text('Showing 1 to 4 of 4 documents',
                          style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                      const Spacer(),
                      _pageBtn('«'),
                      const SizedBox(width: 4),
                      _pageBtn('‹'),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 4),
                      _pageBtn('›'),
                      const SizedBox(width: 4),
                      _pageBtn('»'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBtn(String label, int i) {
    final active = _tab == i;
    return GestureDetector(
      onTap: () => setState(() => _tab = i),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: active ? AppColors.primary : AppPalette.of(context).foreground,
            )),
      ),
    );
  }

  Widget _pageBtn(String s) => Container(
        width: 28,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(s, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
      );

  Widget _table() {
    TextStyle head() => const TextStyle(
        fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground, letterSpacing: 0.6);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Expanded(flex: 4, child: Text('DOCUMENT NAME', style: head())),
              Expanded(flex: 3, child: Text('APPLICANTS / RECIPIENTS', style: head())),
              Expanded(flex: 2, child: Text('OWNER', style: head())),
              Expanded(flex: 3, child: Text('RELATED TO', style: head())),
              Expanded(flex: 2, child: Text('STATUS', style: head())),
              Expanded(flex: 2, child: Text('SENT', style: head())),
              Expanded(flex: 2, child: Text('LAST ACTIVITY', style: head())),
              const SizedBox(width: 88),
            ],
          ),
        ),
        Divider(height: 1, color: AppPalette.of(context).border),
        for (int i = 0; i < kSigRecent.length; i++) ...[
          if (i > 0) Divider(height: 1, color: AppPalette.of(context).border),
          _row(kSigRecent[i]),
        ],
      ],
    );
  }

  Widget _row(SigDoc d) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                  decoration: BoxDecoration(
                      color: AppPalette.of(context).muted, borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.description_outlined, size: 16, color: AppColors.mutedForeground),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: d.status.bg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(d.status.label,
                            style: TextStyle(fontSize: 10.5, color: d.status.fg, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                for (int i = 0; i < d.recipientInitials.length; i++) ...[
                  if (i > 0) const SizedBox(width: 4),
                  _initialsAvatar(d.recipientInitials[i]),
                ],
                const SizedBox(width: 8),
                Flexible(
                    child: Text(d.recipientPrimary,
                        style: const TextStyle(fontSize: 12.5), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _initialsAvatar(d.ownerInitials, small: true),
                const SizedBox(width: 6),
                Flexible(child: Text(d.owner, style: const TextStyle(fontSize: 12.5))),
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
              child: StatusPill(label: d.status.label, background: d.status.bg, foreground: d.status.fg),
            ),
          ),
          Expanded(flex: 2, child: Text(d.sent, style: const TextStyle(fontSize: 12))),
          Expanded(flex: 2, child: Text(d.lastActivity, style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 88,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: const Size(0, 28),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: const Text('View', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.more_vert, size: 16, color: AppColors.mutedForeground),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileList() {
    return Column(
      children: [
        for (final d in kSigRecent)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppPalette.of(context).border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      child: Text(d.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    StatusPill(label: d.status.label, background: d.status.bg, foreground: d.status.fg),
                  ],
                ),
                const SizedBox(height: 8),
                Text(d.relatedTo, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (final ini in d.recipientInitials) ...[
                      _initialsAvatar(ini, small: true),
                      const SizedBox(width: 4),
                    ],
                    const SizedBox(width: 4),
                    Expanded(child: Text(d.recipientPrimary, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
                    Text(d.lastActivity, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _initialsAvatar(String s, {bool small = false}) {
    final size = small ? 20.0 : 22.0;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      child: Text(s, style: const TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.w600)),
    );
  }
}

class _Header extends StatelessWidget {
  final bool mobile;
  const _Header({required this.mobile});

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Expanded(child: PrimaryButton(label: 'Send for Signature', icon: Icons.send, onPressed: () {})),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: SecondaryButton(label: 'Sign Yourself', icon: Icons.edit_outlined, onPressed: () {})),
          ]),
        ],
      );
    }
    return Row(
      children: [
        const Spacer(),
        PrimaryButton(label: 'Send for Signature', icon: Icons.send, onPressed: () {}),
        const SizedBox(width: 10),
        SecondaryButton(label: 'Sign Yourself', icon: Icons.edit_outlined, onPressed: () {}),
      ],
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final cols = w < 640 ? 1 : (w < 1024 ? 3 : 5);
        const gap = 12.0;
        final cardW = (w - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final s in kSigOverviewStats)
              SizedBox(width: cardW, child: _statCard(context, s)),
          ],
        );
      },
    );
  }

  Widget _statCard(BuildContext context, SigStat s) {
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.card,
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: s.iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(s.icon, size: 20, color: s.iconFg),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.count, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(s.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                if (s.sub != null) ...[
                  const SizedBox(height: 2),
                  Text(s.sub!,
                      style: const TextStyle(fontSize: 11.5, color: AppColors.primary, fontWeight: FontWeight.w500)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
