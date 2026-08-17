import 'package:flutter/material.dart';

import '../../core/data/mock_documents.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/filter_tab.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';
import '../../widgets/status_pill.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _folderIdx = 0;
  int _access = 0; // 0=All 1=Private 2=Team 3=Organization
  String _query = '';

  List<DocFile> get _filtered {
    Iterable<DocFile> list = kDocFiles;
    if (_folderIdx > 0) {
      list = list.where((f) => f.folder == kDocFolders[_folderIdx].name);
    }
    switch (_access) {
      case 1:
        list = list.where((f) => f.access == DocAccess.private);
      case 2:
        list = list.where((f) => f.access == DocAccess.team);
      case 3:
        list = list.where((f) => f.access == DocAccess.organization);
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((f) =>
          f.name.toLowerCase().contains(q) ||
          f.tags.any((t) => t.toLowerCase().contains(q)));
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
          SizedBox(height: mobile ? 12 : 16),
          if (mobile) ...[
            _FoldersMobileBar(
              selected: _folderIdx,
              onSelect: (i) => setState(() => _folderIdx = i),
            ),
            const SizedBox(height: 12),
            _AccessBar(
              access: _access,
              onAccess: (i) => setState(() => _access = i),
              rows: rows.length,
            ),
            const SizedBox(height: 12),
            SearchField(hint: 'Search files, tags…', onChanged: (v) => setState(() => _query = v)),
            const SizedBox(height: 12),
            for (final f in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _FileCard(file: f),
              ),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: _FoldersPanel(
                    selected: _folderIdx,
                    onSelect: (i) => setState(() => _folderIdx = i),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${kDocFolders[_folderIdx].name}  ·  ${rows.length} files',
                            style: const TextStyle(
                                fontSize: 13.5,
                                color: AppColors.mutedForeground),
                          ),
                          const Spacer(),
                          _AccessBar(
                            access: _access,
                            onAccess: (i) => setState(() => _access = i),
                            rows: rows.length,
                            inline: true,
                          ),
                          const SizedBox(width: 12),
                          SearchField(
                              hint: 'Search files, tags…',
                              width: 240,
                              onChanged: (v) => setState(() => _query = v)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _FilesTable(rows: rows),
                    ],
                  ),
                ),
              ],
            ),
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
    return Row(
      children: [
        Text('Library',
            style: TextStyle(
                fontSize: mobile ? 20 : 22, fontWeight: FontWeight.w700)),
        const Spacer(),
        PrimaryButton(label: 'Upload', icon: Icons.add, onPressed: () {}),
      ],
    );
  }
}

class _FoldersPanel extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _FoldersPanel({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
            child: Row(
              children: [
                const Text('FOLDERS',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mutedForeground,
                        letterSpacing: 0.6)),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.add,
                        size: 16, color: AppColors.mutedForeground),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          for (int i = 0; i < kDocFolders.length; i++)
            _folderRow(i, kDocFolders[i]),
        ],
      ),
    );
  }

  Widget _folderRow(int i, DocFolder f) {
    final active = i == selected;
    return InkWell(
      onTap: () => onSelect(i),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: active ? AppColors.primarySoft : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.folder_outlined,
                size: 16,
                color: active ? AppColors.primary : AppColors.mutedForeground),
            const SizedBox(width: 8),
            Expanded(
              child: Text(f.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                    color: active ? AppColors.primary : AppColors.foreground,
                  )),
            ),
            Text('${f.count}',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.mutedForeground)),
          ],
        ),
      ),
    );
  }
}

class _FoldersMobileBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  const _FoldersMobileBar({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < kDocFolders.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            FilterTab(
              label: kDocFolders[i].name,
              count: kDocFolders[i].count,
              selected: i == selected,
              onTap: () => onSelect(i),
            ),
          ],
        ],
      ),
    );
  }
}

class _AccessBar extends StatelessWidget {
  final int access;
  final ValueChanged<int> onAccess;
  final int rows;
  final bool inline;
  const _AccessBar({
    required this.access,
    required this.onAccess,
    required this.rows,
    this.inline = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget seg(String label, int i) {
      final active = access == i;
      return InkWell(
        onTap: () => onAccess(i),
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: active ? Colors.white : AppColors.foreground,
              )),
        ),
      );
    }

    final segs = Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          seg('All', 0),
          seg('Private', 1),
          seg('Team', 2),
          seg('Organization', 3),
        ],
      ),
    );

    if (inline) return segs;

    return Row(
      children: [
        Expanded(
          child: Text('$rows files',
              style: const TextStyle(
                  fontSize: 12.5, color: AppColors.mutedForeground)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: segs,
        ),
      ],
    );
  }
}

class _FilesTable extends StatelessWidget {
  final List<DocFile> rows;
  const _FilesTable({required this.rows});

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
                Expanded(flex: 4, child: Text('FILE NAME', style: head())),
                Expanded(flex: 2, child: Text('FOLDER', style: head())),
                Expanded(flex: 3, child: Text('OWNER', style: head())),
                Expanded(flex: 3, child: Text('RELATED TO', style: head())),
                Expanded(flex: 2, child: Text('VERSION', style: head())),
                Expanded(flex: 3, child: Text('TAGS', style: head())),
                Expanded(flex: 2, child: Text('UPLOADED', style: head())),
                Expanded(flex: 2, child: Text('ACCESS', style: head())),
                SizedBox(width: 32, child: Text('', style: head())),
              ],
            ),
          ),
          if (rows.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Text('No files match your filters',
                  style: TextStyle(color: AppColors.mutedForeground)),
            )
          else
            for (int i = 0; i < rows.length; i++) ...[
              if (i > 0) const Divider(height: 1),
              _row(rows[i]),
            ],
        ],
      ),
    );
  }

  Widget _row(DocFile f) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                const Icon(Icons.insert_drive_file_outlined,
                    size: 18, color: AppColors.mutedForeground),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.name,
                          style: const TextStyle(
                              fontSize: 13.5, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(f.size,
                          style: const TextStyle(
                              fontSize: 11.5,
                              color: AppColors.mutedForeground)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(f.folder, style: const TextStyle(fontSize: 13))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                _Avatar(initials: f.ownerInitials),
                const SizedBox(width: 8),
                Flexible(
                    child: Text(f.owner,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(f.relatedTo,
                style: const TextStyle(fontSize: 12.5, color: AppColors.foreground),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.neutralBg,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 40),
              child: Text(f.version,
                  style: const TextStyle(
                      fontSize: 11.5, fontWeight: FontWeight.w600)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [for (final t in f.tags) _tagChip(t)],
            ),
          ),
          Expanded(flex: 2, child: Text(f.uploaded, style: const TextStyle(fontSize: 12.5))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                  label: f.access.label,
                  background: f.access.bg,
                  foreground: f.access.fg),
            ),
          ),
          const SizedBox(
            width: 32,
            child: Icon(Icons.more_horiz,
                size: 18, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _tagChip(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(t,
          style: const TextStyle(
              fontSize: 11, color: AppColors.mutedForeground)),
    );
  }
}

class _FileCard extends StatelessWidget {
  final DocFile file;
  const _FileCard({required this.file});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.insert_drive_file_outlined,
                    size: 20, color: AppColors.mutedForeground),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(file.name,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text('${file.size}  ·  ${file.folder}',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.mutedForeground)),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz,
                  size: 18, color: AppColors.mutedForeground),
            ],
          ),
          if (file.relatedTo.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(file.relatedTo,
                style: const TextStyle(fontSize: 12.5)),
          ],
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.neutralBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(file.version,
                    style: const TextStyle(
                        fontSize: 11.5, fontWeight: FontWeight.w600)),
              ),
              for (final t in file.tags)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(t,
                      style: const TextStyle(
                          fontSize: 11.5, color: AppColors.mutedForeground)),
                ),
              StatusPill(
                  label: file.access.label,
                  background: file.access.bg,
                  foreground: file.access.fg),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              _Avatar(initials: file.ownerInitials),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(file.owner,
                      style: const TextStyle(fontSize: 12.5))),
              Text(file.uploaded,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.mutedForeground)),
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
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
        shape: BoxShape.circle,
      ),
      child: Text(initials,
          style: const TextStyle(
              color: AppColors.primary,
              fontSize: 10.5,
              fontWeight: FontWeight.w600)),
    );
  }
}
