import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';

/// Friendly "coming soon" placeholder used for sidebar routes that haven't
/// been fully built out yet. Reads better than a raw wrench icon and shows
/// the user the module is on the roadmap.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final List<String> plannedFeatures;

  const PlaceholderScreen({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.auto_awesome_outlined,
    this.plannedFeatures = const [
      'Web-app parity list, filters, and search',
      'Detail view with related activity',
      'Bulk actions and CSV export',
    ],
  });

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: mobile ? 20 : 22,
                  fontWeight: FontWeight.w700,
                  color: p.foreground)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!,
                style: TextStyle(fontSize: 13, color: p.mutedForeground)),
          ],
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: p.card,
              border: Border.all(color: p.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 30),
                ),
                const SizedBox(height: 16),
                Text('$title is on the roadmap',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: p.foreground)),
                const SizedBox(height: 6),
                Text(
                  "This module isn't wired up yet. Here's what's planned once it lands.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: p.mutedForeground),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 460),
                  child: Column(
                    children: [
                      for (final f in plannedFeatures)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle,
                                  size: 16, color: AppColors.successFg),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(f,
                                    style: TextStyle(
                                        fontSize: 13, color: p.foreground)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    SecondaryButton(
                        label: 'Request early access',
                        icon: Icons.notifications_none,
                        onPressed: () {}),
                    PrimaryButton(
                        label: 'Give feedback',
                        icon: Icons.feedback_outlined,
                        onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
