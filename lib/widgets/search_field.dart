import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// A search input that adapts to any parent layout.
///
///  - If a fixed `width` is given, uses it.
///  - Otherwise fills the parent's available width via LayoutBuilder.
///  - If the parent is unbounded (e.g. a Row without Expanded), falls back
///    to a sensible default width instead of throwing.
class SearchField extends StatelessWidget {
  final String hint;
  final double? width;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;

  const SearchField({
    super.key,
    required this.hint,
    this.width,
    this.onChanged,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        prefixIcon: const Icon(Icons.search,
            size: 18, color: AppColors.mutedForeground),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),
        suffixIcon: trailing,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );

    if (width != null) return SizedBox(width: width, child: field);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.hasBoundedWidth ? constraints.maxWidth : 240.0;
        return SizedBox(width: w, child: field);
      },
    );
  }
}
