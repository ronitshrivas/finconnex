import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  final bool showMenu;
  const TopBar({super.key, this.showMenu = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (showMenu)
            Builder(
              builder: (context) => _IconButton(
                icon: Icons.menu,
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            )
          else
            _IconButton(icon: Icons.keyboard_double_arrow_left, onTap: () {}),
          const SizedBox(width: 8),
          if (!isMobile)
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: const _GlobalSearch(),
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: 8),
          if (isMobile)
            _IconButton(icon: Icons.search, onTap: () {})
          else
            const _ThemeToggle(),
          const SizedBox(width: 8),
          const _TopAction(icon: Icons.chat_bubble_outline, badgeDot: true),
          const SizedBox(width: 12),
          const _TopAction(icon: Icons.notifications_none, badgeCount: 4),
          if (!isMobile) ...[
            const SizedBox(width: 12),
            const _TopAction(icon: Icons.calendar_month_outlined),
          ],
          const SizedBox(width: 12),
          _UserChip(compact: isMobile),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.foreground),
      ),
    );
  }
}

class _GlobalSearch extends StatelessWidget {
  const _GlobalSearch();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 16, color: AppColors.mutedForeground),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "Search anything's",
              style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text('⌘K',
                style: TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
          ),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(Icons.wb_sunny_outlined,
                size: 14, color: AppColors.foreground),
          ),
          const SizedBox(width: 4),
          const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(Icons.dark_mode_outlined,
                size: 14, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  final IconData icon;
  final int? badgeCount;
  final bool badgeDot;

  const _TopAction({
    required this.icon,
    this.badgeCount,
    this.badgeDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 22, color: AppColors.foreground),
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
        if (badgeCount != null)
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
    );
  }
}

class _UserChip extends StatelessWidget {
  final bool compact;
  const _UserChip({required this.compact});

  @override
  Widget build(BuildContext context) {
    final avatar = Stack(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.foreground,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'JS',
            style: TextStyle(
              color: Colors.white,
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
              border: Border.all(color: AppColors.background, width: 2),
            ),
          ),
        ),
      ],
    );

    if (compact) return avatar;

    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('John Smith',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.expand_more, size: 12, color: AppColors.mutedForeground),
                SizedBox(width: 2),
                Text('Manager',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        avatar,
      ],
    );
  }
}
