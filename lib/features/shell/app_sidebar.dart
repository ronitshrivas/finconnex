import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'nav_items.dart';

class AppSidebar extends StatefulWidget {
  final String currentRoute;
  final ValueChanged<String> onNavigate;

  const AppSidebar({
    super.key,
    required this.currentRoute,
    required this.onNavigate,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  final _expanded = <String>{};

  @override
  void initState() {
    super.initState();
    // Auto-expand the section that contains the current route.
    for (final item in kNavItems) {
      if (item.expandable &&
          item.children.any((c) => c.route == widget.currentRoute)) {
        _expanded.add(item.label);
      }
    }
  }

  @override
  void didUpdateWidget(covariant AppSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentRoute != widget.currentRoute) {
      for (final item in kNavItems) {
        if (item.expandable &&
            item.children.any((c) => c.route == widget.currentRoute)) {
          _expanded.add(item.label);
        }
      }
    }
  }

  bool _isSectionActive(NavItem item) {
    if (item.route == widget.currentRoute) return true;
    return item.expandable &&
        item.children.any((c) => c.route == widget.currentRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SidebarHeader(),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Text(
                    kSidebarSection,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mutedForeground,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                for (final item in kNavItems) _buildItem(item),
              ],
            ),
          ),
          const _SmartChat(),
        ],
      ),
    );
  }

  Widget _buildItem(NavItem item) {
    if (!item.expandable) {
      return _SidebarTile(
        item: item,
        selected: item.route == widget.currentRoute,
        onTap: () {
          if (item.route != null) widget.onNavigate(item.route!);
        },
      );
    }
    final open = _expanded.contains(item.label);
    return Column(
      children: [
        _SidebarTile(
          item: item,
          selected: _isSectionActive(item),
          expanded: open,
          onTap: () {
            setState(() {
              if (open) {
                _expanded.remove(item.label);
              } else {
                _expanded.add(item.label);
              }
            });
          },
        ),
        if (open)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              children: [
                for (final child in item.children)
                  _SidebarSubTile(
                    item: child,
                    selected: child.route == widget.currentRoute,
                    onTap: () {
                      if (child.route != null) widget.onNavigate(child.route!);
                    },
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FinConnex',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'FinConnex HQ',
            style: TextStyle(fontSize: 12, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatefulWidget {
  final NavItem item;
  final bool selected;
  final bool expanded;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
    this.expanded = false,
  });

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final color = selected ? AppColors.primary : AppColors.foreground;
    final bg = selected
        ? AppColors.primarySoft
        : (_hover ? AppColors.hover : Colors.transparent);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(widget.item.icon, size: 18, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    color: color,
                    fontSize: 13.5,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (widget.item.expandable)
                Icon(
                    widget.expanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 18,
                    color: AppColors.mutedForeground),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarSubTile extends StatefulWidget {
  final NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarSubTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_SidebarSubTile> createState() => _SidebarSubTileState();
}

class _SidebarSubTileState extends State<_SidebarSubTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;
    final color = selected ? AppColors.primary : AppColors.foreground;
    final bg = selected
        ? AppColors.primarySoft
        : (_hover ? AppColors.hover : Colors.transparent);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 1),
          padding: const EdgeInsets.fromLTRB(28, 8, 12, 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.item.label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _SmartChat extends StatelessWidget {
  const _SmartChat();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Here is your Smart Chat (Ctrl+Space)',
          hintStyle: const TextStyle(fontSize: 12, color: AppColors.subtleText),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.inputBorder),
          ),
        ),
      ),
    );
  }
}
