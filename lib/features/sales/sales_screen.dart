import 'package:flutter/material.dart';

import '../../core/data/mock_sales.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  int _tab = 0;
  String _query = '';

  List<Deal> get _filtered {
    Iterable<Deal> list = kMockDeals;
    switch (_tab) {
      case 1:
        list = list.where((d) => d.stage == DealStage.prospecting || d.stage == DealStage.qualification);
      case 2:
        list = list.where((d) => d.stage == DealStage.proposal || d.stage == DealStage.negotiation);
      case 3:
        list = list.where((d) => d.stage == DealStage.closedWon);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((d) =>
          d.name.toLowerCase().contains(q) ||
          d.client.toLowerCase().contains(q) ||
          d.id.toLowerCase().contains(q));
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
          else if (mobile)
            Column(
              children: [
                for (final d in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _DealCard(deal: d),
                  ),
              ],
            )
          else
            _DealsTable(rows: rows),
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
          child: Text('No deals match your filters',
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
          const Text('Sales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          const Text('Deals and pipeline overview.',
              style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                    label: 'New deal', icon: Icons.add, onPressed: () {}),
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
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sales',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Deals and pipeline overview.',
                style: TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
          ],
        ),
        const Spacer(),
        SecondaryButton(
            label: 'Export',
            icon: Icons.file_download_outlined,
            onPressed: () {}),
        const SizedBox(width: 10),
        PrimaryButton(label: 'New deal', icon: Icons.add, onPressed: () {}),
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
          FilterTab(label: 'Early stage', selected: tab == 1, onTap: () => onTab(1)),
          const SizedBox(width: 8),
          FilterTab(label: 'Late stage', selected: tab == 2, onTap: () => onTab(2)),
          const SizedBox(width: 8),
          FilterTab(label: 'Won', selected: tab == 3, onTap: () => onTab(3)),
        ],
      ),
    );

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SearchField(hint: 'Search deals…', onChanged: onSearch),
          const SizedBox(height: 12),
          tabs,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: tabs),
        const SizedBox(width: 12),
        SearchField(hint: 'Search deals…', width: 260, onChanged: onSearch),
      ],
    );
  }
}

class _DealCard extends StatelessWidget {
  final Deal deal;
  const _DealCard({required this.deal});

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
              Text(deal.id,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.mutedForeground,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusPill(
                  label: deal.stage.label,
                  background: deal.stage.bg,
                  foreground: deal.stage.fg),
            ],
          ),
          const SizedBox(height: 8),
          Text(deal.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(deal.client,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.mutedForeground)),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(deal.value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text('${deal.probability}% probability',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.mutedForeground)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: deal.probability / 100,
              minHeight: 6,
              backgroundColor: AppColors.muted,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              _Avatar(initials: deal.ownerInitials),
              const SizedBox(width: 8),
              Expanded(
                child: Text(deal.owner, style: const TextStyle(fontSize: 13)),
              ),
              const Icon(Icons.event_outlined,
                  size: 14, color: AppColors.mutedForeground),
              const SizedBox(width: 4),
              Text('Close ${deal.close}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.mutedForeground)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DealsTable extends StatelessWidget {
  final List<Deal> rows;
  const _DealsTable({required this.rows});

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
                Expanded(flex: 4, child: Text('DEAL', style: head())),
                Expanded(flex: 3, child: Text('CLIENT', style: head())),
                Expanded(flex: 2, child: Text('STAGE', style: head())),
                Expanded(flex: 2, child: Text('VALUE', style: head())),
                Expanded(flex: 2, child: Text('PROB', style: head())),
                Expanded(flex: 3, child: Text('OWNER', style: head())),
                Expanded(flex: 2, child: Text('CLOSE', style: head())),
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

  Widget _row(Deal d) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.name,
                    style: const TextStyle(
                        fontSize: 13.5, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(d.id,
                    style: const TextStyle(
                        fontSize: 11.5, color: AppColors.mutedForeground)),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(d.client, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: d.stage.label,
                  background: d.stage.bg,
                  foreground: d.stage.fg),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(d.value,
                  style:
                      const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600))),
          Expanded(
              flex: 2,
              child: Text('${d.probability}%',
                  style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _Avatar(initials: d.ownerInitials),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(d.owner,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(d.close, style: const TextStyle(fontSize: 13))),
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
