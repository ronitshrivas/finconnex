import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';
import '../../widgets/primary_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _section = 0;
  final _sections = const [
    ('Profile', Icons.person_outline),
    ('Appearance', Icons.palette_outlined),
    ('Notifications', Icons.notifications_none),
    ('Workspace', Icons.business_outlined),
    ('Integrations', Icons.extension_outlined),
    ('Security', Icons.shield_outlined),
    ('Billing', Icons.credit_card_outlined),
  ];

  // Toggles
  bool _emailNotifs = true;
  bool _pushNotifs = true;
  bool _mentionsOnly = false;
  bool _mfa = true;
  bool _autoSave = true;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final mobile = context.isMobile;
    final pad = mobile ? 16.0 : 24.0;

    if (mobile) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            _sectionPicker(p, mobile: true),
            const SizedBox(height: 12),
            _rightPane(p),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Settings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Manage your account, workspace, and integrations.',
              style: TextStyle(fontSize: 13, color: p.mutedForeground)),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 240, child: _sectionPicker(p, mobile: false)),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(child: _rightPane(p)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionPicker(AppPalette p, {required bool mobile}) {
    if (mobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < _sections.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              InkWell(
                onTap: () => setState(() => _section = i),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _section == i ? AppColors.primary : p.card,
                    border: Border.all(color: _section == i ? AppColors.primary : p.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(_sections[i].$1,
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: _section == i ? Colors.white : p.foreground)),
                ),
              ),
            ],
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (int i = 0; i < _sections.length; i++)
            InkWell(
              onTap: () => setState(() => _section = i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _section == i ? AppColors.primarySoft : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(_sections[i].$2,
                        size: 18,
                        color: _section == i ? AppColors.primary : p.foreground),
                    const SizedBox(width: 12),
                    Text(_sections[i].$1,
                        style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: _section == i ? FontWeight.w600 : FontWeight.w500,
                            color: _section == i ? AppColors.primary : p.foreground)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _rightPane(AppPalette p) {
    switch (_section) {
      case 0:
        return _profileSection(p);
      case 1:
        return _appearanceSection(p);
      case 2:
        return _notificationsSection(p);
      case 3:
        return _workspaceSection(p);
      case 4:
        return _integrationsSection(p);
      case 5:
        return _securitySection(p);
      case 6:
        return _billingSection(p);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _card(AppPalette p,
      {required String title, String? subtitle, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600, color: p.foreground)),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle,
                style: TextStyle(fontSize: 12.5, color: p.mutedForeground)),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _field(AppPalette p, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: p.foreground)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }

  Widget _row(AppPalette p, String title, String subtitle, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        color: p.foreground)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: TextStyle(fontSize: 12, color: p.mutedForeground)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _profileSection(AppPalette p) {
    return Column(
      children: [
        _card(p,
            title: 'Profile',
            subtitle: 'Update how you appear across the workspace.',
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: p.foreground, shape: BoxShape.circle),
                      child: Text('JS',
                          style: TextStyle(
                              color: p.background,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 16),
                    SecondaryButton(
                        label: 'Change avatar',
                        icon: Icons.upload_outlined,
                        onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _field(p, 'First name', 'John')),
                    const SizedBox(width: 12),
                    Expanded(child: _field(p, 'Last name', 'Smith')),
                  ],
                ),
                const SizedBox(height: 14),
                _field(p, 'Email', 'john@finconnex.example'),
                const SizedBox(height: 14),
                _field(p, 'Role', 'Manager'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SecondaryButton(label: 'Cancel', onPressed: () {}),
                    const SizedBox(width: 8),
                    PrimaryButton(label: 'Save changes', onPressed: () {}),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  Widget _appearanceSection(AppPalette p) {
    final theme = ThemeScope.of(context);
    return Column(
      children: [
        _card(p,
            title: 'Theme',
            subtitle: 'Choose how FinConnex looks on this device.',
            child: Row(
              children: [
                Expanded(child: _themeTile(p, dark: false, active: !theme.isDark)),
                const SizedBox(width: 12),
                Expanded(child: _themeTile(p, dark: true, active: theme.isDark)),
              ],
            )),
        _card(p,
            title: 'Density',
            subtitle: 'Comfortable spacing across tables and lists.',
            child: Row(
              children: [
                _pickChip(p, 'Comfortable', true),
                const SizedBox(width: 8),
                _pickChip(p, 'Compact', false),
              ],
            )),
      ],
    );
  }

  Widget _themeTile(AppPalette p, {required bool dark, required bool active}) {
    final theme = ThemeScope.of(context);
    return InkWell(
      onTap: () => setState(() => theme.setDark(dark)),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF14141C) : Colors.white,
          border: Border.all(
              color: active ? AppColors.primary : p.border,
              width: active ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(dark ? Icons.dark_mode_outlined : Icons.wb_sunny_outlined,
                color: dark ? Colors.white : AppColors.foreground, size: 28),
            const SizedBox(height: 10),
            Text(dark ? 'Dark' : 'Light',
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: dark ? Colors.white : AppColors.foreground)),
            const SizedBox(height: 4),
            Text(active ? 'Active' : 'Tap to use',
                style: TextStyle(
                    fontSize: 11,
                    color:
                        active ? AppColors.primary : (dark ? Colors.white70 : AppColors.mutedForeground),
                    fontWeight: active ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _pickChip(AppPalette p, String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primarySoft : p.card,
        border: Border.all(color: active ? AppColors.primary : p.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: active ? AppColors.primary : p.foreground)),
    );
  }

  Widget _notificationsSection(AppPalette p) {
    return _card(p,
        title: 'Notifications',
        subtitle: 'Choose where and when to be pinged.',
        child: Column(
          children: [
            _row(p, 'Email notifications', 'Digest sent every morning.',
                Switch(value: _emailNotifs, onChanged: (v) => setState(() => _emailNotifs = v), activeColor: AppColors.primary)),
            Divider(height: 20, color: p.border),
            _row(p, 'Push notifications', 'Sent to your phone in real time.',
                Switch(value: _pushNotifs, onChanged: (v) => setState(() => _pushNotifs = v), activeColor: AppColors.primary)),
            Divider(height: 20, color: p.border),
            _row(p, 'Mentions only', 'Only ping me when I\'m tagged.',
                Switch(value: _mentionsOnly, onChanged: (v) => setState(() => _mentionsOnly = v), activeColor: AppColors.primary)),
          ],
        ));
  }

  Widget _workspaceSection(AppPalette p) {
    return _card(p,
        title: 'Workspace',
        subtitle: 'FinConnex HQ',
        child: Column(
          children: [
            _field(p, 'Workspace name', 'FinConnex HQ'),
            const SizedBox(height: 14),
            _field(p, 'Time zone', 'Asia/Kathmandu (UTC+5:45)'),
            const SizedBox(height: 14),
            _row(p, 'Auto-save drafts', 'Documents, quotes, and email drafts.',
                Switch(value: _autoSave, onChanged: (v) => setState(() => _autoSave = v), activeColor: AppColors.primary)),
          ],
        ));
  }

  Widget _integrationsSection(AppPalette p) {
    final items = const [
      ('Slack', Icons.chat_bubble_outline, 'Connected', true),
      ('Google Workspace', Icons.mail_outline, 'Connected', true),
      ('Xero', Icons.attach_money, 'Not connected', false),
      ('Zapier', Icons.electric_bolt, 'Not connected', false),
      ('Stripe', Icons.credit_card, 'Connected', true),
    ];
    return _card(p,
        title: 'Integrations',
        subtitle: 'Bring the rest of your stack into FinConnex.',
        child: Column(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) Divider(height: 20, color: p.border),
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: p.muted, borderRadius: BorderRadius.circular(8)),
                    child: Icon(items[i].$2, color: p.foreground, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[i].$1,
                            style: TextStyle(
                                fontSize: 13.5, fontWeight: FontWeight.w600, color: p.foreground)),
                        const SizedBox(height: 2),
                        Text(items[i].$3,
                            style: TextStyle(
                                fontSize: 12,
                                color: items[i].$4 ? AppColors.successFg : p.mutedForeground)),
                      ],
                    ),
                  ),
                  SecondaryButton(
                      label: items[i].$4 ? 'Manage' : 'Connect',
                      onPressed: () {}),
                ],
              ),
            ],
          ],
        ));
  }

  Widget _securitySection(AppPalette p) {
    return _card(p,
        title: 'Security',
        subtitle: 'Keep your workspace safe.',
        child: Column(
          children: [
            _row(p, 'Two-factor authentication',
                'Required for admins and finance roles.',
                Switch(value: _mfa, onChanged: (v) => setState(() => _mfa = v), activeColor: AppColors.primary)),
            Divider(height: 20, color: p.border),
            _row(p, 'Active sessions', 'You\'re signed in on 2 devices.',
                SecondaryButton(label: 'Manage', onPressed: () {})),
            Divider(height: 20, color: p.border),
            _row(p, 'Change password',
                'Update the password used to sign in.',
                SecondaryButton(label: 'Change', onPressed: () {})),
          ],
        ));
  }

  Widget _billingSection(AppPalette p) {
    return Column(
      children: [
        _card(p,
            title: 'Plan',
            subtitle: 'Business · billed annually',
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$248 / user / month',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: p.foreground)),
                      const SizedBox(height: 4),
                      Text('Renews on 20 Jan 2027 · 24 seats',
                          style: TextStyle(fontSize: 12, color: p.mutedForeground)),
                    ],
                  ),
                ),
                PrimaryButton(label: 'Upgrade plan', onPressed: () {}),
              ],
            )),
        _card(p,
            title: 'Payment method',
            subtitle: 'Visa •••• 6411 · expires 08/28',
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text('VISA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Visa •••• 6411',
                      style: TextStyle(fontSize: 13.5, color: p.foreground)),
                ),
                SecondaryButton(label: 'Update', onPressed: () {}),
              ],
            )),
      ],
    );
  }
}
