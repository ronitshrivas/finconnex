import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum PortalStatus { active, inactive, suspended }

enum PortalAccess { full, limited, readOnly }

class Portal {
  final String id;
  final String name;
  final String slug;
  final String client;
  final PortalAccess access;
  final int modules;
  final PortalStatus status;
  final String contactName;
  final String contactEmail;

  const Portal({
    required this.id,
    required this.name,
    required this.slug,
    required this.client,
    required this.access,
    required this.modules,
    required this.status,
    required this.contactName,
    required this.contactEmail,
  });
}

extension PortalStatusX on PortalStatus {
  String get label => switch (this) {
        PortalStatus.active => 'Active',
        PortalStatus.inactive => 'Inactive',
        PortalStatus.suspended => 'Suspended',
      };

  Color get bg => switch (this) {
        PortalStatus.active => AppColors.successBg,
        PortalStatus.inactive => AppColors.neutralBg,
        PortalStatus.suspended => AppColors.dangerBg,
      };

  Color get fg => switch (this) {
        PortalStatus.active => AppColors.successFg,
        PortalStatus.inactive => AppColors.neutralFg,
        PortalStatus.suspended => AppColors.dangerFg,
      };
}

extension PortalAccessX on PortalAccess {
  String get label => switch (this) {
        PortalAccess.full => 'Full',
        PortalAccess.limited => 'Limited',
        PortalAccess.readOnly => 'Read-only',
      };

  Color get bg => switch (this) {
        PortalAccess.full => AppColors.accessFullBg,
        PortalAccess.limited => AppColors.accessLimitedBg,
        PortalAccess.readOnly => AppColors.neutralBg,
      };

  Color get fg => switch (this) {
        PortalAccess.full => AppColors.accessFullFg,
        PortalAccess.limited => AppColors.accessLimitedFg,
        PortalAccess.readOnly => AppColors.neutralFg,
      };
}

const kMockPortals = <Portal>[
  Portal(
    id: 'PRT-7001',
    name: 'Greystone Client Portal',
    slug: '/p/greystone',
    client: 'Greystone Realty',
    access: PortalAccess.full,
    modules: 6,
    status: PortalStatus.active,
    contactName: 'Priya Mehta',
    contactEmail: 'priya@greystone.example',
  ),
  Portal(
    id: 'PRT-7002',
    name: 'Harbour self-service',
    slug: '/p/harbour',
    client: 'Harbour Loans',
    access: PortalAccess.limited,
    modules: 5,
    status: PortalStatus.active,
    contactName: 'Marcus Chen',
    contactEmail: 'marcus@harbour.example',
  ),
  Portal(
    id: 'PRT-7003',
    name: 'Apex portal (suspended)',
    slug: '/p/apex',
    client: 'Apex Property Group',
    access: PortalAccess.full,
    modules: 4,
    status: PortalStatus.suspended,
    contactName: 'Daniel Rossi',
    contactEmail: 'daniel@apex.example',
  ),
];
