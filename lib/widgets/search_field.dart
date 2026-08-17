import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

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
    return SizedBox(
      width: width,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          isDense: true,
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.mutedForeground),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          suffixIcon: trailing,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }
}
