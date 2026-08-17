import 'package:flutter/material.dart';

/// Breakpoints used across the app.
class Breakpoints {
  const Breakpoints._();
  static const double mobile = 640;
  static const double tablet = 1024;
}

enum ScreenSize { mobile, tablet, desktop }

ScreenSize screenSizeOf(BuildContext context) {
  final w = MediaQuery.sizeOf(context).width;
  if (w < Breakpoints.mobile) return ScreenSize.mobile;
  if (w < Breakpoints.tablet) return ScreenSize.tablet;
  return ScreenSize.desktop;
}

extension ScreenSizeX on BuildContext {
  ScreenSize get screen => screenSizeOf(this);
  bool get isMobile => screen == ScreenSize.mobile;
  bool get isTablet => screen == ScreenSize.tablet;
  bool get isDesktop => screen == ScreenSize.desktop;
  bool get isHandheld => screen != ScreenSize.desktop;
}
