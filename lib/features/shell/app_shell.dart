import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import 'app_sidebar.dart';
import 'top_bar.dart';

/// Adaptive shell:
///  - Desktop (>=1024): persistent left sidebar + top bar.
///  - Tablet/mobile: hamburger opens the sidebar as a Drawer; compact top bar.
class AppShell extends StatelessWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final Widget child;

  const AppShell({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: AppColors.sidebar,
              child: AppSidebar(
                currentRoute: currentRoute,
                onNavigate: (r) {
                  Navigator.of(context).pop();
                  onNavigate(r);
                },
              ),
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              AppSidebar(currentRoute: currentRoute, onNavigate: onNavigate),
            Expanded(
              child: Column(
                children: [
                  TopBar(showMenu: !isDesktop),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
