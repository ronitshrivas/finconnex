import 'package:flutter/material.dart';

import '../../core/data/mock_notifications.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';

class TopBar extends StatelessWidget {
  final bool showMenu;
  final bool sidebarCollapsed;
  final VoidCallback? onToggleSidebar;
  final VoidCallback? onSignOut;
  final ValueChanged<String>? onNavigate;

  const TopBar({
    super.key,
    this.showMenu = false,
    this.sidebarCollapsed = false,
    this.onToggleSidebar,
    this.onSignOut,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final palette = AppPalette.of(context);
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
      decoration: BoxDecoration(
        color: palette.background,
        border: Border(bottom: BorderSide(color: palette.border)),
      ),
      child: Row(
        children: [
          if (showMenu)
            Builder(
              builder: (context) => _IconBtn(
                icon: Icons.menu,
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            )
          else
            _IconBtn(
              icon: sidebarCollapsed
                  ? Icons.keyboard_double_arrow_right
                  : Icons.keyboard_double_arrow_left,
              onTap: onToggleSidebar ?? () {},
            ),
          const SizedBox(width: 8),
          if (!isMobile)
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: _GlobalSearch(onTap: () => _openSearch(context)),
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: 8),
          if (isMobile)
            _IconBtn(icon: Icons.search, onTap: () => _openSearch(context))
          else
            const _ThemeToggle(),
          const SizedBox(width: 12),
          _TopAction(
              icon: Icons.chat_bubble_outline,
              badgeDot: true,
              onTap: () => onNavigate?.call('/activities/team-chat')),
          const SizedBox(width: 12),
          _TopAction(
              icon: Icons.notifications_none,
              badgeCount: kMockNotifications.where((n) => n.unread).length,
              onTap: () => _openNotifications(context)),
          if (!isMobile) ...[
            const SizedBox(width: 12),
            _TopAction(
                icon: Icons.calendar_month_outlined,
                onTap: () => onNavigate?.call('/activities/calendar')),
          ],
          const SizedBox(width: 12),
          _UserChip(compact: isMobile, onSignOut: onSignOut),
        ],
      ),
    );
  }

  void _openSearch(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withAlpha(80),
      builder: (_) => const _SearchModal(),
    );
  }

  void _openNotifications(BuildContext context) {
    final overlay = Overlay.of(context);
    final renderBox = overlay.context.findRenderObject() as RenderBox;
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withAlpha(40),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(top: 68, right: renderBox.size.width < 640 ? 8 : 20),
          child: const _NotificationsPanel(),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 120),
      transitionBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
    );
  }
}

// ─── Search modal ────────────────────────────────────────────────────────────

class _SearchModal extends StatelessWidget {
  const _SearchModal();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Dialog(
      backgroundColor: palette.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
                children: [
                  Icon(Icons.search, size: 20, color: palette.mutedForeground),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: palette.foreground, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Search anything…',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: TextStyle(color: palette.mutedForeground),
                      ),
                    ),
                  ),
                  _kbdChip(context, 'Esc'),
                ],
              ),
            ),
            Divider(height: 1, color: palette.border),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHead(context, 'Quick actions'),
                  const SizedBox(height: 8),
                  _row(context, Icons.add, 'Create new deal'),
                  _row(context, Icons.person_add_alt, 'Add new lead'),
                  _row(context, Icons.description_outlined, 'New document request'),
                  const SizedBox(height: 16),
                  _sectionHead(context, 'Recent'),
                  const SizedBox(height: 8),
                  _row(context, Icons.public_outlined, 'Client Portal'),
                  _row(context, Icons.dashboard_outlined, 'Dashboard'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHead(BuildContext context, String s) => Text(
        s.toUpperCase(),
        style: TextStyle(
          fontSize: 10.5,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w600,
          color: AppPalette.of(context).mutedForeground,
        ),
      );

  Widget _row(BuildContext context, IconData icon, String label) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 16, color: palette.mutedForeground),
            const SizedBox(width: 12),
            Expanded(
                child: Text(label,
                    style: TextStyle(fontSize: 13.5, color: palette.foreground))),
            Icon(Icons.arrow_forward, size: 14, color: palette.mutedForeground),
          ],
        ),
      ),
    );
  }

  Widget _kbdChip(BuildContext context, String label) {
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: palette.muted,
        border: Border.all(color: palette.border),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(fontSize: 10.5, color: palette.mutedForeground)),
    );
  }
}

// ─── Notifications panel ─────────────────────────────────────────────────────

class _NotificationsPanel extends StatelessWidget {
  const _NotificationsPanel();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Material(
      elevation: 12,
      color: palette.card,
      borderRadius: BorderRadius.circular(14),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380, maxHeight: 520),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
              child: Row(
                children: [
                  Text('Notifications',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: palette.foreground)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text('Mark all read',
                        style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: palette.border),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: kMockNotifications.length,
                separatorBuilder: (_, __) => Divider(height: 1, color: palette.border),
                itemBuilder: (_, i) => _row(context, kMockNotifications[i]),
              ),
            ),
            Divider(height: 1, color: palette.border),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('View all notifications',
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, NotificationItem n) {
    final palette = AppPalette.of(context);
    return Container(
      color: n.unread
          ? AppColors.primarySoft.withAlpha(palette.isDark ? 40 : 90)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
                color: n.iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(n.icon, size: 16, color: n.iconFg),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(n.title,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: palette.foreground)),
                    ),
                    Text(n.time,
                        style: TextStyle(
                            fontSize: 11, color: palette.mutedForeground)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(n.body,
                    style: TextStyle(
                        fontSize: 12, color: palette.mutedForeground)),
              ],
            ),
          ),
          if (n.unread)
            Container(
              margin: const EdgeInsets.only(left: 8, top: 4),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                  color: AppColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}

// ─── Building blocks ─────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: palette.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: palette.foreground),
      ),
    );
  }
}

class _GlobalSearch extends StatelessWidget {
  final VoidCallback onTap;
  const _GlobalSearch({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: palette.muted,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: palette.border),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 16, color: palette.mutedForeground),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Search anything's",
                style: TextStyle(fontSize: 13, color: palette.mutedForeground),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: palette.background,
                border: Border.all(color: palette.border),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('⌘K',
                  style: TextStyle(
                      fontSize: 11, color: palette.mutedForeground)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: palette.muted,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _seg(
            context,
            active: !theme.isDark,
            icon: Icons.wb_sunny_outlined,
            onTap: () => theme.setDark(false),
          ),
          const SizedBox(width: 4),
          _seg(
            context,
            active: theme.isDark,
            icon: Icons.dark_mode_outlined,
            onTap: () => theme.setDark(true),
          ),
        ],
      ),
    );
  }

  Widget _seg(BuildContext context,
      {required bool active,
      required IconData icon,
      required VoidCallback onTap}) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: active ? palette.background : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Icon(icon,
            size: 14,
            color: active ? palette.foreground : palette.mutedForeground),
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  final IconData icon;
  final int? badgeCount;
  final bool badgeDot;
  final VoidCallback onTap;

  const _TopAction({
    required this.icon,
    required this.onTap,
    this.badgeCount,
    this.badgeDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 22, color: palette.foreground),
            if (badgeDot)
              Positioned(
                right: -2,
                top: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (badgeCount != null && badgeCount! > 0)
              Positioned(
                right: -6,
                top: -6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _UserChip extends StatelessWidget {
  final bool compact;
  final VoidCallback? onSignOut;
  const _UserChip({required this.compact, this.onSignOut});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final avatar = Stack(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: palette.foreground,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'JS',
            style: TextStyle(
              color: palette.background,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.online,
              shape: BoxShape.circle,
              border: Border.all(color: palette.background, width: 2),
            ),
          ),
        ),
      ],
    );

    Widget trigger = compact
        ? avatar
        : Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('John Smith',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: palette.foreground)),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.expand_more,
                          size: 12, color: palette.mutedForeground),
                      const SizedBox(width: 2),
                      Text('Manager',
                          style: TextStyle(
                              fontSize: 11, color: palette.mutedForeground)),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 10),
              avatar,
            ],
          );

    return PopupMenuButton<String>(
      tooltip: '',
      color: palette.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: palette.border),
      ),
      elevation: 8,
      offset: const Offset(0, 48),
      onSelected: (v) {
        if (v == 'signout') onSignOut?.call();
      },
      itemBuilder: (_) => [
        PopupMenuItem<String>(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Smith',
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: palette.foreground)),
                const SizedBox(height: 2),
                Text('john@finconnex.example',
                    style: TextStyle(
                        fontSize: 11.5, color: palette.mutedForeground)),
              ],
            ),
          ),
        ),
        PopupMenuDivider(height: 1),
        _menuItem('profile', Icons.person_outline, 'Profile', palette),
        _menuItem('settings', Icons.settings_outlined, 'Settings', palette),
        _menuItem('team', Icons.people_alt_outlined, 'Team', palette),
        PopupMenuDivider(height: 1),
        _menuItem('signout', Icons.logout, 'Sign out', palette,
            danger: true),
      ],
      child: trigger,
    );
  }

  PopupMenuItem<String> _menuItem(
      String value, IconData icon, String label, AppPalette palette,
      {bool danger = false}) {
    final color = danger ? AppColors.destructive : palette.foreground;
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(fontSize: 13, color: color)),
        ],
      ),
    );
  }
}
