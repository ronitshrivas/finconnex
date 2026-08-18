import 'package:flutter/material.dart';

import '../../core/data/mock_messages.dart';
import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/search_field.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _activeId = 't1';
  bool _mobileShowingConvo = false;
  final _composer = TextEditingController();

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  ChatThread get _active =>
      kChatThreads.firstWhere((t) => t.id == _activeId, orElse: () => kChatThreads.first);

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;

    if (mobile) {
      return _mobileShowingConvo
          ? _convoPane(p, backButton: true)
          : _listPane(p, mobile: true);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 320, child: _listPane(p, mobile: false)),
        Container(width: 1, color: p.border),
        Expanded(child: _convoPane(p, backButton: false)),
      ],
    );
  }

  Widget _listPane(AppPalette p, {required bool mobile}) {
    return Container(
      color: p.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Text('Messages',
                    style: TextStyle(
                        fontSize: mobile ? 20 : 22,
                        fontWeight: FontWeight.w700,
                        color: p.foreground)),
                const Spacer(),
                PrimaryButton(label: 'New', icon: Icons.edit_outlined, onPressed: () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: SearchField(hint: 'Search conversations…', onChanged: (_) {}),
          ),
          Divider(height: 1, color: p.border),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: kChatThreads.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: p.border),
              itemBuilder: (_, i) {
                final t = kChatThreads[i];
                final active = t.id == _activeId;
                return InkWell(
                  onTap: () => setState(() {
                    _activeId = t.id;
                    if (context.isMobile) _mobileShowingConvo = true;
                  }),
                  child: Container(
                    color: active && !context.isMobile ? AppColors.primarySoft : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _avatar(t.initials, t.avatarBg, t.avatarFg, online: t.online, palette: p),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(t.name,
                                        style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: p.foreground)),
                                  ),
                                  Text(t.time,
                                      style: TextStyle(
                                          fontSize: 11, color: p.mutedForeground)),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(t.preview,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: p.mutedForeground)),
                                  ),
                                  if (t.unread > 0) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: Text('${t.unread}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _convoPane(AppPalette p, {required bool backButton}) {
    final t = _active;
    return Container(
      color: p.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: p.border)),
            ),
            child: Row(
              children: [
                if (backButton)
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: p.foreground),
                    onPressed: () => setState(() => _mobileShowingConvo = false),
                  ),
                _avatar(t.initials, t.avatarBg, t.avatarFg,
                    online: t.online, palette: p),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.name,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: p.foreground)),
                      Text(t.online ? 'Active now' : 'Last seen recently',
                          style: TextStyle(fontSize: 11.5, color: p.mutedForeground)),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.phone_outlined, color: p.foreground),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.videocam_outlined, color: p.foreground),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.more_horiz, color: p.foreground),
                    onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: kActiveChat.length,
              itemBuilder: (_, i) => _bubble(kActiveChat[i], p, t),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: p.border)),
            ),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.attach_file, color: p.mutedForeground),
                    onPressed: () {}),
                Expanded(
                  child: TextField(
                    controller: _composer,
                    style: TextStyle(color: p.foreground, fontSize: 13.5),
                    decoration: InputDecoration(
                      hintText: 'Write a message…',
                      hintStyle: TextStyle(color: p.mutedForeground, fontSize: 13.5),
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      filled: true,
                      fillColor: p.muted,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                        borderSide: BorderSide(color: p.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(999),
                        borderSide: BorderSide(color: p.border),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _composer.clear(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(ChatMsg m, AppPalette p, ChatThread t) {
    final mine = m.mine;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine) ...[
            _avatar(m.initials ?? t.initials, t.avatarBg, t.avatarFg,
                online: false, palette: p, small: true),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 480),
                  decoration: BoxDecoration(
                    color: mine ? AppColors.primary : p.card,
                    border: mine ? null : Border.all(color: p.border),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(mine ? 14 : 4),
                      bottomRight: Radius.circular(mine ? 4 : 14),
                    ),
                  ),
                  child: Text(m.body,
                      style: TextStyle(
                          fontSize: 13.5,
                          color: mine ? Colors.white : p.foreground)),
                ),
                const SizedBox(height: 3),
                Text(m.time,
                    style: TextStyle(fontSize: 10.5, color: p.mutedForeground)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatar(String initials, Color bg, Color fg,
      {required bool online, required AppPalette palette, bool small = false}) {
    final size = small ? 28.0 : 40.0;
    final dot = small ? 8.0 : 10.0;
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Text(initials,
              style: TextStyle(
                  color: fg,
                  fontSize: small ? 10.5 : 13,
                  fontWeight: FontWeight.w600)),
        ),
        if (online)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dot,
              height: dot,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: palette.background, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
