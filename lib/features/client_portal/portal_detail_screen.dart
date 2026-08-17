import 'package:flutter/material.dart';

import '../../core/data/mock_portals.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/status_pill.dart';

class PortalDetailScreen extends StatelessWidget {
  final Portal portal;
  const PortalDetailScreen({super.key, required this.portal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.foreground),
        title: Text(portal.id,
            style: const TextStyle(
                color: AppColors.foreground,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        shape: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _headerCard(),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Client',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(portal.client,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(portal.slug,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _sectionCard(
                title: 'Access & modules',
                child: Row(
                  children: [
                    StatusPill(
                        label: portal.access.label,
                        background: portal.access.bg,
                        foreground: portal.access.fg),
                    const SizedBox(width: 12),
                    Text('${portal.modules} modules enabled',
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _sectionCard(
                title: 'Primary contact',
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primarySoft,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        portal.contactName.substring(0, 1),
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(portal.contactName,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(portal.contactEmail,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedForeground)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mail_outline,
                          color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                        label: 'Manage users',
                        icon: Icons.people_alt_outlined,
                        onPressed: () {}),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                        label: 'Open portal',
                        icon: Icons.open_in_new,
                        onPressed: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
              Expanded(
                child: Text(portal.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),
              ),
              StatusPill(
                  label: portal.status.label,
                  background: portal.status.bg,
                  foreground: portal.status.fg),
            ],
          ),
          const SizedBox(height: 6),
          Text(portal.id,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.mutedForeground)),
        ],
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
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
          Text(title.toUpperCase(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: AppColors.mutedForeground)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
