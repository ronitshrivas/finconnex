import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class StatusPill extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  const StatusPill({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  factory StatusPill.success(String label) => StatusPill(
        label: label,
        background: AppColors.successBg,
        foreground: AppColors.successFg,
      );

  factory StatusPill.danger(String label) => StatusPill(
        label: label,
        background: AppColors.dangerBg,
        foreground: AppColors.dangerFg,
      );

  factory StatusPill.neutral(String label) => StatusPill(
        label: label,
        background: AppColors.neutralBg,
        foreground: AppColors.neutralFg,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
