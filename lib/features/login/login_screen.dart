import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignedIn;

  const LoginScreen({super.key, required this.onSignedIn});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _keepSignedIn = false;
  String? _error;

  void _submit() {
    if (_username.text.trim() == 'admin' && _password.text == 'admin123') {
      widget.onSignedIn();
    } else {
      setState(() => _error = 'Invalid credentials. Use admin / admin123.');
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    final card = _SignInCard(
      username: _username,
      password: _password,
      keepSignedIn: _keepSignedIn,
      onKeepSignedIn: (v) => setState(() => _keepSignedIn = v),
      error: _error,
      onSubmit: _submit,
    );

    return Scaffold(
      backgroundColor: isDesktop ? AppColors.background : AppColors.loginDark,
      body: SafeArea(
        child: isDesktop
            ? Row(
                children: [
                  const Expanded(child: _LeftPanel(compact: false)),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(48),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 460),
                          child: card,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _LeftPanel(compact: true),
                    Container(
                      color: AppColors.background,
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      child: card,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _LeftPanel extends StatelessWidget {
  final bool compact;
  const _LeftPanel({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 20 : 56,
        vertical: compact ? 28 : 56,
      ),
      color: AppColors.loginDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            compact ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FinConnex',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Multi-tenant CRM for modern teams',
                style: TextStyle(color: AppColors.loginDarkMuted, fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: compact ? 20 : 40),
          Text(
            compact
                ? 'Manage every client relationship, securely.'
                : 'Manage every client\nrelationship, securely.',
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 22 : 34,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Sign in to access dashboards, sales pipelines, finance reports, and team tools.',
            style: TextStyle(
              color: AppColors.loginDarkMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          if (!compact) ...[
            const SizedBox(height: 32),
            const _FeatureRow(
              icon: Icons.bar_chart,
              title: 'Unified analytics',
              subtitle: 'Track sales, finance, and pipeline metrics in one place.',
            ),
            const SizedBox(height: 20),
            const _FeatureRow(
              icon: Icons.people_alt_outlined,
              title: 'Multi-tenant workspaces',
              subtitle: 'Each organization gets an isolated, secure environment.',
            ),
            const SizedBox(height: 20),
            const _FeatureRow(
              icon: Icons.show_chart,
              title: 'Real-time insights',
              subtitle: 'Monitor leads, deals, and revenue as they happen.',
            ),
            const SizedBox(height: 20),
            const _FeatureRow(
              icon: Icons.shield_outlined,
              title: 'Enterprise security',
              subtitle: 'Role-based access with tenant-scoped authentication.',
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Text(
                '© 2026 FinConnex. All rights reserved.',
                style: TextStyle(color: AppColors.loginDarkMuted, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: const TextStyle(
                    color: AppColors.loginDarkMuted,
                    fontSize: 12.5,
                    height: 1.4,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignInCard extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;
  final bool keepSignedIn;
  final ValueChanged<bool> onKeepSignedIn;
  final String? error;
  final VoidCallback onSubmit;

  const _SignInCard({
    required this.username,
    required this.password,
    required this.keepSignedIn,
    required this.onKeepSignedIn,
    required this.error,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome back',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Enter your username and password to continue',
            style: TextStyle(fontSize: 13.5, color: AppColors.mutedForeground),
          ),
          const SizedBox(height: 20),
          const _FieldLabel('Username'),
          const SizedBox(height: 8),
          TextField(
            controller: username,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Enter your username'),
          ),
          const SizedBox(height: 16),
          const _FieldLabel('Password'),
          const SizedBox(height: 8),
          TextField(
            controller: password,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(hintText: 'Enter your password'),
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: keepSignedIn,
                  onChanged: (v) => onKeepSignedIn(v ?? false),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Keep me signed in for 30 days',
                    style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(error!,
                style: const TextStyle(color: AppColors.destructive, fontSize: 12)),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shield_outlined, size: 16),
                  SizedBox(width: 8),
                  Text('Sign in to workspace',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Center(
            child: Text(
              'By signing in, you agree to our Terms of Service and Privacy Policy',
              style: TextStyle(fontSize: 11.5, color: AppColors.subtleText),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
      ),
    );
  }
}
