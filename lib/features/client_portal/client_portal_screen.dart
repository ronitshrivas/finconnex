import 'package:flutter/material.dart';

import '../../core/data/mock_portals.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';
import 'portal_detail_screen.dart';

class ClientPortalScreen extends StatefulWidget {
  const ClientPortalScreen({super.key});

  @override
  State<ClientPortalScreen> createState() => _ClientPortalScreenState();
}

class _ClientPortalScreenState extends State<ClientPortalScreen> {
  int _tab = 0;
  String _query = '';
  String _access = 'All';

  List<Portal> get _filtered {
    Iterable<Portal> list = kMockPortals;
    switch (_tab) {
      case 1:
        list = list.where((p) => p.status == PortalStatus.active);
      case 2:
        list = list.where((p) => p.status == PortalStatus.inactive);
      case 3:
        list = list.where((p) => p.status == PortalStatus.suspended);
    }
    if (_access != 'All') {
      list = list.where((p) => p.access.label == _access);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((p) =>
          p.name.toLowerCase().contains(q) ||
          p.client.toLowerCase().contains(q) ||
          p.id.toLowerCase().contains(q));
    }
    return list.toList();
  }

  int _count(PortalStatus? status) => status == null
      ? kMockPortals.length
      : kMockPortals.where((p) => p.status == status).length;

  void _open(Portal p) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PortalDetailScreen(portal: p)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rows = _filtered;
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(mobile: mobile),
          SizedBox(height: mobile ? 16 : 20),
          _FilterBar(
            tab: _tab,
            counts: {
              0: _count(null),
              1: _count(PortalStatus.active),
              2: _count(PortalStatus.inactive),
              3: _count(PortalStatus.suspended),
            },
            onTab: (i) => setState(() => _tab = i),
            access: _access,
            onAccess: (v) => setState(() => _access = v),
            onSearch: (v) => setState(() => _query = v),
            mobile: mobile,
          ),
          SizedBox(height: mobile ? 12 : 16),
          if (mobile)
            _MobileList(rows: rows, onTap: _open)
          else
            _PortalsTable(rows: rows, onTap: _open),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool mobile;
  const _Header({required this.mobile});

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Client Portal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    label: 'New portal', icon: Icons.add, onPressed: () {}),
              ),
              const SizedBox(width: 8),
              SecondaryButton(
                  label: 'Export',
                  icon: Icons.file_download_outlined,
                  onPressed: () {}),
            ],
          ),
        ],
      );
    }
    return Row(
      children: [
        const Text('Client Portal',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Spacer(),
        SecondaryButton(
            label: 'Export',
            icon: Icons.file_download_outlined,
            onPressed: () {}),
        const SizedBox(width: 10),
        PrimaryButton(label: 'New portal', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int tab;
  final Map<int, int> counts;
  final ValueChanged<int> onTab;
  final String access;
  final ValueChanged<String> onAccess;
  final ValueChanged<String> onSearch;
  final bool mobile;

  const _FilterBar({
    required this.tab,
    required this.counts,
    required this.onTab,
    required this.access,
    required this.onAccess,
    required this.onSearch,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterTab(
              label: 'All',
              count: counts[0],
              selected: tab == 0,
              onTap: () => onTab(0)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'Active',
              count: counts[1],
              selected: tab == 1,
              onTap: () => onTab(1)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'Inactive',
              count: counts[2],
              selected: tab == 2,
              onTap: () => onTab(2)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'Suspended',
              count: counts[3],
              selected: tab == 3,
              onTap: () => onTab(3)),
          const SizedBox(width: 8),
          _AccessDropdown(value: access, onChanged: onAccess),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search portals…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search portals…', width: 260, onChanged: onSearch),
      ],
    );
  }
}

class _AccessDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _AccessDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.unfold_more,
              size: 16, color: AppColors.mutedForeground),
          style: const TextStyle(fontSize: 13, color: AppColors.foreground),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All access')),
            DropdownMenuItem(value: 'Full', child: Text('Full')),
            DropdownMenuItem(value: 'Limited', child: Text('Limited')),
            DropdownMenuItem(value: 'Read-only', child: Text('Read-only')),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _MobileList extends StatelessWidget {
  final List<Portal> rows;
  final ValueChanged<Portal> onTap;

  const _MobileList({required this.rows, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const _EmptyState();
    return Column(
      children: [
        for (final p in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PortalCard(portal: p, onTap: () => onTap(p)),
          ),
      ],
    );
  }
}

class _PortalCard extends StatelessWidget {
  final Portal portal;
  final VoidCallback onTap;
  const _PortalCard({required this.portal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(portal.id,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(portal.name,
                          style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
                StatusPill(
                    label: portal.status.label,
                    background: portal.status.bg,
                    foreground: portal.status.fg),
              ],
            ),
            const SizedBox(height: 12),
            Text(portal.client,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(portal.slug,
                style: const TextStyle(fontSize: 12, color: AppColors.primary)),
            const SizedBox(height: 12),
            Row(
              children: [
                StatusPill(
                    label: portal.access.label,
                    background: portal.access.bg,
                    foreground: portal.access.fg),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.neutralBg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('${portal.modules} modules',
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.neutralFg,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person_outline,
                    size: 16, color: AppColors.mutedForeground),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(portal.contactName,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(portal.contactEmail,
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppColors.mutedForeground),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off,
                size: 32, color: AppColors.mutedForeground),
            SizedBox(height: 12),
            Text('No portals match your filters',
                style: TextStyle(color: AppColors.mutedForeground)),
          ],
        ),
      ),
    );
  }
}

class _PortalsTable extends StatelessWidget {
  final List<Portal> rows;
  final ValueChanged<Portal> onTap;

  const _PortalsTable({required this.rows, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _headerRow(),
          if (rows.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Text('No portals match your filters',
                  style: TextStyle(color: AppColors.mutedForeground)),
            )
          else
            for (int i = 0; i < rows.length; i++) ...[
              if (i > 0) const Divider(height: 1),
              InkWell(
                onTap: () => onTap(rows[i]),
                child: _bodyRow(rows[i]),
              ),
            ],
          const Divider(height: 1),
          _footerRow(rows.length),
        ],
      ),
    );
  }

  Widget _headerRow() {
    TextStyle head() => const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.mutedForeground,
          letterSpacing: 0.6,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('PORTAL', style: head())),
          Expanded(flex: 3, child: Text('CLIENT', style: head())),
          Expanded(flex: 2, child: Text('ACCESS', style: head())),
          Expanded(flex: 2, child: Text('MODULES', style: head())),
          Expanded(flex: 2, child: Text('STATUS', style: head())),
          Expanded(flex: 3, child: Text('CONTACT', style: head())),
        ],
      ),
    );
  }

  Widget _bodyRow(Portal p) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.id,
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(p.name,
                    style: const TextStyle(
                        fontSize: 12.5, color: AppColors.mutedForeground)),
                const SizedBox(height: 2),
                Text(p.slug,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.primary)),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(p.client, style: const TextStyle(fontSize: 13.5))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: p.access.label,
                  background: p.access.bg,
                  foreground: p.access.fg),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text('${p.modules}',
                  style: const TextStyle(fontSize: 13.5))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: p.status.label,
                  background: p.status.bg,
                  foreground: p.status.fg),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.contactName,
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(p.contactEmail,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.mutedForeground)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerRow(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Text('$count results',
              style: const TextStyle(
                  fontSize: 12.5, color: AppColors.mutedForeground)),
          const Spacer(),
          _pagerButton('Prev', enabled: false),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('1 / 1', style: TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: 8),
          _pagerButton('Next', enabled: false),
        ],
      ),
    );
  }

  Widget _pagerButton(String label, {required bool enabled}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: enabled ? AppColors.foreground : AppColors.subtleText,
        ),
      ),
    );
  }
}
