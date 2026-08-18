import 'package:flutter/material.dart';

/// Palette sampled directly from the FinConnex web app (light mode) with a
/// matching dark palette derived from the same brand values.
class AppColors {
  const AppColors._();

  // ─── Light ───────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color sidebar = Color(0xFFFAFAFA);
  static const Color card = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFFF5F5F5);
  static const Color hover = Color(0xFFF3F4F6);

  static const Color foreground = Color(0xFF0A0A0A);
  static const Color mutedForeground = Color(0xFF737373);
  static const Color subtleText = Color(0xFF9CA3AF);

  static const Color border = Color(0xFFE5E5E5);
  static const Color inputBorder = Color(0xFFE5E7EB);

  static const Color primary = Color(0xFF7F22FE);
  static const Color primaryHover = Color(0xFF6D18E0);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color primarySoft = Color(0xFFF3E8FF);

  static const Color successBg = Color(0xFFECFDF5);
  static const Color successFg = Color(0xFF007A55);
  static const Color dangerBg = Color(0xFFFFF1F2);
  static const Color dangerFg = Color(0xFFC70036);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color warningFg = Color(0xFFB45309);
  static const Color infoBg = Color(0xFFEFF6FF);
  static const Color infoFg = Color(0xFF1D4ED8);
  static const Color neutralBg = Color(0xFFF3F4F6);
  static const Color neutralFg = Color(0xFF4B5563);

  static const Color accessFullBg = Color(0xFFF3E8FF);
  static const Color accessFullFg = Color(0xFF7F22FE);
  static const Color accessLimitedBg = Color(0xFFFEF3C7);
  static const Color accessLimitedFg = Color(0xFFB45309);

  static const Color loginDark = Color(0xFF0F172A);
  static const Color loginDarkMuted = Color(0xFF94A3B8);

  static const Color destructive = Color(0xFFE7000B);
  static const Color online = Color(0xFF10B981);

  // ─── Dark ────────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0B0B10);
  static const Color darkSidebar = Color(0xFF0E0E14);
  static const Color darkCard = Color(0xFF14141C);
  static const Color darkMuted = Color(0xFF1B1B24);
  static const Color darkHover = Color(0xFF1F1F2A);

  static const Color darkForeground = Color(0xFFF5F5F5);
  static const Color darkMutedForeground = Color(0xFF9CA3AF);
  static const Color darkSubtleText = Color(0xFF6B7280);

  static const Color darkBorder = Color(0xFF262633);
  static const Color darkInputBorder = Color(0xFF2A2A38);

  static const Color darkPrimarySoft = Color(0xFF2A1A4A);
}

/// Palette that resolves to the right value based on brightness. Screens can
/// keep referring to concrete `AppColors.*` constants (light), but the shared
/// widgets can call `AppPalette.of(context).background` etc. for full theming.
class AppPalette {
  final Brightness brightness;
  const AppPalette(this.brightness);

  factory AppPalette.of(BuildContext context) =>
      AppPalette(Theme.of(context).brightness);

  bool get isDark => brightness == Brightness.dark;

  Color get background => isDark ? AppColors.darkBackground : AppColors.background;
  Color get sidebar => isDark ? AppColors.darkSidebar : AppColors.sidebar;
  Color get card => isDark ? AppColors.darkCard : AppColors.card;
  Color get muted => isDark ? AppColors.darkMuted : AppColors.muted;
  Color get hover => isDark ? AppColors.darkHover : AppColors.hover;
  Color get foreground => isDark ? AppColors.darkForeground : AppColors.foreground;
  Color get mutedForeground => isDark ? AppColors.darkMutedForeground : AppColors.mutedForeground;
  Color get subtleText => isDark ? AppColors.darkSubtleText : AppColors.subtleText;
  Color get border => isDark ? AppColors.darkBorder : AppColors.border;
  Color get inputBorder => isDark ? AppColors.darkInputBorder : AppColors.inputBorder;
  Color get primarySoft => isDark ? AppColors.darkPrimarySoft : AppColors.primarySoft;
}
