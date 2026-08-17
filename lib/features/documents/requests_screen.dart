import 'package:flutter/material.dart';

import '../../core/data/mock_documents.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class DocumentRequestsScreen extends StatefulWidget {
  const DocumentRequestsScreen({super.key});

  @override
  State<DocumentRequestsScreen> createState() => _DocumentRequestsScreenState();
}

class _DocumentRequestsScreenState extends State<DocumentRequestsScreen> {
  int _tab = 0;
  String _query = '';
  bool _grid = false;

  List<DocRequest> get _filtered {
    Iterable<DocRequest> list = kDocRequests;
    final map = {
      1: DocReqStatus.requested,
      2: DocReqStatus.pending,
      3: DocReqStatus.received,
      4: DocReqStatus.approved,
      5: DocReqStatus.rejected,
      6: DocReqStatus.expired,
    };
    final s = map[_tab];
    if (s != null) list = list.where((r) => r.status == s);
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((r) =>
          r.title.toLowerCase().contains(q) ||
          r.from.toLowerCase().contains(q) ||
          r.id.toLowerCase().contains(q));
    }
    return list.toList();
  }

  int _count(DocReqStatus? s) => s == null
      ? kDocRequests.length
      : kDocRequests.where((r) => r.status == s).length;

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
              1: _count(DocReqStatus.requested),
              2: _count(DocReqStatus.pending),
              3: _count(DocReqStatus.received),
              4: _count(DocReqStatus.approved),
              5: _count(DocReqStatus.rejected),
              6: _count(DocReqStatus.expired),
            },
            onTab: (i) => setState(() => _tab = i),
            onSearch: (v) => setState(() => _query = v),
            grid: _grid,
            onToggleGrid: (v) => setState(() => _grid = v),
            mobile: mobile,
          ),
          SizedBox(height: mobile ? 12 : 16),
          if (rows.isEmpty)
            _empty()
          else if (mobile || _grid)
            Column(
              children: [
                for (final r in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RequestCard(req: r),
                  ),
              ],
            )
          else
            _RequestsTable(rows: rows),
          const SizedBox(height: 12),
          _Footer(count: rows.length),
        ],
      ),
    );
  }

  Widget _empty() => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text('No document requests match your filters',
              style: TextStyle(color: AppColors.mutedForeground)),
        ),
      );
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
          const Text('Document Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    label: 'Create request', icon: Icons.add, onPressed: () {}),
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
        const Text('Document Requests',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const Spacer(),
        SecondaryButton(
            label: 'Export',
            icon: Icons.file_download_outlined,
            onPressed: () {}),
        const SizedBox(width: 10),
        PrimaryButton(label: 'Create request', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int tab;
  final Map<int, int> counts;
  final ValueChanged<int> onTab;
  final ValueChanged<String> onSearch;
  final bool grid;
  final ValueChanged<bool> onToggleGrid;
  final bool mobile;

  const _FilterBar({
    required this.tab,
    required this.counts,
    required this.onTab,
    required this.onSearch,
    required this.grid,
    required this.onToggleGrid,
    required this.mobile,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['All', 'Requested', 'Pending', 'Received', 'Approved', 'Rejected', 'Expired'];
    final tabs = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < labels.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            FilterTab(
                label: labels[i],
                count: counts[i],
                selected: tab == i,
                onTap: () => onTab(i)),
          ],
        ],
      ),
    );

    final viewToggle = Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _viewBtn(Icons.view_list, !grid, () => onToggleGrid(false), true),
          _viewBtn(Icons.grid_view, grid, () => onToggleGrid(true), false),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search…', width: 240, onChanged: onSearch),
        const SizedBox(width: 8),
        viewToggle,
      ],
    );
  }

  Widget _viewBtn(IconData icon, bool active, VoidCallback onTap, bool left) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: left
              ? const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7))
              : const BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
        ),
        child: Icon(icon,
            size: 16,
            color: active ? Colors.white : AppColors.mutedForeground),
      ),
    );
  }
}

class _RequestsTable extends StatelessWidget {
  final List<DocRequest> rows;
  const _RequestsTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    TextStyle head() => const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.mutedForeground,
          letterSpacing: 0.6,
        );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text('REQUEST', style: head())),
                Expanded(flex: 3, child: Text('FROM', style: head())),
                Expanded(flex: 2, child: Text('TYPE', style: head())),
                Expanded(flex: 3, child: Text('RELATED TO', style: head())),
                Expanded(flex: 2, child: Text('DUE', style: head())),
                Expanded(flex: 2, child: Text('STATUS', style: head())),
                Expanded(flex: 3, child: Text('REQUESTED BY', style: head())),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            _row(rows[i]),
          ],
        ],
      ),
    );
  }

  Widget _row(DocRequest r) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 3,
            color: r.status.accent,
            margin: const EdgeInsets.symmetric(vertical: 4),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.title,
                            style: const TextStyle(
                                fontSize: 13.5, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(r.id,
                            style: const TextStyle(
                                fontSize: 11.5,
                                color: AppColors.mutedForeground)),
                      ],
                    ),
                  ),
                  Expanded(flex: 3, child: Text(r.from, style: const TextStyle(fontSize: 13))),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: r.type.bg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(r.type.label,
                            style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: r.type.fg)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(r.relatedTo,
                        style: const TextStyle(fontSize: 12.5),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        const Icon(Icons.event_outlined,
                            size: 13, color: AppColors.mutedForeground),
                        const SizedBox(width: 4),
                        Flexible(
                            child: Text(r.due,
                                style: const TextStyle(fontSize: 12.5))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: r.status.dot,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(r.status.label,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: r.status.fg)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        _Avatar(initials: r.requestedByInitials),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(r.requestedBy,
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final DocRequest req;
  const _RequestCard({required this.req});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 3, color: req.status.accent),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                            color: req.status.dot, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(req.status.label,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: req.status.fg)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: req.type.bg,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(req.type.label,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: req.type.fg)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(req.title,
                      style: const TextStyle(
                          fontSize: 14.5, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(req.id,
                      style: const TextStyle(
                          fontSize: 11.5, color: AppColors.mutedForeground)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 13, color: AppColors.mutedForeground),
                      const SizedBox(width: 4),
                      Text(req.from, style: const TextStyle(fontSize: 12.5)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.link,
                          size: 13, color: AppColors.mutedForeground),
                      const SizedBox(width: 4),
                      Flexible(
                          child: Text(req.relatedTo,
                              style: const TextStyle(fontSize: 12.5),
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.event_outlined,
                          size: 13, color: AppColors.mutedForeground),
                      const SizedBox(width: 4),
                      Text('Due ${req.due}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.mutedForeground)),
                      const Spacer(),
                      _Avatar(initials: req.requestedByInitials),
                      const SizedBox(width: 6),
                      Text(req.requestedBy,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int count;
  const _Footer({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Showing 1–$count of $count',
            style: const TextStyle(
                fontSize: 12, color: AppColors.mutedForeground)),
        const Spacer(),
        _pagerBtn('Prev', enabled: false),
        const SizedBox(width: 8),
        const Text('Page 1 of 1',
            style: TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
        const SizedBox(width: 8),
        _pagerBtn('Next', enabled: false),
      ],
    );
  }

  Widget _pagerBtn(String label, {required bool enabled}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              color: enabled ? AppColors.foreground : AppColors.subtleText)),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  const _Avatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      child: Text(initials,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 10,
              fontWeight: FontWeight.w600)),
    );
  }
}
