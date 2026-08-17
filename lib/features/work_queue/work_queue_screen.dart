import 'package:flutter/material.dart';

import '../../core/data/mock_work_queue.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class WorkQueueScreen extends StatefulWidget {
  const WorkQueueScreen({super.key});

  @override
  State<WorkQueueScreen> createState() => _WorkQueueScreenState();
}

class _WorkQueueScreenState extends State<WorkQueueScreen> {
  int _tab = 0;
  String _query = '';

  List<WorkItem> get _filtered {
    Iterable<WorkItem> list = kMockWorkItems;
    switch (_tab) {
      case 1:
        list = list.where((w) => w.status == WorkStatus.todo);
      case 2:
        list = list.where((w) => w.status == WorkStatus.inProgress);
      case 3:
        list = list.where((w) => w.status == WorkStatus.blocked);
      case 4:
        list = list.where((w) => w.status == WorkStatus.done);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((w) =>
          w.title.toLowerCase().contains(q) ||
          w.client.toLowerCase().contains(q) ||
          w.id.toLowerCase().contains(q));
    }
    return list.toList();
  }

  int _count(WorkStatus? status) => status == null
      ? kMockWorkItems.length
      : kMockWorkItems.where((w) => w.status == status).length;

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
              1: _count(WorkStatus.todo),
              2: _count(WorkStatus.inProgress),
              3: _count(WorkStatus.blocked),
              4: _count(WorkStatus.done),
            },
            onTab: (i) => setState(() => _tab = i),
            onSearch: (v) => setState(() => _query = v),
            mobile: mobile,
          ),
          SizedBox(height: mobile ? 12 : 16),
          if (rows.isEmpty)
            _empty()
          else if (mobile)
            Column(
              children: [
                for (final w in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _WorkCard(item: w),
                  ),
              ],
            )
          else
            _WorkTable(rows: rows),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inbox_outlined,
                  size: 32, color: AppColors.mutedForeground),
              SizedBox(height: 12),
              Text('No work items match your filters',
                  style: TextStyle(color: AppColors.mutedForeground)),
            ],
          ),
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
          const Text('Work Queue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Tasks assigned to you and your team.',
              style:
                  TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    label: 'New task', icon: Icons.add, onPressed: () {}),
              ),
              const SizedBox(width: 8),
              SecondaryButton(
                  label: 'Filter',
                  icon: Icons.tune,
                  onPressed: () {}),
            ],
          ),
        ],
      );
    }
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work Queue',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Tasks assigned to you and your team.',
                style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          ],
        ),
        const Spacer(),
        SecondaryButton(label: 'Filter', icon: Icons.tune, onPressed: () {}),
        const SizedBox(width: 10),
        PrimaryButton(label: 'New task', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int tab;
  final Map<int, int> counts;
  final ValueChanged<int> onTab;
  final ValueChanged<String> onSearch;
  final bool mobile;

  const _FilterBar({
    required this.tab,
    required this.counts,
    required this.onTab,
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
              label: 'To do',
              count: counts[1],
              selected: tab == 1,
              onTap: () => onTab(1)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'In progress',
              count: counts[2],
              selected: tab == 2,
              onTap: () => onTab(2)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'Blocked',
              count: counts[3],
              selected: tab == 3,
              onTap: () => onTab(3)),
          const SizedBox(width: 8),
          FilterTab(
              label: 'Done',
              count: counts[4],
              selected: tab == 4,
              onTap: () => onTab(4)),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search tasks…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search tasks…', width: 260, onChanged: onSearch),
      ],
    );
  }
}

class _WorkCard extends StatelessWidget {
  final WorkItem item;
  const _WorkCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: [
              Text(item.id,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.mutedForeground,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusPill(
                  label: item.status.label,
                  background: item.status.bg,
                  foreground: item.status.fg),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(item.client,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          Row(
            children: [
              StatusPill(
                  label: item.priority.label,
                  background: item.priority.bg,
                  foreground: item.priority.fg,
                  icon: Icons.flag_outlined),
              const Spacer(),
              const Icon(Icons.event_outlined,
                  size: 14, color: AppColors.mutedForeground),
              const SizedBox(width: 4),
              Text(item.due,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.mutedForeground)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              _Avatar(initials: item.assigneeInitials),
              const SizedBox(width: 10),
              Text(item.assignee, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  const _Avatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      child: Text(initials,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _WorkTable extends StatelessWidget {
  final List<WorkItem> rows;
  const _WorkTable({required this.rows});

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
                Expanded(flex: 4, child: Text('TASK', style: head())),
                Expanded(flex: 3, child: Text('CLIENT', style: head())),
                Expanded(flex: 2, child: Text('PRIORITY', style: head())),
                Expanded(flex: 2, child: Text('STATUS', style: head())),
                Expanded(flex: 3, child: Text('ASSIGNEE', style: head())),
                Expanded(flex: 2, child: Text('DUE', style: head())),
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

  Widget _row(WorkItem w) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(w.title,
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(w.id,
                    style: const TextStyle(
                        fontSize: 11.5, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          Expanded(
              flex: 3, child: Text(w.client, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: w.priority.label,
                  background: w.priority.bg,
                  foreground: w.priority.fg,
                  icon: Icons.flag_outlined),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: w.status.label,
                  background: w.status.bg,
                  foreground: w.status.fg),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _Avatar(initials: w.assigneeInitials),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(w.assignee,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 2, child: Text(w.due, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
