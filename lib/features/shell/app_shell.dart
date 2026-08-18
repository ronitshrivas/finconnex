import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import 'app_sidebar.dart';
import 'top_bar.dart';

/// Adaptive shell with a collapsible desktop sidebar and a drawer on
/// mobile/tablet.
class AppShell extends StatefulWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;
  final VoidCallback? onSignOut;
  final Widget child;

  const AppShell({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
    required this.child,
    this.onSignOut,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _sidebarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final palette = AppPalette.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: palette.sidebar,
              child: AppSidebar(
                currentRoute: widget.currentRoute,
                onNavigate: (r) {
                  Navigator.of(context).pop();
                  widget.onNavigate(r);
                },
              ),
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop && !_sidebarCollapsed)
              AppSidebar(
                currentRoute: widget.currentRoute,
                onNavigate: widget.onNavigate,
              ),
            Expanded(
              child: Column(
                children: [
                  TopBar(
                    showMenu: !isDesktop,
                    sidebarCollapsed: _sidebarCollapsed,
                    onToggleSidebar: isDesktop
                        ? () => setState(
                            () => _sidebarCollapsed = !_sidebarCollapsed)
                        : null,
                    onSignOut: widget.onSignOut,
                  ),
                  Expanded(child: widget.child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
