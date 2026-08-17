import 'package:flutter/material.dart';

import '../../core/data/mock_activities.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _tab = 0;
  String _query = '';

  List<ActivityEntry> get _filtered {
    Iterable<ActivityEntry> list = kMockActivities;
    switch (_tab) {
      case 1:
        list = list.where((a) => a.type == ActivityType.call);
      case 2:
        list = list.where((a) => a.type == ActivityType.meeting);
      case 3:
        list = list.where((a) => a.type == ActivityType.email);
      case 4:
        list = list.where((a) => a.type == ActivityType.task);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((a) =>
          a.title.toLowerCase().contains(q) ||
          a.related.toLowerCase().contains(q));
    }
    return list.toList();
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
            onTab: (i) => setState(() => _tab = i),
            onSearch: (v) => setState(() => _query = v),
            mobile: mobile,
          ),
          SizedBox(height: mobile ? 12 : 16),
          if (rows.isEmpty)
            _empty()
          else
            _Timeline(rows: rows),
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
          child: Text('No activities match your filters',
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
          const Text('Activities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Calls, meetings, emails, and notes.',
              style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Log activity', icon: Icons.add, onPressed: () {}),
        ],
      );
    }
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activities',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Calls, meetings, emails, and notes.',
                style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          ],
        ),
        const Spacer(),
        PrimaryButton(label: 'Log activity', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int tab;
  final ValueChanged<int> onTab;
  final ValueChanged<String> onSearch;
  final bool mobile;

  const _FilterBar({
    required this.tab,
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
          FilterTab(label: 'All', selected: tab == 0, onTap: () => onTab(0)),
          const SizedBox(width: 8),
          FilterTab(label: 'Calls', selected: tab == 1, onTap: () => onTab(1)),
          const SizedBox(width: 8),
          FilterTab(label: 'Meetings', selected: tab == 2, onTap: () => onTab(2)),
          const SizedBox(width: 8),
          FilterTab(label: 'Emails', selected: tab == 3, onTap: () => onTab(3)),
          const SizedBox(width: 8),
          FilterTab(label: 'Tasks', selected: tab == 4, onTap: () => onTab(4)),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search activities…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search activities…', width: 260, onChanged: onSearch),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  final List<ActivityEntry> rows;
  const _Timeline({required this.rows});

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
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 24),
            _row(rows[i]),
          ],
        ],
      ),
    );
  }

  Widget _row(ActivityEntry a) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: a.type.bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(a.type.icon, size: 20, color: a.type.fg),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      a.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: a.done ? AppColors.mutedForeground : AppColors.foreground,
                        decoration: a.done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(a.date,
                      style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.mutedForeground,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 4),
              Text(a.related,
                  style: const TextStyle(
                      fontSize: 12.5, color: AppColors.mutedForeground)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule,
                      size: 13, color: AppColors.mutedForeground),
                  const SizedBox(width: 4),
                  Text(a.time,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.mutedForeground)),
                  const SizedBox(width: 12),
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: Text(a.ownerInitials,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 6),
                  Text(a.owner,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.mutedForeground)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
